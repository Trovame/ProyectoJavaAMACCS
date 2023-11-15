<%@page import="ModelosDAO.CategoriaDAO"%>
<%@page import="ModelosDAO.ProveedorDAO"%>
<%@page import="Modelos.Producto"%>
<%@page import="Modelos.Categoria"%>
<%@page import="Modelos.Proveedor"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <title>Platillos</title>
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
             .container {
            max-width: 100%;
        }

        /* Ensure the form elements take full width on small screens */
        .form-control {
            width: 100%;
        }

        .btn {
            margin-right: 0; /* Remove margin for buttons to ensure they align properly on small screens */
        }

        /* Adjust image size to be more responsive */
        .imagen-adaptable {
            max-width: 100%;
            height: auto;
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
        <script>
            function validarPrecio(input) {
                let valor = input.value;
                let puntoIndex = valor.indexOf('.');
                if (puntoIndex != -1) {
                    let decimales = valor.substring(puntoIndex + 1);
                    if (decimales.length > 2) {
                        input.value = valor.substring(0, puntoIndex + 3);
                    }
                }
            }

            function soloNumeros(event) {
                let charCode = event.keyCode;
                if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            }
        </script>


        <div>
            <jsp:include page="menu2.jsp"></jsp:include>
            </div>
            <div class="container">
                <br>
                <h1>Agregar Platillo</h1>
                <form action="ControllerProducto" method="post">
                    <div class="mb-3 row">
                        <label class="col-4 col-form-label" for="Nombre">Nombre del Platillo</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Nombre" id="Nombre" placeholder="Ingrese el nombre del platillo" required>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-4 col-form-label" for="Descripcion">Descripción</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Descripcion" id="Descripcion" placeholder="Ingrese la descripción del platillo" required>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-4 col-form-label" for="Precio">Precio $</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="Precio" id="Precio" placeholder="Ingrese el precio del platillo" oninput="validarPrecio(this)" onkeypress="return soloNumeros(event)" required>
                        </div>
                    </div>

                    <div class="mb-3 row">
                        <label class="col-4 col-form-label" for="tiempo">Tiempo de Preparación</label>
                        <div class="col-8">
                            <select class="form-control" name="tiempo" id="tiempo">
                                <option value="Desayuno">Desayuno</option>
                                <option value="Almuerzo">Almuerzo</option>
                                <option value="Cena">Cena</option>
                                <option value="Bebidas">Bebidas</option>
                                <option value="Siempre">Siempre</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-4 col-form-label" for="imagen">Imagen</label>
                        <div class="col-8">
                            <input type="file" class="form-control" name="imagen" id="imagen" placeholder="Ingrese la URL de la imagen del platillo" required>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-4 col-form-label" for="idProveedor">Proveedor</label>
                        <div class="col-8">
                            <select class="form-control" name="idProveedor" id="idProveedor">
                            <% List<Proveedor> proveedores = (List<Proveedor>) request.getAttribute("proveedores");
                        for (Proveedor proveedor : proveedores) {%>
                            <option value="<%= proveedor.getIdProveedor()%>"><%= proveedor.getNombreProveedor()%></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-4 col-form-label" for="idCategoria">Categoría</label>
                    <div class="col-8">
                        <select class="form-control" name="idCategoria" id="idCategoria">
                            <% List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
                        for (Categoria categoria : categorias) {%>
                            <option value="<%= categoria.getIdCategoria()%>"><%= categoria.getNombreCategoria()%></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <div class="offset-sm-4 col-sm-8">
                        <button  name="operacion" value="Agregar" type="submit" class="btn btn-primary">Agregar <i class="bi bi-person-add"></i></button>
                    </div>
                </div>
            </form>
        </div>



        <div class="container">
            <h1>Platillos</h1>
            <div class="container">
                                 <label for="cantidadRegistros">Mostrar registros por página:</label>
                        <select name="cantidadRegistros" id="cantidadRegistros" onchange="mostrarRegistros()">
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="25">25</option>
                            <option value="1000">Todos</option>
                        </select>
                        <table id="tablaProductos" border="1">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Proveedor</th>
                        <th>Categoría</th>
                        <th>Precio</th>
                        <th>Tiempo</th>
                        <th>Imagen</th>
                        <th>Acciones</th>
                    </tr>
                    <%
                        List<Producto> consulta = (List<Producto>) request.getAttribute("consulta");
                        for (Producto producto : consulta) {
                    %>
                    <tr>
                        <td><%= producto.getIdProducto()%></td>
                        <td><%= producto.getNombreProducto()%></td>
                        <td><%= obtenerNombreProveedor(producto.getIdProveedor())%></td>
                        <td><%= obtenerNombreCategoria(producto.getIdCategoria())%></td>
                        <td>$<%= producto.getPrecio()%></td>
                        <td><%= producto.getTiempo()%></td>
                        <td><img src="img/<%= producto.getImagen()%>" class="imagen-adaptable"></td>
                        <td>
                            <a class="btn btn-warning" href="editar2.jsp?idProducto=<%= producto.getIdProducto()%>&nombre=<%= producto.getNombreProducto()%>&idProveedor=<%= producto.getIdProveedor()%>&idCategoria=<%= producto.getIdCategoria()%>&precio=<%= producto.getPrecio()%>&tiempo=<%= producto.getTiempo()%>&imagen=<%= producto.getImagen()%>">Editar <i class="bi bi-pencil-square"></i></a><br><br>                               
                            <a href="javascript:void(0);" class="btn btn-danger" onclick="showConfirmation(<%= producto.getIdProducto()%>)">Eliminar  <i class="bi bi-trash"></i></a>
                        </td>
                    </tr>
                    <%
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
                    <c:set var="totalProductos" value="${consulta.size()}" />
                    <script>
                        var pagina = 1; // Página actual
                        var totalProductos = ${totalProductos}; // Asegúrate de que totalJefes esté disponible en el ámbito de la página
                        var registrosPorPagina = parseInt(document.getElementById("cantidadRegistros").value);
                        var totalPaginas = Math.ceil(totalProductos / registrosPorPagina);

                        function mostrarRegistros() {
                            // Aquí implementa la lógica para mostrar registros por página
                            var seleccion = document.getElementById("cantidadRegistros");
                            registrosPorPagina = parseInt(seleccion.value);
                            totalPaginas = Math.ceil(totalProductos / registrosPorPagina);

                            var tabla = document.getElementById("tablaProductos");
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
</div>
<%!
    public String obtenerNombreProveedor(int idProveedor) {
        try {
            ProveedorDAO proveedorDAO = new ProveedorDAO();
            Proveedor proveedor = proveedorDAO.search_by_id(idProveedor);
            return proveedor.getNombreProveedor();
        } catch (Exception e) {
            e.printStackTrace();
            return "Error al obtener el nombre del proveedor";
        }
    }

    public String obtenerNombreCategoria(int idCategoria) {
        try {
            CategoriaDAO categoriaDAO = new CategoriaDAO();
            Categoria categoria = categoriaDAO.search_by_id(idCategoria);
            return categoria.getNombreCategoria();
        } catch (Exception e) {
            e.printStackTrace();
            return "Error al obtener el nombre de la categoría";
        }
    }
%>

<div class="confirmation-modal" id="confirmationModal">
    <div class="confirmation-box">
        <p class="confirmation-message">¿Desea eliminar el Producto?</p>
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
                        text: '¿Desea eliminar el Producto?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#dc3545',
                        cancelButtonColor: '#6c757d',
                        confirmButtonText: 'Eliminar',
                        cancelButtonText: 'Cancelar'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Si se confirma, redirigir a ControllerVentas con el ID de la venta
                            window.location.href = 'ControllerProducto?idproducto=' + id;
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


