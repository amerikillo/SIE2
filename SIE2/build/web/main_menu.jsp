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
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
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
                                    <li><a href="captura_handheld.jsp">Captura de Insumos handheld</a></li>
                                    <li><a href="factura.jsp">Facturación Automática</a></li>
                                    <li><a href="requerimiento.jsp">Carga de Requerimiento</a></li>
                                    <li class="divider"></li>
                                    <li><a href="medicamento.jsp">Catálogo de Medicamento</a></li>
                                    <li><a href="catalogo.jsp">Catálogo de Proveedores</a></li>                                    
                                    <li><a href="marcas.jsp">Catálogo de Marcas</a></li>
                                    <li><a href="reimpresion.jsp">Reimpresión de Compras</a></li>
                                    <li><a href="reimp_factura.jsp">Reimpresión de Facturas</a></li>
                                    <li class="divider"></li>
                                    <li><a href="http://192.168.2.170:8081/UbicacionesConsolidado" target="_blank">Ubicaciones</a></li>
                                    
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
                            <%
                                if (usua.equals("root")) {
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
                <br /><br /><br />
                <img src="imagenes/Logo GNK claro2.jpg" width="200" height="100" alt="Logo GNK claro2"/>
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