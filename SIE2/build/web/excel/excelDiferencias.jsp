<%-- 
    Document   : index
    Created on : 17/02/2014, 03:34:46 PM
    Author     : Americo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conn.*" %>
<!DOCTYPE html>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddhhmmss"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "attachment;filename=\"Diferencias.xls\"");
    HttpSession sesion = request.getSession();
    String usua = "";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
    } else {
        response.sendRedirect("index.jsp");
    }
    ConectionDB con = new ConectionDB();
    ConectionDB_SQLServer consql = new ConectionDB_SQLServer();
    String ceros = "";
    try {
        ceros = request.getParameter("ceros");
    } catch (Exception e) {
    }
    if (ceros == null) {
        ceros = "";
    }
    try {
        if (request.getParameter("accion").equals("lote")) {
            try {
                con.conectar();
                con.insertar("delete from comparativa");
                con.cierraConexion();
            } catch (Exception e) {

            }
            try {
                con.conectar();
                consql.conectar();
                try {
                    ResultSet rsetsql = consql.consulta("select F_ClaPro, F_ClaLot, sum(F_ExiLot) from TB_Lote group by F_ClaPro, F_Clalot");
                    while (rsetsql.next()) {
                        String clave = "";
                        clave = rsetsql.getString("F_ClaPro");
                        con.insertar("insert into comparativa values('" + clave + "', '" + rsetsql.getString(2) + "', '" + rsetsql.getString(3) + "', 'SGW', '0')");
                    }

                    ResultSet rset = con.consulta("select clave, lote, sum(cant) from datos_inv_cod group by clave, lote");
                    while (rset.next()) {
                        con.insertar("insert into comparativa values('" + rset.getString(1) + "', '" + rset.getString(2) + "', '" + rset.getString(3) + "', 'UBICACIONES', '0')");
                    }
                } catch (Exception e) {

                }
                consql.cierraConexion();
                con.cierraConexion();
            } catch (Exception e) {
            }
        }

        if (request.getParameter("accion").equals("clave")) {
            try {
                con.conectar();
                con.insertar("delete from comparativa");
                con.cierraConexion();
            } catch (Exception e) {

            }
            try {
                con.conectar();
                consql.conectar();
                try {
                    ResultSet rsetsql = consql.consulta("select F_ClaPro, sum(F_ExiLot) from TB_Lote group by F_ClaPro");
                    while (rsetsql.next()) {
                        String clave = "";
                        clave = rsetsql.getString("F_ClaPro");
                        con.insertar("insert into comparativa values('" + clave + "', '-', '" + rsetsql.getString(2) + "', 'SGW', '0')");
                    }

                    ResultSet rset = con.consulta("select clave, sum(cant) from datos_inv_cod group by clave");
                    while (rset.next()) {
                        con.insertar("insert into comparativa values('" + rset.getString(1) + "', '-', '" + rset.getString(2) + "', 'UBICACIONES', '0')");
                    }
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
                consql.cierraConexion();
                con.cierraConexion();
            } catch (Exception e) {
                out.println(e.getMessage());
            }

        }
    } catch (Exception e) {

    }

%>
<table>
    <tr>
        <td>Clave</td>
        <td>Descripcion</td>
        <td>Lote</td>
        <td>SGW</td>
        <td>Ubicaciones</td>
        <td>Diferencia</td>
    </tr>
    <%            try {
            con.conectar();
            try {
                ResultSet rset = con.consulta("select c.cla_pro, cm.descrip, c.lot_pro, c.can_pro from comparativa c, clave_med cm where c.cla_pro = cm.clave and c.base = 'SGW' order by c.cla_pro+0 asc ");
                while (rset.next()) {
                    int c1 = 0, c2 = 0, c3 = 0;
                    c1 = (int) Double.parseDouble(rset.getString(4));
                    ResultSet rset2 = con.consulta("select can_pro from comparativa where cla_pro = '" + rset.getString(1) + "' and lot_pro = '" + rset.getString(3) + "' and base = 'UBICACIONES' ");
                    while (rset2.next()) {
                        c2 = (int) Double.parseDouble(rset2.getString(1));
                    }

                    c3 = c1 - c2;
                    if (ceros.equals("on")) {
                        out.println("<tr>");
                        out.println("<td>" + rset.getString(1) + "</td>");
                        out.println("<td>" + rset.getString(2) + "</td>");
                        out.println("<td>" + rset.getString(3) + "</td>");
                        out.println("<td>" + c1 + "</td>");
                        out.println("<td>" + c2 + "</td>");
                        out.println("<td>" + c3 + "</td>");
                        out.println("</tr>");
                    } else {
                        if (c3 != 0) {
                            out.println("<tr>");
                            out.println("<td>" + rset.getString(1) + "</td>");
                            out.println("<td>" + rset.getString(2) + "</td>");
                            out.println("<td>" + rset.getString(3) + "</td>");
                            out.println("<td>" + c1 + "</td>");
                            out.println("<td>" + c2 + "</td>");
                            out.println("<td>" + c3 + "</td>");
                            out.println("</tr>");
                        }
                    }
                }
            } catch (Exception e) {
                out.println(e.getMessage());
            }
            con.cierraConexion();
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    %>
</table>