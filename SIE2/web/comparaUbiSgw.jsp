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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.css">
        <!---->
        <title>SIE Sistema de Ingreso de Entradas</title>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4>
            <div class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="main_menu.jsp">Inicio</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">SIE <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="captura.jsp">Captura de Insumos</a></li>
                                    <li class="divider"></li>
                                    <li><a href="catalogo.jsp">Catálogo de Proveedores</a></li>
                                    <li><a href="reimpresion.jsp">Reimpresión de Docs</a></li>
                                    <li class="divider"></li>
                                    <li><a href="http://localhost:8088/Ubi">Ubicaciones</a></li>
                                    <li class="divider"></li>
                                    <li><a href="comparaUbiSgw.jsp">Diferencias SGW Ubicaciones</a></li>
                                </ul>
                            </li>
                            <!--li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">ADASU<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="captura.jsp">Captura de Insumos</a></li>
                                    <li class="divider"></li>
                                    <li><a href="catalogo.jsp">Catálogo de Proveedores</a></li>
                                    <li><a href="reimpresion.jsp">Reimpresión de Docs</a></li>
                                </ul>
                            </li-->
                            <%                                if (usua.equals("root")) {
                            %>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Usuario<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="usuarios/usuario_nuevo.jsp">Nuevo Usuario</a></li>
                                    <li><a href="usuarios/edita_usuario.jsp">Edicion de Usuarios</a></li>
                                </ul>
                            </li>
                            <%                                }
                            %>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href=""><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>

            <div class="text-center">
                <form method="post" name="form" id="form">
                    <div class="row">
                        <div class="col-lg-1">Filtrar por:</div>
                        <div class="col-lg-2">Cantidades en '0' <input name="ceros" type="checkbox" <% if (ceros.equals("on")) {
                                out.println("checked");
                            }%> onclick="this.form.submit();"></div>
                        <div class="col-lg-2"><button class="btn btn-block btn-primary" name="accion" value="clave">Clave</button></div>
                        <div class="col-lg-2"><button class="btn btn-block btn-success" name="accion" value="lote">Clave y Lote</button></div>
                        <div class="col-lg-2"><a href="excel/excelDiferencias.jsp?accion=clave&ceros=<%=ceros%>" target="_blank" class="btn btn-block btn-primary ">Exportar sin Lote</a></div>
                        <div class="col-lg-2"><a href="excel/excelDiferencias.jsp?accion=lote&ceros=<%=ceros%>" target="_blank" class="btn btn-block btn-success ">Exportar con Lote</a></div>
                    </div>
                </form>
                <br />
                <div>
                    <table class="table table-striped table-bordered" id="tablaComp">
                        <thead>
                            <tr>
                                <td>Clave</td>
                                <td>Descripcion</td>
                                <td>Lote</td>
                                <td>SGW</td>
                                <td>Ubicaciones</td>
                                <td>Diferencia</td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    con.conectar();
                                    try {
                                        ResultSet rset = con.consulta("select c.cla_pro, cm.descrip, c.lot_pro from comparativa c, clave_med cm where c.cla_pro = cm.clave order by c.cla_pro+0 asc ");
                                        while (rset.next()) {
                                            int c1 = 0, c2 = 0, c3 = 0;
                                            
                                            ResultSet rset2 = con.consulta("select can_pro from comparativa where cla_pro = '" + rset.getString(1) + "' and lot_pro = '" + rset.getString(3) + "' and base = 'SGW' ");
                                            while (rset2.next()) {
                                                c1 = (int) Double.parseDouble(rset2.getString(1));
                                            }
                                            rset2 = con.consulta("select can_pro from comparativa where cla_pro = '" + rset.getString(1) + "' and lot_pro = '" + rset.getString(3) + "' and base = 'UBICACIONES' ");
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <br><br><br>
        <div class="navbar navbar-fixed-bottom navbar-inverse">
            <div class="text-center text-muted">
                GNK Logística || Desarrollo de Aplicaciones 2009 - 2014 <span class="glyphicon glyphicon-registration-mark"></span><br />
                Todos los Derechos Reservados
            </div>
        </div>
    </body>
</html>


<!-- 
================================================== -->
<!-- Se coloca al final del documento para que cargue mas rapido -->
<!-- Se debe de seguir ese orden al momento de llamar los JS -->
<script src="js/jquery-1.9.1.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-ui-1.10.3.custom.js"></script>
<script src="js/jquery.dataTables.js"></script>
<script src="js/dataTables.bootstrap.js"></script>
<script>
                                $(document).ready(function() {
                                    $('#tablaComp').dataTable();
                                });
</script>