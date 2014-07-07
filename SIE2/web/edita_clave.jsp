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
    String folio_gnk = "", fecha = "", folio_remi = "", orden = "", provee = "", recib = "", entrega = "", origen = "", coincide = "", observaciones = "", clave = "", descrip = "", cod_bar = "", um = "", lote = "", cadu = "", cajas = "", piezas = "", resto = "", marca = "", fec_fab="";
    try {
        folio_gnk = (String) session.getAttribute("folio");
        fecha = (String) session.getAttribute("fecha");
        folio_remi = (String) session.getAttribute("folio_remi");
        orden = (String) session.getAttribute("orden");
        provee = (String) session.getAttribute("provee");
        recib = (String) session.getAttribute("recib");
        entrega = (String) session.getAttribute("entrega");
        clave = (String) session.getAttribute("clave");
        descrip = (String) session.getAttribute("descrip");
    } catch (Exception e) {
    }
    try {
        con.conectar();
        ResultSet rset = con.consulta("SELECT L.F_Cb,C.F_ClaPro,M.F_DesPro,L.F_ClaLot,L.F_FecCad,C.F_CanCom,F_IdCom FROM tb_compra C INNER JOIN tb_lote L ON C.F_Lote=L.F_FolLot INNER JOIN tb_medica M ON C.F_ClaPro=M.F_ClaPro where F_IdCom = '" + ((String) sesion.getAttribute("id")) + "'");
        while (rset.next()) {
            clave = rset.getString("C.F_ClaPro");
            descrip = rset.getString("M.F_DesPro");
            cod_bar = rset.getString("L.F_Cb");
            marca = rset.getString("marca");
            um = rset.getString("um");
            lote = rset.getString("lote");
            cadu = rset.getString("cadu");
            cajas = rset.getString("cajas");
            piezas = rset.getString("piezas");
            resto = rset.getString("resto");
            fec_fab = rset.getString("fec_fab");
        }
        con.cierraConexion();
    } catch (Exception e) {

    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/datepicker3.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
        <!---->
        <title>SIE Sistema de Ingreso de Entradas</title>
        <!-- -->

    </head>

    <body>
        <div class="container">
            <h1>SIE</h1>
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

            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Edición de Insumo</h3>
                </div>
                <form class="form-horizontal" role="form" name="formulario1" id="formulario1" method="post" action="Modificaciones">
                    <div class="panel-body">
                        <div class="form-group">
                            <div class="form-group">
                                <label for="folio" class="col-sm-2 control-label">Folio GNK</label>
                                <div class="col-sm-2">
                                    <input type="folio" class="form-control" id="folio" name="folio" placeholder="Folio" readonly value="<%=folio_gnk%>"/>
                                </div>
                                <label for="fecha" class="col-sm-1 control-label">ID</label>
                                <div class="col-sm-2">
                                    <input type="fecha" class="form-control" id="id" name="id" placeholder="Fecha" readonly value="<%=((String) sesion.getAttribute("id"))%>">
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-block btn-success"  href="captura.jsp" >Regresar</a>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="fol_rem" class="col-sm-2 control-label">Folio Remisión</label>
                                <div class="col-sm-3">
                                    <input type="fol_rem" class="form-control" id="folio_remi" name="folio_remi" placeholder="Folio Remisión" onKeyPress="return tabular(event, this)"  value="<%=folio_remi%>" readonly>
                                </div>
                                <label for="orden" class="col-sm-2 control-label">Orden de Compra</label>
                                <div class="col-sm-3">
                                    <input type="orden" class="form-control" id="orden" name="orden" placeholder="Orden de Compra" onKeyPress="return tabular(event, this)" value="<%=orden%>"/ readonly="readonly">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="prov" class="col-sm-2 control-label">Proveedor</label>
                                <div class="col-sm-3">
                                    <input type="prov" class="form-control" id="provee" name="provee" placeholder="Proveedor" onKeyPress="return tabular(event, this)" value="<%=provee%>" readonly />
                                </div>
                                <!--div class="col-sm-3">
                                    <select class="form-control" name="list_provee" id="list_provee" onchange="proveedor();">
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta("select f_nomprov from provee_all");
                                        while (rset.next()) {
                                            out.println("<option value = '" + rset.getString("f_nomprov") + "'>" + rset.getString("f_nomprov") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                    }
                                %>
                            </select>
                        </div-->

                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="recib" class="col-sm-2 control-label">Recibido por</label>
                                <div class="col-sm-3">
                                    <input type="recib" class="form-control" id="recib" name="recib" placeholder="Recibe" onKeyPress="return tabular(event, this)" value = "<%=usua%>" readonly>
                                </div>
                                <label for="entrega" class="col-sm-2 control-label">Entregado por</label>
                                <div class="col-sm-3">
                                    <input type="entrega" class="form-control" id="entrega" name="entrega" placeholder="Entrega" onKeyPress="return tabular(event, this)"  value="<%=entrega%>" readonly />
                                </div>
                            </div>
                        </div>
                     
                        <!-- En duda -->
                        <!--button class="btn btn-block btn-info">Guardar</button-->
                        <!-- En duda -->
                    </div>
                    <div class="panel-footer">
                        <div class="form-group">
                            <div class="form-group">
                                <label for="clave1" class="col-sm-1 control-label">Clave</label>
                                <div class="col-sm-2">
                                    <input type="clave1" class="form-control" id="clave1" name="clave1" placeholder="Clave" value="<%=clave%>" readonly onKeyPress="return tabular(event, this)">
                                </div>
                                <label for="descr1" class="col-sm-1 control-label">Descripción</label>
                                <div class="col-sm-3">
                                    <textarea class="form-control" name="descripci" id="descripci" readonly onKeyPress="return tabular(event, this)"><%=descrip%></textarea>
                                </div>
                                <label for="cb" class="col-sm-2 control-label">Código de Barras</label>
                                <div class="col-sm-2">
                                    <input type="cb" class="form-control" id="cb" name="cb" placeholder="C. B." onKeyPress="return tabular(event, this)" value="<%=cod_bar%>" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="Marca" class="col-sm-1 control-label">Marca</label>
                                <div class="col-sm-2">
                                    <input type="Marca" class="form-control" id="Marca" name="Marca" placeholder="Marca" onKeyPress="return tabular(event, this)" value="<%=marca%>" />
                                </div>
                                <label for="pres" class="col-sm-1 control-label">Presentación</label>
                                <div class="col-sm-2">
                                    <textarea class="form-control" placeholder="Presentación" name="pres" onKeyPress="return tabular(event, this)" ><%=um%></textarea>
                                </div>
                                <label for="Lote" class="col-sm-1 control-label">Lote</label>
                                <div class="col-sm-2">
                                    <input type="Lote" class="form-control" id="Lote" name="Lote" placeholder="Lote" onKeyPress="return tabular(event, this)" value="<%=lote%>" />
                                </div>
                                <label for="FecFab" class="col-sm-1 control-label">Fec Fab</label>
                                <div class="col-sm-2">
                                    <input data-date-format="dd/mm/yyyy" readonly="readonly" type="text" class="form-control" id="FecFab" name="FecFab" placeholder="FecFab" onKeyPress="LP_data();
                                            anade(this);
                                            return tabular(event, this)" maxlength="10" value="<%=fec_fab%>" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="Caducidad" class="col-sm-1 control-label">Cadu</label>
                                <div class="col-sm-2">
                                    <input data-date-format="dd/mm/yyyy" type="text" readonly="readonly" class="form-control" id="Caducidad" name="Caducidad" placeholder="Caducidad" onKeyPress="return tabular(event, this)" value="<%=cadu%>" />
                                </div>
                                <label for="Cajas" class="col-sm-1 control-label">Cajas</label>
                                <div class="col-sm-1">
                                    <input type="Cajas" class="form-control" id="Cajas" name="Cajas" placeholder="Cajas" onKeyPress="return justNumbers(event);"  value="<%=cajas%>" />
                                </div>
                                <label for="pzsxcaja" class="col-sm-2 control-label">Pzs x Caja</label>
                                <div class="col-sm-2">
                                    <input type="pzsxcaja" class="form-control" id="pzsxcaja" name="pzsxcaja" placeholder="Pzs x Caja" onKeyPress="return justNumbers(event);"  value="<%=piezas%>" />
                                </div>
                                <label for="Resto" class="col-sm-1 control-label">Resto</label>
                                <div class="col-sm-1">
                                    <input type="Resto" class="form-control" id="Resto" name="Resto" placeholder="Resto" onKeyPress="return justNumbers(event);"  value="<%=resto%>" />
                                </div>
                            </div>
                        </div>
                        <!-- En duda -->
                        <button class="btn btn-block btn-primary" type="submit" name="accion" value="actualizar" onclick="return (validaCapturaVacios());">Actualizar</button>
                        <!-- En duda -->
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

<script src="js/jquery-1.9.1.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-ui-1.10.3.custom.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script>
                                    $(function() {
                                        $("#Caducidad").datepicker();
                                        $("#Caducidad").datepicker('option', {dateFormat: 'dd/mm/yy'});
                                    });
                                    $(function() {
                                        $("#FecFab").datepicker();
                                        $("#FecFab").datepicker('option', {dateFormat: 'dd/mm/yy'});
                                    });
</script>
<script>
    $(function() {
        var availableTags = [
    <%
        try {
            con.conectar();
            ResultSet rset = con.consulta("select descrip from clave_med");
            while (rset.next()) {
                out.println("\'" + rset.getString("descrip") + "\',");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
    %>
        ];
        $("#descr").autocomplete({
            source: availableTags
        });
    });
</script>
<script>
    $(function() {
        var availableTags = [
    <%
        try {
            con.conectar();
            ResultSet rset = con.consulta("select f_nomprov from provee_all");
            while (rset.next()) {
                out.println("\'" + rset.getString("f_nomprov") + "\',");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
    %>
        ];
        $("#provee").autocomplete({
            source: availableTags
        });
    });
</script>
<script>
    function ubi() {
        var ubi = document.formulario1.ubica.value;
        document.formulario1.ubicacion.value = ubi;
    }
    function proveedor() {
        var proveedor = document.formulario1.list_provee.value;
        document.formulario1.provee.value = proveedor;
    }
    function orig() {
        var origen = document.formulario1.ori.value;
        document.formulario1.origen.value = origen;
    }
</script>
<script> // este script hace que tabule el enter !!!


    function tabular(e, obj)
    {
        tecla = (document.all) ? e.keyCode : e.which;
        if (tecla != 13)
            return;
        frm = obj.form;
        for (i = 0; i < frm.elements.length; i++)
            if (frm.elements[i] == obj)
            {
                if (i == frm.elements.length - 1)
                    i = -1;
                break
            }
        /*ACA ESTA EL CAMBIO*/
        if (frm.elements[i + 1].disabled == true)
            tabular(e, frm.elements[i + 1]);
        else
            frm.elements[i + 1].focus();
        return false;
    }

    function foco() {
        if (document.formulario1.folio_remi.value !== "") {
            document.formulario1.clave.focus();
        }
        if (document.formulario1.clave1.value !== "") {
            document.formulario1.cb.focus();
            document.location.href = "#ancla";
        }
    }


    function validaCapturaVacios() {
        var mensaje = "\n";
        var RegExPattern = /^\d{1,2}\/\d{1,2}\/\d{4,4}$/;
        var folio_remi = document.formulario1.folio_remi.value;
        if (folio_remi === "")
            mensaje = mensaje + "Folio de Remisión vacío \n";
        var orden = document.formulario1.orden.value;
        if (orden === "")
            mensaje = mensaje + "Orden de compra vacía \n";
        var provee = document.formulario1.provee.value;
        if (provee === "")
            mensaje = mensaje + "Proveedor vacío \n";
        var recib = document.formulario1.recib.value;
        if (recib === "")
            mensaje = mensaje + "Recibe vacío \n";
        var entrega = document.formulario1.entrega.value;
        if (entrega === "")
            mensaje = mensaje + "Entrega vacío \n";
        var clave1 = document.formulario1.clave1.value;
        if (clave1 === "")
            mensaje = mensaje + "Clave de producto vacía \n";
        var descripci = document.formulario1.descripci.value;
        if (descripci === "")
            mensaje = mensaje + "Descripción vacía \n";
        var cb = document.formulario1.cb.value;
        if (cb === "")
            mensaje = mensaje + "Código de Barras vacío \n";
        var Caducidad = document.formulario1.Caducidad.value;
        if (Caducidad === "")
            mensaje = mensaje + "Caducidad vacía \n";
        var FecFab = document.formulario1.FecFab.value;
        if (FecFab === "")
            mensaje = mensaje + "Fecha de elaboración vacía \n";
        var Marca = document.formulario1.Marca.value;
        if (Marca === "")
            mensaje = mensaje + "Campo de Marca vacío \n";
        var pres = document.formulario1.pres.value;
        if (pres === "")
            mensaje = mensaje + "Campo Presentación vacío \n";
        var Lote = document.formulario1.Lote.value;
        if (Lote === "")
            mensaje = mensaje + "Campo Lote vacío \n";
        var Obser = document.formulario1.observaciones.value;
        if (Obser === "")
            mensaje = mensaje + "Campo de observaciones vacío \n";


        var Cajas = document.formulario1.Cajas.value;
        if (Cajas === "")
            Cajas = parseInt(0);
        var pzsxcaja = document.formulario1.pzsxcaja.value;
        if (pzsxcaja === "")
            pzsxcaja = parseInt(0);
        var Resto = document.formulario1.Resto.value;
        if (Resto === "")
            Resto = parseInt(0);
        var total = (Cajas * pzsxcaja) + Resto;

        if (folio_remi === "" || orden === "" || provee === "" || recib === "" || entrega === "" || clave1 === "" || descripci === "" || cb === "" || Caducidad === "" || Obser === "" || Marca === "" || pres === "" || Lote === "") {
            alert("Tiene campos vacíos, verifique." + mensaje + "");
            return false;
        }

        if (parseInt(total) === 0) {
            alert("El total de piezas no puede ser \'0\' ");
            return false;
        }

        var dtFechaActual = new Date();
        var dtFechaActualFB = new Date();
        var sumarDias = parseInt(93);
        dtFechaActual.setDate(dtFechaActual.getDate() + sumarDias);
        var cadu = Caducidad.split('/');
        var cad = cadu[2] + '-' + cadu[1] + "-" + cadu[0]

        var fecfa = FecFab.split('/');
        var fecf = fecfa[2] + '-' + fecfa[1] + "-" + fecfa[0]

        if (Date.parse(dtFechaActual) > Date.parse(cad)) {
            alert("La fecha de caducidad no puede ser menor a tres meses próximos");
            return false;
        }
        if (Date.parse(dtFechaActualFB) < Date.parse(fecf)) {
            alert("La fecha de fabricacion no puede ser mayor a la fecha actual.");
            return false;
        }

        if ((Caducidad.match(RegExPattern)) && (Caducidad != '')) {
        } else {
            alert("Caducidad Incorrecta, verifique.");
            return false;
        }

        return true;

    }


    function validaCompra() {
        var RegExPattern = /^\d{1,2}\/\d{1,2}\/\d{2,4}$/;
        var folio_remi = document.formulario1.folio_remi.value;
        var orden = document.formulario1.orden.value;
        var provee = document.formulario1.provee.value;
        var recib = document.formulario1.recib.value;
        var entrega = document.formulario1.entrega.value;
        var Obser = document.formulario1.observaciones.value;
        if (folio_remi === "" || orden === "" || provee === "" || recib === "" || entrega === "" || Obser === "") {
            alert("Tiene campos vacíos, verifique.");
            return false;
        }
        return true;
    }
</script>
<script type="text/javascript">
    function justNumbers(e)
    {
        var keynum = window.event ? window.event.keyCode : e.which;
        if ((keynum == 8) || (keynum == 46))
            return true;

        return /\d/.test(String.fromCharCode(keynum));
    }
</script>

<script language="javascript">
    otro = 0;
    function LP_data() {
        var key = window.event.keyCode;//codigo de tecla. 
        if (key < 48 || key > 57) {//si no es numero 
            window.event.keyCode = 0;//anula la entrada de texto. 
        }
    }
    function anade(esto) {
        if (esto.value.length > otro) {
            if (esto.value.length == 2) {
                esto.value += "/";
            }
        }
        if (esto.value.length > otro) {
            if (esto.value.length == 5) {
                esto.value += "/";
            }
        }
        if (esto.value.length < otro) {
            if (esto.value.length == 2 || esto.value.length == 5) {
                esto.value = esto.value.substring(0, esto.value.length - 1);
            }
        }
        otro = esto.value.length
    }

</script> 