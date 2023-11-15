<%@page import="ModelosDAO.CategoriaDAO"%>
<%@page import="ModelosDAO.ProveedorDAO"%>
<%@page import="ModelosDAO.ProductoDAO"%>
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
<%
    ProductoDAO productoDAO = new ProductoDAO();
    List<Producto> productos = productoDAO.listProductos();
    request.setAttribute("consulta", productos);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
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
            .card {
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            .card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-top-left-radius: 5px;
                border-top-right-radius: 5px;
            }
            .card-body {
                padding: 15px;
            }
            .card-title {
                font-size: 1.25rem;
                font-weight: bold;
            }
            .card-text {
                color: #6c757d;
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            /* Estilos para el carrito de compras */
            .cart {
                position: fixed;
                top: 10px;
                right: 10px;
                background-color: #fff;
                border: 1px solid #ccc;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                padding: 10px;
                width: 250px;
            }
            .cart h2 {
                margin: 0;
            }
            .cart ul {
                list-style-type: none;
                padding: 0;
            }
            .cart li {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }
            .cart button {
                background-color: #333;
                color: #fff;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                width: 100%;
            }

            .imagen-adaptable {
                height: auto;
                width: auto;
            }
        </style>
         <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
      function agregarAlCarrito(imagen, nombre, precio, tiempo) {
        var date = new Date();
        var currentHour = date.getHours();
        var tiempoValido = true;
        var mensajeError = "";

        if (tiempo === "Desayuno" && currentHour >= 11) {
          tiempoValido = false;
          mensajeError = "El desayuno ya no está disponible después de las 11:00 am.";
        } else if (tiempo === "Almuerzo" && (currentHour < 11 || currentHour >= 17)) {
          tiempoValido = false;
          mensajeError = "El almuerzo solo está disponible de 11:00 am a 5:00 pm.";
        } else if (tiempo === "Cena" && (currentHour < 17 || currentHour >= 23)) {
          tiempoValido = false;
          mensajeError = "La cena solo está disponible de 5:00 pm a 10:00 pm.";
        }

        if (!tiempoValido) {
          Swal.fire({
            icon: "error",
            title: "Producto no disponible",
            text: mensajeError,
            confirmButtonColor: "#3085d6",
          });
        } else {
          var cantidad = prompt(
            "Ingrese la cantidad de " + nombre + " que desea agregar al carrito:",
            "1"
          );
          if (cantidad != null && cantidad > 0) {
            var total = parseFloat(precio) * parseInt(cantidad);
            window.location.href =
              "carrito.jsp?imagen=" +
              imagen +
              "&nombre=" +
              nombre +
              "&precio=" +
              precio +
              "&cantidad=" +
              cantidad +
              "&total=" +
              total;
          }
        }
      }
    </script>
    </head>
    <body>
        <div>
            <jsp:include page="menu.jsp"></jsp:include>
            </div>
            <br>
            <div class="container">
                <h1>Productos</h1>
                <br>
                <form action="ControllerSearch" method="get">
                    <div class="mb-3 row">
                        <label class="col-4 col-form-label" for="tiempo">Filtrar Productos</label>
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
                        <div class="offset-sm-4 col-sm-8">
                            <button type="submit" class="btn btn-primary" name="boton" value="FiltrarMesero">Buscar</button>
                        </div>
                    </div>
                </form>

                <br>
                <div class="container">
                    <div class="row row-cols-1 row-cols-md-3 g-4">
                    <% for (Producto producto : productos) {%>
                    <div class="col">
                        <div class="card">
                            <img src="img/<%= producto.getImagen()%>"  class="imagen-adaptable">
                            <div class="card-body">
                                <h5 class="card-title"><%= producto.getNombreProducto()%></h5>
                                <p class="card-text">Precio $<%= producto.getPrecio()%></p>
                                <p class="card-text">Tiempo: <%= producto.getTiempo()%></p>
                                <a  class="btn btn-danger" 
                                    onclick="agregarAlCarrito('<%=producto.getImagen()%>', '<%=producto.getNombreProducto()%>', '<%=producto.getPrecio()%>', '<%=producto.getTiempo()%>')">
                                    Agregar al Carrito</a></div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>

    </body>
</html>
<%
    }
%>


