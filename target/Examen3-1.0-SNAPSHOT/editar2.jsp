<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Producto</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"] {
            width: calc(100% - 12px);
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        input[type="file"] {
            margin-bottom: 20px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            background-color: #4CAF50;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
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

<%
    String idProducto = request.getParameter("idProducto") != null ? request.getParameter("idProducto") : "";
    String nombre = request.getParameter("nombre") != null ? request.getParameter("nombre") : "";
    String idProveedor = request.getParameter("idProveedor") != null ? request.getParameter("idProveedor") : "";
    String idCategoria = request.getParameter("idCategoria") != null ? request.getParameter("idCategoria") : "";
    String precio = request.getParameter("precio") != null ? request.getParameter("precio") : "";
    String tiempo = request.getParameter("tiempo") != null ? request.getParameter("tiempo") : "";
    String imagen = request.getParameter("imagen") != null ? request.getParameter("imagen") : "";
%>

<div class="container">
    <h1>Editar Producto</h1>

    <form action="ControllerProducto" method="post">
        <label>ID:</label>
        <input type="text" name="idProducto" value="<%= idProducto%>" readonly required>

        <label>Nombre:</label>
        <input type="text" name="Nombre" value="<%= nombre%>">

        <label>ID Proveedor:</label>
        <input type="text" name="idProveedor" value="<%= idProveedor%>" readonly required>

        <label>ID Categoría:</label>
        <input type="text" name="idCategoria" value="<%= idCategoria%>" readonly required>

        <label>Precio:</label>
        <input type="text" name="Precio" value="<%= precio%>" oninput="validarPrecio(this)" onkeypress="return soloNumeros(event)" required>

        <label>Tiempo de Preparación:</label>
        <input type="text" name="tiempo" value="<%= tiempo%>" readonly required>

        <label>Imagen:</label>
        <input type="file" name="imagen" value="<%= imagen%>" required>

        <input type="submit" name="operacion" value="Editar">

    </form>
</div>
</body>
</html>
