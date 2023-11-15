<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Modelos.Jefe"%>
<%@ page import="java.util.List"%>
<%@ page import="ModelosDAO.JefeDAO"%>
<%@ page import="java.util.ArrayList"%>
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
        <title>Jefes</title>
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

            /* Estilos del formulario */
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

            /* Estilos de la tabla */
            /* Estilos para los botones */
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

            .imagen-pequena {
                max-width: 40px; /* Ancho máximo de 70px */
                height: auto;
            }

            table {
                border-collapse: collapse;
                width: 100%;
                border: 1px solid #ddd;
            }

            th, td {
                text-align: left;
                padding: 8px;
                border: 1px solid #ddd;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #e9e9e9;
            }

            .password-field {
                font-family: "Arial", sans-serif;
            }
        </style>
    </head>
    <body>

        <div>
            <jsp:include page="menu2.jsp"></jsp:include>
            </div>

            <div class="container">
                <br>
                <h1>Agregar Jefe</h1>
                <br>
                <form method="post" action="ControllerJefe" enctype="multipart/form-data">
                    <div class="mb-3 row">
                        <label for="inputName" class="col-4 col-form-label">Nombres Jefe</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Nombres" id="nombres" placeholder="Ingrese el nombre del jefe" required>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="inputName" class="col-4 col-form-label">Apellidos</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Apellidos" id="apellidos" placeholder="Ingrese los apellidos del jefe" required>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="inputName" class="col-4 col-form-label">Correo</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Correo" id="correo" placeholder="Ingrese el correo del jefe" required  oninput="validarCorreo(this)">
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
                    </script>                    <div class="mb-3 row">
                        <label for="inputName" class="col-4 col-form-label">Usuario</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="usuario" id="usuario" placeholder="Ingrese el usuario del jefe" required>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="inputName" class="col-4 col-form-label">Contraseña</label>
                        <div class="col-8">
                            <input type="password" class="form-control" name="password" id="password" placeholder="Ingrese la contraseña del jefe" required>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="inputName" class="col-4 col-form-label">Imagen</label>
                        <div class="col-8">
                            <input type="file" class="form-control" name="imagen" id="imagen" required>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <div class="offset-sm-4 col-sm-8">
                            <button type="submit" class="btn btn-primary" name="operacion" value="Agregar">Agregar <i class="bi bi-person-add"></i></button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="container">
                <h1>Lista de Jefes</h1>
                <div class="container">
                    <label for="cantidadRegistros">Mostrar registros por página:</label>
                    <select name="cantidadRegistros" id="cantidadRegistros" onchange="mostrarRegistros()">
                        <option value="5">5</option>
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="1000">Todos</option>
                    </select>
                    <table id="tablaJefes">
                        <tr>
                            <th>ID</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Correo</th>
                            <th>Usuario</th>
                            <th>Contraseña</th>
                            <th>Imagen</th>
                            <th>Acciones</th>
                        </tr>
                    <%
                        JefeDAO jefeDAO = new JefeDAO();
                        List<Jefe> listaJefes = jefeDAO.listJefes();
                        for (Jefe jefe : listaJefes) {
                    %>
                    <tr>
                        <td><%=jefe.getIdJefe()%></td>
                        <td><%=jefe.getNombres()%></td>
                        <td><%=jefe.getApellidos()%></td>
                        <td><%=jefe.getCorreo()%></td>
                        <td><%=jefe.getUsuario()%></td>
                        <td class="password-field"><%=jefe.getPassword()%></td>
                        <td><img src="img/<%=jefe.getImagen()%>" class="imagen-pequena" alt="Imagen Jefe"></td>
                        <td>
                            <a href="javascript:void(0);" class="btn btn-danger" onclick="showConfirmation(<%= jefe.getIdJefe()%>)">Eliminar  <i class="bi bi-trash"></i></a>
                            <a class="btn btn-warning" href="editar5.jsp?id=<%= jefe.getIdJefe()%>&nombres=<%=jefe.getNombres()%>&apellidos=<%=jefe.getApellidos()%>&correo=<%=jefe.getCorreo()%>&usuario=<%=jefe.getUsuario()%>&password=<%=jefe.getPassword()%>&imagen=<%=jefe.getImagen()%>">Editar <i class="bi bi-pencil"></i></a>

                        </td>
                    </tr>
                    <% }%>
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
                <c:set var="totalJefes" value="${jefes.size()}" />
                <script>
                    var pagina = 1; // Página actual
                    var totalJefes = ${totalJefes}; // Asegúrate de que totalJefes esté disponible en el ámbito de la página
                    var registrosPorPagina = parseInt(document.getElementById("cantidadRegistros").value);
                    var totalPaginas = Math.ceil(totalJefes / registrosPorPagina);

                    function mostrarRegistros() {
                        // Aquí implementa la lógica para mostrar registros por página
                        var seleccion = document.getElementById("cantidadRegistros");
                        registrosPorPagina = parseInt(seleccion.value);
                        totalPaginas = Math.ceil(totalJefes / registrosPorPagina);

                        var tabla = document.getElementById("tablaJefes");
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
        <div class="confirmation-modal" id="confirmationModal">
            <div class="confirmation-box">
                <p class="confirmation-message">¿Desea eliminar el Administrador?</p>
                <div class="confirmation-buttons">
                    <button class="btn btn-danger" onclick="deleteVenta()">Eliminar</button>
                    <button class="btn btn-secondary" onclick="hideConfirmation()">Cancelar</button>
                </div>
            </div>
        </div>




        <script>
                        // Función para mostrar el mensaje de confirmación
                        function showConfirmation(id) {
                            Swal.fire({
                                title: 'Confirmación',
                                text: '¿Desea eliminar el Administrador?',
                                icon: 'warning',
                                showCancelButton: true,
                                confirmButtonColor: '#dc3545',
                                cancelButtonColor: '#6c757d',
                                confirmButtonText: 'Eliminar',
                                cancelButtonText: 'Cancelar'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    // Si se confirma, redirigir a ControllerVentas con el ID de la venta
                                    window.location.href = 'ControllerJefe?idJefe=' + id;
                                }
                            });
                        }



                        // Función para ocultar el mensaje de confirmación
                        function hideConfirmation() {
                            var modal = document.getElementById('confirmationModal');
                            modal.style.display = 'none';
                        }


        </script>
        <!-- Enlaces a Bootstrap JS y jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
<%
    }
%>

