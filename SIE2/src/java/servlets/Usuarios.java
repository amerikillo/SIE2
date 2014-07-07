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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Americo
 */
public class Usuarios extends HttpServlet {

    ConectionDB con = new ConectionDB();
    ConectionDB_SQLServer consql = new ConectionDB_SQLServer();
    java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy");
    java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

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
        try {
            if (request.getParameter("accion").equals("Guardar")) {
                try {
                    con.conectar();
                    try {
                        con.insertar("insert into usuarios values('0', '" + request.getParameter("Nombre") + "', '" + request.getParameter("Apellido") + "', PASSWORD('" + request.getParameter("Pass") + "'), '" + request.getParameter("Rol") + "')");
                    } catch (Exception e) {
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    out.println("<script>alert('Error al guardar el usuario')</script>");
                    out.println("<script>window.location='usuarios/usuario_nuevo.jsp'</script>");
                }
                out.println("<script>alert('Usuario Capturado Correctamente')</script>");
                out.println("<script>window.location='usuarios/usuario_nuevo.jsp'</script>");
            }

            if (request.getParameter("accion").equals("Modificar")) {
                try {
                    con.conectar();
                    try {
                        con.insertar("update usuarios set nombre= '" + request.getParameter("Nombre") + "', apellido= '" + request.getParameter("Apellido") + "', contra=PASSWORD('" + request.getParameter("Pass") + "') where nombre= '" + request.getParameter("Nombre") + "'");
                    } catch (Exception e) {
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    out.println("<script>alert('Error al actualizar el usuario')</script>");
                    out.println("<script>window.location='usuarios/edita_usuario.jsp'</script>");
                }
                out.println("<script>alert('Usuario Actualizado Correctamente')</script>");
                out.println("<script>window.location='usuarios/edita_usuario.jsp'</script>");
            }
            
            if (request.getParameter("accion").equals("Eliminar")) {
                try {
                    con.conectar();
                    try {
                        con.insertar("delete from usuarios where nombre= '" + request.getParameter("Nombre") + "' ");
                    } catch (Exception e) {
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    out.println("<script>alert('Error al eliminar el usuario')</script>");
                    out.println("<script>window.location='usuarios/edita_usuario.jsp'</script>");
                }
                out.println("<script>alert('Usuario eliminado Correctamente')</script>");
                out.println("<script>window.location='usuarios/edita_usuario.jsp'</script>");
            }
        } finally {
            out.close();
        }

        out.println("<script>window.location='usuarios/usuario_nuevo.jsp'</script>");
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
