<%-- Código de editar5.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Modelos.Jefe"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Jefe</title>
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
          .password-toggle {
            position: relative;
        }

        .password-toggle input[type="password"] {
            padding-right: 30px;
        }

        .password-toggle .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>Editar Jefe</h1>
        <form method="post" action="ControllerJefe" enctype="multipart/form-data">   <div class="mb-3 row">
                <label for="id" class="col-4 col-form-label">ID Jefe</label>
                <div class="col-8">
                    <input type="text" class="form-control" name="id" id="id" value="<%= request.getParameter("id") %>" readonly required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="inputName" class="col-4 col-form-label">Nombres Jefe</label>
                <div class="col-8">
                    <input type="text" class="form-control" name="nombres" id="nombres" value="<%= request.getParameter("nombres") %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="inputName" class="col-4 col-form-label">Apellidos</label>
                <div class="col-8">
                    <input type="text" class="form-control" name="apellidos" id="apellidos" value="<%= request.getParameter("apellidos") %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="inputName" class="col-4 col-form-label">Correo</label>
                <div class="col-8">
                    <input type="text" class="form-control" name="correo" id="correo" value="<%= request.getParameter("correo") %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="inputName" class="col-4 col-form-label">Usuario</label>
                <div class="col-8">
                    <input type="text" class="form-control" name="usuario" id="usuario" value="<%= request.getParameter("usuario") %>" required>
                </div>
            </div>
                 <div class="mb-3 row">
            <label for="password" class="col-4 col-form-label">Contraseña</label>
            <div class="col-8 password-toggle">
                <input type="password" class="form-control" name="password" id="password" value="<%= request.getParameter("password") %>" aria-describedby="togglePassword" required>
                <span class="toggle-password" onclick="togglePasswordVisibility()">👁️</span>
            </div>
        </div>
            <div class="mb-3 row">
                <label for="inputName" class="col-4 col-form-label">Imagen</label>
                <div class="col-8">
                    <input type="file" class="form-control" name="imagen" id="imagen" value="<%= request.getParameter("imagen") %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <div class="offset-sm-4 col-sm-8">
                    <button type="submit" class="btn btn-primary" name="operacion" value="Editar">Actualizar <i class="bi bi-arrow-repeat"></i></button>
                </div>
            </div>
        </form>
    </div>
                                 <script>
        function togglePasswordVisibility() {
            var passwordInput = document.getElementById('password');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
            } else {
                passwordInput.type = 'password';
            }
        }
    </script>
<!-- Enlaces a Bootstrap JS y jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
