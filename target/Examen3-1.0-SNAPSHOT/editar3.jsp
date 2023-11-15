<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Reservación</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container mt-5">
    <center>
    <h1>Editar Reservación</h1>
    </center>
    <form action="ControllerReservacion" method="post" style="max-width: 400px; margin: auto;">
        <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
            <label for="idReser" style="margin-bottom: 5px;">ID de Reservación:</label>
            <input type="text" id="idReser" name="idReser" style="padding: 8px; margin-bottom: 10px;" value="<%= request.getParameter("idReser") %>" readonly>
        </div>
        <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
            <label for="cliente" style="margin-bottom: 5px;">Cliente:</label>
            <input type="text" id="cliente" name="cliente" style="padding: 8px; margin-bottom: 10px;" value="<%= request.getParameter("cliente") %>">
        </div>
        <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
            <label for="fecha" style="margin-bottom: 5px;">Fecha:</label>
            <input type="date" id="fecha" name="fecha" style="padding: 8px; margin-bottom: 10px;" value="<%= request.getParameter("fecha") %>">
        </div>
        <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
            <label for="hora_llegada" style="margin-bottom: 5px;">Hora de Llegada:</label>
            <input type="time" id="hora_llegada" name="hora_llegada" style="padding: 8px; margin-bottom: 10px;" value="<%= request.getParameter("horaLlegada") %>">
        </div>
        <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
            <label for="hora_salida" style="margin-bottom: 5px;">Hora de Salida:</label>
            <input type="time" id="hora_salida" name="hora_salida" style="padding: 8px; margin-bottom: 10px;" value="<%= request.getParameter("horaSalida") %>">
        </div>
        <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
            <label for="cantidad" style="margin-bottom: 5px;">Cantidad de Personas:</label>
            <input type="number" id="cantidad" name="cantidad" style="padding: 8px; margin-bottom: 10px;" value="<%= request.getParameter("cantidad") %>">
        </div>
        <div style="display: flex; flex-direction: column; margin-bottom: 10px;">
            <label for="mesa" style="margin-bottom: 5px;">Mesa:</label>
            <select name="mesa" id="mesa" style="padding: 8px; margin-bottom: 10px;">
                <option value="Mesa1">Mesa1</option>
                <option value="Mesa2">Mesa2</option>
                <option value="Mesa3">Mesa3</option>
                <option value="Mesa4">Mesa4</option>
                <option value="Mesa5">Mesa5</option>
                <option value="Mesa6">Mesa6</option>
                <option value="Mesa7">Mesa7</option>
                <option value="Mesa8">Mesa8</option>
                <option value="Mesa9">Mesa9</option>
            </select>
        </div>
        <input type="submit" name="operacion" value="Editar" style="padding: 10px; background-color: #4CAF50; color: white; border: none; margin-bottom: 10px; cursor: pointer;">
    </form>
</div>

</body>
</html>
