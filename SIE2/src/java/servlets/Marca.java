/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import conn.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class Marca extends HttpServlet {

    ConectionDB con = new ConectionDB();
    ConectionDB_SQLServer consql = new ConectionDB_SQLServer();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession(true);
        try {
            /*
             *Para actualizar Registros
             */
            if (request.getParameter("accion").equals("actualizar")) {
                consql.conectar();
                con.conectar();
                try {
                    String clave = request.getParameter("Clave");
                    try {
                        int largoClave = request.getParameter("Clave").length();
                        int espacios = 5 - largoClave;
                        for (int i = 1; i <= espacios; i++) {
                            clave = " " + clave;
                        }
                    } catch (Exception e) {
                    }
                    consql.actualizar("update TB_Provee set F_ClaPrv='" + clave + "', F_NomPrv='" + request.getParameter("Nombre").toUpperCase() + "', F_Dir='" + request.getParameter("Direccion").toUpperCase() + "', F_Col='" + request.getParameter("Colonia").toUpperCase() + "', F_Pob='" + request.getParameter("Poblacion").toUpperCase() + "', F_CP='" + request.getParameter("CP").toUpperCase() + "', F_RFC='" + request.getParameter("RFC").toUpperCase() + "', F_Con='" + request.getParameter("CON").toUpperCase() + "', F_Cls='" + request.getParameter("CLS").toUpperCase() + "', F_Tel='" + request.getParameter("Telefono").toUpperCase() + "', F_Fax='" + request.getParameter("FAX").toUpperCase() + "', F_Mail='" + request.getParameter("Mail").toUpperCase() + "', F_Obs='" + request.getParameter("Observaciones").toUpperCase() + "' where F_ClaPrv='" + request.getParameter("id").toUpperCase() + "';");

                    con.actualizar("update provee_all set F_ClaPrv='" + clave + "', F_nomprov='" + request.getParameter("Nombre").toUpperCase() + "', F_Dir='" + request.getParameter("Direccion").toUpperCase() + "', F_Col='" + request.getParameter("Colonia").toUpperCase() + "', F_Pob='" + request.getParameter("Poblacion").toUpperCase() + "', F_CP='" + request.getParameter("CP").toUpperCase() + "', F_RFC='" + request.getParameter("RFC").toUpperCase() + "', F_Con='" + request.getParameter("CON").toUpperCase() + "', F_Cls='" + request.getParameter("CLS").toUpperCase() + "', F_Tel='" + request.getParameter("Telefono").toUpperCase() + "', F_Fax='" + request.getParameter("FAX").toUpperCase() + "', F_Mail='" + request.getParameter("Mail").toUpperCase() + "', F_Obs='" + request.getParameter("Observaciones").toUpperCase() + "' where F_ClaPrv='" + request.getParameter("id").toUpperCase() + "';");

                } catch (Exception e) {
                    System.out.println(e.getMessage());

                    out.println("<script>alert('Ya esta registrado ese proveedor')</script>");
                    out.println("<script>window.location='editar_proveedor.jsp'</script>");
                }
                con.cierraConexion();
                consql.cierraConexion();

                out.println("<script>alert('Proveedor actualizado correctamente.')</script>");
                out.println("<script>window.location='catalogo.jsp'</script>");
            }
            /*
             *Manda al jsp el id del registro a editar
             */
            if (request.getParameter("accion").equals("editar")) {
                request.getSession().setAttribute("id", request.getParameter("id"));
                response.sendRedirect("editar_proveedor.jsp");
            }
            /*
             *Para eliminar registro
             */
            if (request.getParameter("accion").equals("eliminar")) {
                consql.conectar();
                con.conectar();
                try {
                    consql.insertar("delete from TB_Provee where F_ClaPrv = '" + request.getParameter("id") + "' ");
                    con.insertar("delete from provee_all where F_ClaPrv = '" + request.getParameter("id") + "' ");
                } catch (SQLException e) {
                    System.out.println(e.getMessage());

                    out.println("<script>alert('Error al eliminar')</script>");
                    out.println("<script>window.location='catalogo.jsp'</script>");
                }
                con.cierraConexion();
                consql.cierraConexion();

                out.println("<script>alert('Se elimino el proveedor correctamente')</script>");
                out.println("<script>window.location='catalogo.jsp'</script>");
            }
            /*
             *Guarda Registros
             */
            if (request.getParameter("accion").equals("guardar")) {
                try {
                    String Nombre="";
                    con.conectar();
                    consql.conectar();
                    try {
                        ResultSet rst_prov = con.consulta("SELECT F_DesMar FROM tb_marca WHERE F_DesMar='"+request.getParameter("Nombre").toUpperCase()+"'");
                        while (rst_prov.next()){
                            Nombre = rst_prov.getString("F_DesMar");
                        }
                        if (!(Nombre.equals(""))){
                            out.println("<script>alert('Ya esta registrado ésta Marca')</script>");
                            out.println("<script>window.location='marcas.jsp'</script>");
                            
                        }else{
                             con.insertar("insert into tb_marca values (0,'" + request.getParameter("Nombre").toUpperCase() + "');");
                             consql.insertar("insert into TB_Marcas values ('" + request.getParameter("Nombre").toUpperCase() + "');");
                        }
                    } catch (SQLException e) {
                        System.out.println(e.getMessage());
                    }
                    con.cierraConexion();
                    consql.cierraConexion();
                    out.println("<script>alert('Marca capturado correctamente.')</script>");
                    out.println("<script>window.location='marcas.jsp'</script>");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

            }

            if (request.getParameter("accion").equals("obtieneProvee")) {
                try {
                    proveedores();
                    out.println("<script>alert('Se obtuvieron los Proveedores Correctamente')</script>");
                } catch (Exception e) {
                    out.println("<script>alert('Error al obtener proveedores')</script>");
                }
                 out.println("<script>window.location='catalogo.jsp'</script>");
            }
        } catch (SQLException e) {

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public void proveedores() {
        try {
            consql.conectar();
            con.conectar();
            try {
                con.insertar("truncate table provee_all");
                ResultSet rset = consql.consulta("select * from TB_Provee;");
                while (rset.next()) {
                    con.insertar("insert into provee_all values ('" + rset.getString(1) + "', '" + rset.getString(2) + "', '" + rset.getString(3) + "', '" + rset.getString(4) + "', '" + rset.getString(5) + "', '" + rset.getString(6) + "', '" + rset.getString(7) + "', '" + rset.getString(8) + "' ,'" + rset.getString(9) + "', '" + rset.getString(10) + "', '" + rset.getString(11) + "', '" + rset.getString(12) + "', '" + rset.getString(13) + "')");
                }
            } catch (Exception e) {
            }
            con.cierraConexion();
            consql.cierraConexion();
        } catch (Exception e) {
        }
    }

}
