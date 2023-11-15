<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Cliente</title>
    <!-- Enlace a Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Estilos CSS personalizados -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Editar Cliente</h2>
        <form action="ControllerCliente" method="post">
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" name="nombre" class="form-control" value="<%= request.getParameter("nombre") %>"/>
            </div>
            <div class="form-group">
                <label for="apellidos">Apellidos:</label>
                <input type="text" name="apellidos" class="form-control" value="<%= request.getParameter("apellidos") %>"/>
            </div>
            <div class="form-group">
                <label for="sexo">Sexo:</label>
                <input type="text" name="sexo" class="form-control" value="<%= request.getParameter("sexo") %>"/>
            </div>
            <div class="form-group">
                <label for="direccion">Dirección:</label>
                <input type="text" name="direccion" class="form-control" value="<%= request.getParameter("direccion") %>"/>
            </div>
            <div class="form-group">
                <label for="telefono">Teléfono:</label>
                <input type="text" name="telefono" class="form-control" value="<%= request.getParameter("telefono") %>"/>
            </div>
            <div class="form-group">
                <label for="pais">País:</label>
                <input type="text" name="pais" class="form-control" value="<%= request.getParameter("pais") %>"/>
            </div>
            <div class="form-group">
                <label for="clave">Clave:</label>
                <input  type="password" name="clave" class="form-control" value="<%= request.getParameter("clave") %>" readonly/>
            </div>
            <div class="form-group">
                <label for="correo">Correo:</label>
                <input type="email" name="correo" class="form-control" value="<%= request.getParameter("correo") %>"/>
            </div>
            <input type="submit" value="Guardar Cambios" class="btn btn-primary"/>
        </form>
    </div>
    <!-- Enlace a Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
