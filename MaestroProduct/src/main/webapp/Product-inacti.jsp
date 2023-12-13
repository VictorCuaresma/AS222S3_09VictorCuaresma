<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Listado De Productos Inactivos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.css">
    <style>
        /* Estilos adicionales según tus necesidades */
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
            margin-bottom: 10px;
        }

        table {
            margin-top: 20px;
        }

        th, td {
            text-align: center;
        }

        .btn-action {
            margin-right: 5px;
        }

        .btn-delete img {
            width: 16px;
            height: 16px;
            margin-right: 5px;
        }

        .btn-delete:hover {
            color: #fff;
            background-color: #dc3545;
            border-color: #dc3545;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2>Lista de Productos Inactivos</h2>

    <button type="button" class="btn btn-primary"
            onclick="location.href='ProductServlet?action=listActive'"><i class="bi bi-eye"></i> Activos
    </button>
    <br>
    <br>
    <div class="btn-group">
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

                <div class="col-sm-6 text-right">
                    <button type="button" class="btn btn-primary" onclick="applyFilters()">
                        <i class="bi bi-search"></i> Buscar
                    </button>
                </div>
            </div>
        </form>
    </div>

    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Código</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio</th>
            <th>Estado</th>
            <th>Tipo de Tienda</th>
            <th>Acción</th>
        </tr>
        </thead>
        <tbody>
        <!-- Iterar sobre la lista de productos inactivos y mostrar cada fila -->
        <c:forEach var="product" items="${products}">
            <c:if test="${product.status eq 'I'}">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.code}</td>
                    <td>${product.name}</td>
                    <td>${product.description}</td>
                    <td>${product.price}</td>
                    <td>${product.status}</td>
                    <td>${product.storeType}</td>
                    <td>
                        <form action="products.jsp" method="POST">
                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="hidden" name="action" value="productId"> <!-- Cambiado de "productId" a "action" -->
                            <button class="btn btn-success" type="submit">
                                <i class="bi bi-arrow-clockwise"></i> Reactivar
                            </button>
                        </form>
                    </td>
                </tr>
            </c:if>
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
                var brandColumn = row.querySelector('td:nth-child(7)').textContent.toLowerCase();
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
