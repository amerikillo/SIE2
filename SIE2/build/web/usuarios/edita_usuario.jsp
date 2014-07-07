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
        response.sendRedirect("../index.jsp");
    }
    ConectionDB con = new ConectionDB();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Estilos CSS -->
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="../css/navbar-fixed-top.css" rel="stylesheet">
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
                        <a class="navbar-brand" href="../main_menu.jsp">Inicio</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">SIE <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="../captura.jsp">Captura de Insumos</a></li>
                                    <li class="divider"></li>
                                    <li><a href="../catalogo.jsp">Catálogo de Proveedores</a></li>
                                    <li><a href="../reimpresion.jsp">Reimpresión de Docs</a></li>
                                    <li class="divider"></li>
                                    <li><a href="http://localhost:8088/Ubi">Ubicaciones</a></li>
                                    <li class="divider"></li>
                                    <li><a href="../comparaUbiSgw.jsp">Diferencias SGW Ubicaciones</a></li>
                                </ul>
                            </li>
                            <!--li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">ADASU<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="../captura.jsp">Captura de Insumos</a></li>
                                    <li class="divider"></li>
                                    <li><a href="../catalogo.jsp">Catálogo de Proveedores</a></li>
                                    <li><a href="../reimpresion.jsp">Reimpresión de Docs</a></li>
                                </ul>
                            </li-->
                            <%
                                if (usua.equals("root")) {
                            %>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Usuarios<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="usuario_nuevo.jsp">Nuevo Usuario</a></li>
                                    <li><a href="edita_usuario.jsp">Edicion de Usuarios</a></li>
                                </ul>
                            </li>
                            <%                                }
                            %>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href=""><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="../index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>

            <div>
                <h3>Alta de Usuarios</h3>
                <form class="form-horizontal" action="../Usuarios" name="formulario1" method="post">
                    <div class="form-group">
                        <label for="Nombre" class="col-sm-2 control-label">Nombre:</label>
                        <div class="col-sm-5">
                            <select class="form-control" id="Nombre" name="Nombre">
                                <option>Seleccione un usuario</option>
                                <%
                                    try {
                                        con.conectar();
                                        try {
                                            ResultSet rset = con.consulta("select nombre from usuarios");
                                            while (rset.next()) {
                                                out.println("<option value = '" + rset.getString("nombre") + "' >" + rset.getString("nombre") + "</option>");
                                            }
                                        } catch (Exception e) {
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                    }
                                %>
                            </select>
                        </div>
                    </div>  
                    <div class="form-group">
                        <label for="Apellido" class="col-sm-2 control-label">Apellido:</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="Apellido" name="Apellido" placeholder="Apellido" value=""/>
                        </div>
                    </div>  
                    <div class="form-group">
                        <label for="Pass" class="col-sm-2 control-label">Contraseña</label>
                        <div class="col-sm-2">
                            <input type="password" class="form-control" id="Pass" name="Pass" placeholder="Contraseña" value="">
                        </div>
                        <label for="Pass2" class="col-sm-1 control-label">Confirmar Contraseña</label>
                        <div class="col-sm-2">
                            <input type="password" class="form-control" id="Pass2" name="Pass2" placeholder="Contraseña" value="">
                        </div>
                    </div>
                    <div class="row">
                        <h6>Deben llenarse todos los campos</h6>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <button class="btn btn-success btn-block" name="accion" value="Modificar" onclick="return validaUsuario();">Modificar</button>
                        </div>
                        <div class="col-sm-6">
                            <button class="btn btn-danger btn-block" name="accion" value="Eliminar" onclick="return confirm('¿Seguro que desea eliminar al usuario?')">Eliminar</button>
                        </div>
                    </div>
                </form>
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
<script src="../js/jquery-1.9.1.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/jquery-ui-1.10.3.custom.js"></script>
<script>
                            function validaUsuario() {
                                var nom = document.formulario1.Nombre.value;
                                var ape = document.formulario1.Apellido.value;
                                var pass = document.formulario1.Pass.value;
                                var pass2 = document.formulario1.Pass2.value;
                                if (nom === "" || ape === "" || pass === "" || pass2 === "") {
                                    alert("Tiene valores vacíos, verifique");
                                    return false;
                                }
                                if (pass != pass2) {
                                    alert("Las contraseñas no coinciden");
                                    return false;
                                }
                                return true;
                            }
</script>