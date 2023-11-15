<%@ page import="java.io.*,java.util.*,javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Verifica si la sesión ya existe y si el usuario ha iniciado sesión
    HttpSession existingSession = request.getSession(false);
    if (existingSession == null || existingSession.getAttribute("nombreUsuario") == null) {
        response.sendRedirect("login.jsp");
    } else {
%>
<!DOCTYPE html>
<html lang="es">
<head>
        <meta charset="UTF-8">
    <title>Registro</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

        h1 {
            color: #333;
        }

        
        .user-details {
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .user-image {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            object-fit: cover;
        }
        .logout-btn {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div>
    <jsp:include page="menu2.jsp"></jsp:include>
</div>
    <%
        HttpSession currentSession = request.getSession();
        String nombreUsuario = (String) currentSession.getAttribute("nombreUsuario");
        String correoUsuario = (String) currentSession.getAttribute("correoUsuario");
        String imagenUsuario = (String) currentSession.getAttribute("imagenUsuario");
        
        if(nombreUsuario == null) {
            nombreUsuario = "Nombre de usuario por defecto";
            currentSession.setAttribute("nombreUsuario", nombreUsuario);
        }
        if(correoUsuario == null) {
            correoUsuario = "correo@ejemplo.com";
            currentSession.setAttribute("correoUsuario", correoUsuario);
        }
        if(imagenUsuario == null) {
            imagenUsuario = "ruta/a/imagen-predeterminada.jpg";
            currentSession.setAttribute("imagenUsuario", imagenUsuario);
        }
    %>

    <div class="container">
        <div class="user-details text-center">
            <h2>Bienvenido, <%= nombreUsuario %>!</h2>
            <p><strong>Correo Electrónico:</strong> <%= correoUsuario %></p>
            <img src="img/<%= imagenUsuario %>" alt="Imagen de Usuario" class="user-image">
            <br>
            <br>
           <form action="ControllerLogin" method="post">
                <input type="hidden" name="accion" value="removeUserDetails">
                <button type="submit" class="btn btn-danger">Cerrar Sesión</button>
            </form> 
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%
    }
%>
