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
    <title>Consulta de Ventas por Fecha</title>
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

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }

        label {
            font-size: 18px;
            margin-bottom: 10px;
        }

        input[type="date"] {
            padding: 8px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        h2 {
            margin-bottom: 30px;
        }

        .result-container {
            margin-top: 50px;
            text-align: center;
        }

        .result-label {
            font-size: 22px;
            font-weight: bold;
        }

        .result-value {
            font-size: 20px;
        }
    </style>
</head>
<body>
            <div>
            <jsp:include page="menu2.jsp"></jsp:include>
            </div>
            <div class="container mt-5">
                <center><h2>Ingrese la fecha para consultar las ventas:</h2></center>
    <form action="ControllerVentas" method="post">
        <label class="result-label"for="fecha">Fecha:</label>
        <input type="date" id="fecha" name="fecha" required>
        <br><br>
        <input type="submit" value="Consultar Ventas">
    </form>
     <%
        // Obtener el atributo totalVentas y fechaConsulta del request
        Integer totalVentas = (Integer) request.getAttribute("totalVentas");
        String fechaConsulta = (String) request.getAttribute("fechaConsulta");
        if (totalVentas != null && fechaConsulta != null) {
    %>
    <div class="result-container">
        <p class="result-label">Total de ventas para la fecha <%= fechaConsulta %>:</p>
        <p class="result-label">$<%= totalVentas %></p>
    </div>
    <%
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
