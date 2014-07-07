/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;
import java.sql.*;
import conn.*;// package que contiene la Clase ConectionDBS
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author wence
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    ConectionDB obj = new ConectionDB();
    ConectionDB con = new ConectionDB();
    ConectionDB_SQLServer consql = new ConectionDB_SQLServer();
    private String nombre, pass, //En pass se guarda la que ingreso el usuario
            AttNombre = "", AttAppe = "",
            SQLEx = "", EX = "", otra_var = "",
            nombre_bdd = "", contra_bdd = "", bandera = "", qry = "";
    private boolean exito;
    private int ban;
    private int insertar;
    java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.text.DateFormat df2 = new java.text.SimpleDateFormat("hh:mm:ss");

    private void lectorBD(Boolean estado, String aviso) {
        if (estado) {
            try {
                String qry_cons = "select F_IdUsu, F_Nombre from tb_usuario where F_Usu='" + this.nombre + "' and F_Pass=PASSWORD('" + this.pass + "')";
                obj.conectar();
                ResultSet consulta = null;
                consulta = obj.consulta(qry_cons);
                if (consulta.next()) {
                    exito = true;
                    this.AttNombre = consulta.getString("F_Nombre");

                } else {
                    exito = false;
                }
                obj.cierraConexion();
                /*   if(this.passMatch(passMD5)){
                 rs = query.executeQuery(selectDatos + IDpass +"'");
                 rs.first();
                 this.AttNombre = rs.getString(1);
                 this.AttAppe = rs.getString(2);
                 rs.close();
                 }else {

                 }
                 query.close(); conexion.close();*/
            } catch (SQLException ex) {
                this.SQLEx = "Se produjo una excepción durante la conexión: " + ex.toString();
            } catch (Exception ex) {
                this.EX = "Se produjo una excepción: " + ex.toString();
            }
        }
    }

    private void validar(String parNom, String parPass) {

        Boolean estado = false;
        String falta = null;

        if (!parNom.isEmpty()) {
            if (!parPass.isEmpty()) {
                estado = true;
                this.nombre = parNom;
                this.pass = parPass;
            } else {
                exito = false;
                falta = "No se ingresó la contraseña";
            }
        } else {
            exito = false;
            falta = "No se ingresó el Nombre de Usuario";
        }
        if (estado == true) {
            this.lectorBD(estado, falta);
        } else {
            exito = false;
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(true);
        PrintWriter out = response.getWriter();
        ban = Integer.parseInt(request.getParameter("ban"));
        switch (ban) {
            case 0:
                this.validar(request.getParameter("nombre"), request.getParameter("pass"));
                sesion.setAttribute("nombre", this.AttNombre);
                sesion.setAttribute("ape", this.AttAppe);
                sesion.setAttribute("valida", "valida");
                sesion.setAttribute("id", sesion.getId());

                sesion.setAttribute("otra_var", request.getParameter("hash"));
                response.setContentType("text/html;charset=UTF-8");

                if (exito == true) {
                    try {
                        obj.conectar();
                        qry = "insert into tb_entrada values('0','" + request.getParameter("nombre") + "','" + df.format(new java.util.Date()) + "','" + df2.format(new java.util.Date()) + "','1');";
                        insertar = obj.insertar(qry);
                        obj.cierraConexion();
                    } catch (SQLException ex) {
                        Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    proveedores();
                    response.sendRedirect(response.encodeRedirectURL("main_menu.jsp"));
                } else {
                    try {
                        obj.conectar();
                        qry = "insert into entradas values('0','" + request.getParameter("nombre") + "','" + df.format(new java.util.Date()) + "','" + df2.format(new java.util.Date()) + "','0');";
                        insertar = obj.insertar(qry);
                        obj.cierraConexion();
                    } catch (SQLException ex) {
                        Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    sesion.setAttribute("info", "Datos no validos");
                    response.sendRedirect(response.encodeRedirectURL("index.jsp"));
                }
                break;
            case 1:

                break;
            case 3:

                break;
            case 4:

                break;
            case 5:

                break;
            case 6:
                response.sendRedirect(response.encodeRedirectURL("index.jsp"));
                break;
            default:

                break;
        }

    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(true);
        PrintWriter out = response.getWriter();
        ban = Integer.parseInt(request.getParameter("ban"));
        switch (ban) {
            case 1:
                sesion.setAttribute("valida", "valida");
                response.sendRedirect(response.encodeRedirectURL("index.jsp"));
                break;
            case 2:
                sesion.setAttribute("valida", "valida");
                response.sendRedirect(response.encodeRedirectURL("indexMain.jsp"));
                break;
            case 3:
                response.sendRedirect(response.encodeRedirectURL("salir.jsp"));
                break;
            case 4:
                response.sendRedirect(response.encodeRedirectURL("salir.jsp"));
                break;
            case 5:

                break;
            case 6:

                break;
            default:

                break;
        }

    }// end of doGet

    public void proveedores() {
        try {
            consql.conectar();
            con.conectar();
            try {
                con.insertar("truncate table tb_proveedor");
                ResultSet rset = consql.consulta("select * from tb_proveedor;");
                while (rset.next()) {
                    con.insertar("insert into tb_proveedor values ('" + rset.getString(1) + "', '" + rset.getString(2) + "', '" + rset.getString(3) + "', '" + rset.getString(4) + "', '" + rset.getString(5) + "', '" + rset.getString(6) + "', '" + rset.getString(7) + "', '" + rset.getString(8) + "' ,'" + rset.getString(9) + "', '" + rset.getString(10) + "', '" + rset.getString(11) + "', '" + rset.getString(12) + "', '" + rset.getString(13) + "')");
                }
            } catch (Exception e) {
            }
            con.cierraConexion();
            consql.cierraConexion();
        } catch (Exception e) {
        }
    }
}// end of the Class
