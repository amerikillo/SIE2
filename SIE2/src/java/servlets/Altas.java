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
public class Altas extends HttpServlet {

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
        HttpSession sesion = request.getSession(true);
        String clave = "", descr = "", cb = "", Cuenta = "", Marca = "", codbar2 = "";
        int ban1 = 0;
        String boton = request.getParameter("accion");
        try {
            if (request.getParameter("accion").equals("codigo")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("SELECT F_Cb,COUNT(F_Cb) as cuenta FROM tb_cb WHERE F_Cb='" + request.getParameter("codigo") + "' GROUP BY F_Cb");
                    while (rset.next()) {
                        ban1 = 1;
                        cb = rset.getString("F_Cb");
                        Cuenta = rset.getString("cuenta");
                    }
                    if (Cuenta.equals("")) {
                        Cuenta = "0";
                        cb = request.getParameter("codigo");
                        ban1 = 2;
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("clave")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select F_ClaPro, F_DesPro from tb_medica where F_ClaPro='" + request.getParameter("clave") + "'");
                    while (rset.next()) {
                        ban1 = 1;
                        cb = request.getParameter("cb");
                        clave = rset.getString("F_ClaPro");
                        descr = rset.getString("F_DesPro");
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("CodBar")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("SELECT MAX(F_IdCb) AS F_IdCb FROM tb_gencb");
                    while (rset.next()) {
                        ban1 = 1;
                        codbar2 = rset.getString("F_IdCb");
                    }
                    con.insertar("insert into tb_gencb values(0,'GNKL')");
                    descr = request.getParameter("descripci");
                    clave = request.getParameter("clave1");
                    Marca = request.getParameter("Marca");
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("descripcion")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select F_ClaPro, F_DesPro from tb_medica where F_DesPro='" + request.getParameter("descr") + "'");
                    while (rset.next()) {
                        ban1 = 1;
                        cb = request.getParameter("cb");
                        clave = rset.getString("F_ClaPro");
                        descr = rset.getString("F_DesPro");
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("refresh")) {
                try {
                    ban1 = 1;
                    descr = request.getParameter("descripci");
                    clave = request.getParameter("clave1");
                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("capturar")) {
                ban1 = 1;
                String cla_pro = request.getParameter("clave1");
                String Tipo = "", FechaC = "", FechaF = "";
                double Costo = 0.0, IVA = 0.0, Monto = 0.0, IVAPro = 0.0, MontoIva = 0.0;
                int fcdu = 0, anofec = 0;
                String lot_pro = request.getParameter("Lote");
                String cdd = request.getParameter("cdd");
                String cmm = request.getParameter("cmm");
                String caa = request.getParameter("caa");
                String FeCad = caa + "-" + cmm + "-" + cdd;

                try {
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

                    con.conectar();

                    ResultSet rset_medica = con.consulta("SELECT F_TipMed,F_Costo FROM tb_medica WHERE F_ClaPro='" + cla_pro + "'");
                    while (rset_medica.next()) {
                        Tipo = rset_medica.getString("F_TipMed");
                        Costo = Double.parseDouble(rset_medica.getString("F_Costo"));
                        if (Tipo.equals("2504")) {
                            IVA = 0.0;
                            fcdu = Integer.parseInt(caa);
                            anofec = fcdu - 3;
                        } else {
                            IVA = 0.16;
                            fcdu = Integer.parseInt(caa);
                            anofec = fcdu - 5;
                        }
                    }
                    String FeFab = anofec + "-" + cmm + "-" + cdd;
                    IVAPro = (cantidad * Costo) * IVA;
                    Monto = cantidad * Costo;
                    MontoIva = Monto + IVAPro;
                    /* FechaC = request.getParameter("Caducidad");
                     FechaF = request.getParameter("FecFab");
                     ResultSet Fechac = con.consulta("SELECT STR_TO_DATE('"+FechaC+"', '%d/%m/%Y')");
                     while(Fechac.next()){
                     FechaC= Fechac.getString("STR_TO_DATE('"+FechaC+"', '%d/%m/%Y')");
                     }
                     ResultSet Fechaf = con.consulta("SELECT STR_TO_DATE('"+FechaF+"', '%d/%m/%Y')");
                     while(Fechaf.next()){
                     FechaF= Fechaf.getString("STR_TO_DATE('"+FechaF+"', '%d/%m/%Y')");
                     }*/
                    con.insertar("insert into tb_compratemp values (0,curdate(),'" + cla_pro.toUpperCase() + "','" + lot_pro + "','" + FeCad + "','" + FeFab + "','" + request.getParameter("Marca") + "','" + request.getParameter("provee") + "','" + request.getParameter("cb") + "', '" + cantidad + "', '" + cajas + "', '" + piezas + "', '" + resto + "', '" + Costo + "', '" + IVAPro + "', '" + MontoIva + "' , '" + request.getParameter("folio_remi") + "', '" + request.getParameter("orden") + "','" + request.getParameter("provee") + "' ,'" + sesion.getAttribute("nombre") + "') ");
                    con.insertar("insert into tb_cb values(0,'" + request.getParameter("cb") + "','" + cla_pro.toUpperCase() + "','" + lot_pro + "','" + FeCad + "','" + FeFab + "')");
                    con.cierraConexion();

                } catch (Exception e) {

                }
            }
            if (request.getParameter("accion").equals("capturarcb")) {
                ban1 = 1;
                String cla_pro = request.getParameter("clave1");
                String Tipo = "", FechaC = "", FechaF = "";
                double Costo = 0.0, IVA = 0.0, Monto = 0.0, IVAPro = 0.0, MontoIva = 0.0;
                String lot_pro = request.getParameter("Lote");
                String FeCad = request.getParameter("cdd");
                String FeFab = request.getParameter("fdd");

                try {
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

                    con.conectar();

                    ResultSet rset_medica = con.consulta("SELECT F_TipMed,F_Costo FROM tb_medica WHERE F_ClaPro='" + cla_pro + "'");
                    while (rset_medica.next()) {
                        Tipo = rset_medica.getString("F_TipMed");
                        Costo = Double.parseDouble(rset_medica.getString("F_Costo"));
                        if (Tipo.equals("2504")) {
                            IVA = 0.0;
                        } else {
                            IVA = 0.16;
                        }
                    }

                    IVAPro = (cantidad * Costo) * IVA;
                    Monto = cantidad * Costo;
                    MontoIva = Monto + IVAPro;

                    ResultSet Fechac = con.consulta("SELECT STR_TO_DATE('" + FeCad + "', '%d/%m/%Y')");
                    while (Fechac.next()) {
                        FeCad = Fechac.getString("STR_TO_DATE('" + FeCad + "', '%d/%m/%Y')");
                    }
                    ResultSet Fechaf = con.consulta("SELECT STR_TO_DATE('" + FeFab + "', '%d/%m/%Y')");
                    while (Fechaf.next()) {
                        FeFab = Fechaf.getString("STR_TO_DATE('" + FeFab + "', '%d/%m/%Y')");
                    }
                    con.insertar("insert into tb_compratemp values (0,curdate(),'" + cla_pro.toUpperCase() + "','" + lot_pro + "','" + FeCad + "','" + FeFab + "','" + request.getParameter("Marca") + "','" + request.getParameter("provee") + "','" + request.getParameter("cb") + "', '" + cantidad + "', '" + cajas + "', '" + piezas + "', '" + resto + "', '" + Costo + "', '" + IVAPro + "', '" + MontoIva + "' , '" + request.getParameter("folio_remi") + "', '" + request.getParameter("orden") + "','" + request.getParameter("provee") + "' ,'" + sesion.getAttribute("nombre") + "') ");
                    con.insertar("insert into tb_cb values(0,'" + request.getParameter("cb") + "','" + cla_pro.toUpperCase() + "','" + lot_pro + "','" + FeCad + "','" + FeFab + "')");
                    con.cierraConexion();

                } catch (Exception e) {

                }
            }
        } catch (Exception e) {
        }
        request.getSession().setAttribute("folio", request.getParameter("folio"));
        request.getSession().setAttribute("fecha", request.getParameter("fecha"));
        request.getSession().setAttribute("folio_remi", request.getParameter("folio_remi"));
        request.getSession().setAttribute("orden", request.getParameter("orden"));
        request.getSession().setAttribute("provee", request.getParameter("provee"));
        request.getSession().setAttribute("recib", request.getParameter("recib"));
        request.getSession().setAttribute("entrega", request.getParameter("entrega"));
        request.getSession().setAttribute("clave", clave);
        request.getSession().setAttribute("descrip", descr);
        request.getSession().setAttribute("cuenta", Cuenta);
        request.getSession().setAttribute("cb", cb);
        request.getSession().setAttribute("codbar2", codbar2);
        request.getSession().setAttribute("Marca", Marca);

        //String original = "hello world";
        //byte[] utf8Bytes = original.getBytes("UTF8");
        //String value = new String(utf8Bytes, "UTF-8"); 
        //out.println(value);
        if (ban1 == 0) {
            out.println("<script>alert('Clave Inexistente')</script>");
            out.println("<script>window.location='captura.jsp'</script>");
        } else if (ban1 == 1) {
            out.println("<script>window.location='captura.jsp'</script>");
        } else if (ban1 == 2) {
            request.getSession().setAttribute("CBInex", "1");
            out.println("<script>alert('CB Inexistente, Favor de Llenar todos los Campos')</script>");
            out.println("<script>window.location='captura.jsp'</script>");
        }
        //response.sendRedirect("captura.jsp");
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
