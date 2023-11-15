<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    // Verifica si la sesión ya existe y si el usuario ha iniciado sesión
    HttpSession existingSession = request.getSession(false);
    if (existingSession == null || existingSession.getAttribute("nombreUsuario") == null) {
        response.sendRedirect("login.jsp");
    } else {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Proveedor</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            /* Estilos generales */
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                margin: 0;
                padding: 0;
            }

            .container {
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: 20px;
            }

            h1 {
                color: #333;
            }

            form {
                margin-top: 20px;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 3px;
                font-size: 16px;
            }

            .btn-primary {
                background-color: #007bff;
                color: #fff;
                border: none;
            }

            .btn {
                padding: 8px 12px;
                margin-right: 10px;
                text-decoration: none;
                color: #fff;
                border: none;
                cursor: pointer;
                border-radius: 3px;
            }

            .btn-danger {
                background-color: #dc3545;
            }

            .btn-primary {
                background-color: #007bff;
            }

            .btn-success {
                background-color: #28a745;
            }

            /* Estilos para los íconos */
            .btn img {
                width: 20px;
                height: 20px;
                margin-right: 5px;
            }

            /* Estilos para el mensaje de confirmación */
            .confirmation-modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 9999;
            }

            .confirmation-box {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            }

            .confirmation-message {
                font-size: 18px;
                margin-bottom: 20px;
            }

            .confirmation-buttons {
                text-align: right;
            }

            .confirmation-buttons button {
                margin-left: 10px;
            }
        </style>
    </head>
    <body>

        <div>
            <jsp:include page="menu2.jsp"></jsp:include>
            </div>

            <div class="container">
                <br>
                <h1>Agregar Proveedor</h1>
                <br>
                <form method="post" action="ControllerProveedor">
                    <div class="mb-3 row">
                        <label for="inputName" class="col-4 col-form-label">Nombre Proveedor</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Nombre" id="nombre_proveedor" placeholder="Ingrese el nombre del proveedor">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="inputPhone" class="col-4 col-form-label">Teléfono</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Telefono" id="telefono" placeholder="Ingrese el teléfono del proveedor">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="inputEmail" class="col-4 col-form-label">Correo</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Correo" id="correo" placeholder="Ingrese el correo del proveedor" required oninput="validarCorreo(this)">
                        </div>
                    </div>

                    <script>
                        function validarCorreo(input) {
                            let correo = input.value;
                            let re = /\S+@\S+\.\S+/;
                            if (!re.test(correo)) {
                                input.setCustomValidity('Por favor, ingrese un correo electrónico válido.');
                            } else {
                                input.setCustomValidity('');
                            }
                        }
                    </script>
                    <div class="mb-3 row">
                        <label for="inputAddress" class="col-4 col-form-label">Dirección</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Direccion" id="direccion" placeholder="Ingrese la dirección del proveedor">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <div class="offset-sm-4 col-sm-8">
                            <button type="submit" class="btn btn-primary">Agregar <i class="bi bi-person-add"></i></button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="container">
                <div class="container-table">
                    <div class="title">
                        <h1>Lista de Proveedores</h1>
                    </div>
                    <div class="container">
                        <label for="cantidadRegistros">Mostrar registros por página:</label>
                        <select name="cantidadRegistros" id="cantidadRegistros" onchange="mostrarRegistros()">
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="25">25</option>
                            <option value="0">Todos</option>
                        </select>
                        <table id="tablaProveedores" class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre del Proveedor</th>
                                    <th>Teléfono</th>
                                    <th>Correo</th>
                                    <th>Dirección</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody class="table__body-table">
                            <c:forEach items="${consulta}" var="proveedor">
                                <tr>
                                    <td>${proveedor.idProveedor}</td>
                                    <td>${proveedor.nombreProveedor}</td>
                                    <td>${proveedor.telefono}</td>
                                    <td>${proveedor.correo}</td>
                                    <td>${proveedor.direccion}</td>
                                    <td>
                                        <a class="btn btn-danger" href="ControllerProveedor?idProveedor=${proveedor.idProveedor}&accion=eliminar">Eliminar <i class="bi bi-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <br>
                    <div id="pagination">
                        <%-- Aquí se mostrarán los botones de número de página --%>
                        <c:forEach begin="1" end="${totalPaginas}" var="i">
                            <c:if test="${i <= totalPaginas}">
                                <button onclick="irAPagina(${i})">${i}</button>
                            </c:if>
                        </c:forEach>
                    </div>
                    <c:set var="totalProveedores" value="${consulta.size()}" />
                    <script>
                        var pagina = 1; // Página actual
                        var totalProveedores = ${totalProveedores}; // Asegúrate de que totalJefes esté disponible en el ámbito de la página
                        var registrosPorPagina = parseInt(document.getElementById("cantidadRegistros").value);
                        var totalPaginas = Math.ceil(totalProveedores / registrosPorPagina);

                        function mostrarRegistros() {
                            // Aquí implementa la lógica para mostrar registros por página
                            var seleccion = document.getElementById("cantidadRegistros");
                            registrosPorPagina = parseInt(seleccion.value);
                            totalPaginas = Math.ceil(totalProveedores / registrosPorPagina);

                            var tabla = document.getElementById("tablaProveedores");
                            var filas = tabla.rows.length;
                            var inicio = (pagina - 1) * registrosPorPagina + 1;
                            var fin = pagina * registrosPorPagina;
                            for (var i = 1; i < filas; i++) {
                                if (i >= inicio && i <= fin) {
                                    tabla.rows[i].style.display = "";
                                } else {
                                    tabla.rows[i].style.display = "none";
                                }
                            }
                            actualizarBotonesPaginacion();
                        }

                        function actualizarBotonesPaginacion() {
                            var paginacion = document.getElementById("pagination");
                            paginacion.innerHTML = "";
                            for (var i = 1; i <= totalPaginas; i++) {
                                if (i <= totalPaginas) {
                                    paginacion.innerHTML += '<button onclick="irAPagina(' + i + ')">' + i + '</button>';
                                }
                            }
                        }

                        function irAPagina(numeroPagina) {
                            pagina = numeroPagina;
                            mostrarRegistros();
                        }

                        function anteriorPagina() {
                            if (pagina > 1) {
                                pagina--;
                                mostrarRegistros();
                            }
                        }

                        function siguientePagina() {
                            if (pagina < totalPaginas) {
                                pagina++;
                                mostrarRegistros();
                            }
                        }
                    </script>
                </div>
            </div>
        </div>

         <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
<%
    }
%>

