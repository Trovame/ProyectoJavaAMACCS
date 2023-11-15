<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Examen 3</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
            background-color: #f4f4f4;
        }
        .navbar {
            background-color: #343a40;
        }
        .navbar-brand, .nav-link {
            color: #000 !important;
            font-weight: 600;
            padding: 10px 20px;
            margin: 0 10px;
            transition: all 0.3s;
        }
        .navbar-brand:hover, .nav-link:hover {
            color: #ffc107 !important;
        }
        .navbar-nav {
            margin-left: auto;
        }
        .navbar-nav .nav-link {
            position: relative;
        }
        .navbar-nav .nav-link::before {
            content: "";
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #ffc107;
            visibility: hidden;
            transition: all 0.3s;
        }
        .navbar-nav .nav-link:hover::before {
            visibility: visible;
            width: 100%;
        }
        .navbar-toggler {
            border: none;
            background-color: transparent !important;
        }
        .navbar-toggler:focus {
            outline: none;
        }
        .navbar-toggler-icon {
            background-color: #fff;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="index2.jsp">Usuario</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                   
                     <li class="nav-item">
                        <a class="nav-link" href="reservar2.jsp">Reservaciones</a>
                    </li>
              
                      <li class="nav-item">
                        <a class="nav-link" href="menus.jsp">Menú</a>
                    </li>
                      <li class="nav-item">
                        <a class="nav-link" href="carrito.jsp">Carrito</a>
                    </li>
                    
                </ul>
            </div>
        </div>
    </nav>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</body>
</html>
