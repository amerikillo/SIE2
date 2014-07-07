/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import conn.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class agregaCeros extends HttpServlet {

    ConectionDB con = new ConectionDB();

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet agregaCeros</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet agregaCeros at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            if (agrega()){
                out.println("Se agregaron correctamente los \'0\' a las claves");
            } else {
                out.println("Error al agregar las claves");
            }
        } finally {
            out.close();
        }
    }

    public boolean agrega() {
        try {
            con.conectar();
            try {
                ResultSet rset = con.consulta("select clave from datos_inv_cod where clave<1000 group by clave;");
                while (rset.next()) {
                    String clave = rset.getString(1);
                    String clave2="";
                    if (!clave.substring(0, 1).equals("0")){
                        //System.out.println(clave);
                        if (clave.length()==1){
                            clave2=("000"+clave);
                        }
                        if (clave.length()==2){
                            clave2=("00"+clave);
                        }
                        if (clave.length()>=3){
                            clave2=("0"+clave);
                        }
                        con.insertar("update datos_inv_cod set clave = '"+clave2+"' where clave='"+clave+"'");
                    }
                }
            } catch (Exception e) {
                return false;
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
        return true;
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
