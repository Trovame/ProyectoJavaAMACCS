<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Modelos.Pedido" %>
<%
    // Verifica si la sesión ya existe y si el usuario ha iniciado sesión
    HttpSession existingSession = request.getSession(false);
    if (existingSession == null || existingSession.getAttribute("nombreUsuario") == null) {
        response.sendRedirect("login.jsp");
    } else {
%>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalle</title>
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
            margin-top: 0;
        }

        .card {
            width: 50%;
            margin: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
    </style>
</head>
<body>
         <div>
            <jsp:include page="menu2.jsp"></jsp:include>
            </div>
    <div class="container">
        <h1>Detalles del pedido</h1>
        <% Pedido pedido = (Pedido) request.getAttribute("pedido"); %>
        <table class="table table-bordered">
            <tr class="table-heading">
                <th>ID Pedido</th>
                <td width="370px"><%= pedido.getIdPedido() %></td>
            </tr>
            <tr>
                <th>Cliente</th>
                <td width="370px"><%= pedido.getCliente() %></td>
            </tr>
            <tr>
                <th>Detalle</th>
                <td width="640px"><%= pedido.getProductos() %></td>
            </tr>
            <tr>
                <th>Mesa</th>
                <td width="370px"><%= pedido.getMesa() %></td>
            </tr>
            <tr>
                <th>Total</th>
                <td width="370px"><%= pedido.getTotal() %></td>
            </tr>
            <tr>
                <th>Fecha</th>
                <td width="370px"><%= pedido.getFecha() %></td>
            </tr>
            <tr>
                <th>Estado</th>
                <td width="370px"><%= pedido.getEstado() %></td>
            </tr>
        </table>
    </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%
    }
%>

