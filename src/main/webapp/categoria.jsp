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
        <title>Agregar Categorias</title>
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
                <h1>Agregar Categoría</h1>
                <br>
                <form method="post" action="ControllerCategoria">
                    <div class="mb-3 row">
                        <label for="inputName" class="col-4 col-form-label">Nombre Categoría</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Nombre" id="nombre_categoria" placeholder="Ingrese el nombre de la categoría" required>
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
                        <h1>Lista de Categorías</h1>
                    </div>
                    <div class="container">
                        <label for="cantidadRegistros">Mostrar registros por página:</label>
                        <select name="cantidadRegistros" id="cantidadRegistros" onchange="mostrarRegistros()">
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="25">25</option>
                            <option value="1000">Todos</option>
                        </select>
                        <table id="tablaEmpleados" class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre de la Categoria</th>
                                    <th>Acciones</th>

                                </tr>
                            </thead>
                            <tbody class="table__body-table">
                            <c:forEach items="${consulta}" var="categoria">
                                <tr>
                                    <td>${categoria.idCategoria}</td>
                                    <td>${categoria.nombreCategoria}</td>
                                    <td>
                                        <a href="javascript:void(0);" class="btn btn-danger" onclick="showConfirmation(${categoria.idCategoria})">Eliminar  <i class="bi bi-trash"></i></a>

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

                    <c:set var="totalCategorias" value="${listacategorias.size()}" />
                    <script>
                        var pagina = 1; // Página actual
                        var totalCategorias = ${totalCategorias}; // Asegúrate de que totalCategorias esté disponible en el ámbito de la página
                        var registrosPorPagina = parseInt(document.getElementById("cantidadRegistros").value);
                        var totalPaginas = Math.ceil(totalCategorias / registrosPorPagina);

                        function mostrarRegistros() {
                            // Aquí implementa la lógica para mostrar registros por página
                            var seleccion = document.getElementById("cantidadRegistros");
                            registrosPorPagina = parseInt(seleccion.value);
                            totalPaginas = Math.ceil(totalCategorias / registrosPorPagina);

                            var tabla = document.getElementById("tablaEmpleados");
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
        <div class="confirmation-modal" id="confirmationModal">
            <div class="confirmation-box">
                <p class="confirmation-message">¿Desea eliminar la Categoria?</p>
                <div class="confirmation-buttons">
                    <button class="btn btn-danger" onclick="deleteVenta()">Eliminar</button>
                    <button class="btn btn-secondary" onclick="hideConfirmation()">Cancelar</button>
                </div>
            </div>
        </div>

        <!-- Mensaje de error -->
        <div class="confirmation-modal" id="errorModal">
            <div class="confirmation-box">
                <p class="confirmation-message">Error: Esta Categoria no se puede eliminar</p>
                <div class="confirmation-buttons">
                    <button class="btn btn-primary" onclick="hideError()">Aceptar</button>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                        // Función para mostrar el mensaje de confirmación
                        function showConfirmation(id) {
                            Swal.fire({
                                title: 'Confirmación',
                                text: '¿Desea eliminar la Categoria?',
                                icon: 'warning',
                                showCancelButton: true,
                                confirmButtonColor: '#dc3545',
                                cancelButtonColor: '#6c757d',
                                confirmButtonText: 'Eliminar',
                                cancelButtonText: 'Cancelar'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    // Si se confirma, redirigir a ControllerVentas con el ID de la venta
                                    window.location.href = 'ControllerCategoria?idcategoria=' + id + '&action=delete';
                                }
                            });
                        }

                        // Función para mostrar el mensaje de error
                        function showError() {
                            var modal = document.getElementById('errorModal');
                            modal.style.display = 'block';
                        }

                        // Función para ocultar el mensaje de error
                        function hideError() {
                            var modal = document.getElementById('errorModal');
                            modal.style.display = 'none';
                        }

                        // Función para ocultar el mensaje de confirmación
                        function hideConfirmation() {
                            var modal = document.getElementById('confirmationModal');
                            modal.style.display = 'none';
                        }

                        // Función para eliminar una venta
                        function deleteVenta() {
                            // Lógica para eliminar la venta aquí
                            // Puedes usar AJAX para realizar la eliminación sin recargar la página
                        }
        </script>

        <c:if test="${not empty error}">
            <script>
                // Mostrar el mensaje de error si existe
                showError();
            </script>
        </c:if>
     
    </body>
</html>
<%
    }
%>


