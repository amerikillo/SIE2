/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import conn.ConectionDB;
import conn.ConectionDB_SQLServer;
import java.sql.SQLException;

/**
 *
 * @author Americo
 */
public class Modificaciones extends HttpServlet {

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
            if (request.getParameter("accion").equals("eliminar")) {
                System.out.println("eliminar");
                try {
                    con.conectar();
                    con.borrar2("delete from tb_compratemp where F_IdCom = '" + request.getParameter("id") + "'");
                    con.cierraConexion();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
                response.sendRedirect("captura.jsp");
            }
            if (request.getParameter("accion").equals("modificar")) {
                System.out.println("modificar");
                request.getSession().setAttribute("id", request.getParameter("id"));
                response.sendRedirect("edita_clave.jsp");
            }
            if (request.getParameter("accion").equals("actualizar")) {
                System.out.println("actualizar");
                int cajas = 0;
                int piezas = 0;
                int resto = 0;
                try {
                    cajas = Integer.parseInt(request.getParameter("Cajas"));
                } catch (Exception e) {
                    cajas = 0;
                }
                try {
                    piezas = Integer.parseInt(request.getParameter("pzsxcaja"));
                } catch (Exception e) {
                    piezas = 0;
                }
                try {
                    resto = Integer.parseInt(request.getParameter("Resto"));
                } catch (Exception e) {
                    resto = 0;
                }
                int cantidad = (cajas * piezas) + resto;
                try {
                    con.conectar();
                    byte[] a = request.getParameter("pres").getBytes("ISO-8859-1");
                    String pres = new String(a, "UTF-8");
                    a = request.getParameter("Marca").getBytes("ISO-8859-1");
                    String marca = new String(a, "UTF-8");
                    con.actualizar("update datos_inv_cod set cod_bar = '" + request.getParameter("cb").toUpperCase() + "', marca = '" + marca.toUpperCase() + "', um = '" + pres.toUpperCase() + "', lote = '" + request.getParameter("Lote").toUpperCase() + "', cadu = '" + request.getParameter("Caducidad").toUpperCase() + "', cajas= '" + cajas + "', piezas = '" + piezas + "', resto = '" + resto + "', cant='" + cantidad + "', fec_fab='" + request.getParameter("FecFab").toUpperCase() + "' where id_cap_inv = '" + request.getParameter("id") + "' ");
                    con.cierraConexion();
                    out.println("<script>alert('Modificación Correcta')</script>");
                    out.println("<script>window.location='captura.jsp'</script>");
                } catch (Exception e) {
                    out.println("<script>alert('Modificación incorrecta!!')</script>");
                    out.println("<script>window.location='edita_clave.jsp'</script>");
                }
            }
        } catch (Exception e) {
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

}
