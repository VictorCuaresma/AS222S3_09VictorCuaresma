<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Listado De Productos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        body {
            background: #007991;
            background: -webkit-linear-gradient(to right, #78ffd6, #007991);
            background: linear-gradient(to right, #78ffd6, #007991);
            font-family: 'Arial', sans-serif;
        }

        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px #000000;
            margin-top: 50px;
        }

        h2 {
            color: #007bff;
            text-align: center;
            margin-bottom: 30px;
        }

        .btn-group {
            margin-bottom: 20px;
        }

        table {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            text-align: center;
            padding: 12px;
            border: 1px solid #ddd;
        }

        th {
            background-color: #343a40;
            color: #fff;
        }

        .btn-action {
            margin-right: 5px;
        }

        .btn-danger img, .btn-delete img {
            width: 16px;
            height: 16px;
            margin-right: 5px;
        }

        .btn-danger:hover {
            color: #fff;
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-delete {
            color: #fff;
            background-color: #ff0000;
            border-color: #ff0000;
        }

        /* Estilo para los nombres de tabla */
        th {
            font-size: 18px;
            font-weight: bold;
        }

        /* Estilo para el botón "Agregar Producto" */
        .btn-success {
            font-size: 18px;
        }

        /* Estilo para la confirmación de eliminación */
        .confirm-delete {
            font-size: 16px;
        }

        #searchForm {
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin: 0 auto; /* Alinea el botón al centro */
        }

        button:hover {
            background-color: #0056b3;
        }

        /* Estilo para la fila del formulario de búsqueda */
        #searchForm .form-group.row {
            margin-bottom: 0;
            margin-top: -5;
        }

        /* Estilo para los campos del formulario de búsqueda */
        #searchForm .form-group.row .col-sm-2 {
            margin-bottom: 20px;
            margin-top: -5;
        }

        /* Estilo para el botón de buscar */
        #searchForm .form-group.row button {
            margin-top: 0px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2>Lista de Productos</h2>
        <div class="btn-group mt-3">
            <a href="product-form.jsp" class="btn btn-success"><i class="bi bi-plus"></i> Agregar Producto</a>
            <!-- Assuming you have Font Awesome included for icons -->
            <button type="button" class="btn btn-primary" onclick="location.href='ProductServlet?action=listActive'">
                <i class="bi bi-eye"></i> Activos
            </button>
            <button type="button" class="btn btn-primary" onclick="location.href='ProductServlet?action=listInactive'">
                <i class="bi bi-eye-slash"></i>Inactivos
            </button>
        </div>
        <!-- Formulario de búsqueda -->
        <form id="searchForm">
            <div class="form-group row">
                <label for="productNameFilter" class="col-sm-2 col-form-label">Nombre del Producto:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="productNameFilter" placeholder="Ingrese el nombre">
                </div>
                <label for="brandFilter" class="col-sm-2 col-form-label">Marca:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="brandFilter" placeholder="Ingrese la marca">
                </div>
            </div>
            <div class="form-group row">
                <label for="idFilter" class="col-sm-2 col-form-label">ID del Producto:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="idFilter" placeholder="Ingrese el ID del producto">
                </div>
                <div class="col-sm-4">
                    <button type="button" class="btn btn-primary" onclick="applyFilters()">
                        <i class="bi bi-search"></i> Buscar
                    </button>
                </div>
            </div>
        </form>

        <div class="btn btn-primary">
            <button onclick="exportToCSV()">Exportar a CSV</button>
        </div>
        <div class="btn btn-primary">
            <button onclick="exportToPDF()">Exportar a PDF</button>
        </div>
        <div class="btn btn-primary">
            <button onclick="exportToExcel()">Exportar a Excel</button>
        </div>

        <table class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Código</th>
                    <th>Producto</th>
                    <th>Precio</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th>Tipo de Tienda</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
                <!-- Iterar sobre la lista de productos y mostrar cada fila -->
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.code}</td>
                        <td>${product.name}</td>
                        <td>${product.price}</td>
                        <td>${product.description}</td>
                        <td>${product.status}</td>
                        <td>${product.storeType}</td>
                        <td>
                            <c:choose>
                                <c:when test="${product.status eq 'A'}">
                                    <a href="ProductServlet?action=delete&productId=${product.id}" class="btn btn-danger"
                                        onclick="return confirm('¿Estás seguro de que deseas eliminar este producto?')">
                                        <i class="bi bi-trash"></i> Eliminar
                                    </a>
                                </c:when>
                                <c:when test="${product.status eq 'I'}">
                                    <a href="ProductServlet?action=reactivate&productId=${product.id}"
                                        class="btn btn-success">Restaurar</a>
                                </c:when>
                            </c:choose>
                            <a href="product-edit.jsp?productId=${product.id}&code=${product.code}&name=${product.name}&price=${product.price}&description=${product.description}&status=${product.status}&storeType=${product.storeType}"
                                class="btn btn-warning">
                                <i class="bi bi-pencil-fill"></i> Editar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <script>
            function applyFilters() {
                var productName = document.getElementById('productNameFilter').value.toLowerCase();
                var brand = document.getElementById('brandFilter').value.toLowerCase();
                var productId = document.getElementById('idFilter').value.toLowerCase();

                var tableRows = document.querySelectorAll('tbody tr');

                tableRows.forEach(function (row) {
                    var productColumn = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
                    var brandColumn = row.querySelector('td:nth-child(6)').textContent.toLowerCase();
                    var idColumn = row.querySelector('td:nth-child(1)').textContent.toLowerCase();

                    var nameMatches = productColumn.includes(productName);
                    var brandMatches = brandColumn.includes(brand);
                    var idMatches = idColumn.includes(productId);

                    if (nameMatches && brandMatches && idMatches) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }
        </script>
    </div>
</body>
</html>
