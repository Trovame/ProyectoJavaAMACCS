<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelos.Pedido" %>
<%@ page import="ModelosDAO.PedidoDAO" %>
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
        <title>Buscar Pedidos</title>
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
            .imagen-adaptable {
                width: 20%;
                height: 20%;
            }
        </style>
    </head>
    <body>
        <div>
            <jsp:include page="menu2.jsp"></jsp:include>
            </div>
            <div class="container">
                <h1>Pedidos</h1>
                <div class="container">
                    <form action="ControllerBuscar" method="post">
                        <input type="text" name="cliente" placeholder="Buscar por Cliente">
                        <input type="date" name="fecha" placeholder="Buscar por Fecha">
                        <button type="submit" class="btn btn-success">Buscar <i class="bi bi-search"></i></button>
                        <a href="ControllerPedido" class="btn btn-success">Todos los pedidos</a>

                    </form>

                    <br>
                    <table border="1">
                        <tr>
                            <th>N# Factura</th>
                            <th>Cliente</th>
                            <th>Mesa</th>
                            <th>Total</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th>Eliminar</th>
                            <th>Acción</th>
                        </tr>
                    <%
                        String cliente = request.getParameter("cliente");
                        String fecha = request.getParameter("fecha");
                        List<Pedido> listaPedidos = new PedidoDAO().listPedidos(cliente, fecha);
                        for (Pedido pedido : listaPedidos) {
                    %>
                    <tr>
                        <%
                            String estado = pedido.getEstado();
                            String accionBoton = "";
                            String link = "";
                            String idPedido = String.valueOf(pedido.getIdPedido());
                            String estadoPedido = pedido.getEstado();
                            if (estado.equals("Ordenado")) {
                                accionBoton = "Cobrar";
                                link = "ControllerHecho?idPedido=" + idPedido + "&estado=" + estadoPedido;
                            } else if (estado.equals("Cancelado")) {
                                accionBoton = "Ver detalle";
                                link = "ControllerHecho?idPedido=" + idPedido + "&estado=" + estadoPedido;
                            }
                        %>
                        <td><%= pedido.getIdPedido()%></td>
                        <td><%= pedido.getCliente()%></td>
                        <td><%= pedido.getMesa()%></td>
                        <td>$<%= pedido.getTotal()%></td>
                        <td><%= pedido.getFecha()%></td>
                        <td><%= pedido.getEstado()%></td>
                        <td><a href="javascript:void(0);" class="btn btn-danger" onclick="showConfirmation(<%= pedido.getIdPedido()%>)">Eliminar <i class="bi bi-trash"></i></a>
                        <td><a href="<%= link%>" class="btn btn-warning"><%= accionBoton%></a></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </div>
        <div class="confirmation-modal" id="confirmationModal">
            <div class="confirmation-box">
                <p class="confirmation-message">¿Desea eliminar el Pedido?</p>
                <div class="confirmation-buttons">
                    <button class="btn btn-danger" onclick="deleteVenta()">Eliminar</button>
                    <button class="btn btn-secondary" onclick="hideConfirmation()">Cancelar</button>
                </div>
            </div>
        </div>



        <!-- Bootstrap JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js" integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous"></script>

        <script>
                        // Función para mostrar el mensaje de confirmación
                        function showConfirmation(id) {
                            Swal.fire({
                                title: 'Confirmación',
                                text: '¿Desea eliminar el Pedido?',
                                icon: 'warning',
                                showCancelButton: true,
                                confirmButtonColor: '#dc3545',
                                cancelButtonColor: '#6c757d',
                                confirmButtonText: 'Eliminar',
                                cancelButtonText: 'Cancelar'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    // Si se confirma, redirigir a ControllerVentas con el ID de la venta
                                    window.location.href = 'ControllerPedido?idPedido=' + id + '&accion=eliminar';
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

