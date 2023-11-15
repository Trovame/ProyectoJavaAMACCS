<%@ page import="java.util.List, Modelos.Reservacion" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <title>Reservación</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
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
        .imagen-adaptable {
            width: 50%;
            height: auto;
        }
    </style>
</head>
<body>

    <div>
        <jsp:include page="menu2.jsp"></jsp:include>
        </div>
        <div class="container">
            <br>
            <center>
                <h1>Agregar Reservación</h1>
            </center>
            <form action="ControllerReservacion" method="post" style="max-width: 400px; margin: auto;">
                <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
                    <label for="cliente" style="margin-bottom: 5px;">Cliente:</label>
                    <input type="text" id="cliente" name="cliente" style="padding: 8px; margin-bottom: 10px;" required>
                </div>
                 <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
                    <label for="fecha" style="margin-bottom: 5px;">Fecha:</label>
                    <input type="date" id="fecha" name="fecha" style="padding: 8px; margin-bottom: 10px;" oninput="validarFecha()" required>
                    <p id="mensajeFecha" style="color: red; display: none;">Ingrese una fecha válida</p>
                </div>

                <script>
                    function validarFecha() {
                        var fechaInput = document.getElementById('fecha');
                        var mensajeFecha = document.getElementById('mensajeFecha');

                        var fechaIngresada = new Date(fechaInput.value + 'T00:00:00');  // Aseguramos que la hora sea 00:00:00 para comparación
                        var fechaActual = new Date();

                        // Comparamos solo las fechas sin la información de la hora
                        fechaIngresada.setHours(0, 0, 0, 0);
                        fechaActual.setHours(0, 0, 0, 0);

                        if (fechaIngresada < fechaActual) {
                            mensajeFecha.style.display = 'block';
                        } else {
                            mensajeFecha.style.display = 'none';
                        }
                    }
                </script>

                <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
                    <label for="hora_llegada" style="margin-bottom: 5px;">Hora de Llegada:</label>
                    <input type="time" id="hora_llegada" name="hora_llegada" style="padding: 8px; margin-bottom: 10px;" required>
                </div>
                <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
                    <label for="hora_salida" style="margin-bottom: 5px;">Hora de Salida:</label>
                    <input type="time" id="hora_salida" name="hora_salida" style="padding: 8px; margin-bottom: 10px;" required>
                </div>
                <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
                    <label for="cantidad" style="margin-bottom: 5px;">Cantidad de Personas:</label>
                    <input type="number" id="cantidad" name="cantidad" style="padding: 8px; margin-bottom: 10px;" oninput="validarCantidad()" min="1" max="8" required>
                    <p id="mensaje" style="color: red; display: none;">La cantidad máxima para una reservación es de 8.</p>
                </div>

                <script>
                    function validarCantidad() {
                        var input = document.getElementById('cantidad');
                        var mensaje = document.getElementById('mensaje');
                        if (input.value > 8) {
                            mensaje.style.display = 'block';
                        } else {
                            mensaje.style.display = 'none';
                        }
                    }
                </script>

                <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
                    <label for="mesa" style="margin-bottom: 5px;">Mesa:</label>
                    <select name="mesa" id="mesa" style="padding: 8px; margin-bottom: 10px;" required>
                        <option value="" disabled selected> --Selecciona la mesa-- </option>
                        <option value="Mesa1">Mesa1</option>
                        <option value="Mesa2">Mesa2</option>
                        <option value="Mesa3">Mesa3</option>
                        <option value="Mesa4">Mesa4</option>
                        <option value="Mesa5">Mesa5</option>
                        <option value="Mesa6">Mesa6</option>
                        <option value="Mesa7">Mesa7</option>
                        <option value="Mesa8">Mesa8</option>
                        <option value="Mesa9">Mesa9</option>
                    </select>
                </div>
                <input type="submit" name="operacion" value="Agregar" style="padding: 10px; background-color: #4CAF50; color: white; border: none; margin-bottom: 10px; cursor: pointer;">
            </form>

            <div class="container">
                <h1>Lista de Reservaciones</h1><a href="consulta.jsp" class="btn btn-success" style="padding: 10px; margin-bottom: 10px; text-decoration: none; color: white;">Buscar   <i class="bi bi-search"></i></a>

                <div class="container">
                    <label for="cantidadRegistros">Mostrar registros por página:</label>
                    <select name="cantidadRegistros" id="cantidadRegistros" onchange="mostrarRegistros()">
                        <option value="5">5</option>
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="1000">Todos</option>
                    </select>
                    <table id="tablaReservaciones" border="1">
                        <tr>
                            <th>ID</th>
                            <th>Cliente</th>
                            <th>Fecha</th>
                            <th>Hora de Llegada</th>
                            <th>Hora de Salida</th>
                            <th>Cantidad de Personas</th>
                            <th>Mesa</th>
                            <th>Acciones</th>
                        </tr>
                    <%
                        List<Modelos.Reservacion> listaReservaciones = (List<Modelos.Reservacion>) request.getAttribute("reservaciones");
                        if (listaReservaciones != null) {
                            for (Modelos.Reservacion reservacion : listaReservaciones) {
                    %>
                    <tr>
                        <td><%= reservacion.getIdreser()%></td>
                        <td><%= reservacion.getCliente()%></td>
                        <td><%= reservacion.getFecha()%></td>
                        <td><%= reservacion.getHoraLlegada()%></td>
                        <td><%= reservacion.getHoraSalida()%></td>
                        <td><%= reservacion.getCantidad()%></td>
                        <td ><%= reservacion.getMesa()%></td>
                        <td>

                            <a class="btn btn-warning" href="editar3.jsp?idReser=<%= reservacion.getIdreser()%>&cliente=<%= reservacion.getCliente()%>&fecha=<%= reservacion.getFecha()%>&horaLlegada=<%= reservacion.getHoraLlegada()%>&horaSalida=<%= reservacion.getHoraSalida()%>&cantidad=<%= reservacion.getCantidad()%>&mesa=<%= reservacion.getMesa()%>">Editar <i class="bi bi-pencil-square"></i></a>
                          <a class="btn btn-success" href="carrito2.jsp?cliente=<%= reservacion.getCliente()%>&fecha=<%= reservacion.getFecha()%>&mesa=<%= reservacion.getMesa()%>">Realizar Pedido</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                            // Código de manejo cuando no hay reservaciones
                            out.println("<tr><td colspan='7'>No hay reservaciones disponibles</td></tr>");
                        }
                    %>
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
                <c:set var="Reservar" value="${listaReservaciones.size()}" />
                <script>
                    var pagina = 1; // Página actual
                    var Reservar = ${Reservar}; // Asegúrate de que totalJefes esté disponible en el ámbito de la página
                    var registrosPorPagina = parseInt(document.getElementById("cantidadRegistros").value);
                    var totalPaginas = Math.ceil(Reservar / registrosPorPagina);

                    function mostrarRegistros() {
                        // Aquí implementa la lógica para mostrar registros por página
                        var seleccion = document.getElementById("cantidadRegistros");
                        registrosPorPagina = parseInt(seleccion.value);
                        totalPaginas = Math.ceil(Reservar / registrosPorPagina);

                        var tabla = document.getElementById("tablaReservaciones");
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
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                <script>
                    // Obtén el parámetro de la URL si es proporcionado
                    const urlParams = new URLSearchParams(window.location.search);
                    const error = urlParams.get('error');
                    const errorEdi = urlParams.get('errorEdi');

                    // Verifica si hay un error de agregar y muestra el mensaje de SweetAlert
                    if (error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Ya hay una reserva con estos datos'
                        }).then(() => {
                            window.location.href = "ControllerReservacion";
                        });
                    }

                    // Verifica si hay un error de editar y muestra el mensaje correspondiente
                    if (errorEdi) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Esta Reservacion no se puede editar, ya no esta disponible'
                        }).then(() => {
                            window.location.href = "ControllerReservacion";
                        });
                    }
                </script>

                <div class="confirmation-modal" id="confirmationModal">
                    <div class="confirmation-box">
                        <p class="confirmation-message">¿Desea eliminar el Pedido?</p>
                        <div class="confirmation-buttons">
                            <button class="btn btn-danger" onclick="deleteVenta()">Eliminar</button>
                            <button class="btn btn-secondary" onclick="hideConfirmation()">Cancelar</button>
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
                                        text: '¿Desea eliminar la Reservación?',
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#dc3545',
                                        cancelButtonColor: '#6c757d',
                                        confirmButtonText: 'Eliminar',
                                        cancelButtonText: 'Cancelar'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            // Si se confirma, redirigir a ControllerVentas con el ID de la venta
                                            window.location.href = 'ControllerReservacion?idreser=' + id + '&accion=eliminar';
                                        }
                                    });
                                }



                                // Función para ocultar el mensaje de confirmación
                                function hideConfirmation() {
                                    var modal = document.getElementById('confirmationModal');
                                    modal.style.display = 'none';
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
