<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
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
        <title>Carrito de Compras</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
            <div class="container mt-5">

            <%
                HttpSession currentSession = request.getSession();

                List<Map<String, Object>> carrito = (List<Map<String, Object>>) currentSession.getAttribute("carrito");
                if (carrito == null) {
                    carrito = new ArrayList<>();
                }
                String cliente = request.getParameter("cliente");
                String fecha = request.getParameter("fecha");
                String mesa = request.getParameter("mesa");

                // Guardar en la sesión si los parámetros no son nulos
                if (cliente != null) {
                    session.setAttribute("cliente", cliente);
                }
                if (fecha != null) {
                    session.setAttribute("fecha", fecha);
                }
                if (mesa != null) {
                    session.setAttribute("mesa", mesa);
                }

                if (request.getParameter("imagen") != null && request.getParameter("nombre") != null && request.getParameter("precio") != null && request.getParameter("cantidad") != null) {

                    String imagen = request.getParameter("imagen");
                    String nombre = request.getParameter("nombre");
                    double precio = Double.parseDouble(request.getParameter("precio"));
                    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
                    double total = precio * cantidad;

                    Map<String, Object> producto = new HashMap<>();
                    producto.put("imagen", imagen);
                    producto.put("nombre", nombre);
                    producto.put("precio", precio);
                    producto.put("cantidad", cantidad);
                    producto.put("total", total);

                    // Verificar si el producto ya existe en el carrito y actualizar la cantidad y el total si es así
                    boolean exists = false;
                    for (Map<String, Object> item : carrito) {
                        if (item.get("nombre").equals(nombre)) {
                            int existingQuantity = (int) item.get("cantidad");
                            item.put("cantidad", existingQuantity + cantidad);
                            item.put("total", precio * (existingQuantity + cantidad));
                            exists = true;
                            break;
                        }
                    }

                    if (!exists) {
                        carrito.add(producto);
                    }

                    currentSession.setAttribute("carrito", carrito);
                    response.sendRedirect("carrito2.jsp");
                }
                // Código para mostrar los productos de la sesión
                List<Map<String, Object>> productosCarrito = (List<Map<String, Object>>) currentSession.getAttribute("carrito");
            %>


            <div class="container">
                <h2>Carrito de Compras</h2>
                <% if (productosCarrito != null && !productosCarrito.isEmpty()) { %>
                <table>
                    <tr>
                        <th>Imagen</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Total</th>
                        <th>Aumentar</th>
                        <th>Disminuir</th>
                        <th>Eliminar</th>
                    </tr>
                    <% for (int i = 0; i < productosCarrito.size(); i++) {%>
                    <tr>
                        <td><img src="img/<%= productosCarrito.get(i).get("imagen")%>" class="imagen-adaptable"></td>
                        <td><%= productosCarrito.get(i).get("nombre")%></td>
                        <td>$<%= productosCarrito.get(i).get("precio")%></td>
                        <td><%= productosCarrito.get(i).get("cantidad")%></td>
                        <td>$<%= productosCarrito.get(i).get("total")%></td>
                        <td><button onclick="sumarCantidad(<%= i%>)" class="btn btn-success">+</button></td>
                        <td><button onclick="restarCantidad(<%= i%>)" class="btn btn-danger">-</button></td>
                        <td><button onclick="eliminarProducto(<%= i%>)" class="btn btn-danger">Eliminar</button></td> </tr>
                        <% } %>
                </table>
                <% } %>

                <%
                    double totalPagar = 0;
                    if (productosCarrito != null) {
                        for (Map<String, Object> item : productosCarrito) {
                            totalPagar += (double) item.get("total");
                        }
                    }
                %>
                <br>
                <br>
                <div class="row">
                    <div class="col">
                        <h4>Total a Pagar: $<%= totalPagar%></h4>
                        <br>
                        <div class="container">
                            <h2>Realizar Pedido</h2>

                            <form action="ControllerPedido" method="post" onsubmit="enviarYEliminar()">
                                <div class="form-group">
                                    <label for="Cliente">Cliente</label>
                                    <input type="text" class="form-control" id="cliente" name="Cliente" value="<%= session.getAttribute("cliente") != null ? session.getAttribute("cliente") : "" %>" <% if (session.getAttribute("cliente") != null) { %>readonly<% } %>  required>
                                </div>
                                <div class="form-group">
                                    <label for="Productos">Productos</label>
                                    <input type="text" class="form-control" id="productos" name="Productos" value="<%
                                        if (productosCarrito != null && !productosCarrito.isEmpty()) {
                                            StringBuilder productsInfo = new StringBuilder();
                                            for (Map<String, Object> item : productosCarrito) {
                                                productsInfo.append("Nombre: ").append((String) item.get("nombre"))
                                                        .append(", Cantidad: ").append((int) item.get("cantidad"))
                                                        .append(", Precio: ").append((double) item.get("precio"))
                                                        .append(", Total: ").append((double) item.get("total")).append("; ");
                                            }
                                            productsInfo.deleteCharAt(productsInfo.length() - 2); // Elimina el último punto y coma
                                            out.print(productsInfo.toString());
                                        } else {
                                            out.print("No hay productos en el carrito.");
                                        }
                                           %>" readonly required>
                                </div>
                                <div class="form-group">
                                    <label for="Mesa">Mesa</label>
                                    <input type="text" class="form-control" id="mesa" name="Mesa" 
                                           <% if (session.getAttribute("mesa") == null) { %>
                                           value="Para Llevar" 
                                           <% } else {%>
                                           value="<%= session.getAttribute("mesa")%>" readonly
                                           <% }%> 
                                           >
                                </div>
                                <div class="form-group">
                                    <label for="total">Total</label>
                                    <input type="number" class="form-control" id="total" name="total" value="<%= totalPagar%>" readonly required>
                                </div>
                                <div class="form-group">
                                    <label for="fecha">Fecha</label>
                                    <input type="text" class="form-control" id="fecha" name="fecha" value="<%= session.getAttribute("fecha") != null ? session.getAttribute("fecha") : "" %>" <% if (session.getAttribute("fecha") != null) { %>readonly<% } %> required>
                                </div>
                                <div class="form-group">
                                    <label for="estado">Estado</label>
                                    <input type="text" class="form-control" id="estado" name="estado" value="Ordenado" readonly required>
                                </div>
                                <button type="submit" name="eliminar" class="btn btn-primary" value="PedidoAdmin">Realizar Pedido</button>

                            </form>

                        </div>
                    </div>

                    <script>

                        function sumarCantidad(index) {
                            var xhr = new XMLHttpRequest();
                            xhr.open("POST", "", true);
                            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                            xhr.send("aumentar=" + index);
                            xhr.onload = function () {
                                location.reload();
                            };
                        }

                        function restarCantidad(index) {
                            var xhr = new XMLHttpRequest();
                            xhr.open("POST", "", true);
                            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                            xhr.send("disminuir=" + index);
                            xhr.onload = function () {
                                location.reload();
                            };
                        }

                        function eliminarProducto(index) {
                            var xhr = new XMLHttpRequest();
                            xhr.open("POST", "", true);
                            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                            xhr.send("eliminar2=" + index);
                            xhr.onload = function () {
                                location.reload();
                            };
                        }


                    </script>
                    <%
                        // Resto del código Java para manejar las solicitudes
                        String aumentarIndex = request.getParameter("aumentar");
                        String disminuirIndex = request.getParameter("disminuir");
                        String eliminarIndex = request.getParameter("eliminar2");
                        if (eliminarIndex != null) {
                            int index = Integer.parseInt(eliminarIndex);
                            if (index >= 0 && index < productosCarrito.size()) {
                                productosCarrito.remove(index);
                                currentSession.setAttribute("carrito", productosCarrito);
                            }
                        }

                        if (aumentarIndex != null) {
                            int index = Integer.parseInt(aumentarIndex);
                            Map<String, Object> item = productosCarrito.get(index);
                            int cantidadAumentar = (int) item.get("cantidad");
                            double precioAumentar = (double) item.get("precio");
                            cantidadAumentar++;
                            item.put("cantidad", cantidadAumentar);
                            item.put("total", precioAumentar * cantidadAumentar);
                            productosCarrito.set(index, item);
                            session.setAttribute("carrito", productosCarrito);
                        }

                        if (disminuirIndex != null) {
                            int index = Integer.parseInt(disminuirIndex);
                            Map<String, Object> item = productosCarrito.get(index);
                            int cantidadDisminuir = (int) item.get("cantidad");
                            double precioDisminuir = (double) item.get("precio");
                            if (cantidadDisminuir > 1) {
                                cantidadDisminuir--;
                                item.put("cantidad", cantidadDisminuir);
                                item.put("total", precioDisminuir * cantidadDisminuir);
                                productosCarrito.set(index, item);
                                session.setAttribute("carrito", productosCarrito);
                            }
                        }

                        double totalPagarSum = 0;
                        if (productosCarrito != null) {
                            for (Map<String, Object> item : productosCarrito) {
                                totalPagarSum += (double) item.get("total");
                            }
                        }
                    %>




                    <script>
                        function enviarYEliminar() {
                            var xhr = new XMLHttpRequest();
                            xhr.open("POST", "", true);
                            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                            xhr.send("eliminar=si");
                        }
                    </script>

                    <%
                        String eliminar = request.getParameter("eliminar");
                        if (eliminar != null) {
                            session.removeAttribute("carrito");
                            session.removeAttribute("cliente"); // Eliminar cliente
                            session.removeAttribute("fecha"); // Eliminar fecha
                            session.removeAttribute("mesa"); // Eliminar mesa

                        }
                    %>


                  
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

                    </body>
                    </html>
                    <%
                        }
                    %>