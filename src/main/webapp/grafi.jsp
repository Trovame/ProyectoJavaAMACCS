<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="Database.Conexion" %>
<%@ page import="java.io.*" %>
<%@ page import="com.google.gson.Gson" %>
<%
    // Verifica si la sesión ya existe y si el usuario ha iniciado sesión
    HttpSession existingSession = request.getSession(false);
    if (existingSession == null || existingSession.getAttribute("nombreUsuario") == null) {
        response.sendRedirect("login.jsp");
    } else {
%>
<%
    try {
        // Gráfico de los 5 productos más caros
        Conexion conProductos = new Conexion();
        Connection connProductos = conProductos.getConnection();

        Statement stmtProductos = connProductos.createStatement();
        String queryProductos = "SELECT Nombre, Precio FROM platillos ORDER BY Precio DESC LIMIT 5";
        ResultSet rsProductos = stmtProductos.executeQuery(queryProductos);

        List<String> labelsProductos = new ArrayList<>();
        List<Integer> dataProductos = new ArrayList<>();

        while (rsProductos.next()) {
            labelsProductos.add(rsProductos.getString("Nombre"));
            dataProductos.add(rsProductos.getInt("Precio"));
        }
        rsProductos.close();
        stmtProductos.close();
        connProductos.close();

        // Gráfico de las 5 mesas más reservadas
        Conexion conReservas = new Conexion();
        Connection connReservas = conReservas.getConnection();

        Statement stmtReservas = connReservas.createStatement();
        String queryReservas = "SELECT Mesa, COUNT(*) as TotalReservas FROM reservacion GROUP BY Mesa ORDER BY TotalReservas DESC LIMIT 5";
        ResultSet rsReservas = stmtReservas.executeQuery(queryReservas);

        List<String> labelsReservas = new ArrayList<>();
        List<Integer> dataReservas = new ArrayList<>();

        while (rsReservas.next()) {
            labelsReservas.add(rsReservas.getString("Mesa"));
            dataReservas.add(rsReservas.getInt("TotalReservas"));
        }
        rsReservas.close();
        stmtReservas.close();
        connReservas.close();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gráficos de pastel</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    <div style="display: flex; justify-content: space-around;">
        <div>
            <h2>Productos más caros</h2>
            <canvas id="chartProductos" width="200" height="200"></canvas>
        </div>
        <div>
            <h2>Mesas más reservadas</h2>
            <canvas id="chartReservas" width="200" height="200"></canvas>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Gráfico de productos más caros
            var ctxProductos = document.getElementById('chartProductos').getContext('2d');
            var chartProductos = new Chart(ctxProductos, {
                type: 'pie',
                data: {
                    labels: <%= new Gson().toJson(labelsProductos) %>,
                    datasets: [{
                        label: 'Precios',
                        data: <%= new Gson().toJson(dataProductos) %>,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(255, 206, 86, 0.7)',
                            'rgba(75, 192, 192, 0.7)',
                            'rgba(153, 102, 255, 0.7)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: 'Productos más caros'
                        }
                    }
                }
            });

            // Gráfico de mesas más reservadas
            var ctxReservas = document.getElementById('chartReservas').getContext('2d');
            var chartReservas = new Chart(ctxReservas, {
                type: 'pie',
                data: {
                    labels: <%= new Gson().toJson(labelsReservas) %>,
                    datasets: [{
                        label: 'Reservas',
                        data: <%= new Gson().toJson(dataReservas) %>,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(255, 206, 86, 0.7)',
                            'rgba(75, 192, 192, 0.7)',
                            'rgba(153, 102, 255, 0.7)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: 'Mesas más reservadas'
                        }
                    }
                }
            });
        });
    </script>
      <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%
    } catch (Exception e) {
        out.println(e);
    }
%>
<%
    }
%>
