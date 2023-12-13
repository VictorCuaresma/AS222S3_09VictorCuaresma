<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Agregar Producto</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Estilos para la página */
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

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        input, textarea, select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        .form-control.is-invalid {
            border: 2px solid #dc3545;
        }

        .invalid-feedback {
            color: #dc3545;
        }

        .btn-primary {
            width: 25%; /* Hacer que el botón ocupe todo el ancho */
        }

        .error-message {
            color: #dc3545;
            font-size: 0.8em;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2>Agregar Producto</h2>

    <form action="ProductServlet" method="post">
        <input type="hidden" name="action" value="add">

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="code">Código</label>
                <input type="text" class="form-control" id="code" name="code" required>
                <div class="valid-feedback">
                    ¡Correcto!
                </div>
                <div class="invalid-feedback">
                    Solo se permiten letras y números en el código.
                </div>
            </div>

            <div class="form-group col-md-6">
                <label for="productName">Producto</label>
                <input type="text" class="form-control" id="productName" name="name" required>
                <div class="valid-feedback">
                    ¡Correcto!
                </div>
                <div class="invalid-feedback">
                    Solo se permiten letras y espacios en el nombre.
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="description">Descripción</label>
                <textarea class="form-control" id="description" name="description" required></textarea>
            </div>

            <div class="form-group col-md-6">
                <label for="price">Precio</label>
                <input type="text" class="form-control" id="price" name="price" required>
                <div class="valid-feedback">
                    ¡Correcto!
                </div>
                <div class="invalid-feedback">
                    Solo se permiten números, comas y puntos en el precio.
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="storeType">Tipo de Tienda</label>
                <select class="form-control" id="storeType" name="storeType" required>
                    <option value="Panadería">Panadería</option>
                    <option value="Tienda">Tienda</option>
                    <!-- Agrega más opciones según sea necesario -->
                </select>
            </div>
        </div>

        <div class="text-center">
            <input type="submit" class="btn btn-primary" value="Agregar">
        </div>

    </form>
</div>

<script>
    document.getElementById("code").addEventListener("input", function () {
        var codeInput = document.getElementById("code");
        var codeValue = codeInput.value.trim();
        var regex = /^[a-zA-Z0-9]+$/;

        if (!regex.test(codeValue)) {
            codeInput.setCustomValidity("Solo se permiten letras y números en el código.");
            codeInput.classList.remove("is-valid");
            codeInput.classList.add("is-invalid");
        } else {
            codeInput.setCustomValidity("");
            codeInput.classList.remove("is-invalid");
            codeInput.classList.add("is-valid");
        }
    });

    document.getElementById("productName").addEventListener("input", function () {
        var productNameInput = document.getElementById("productName");
        var productNameValue = productNameInput.value.trim();
        var regex = /^[a-zA-Z\s]+$/;

        if (!regex.test(productNameValue)) {
            productNameInput.setCustomValidity("Solo se permiten letras y espacios en el nombre.");
            productNameInput.classList.remove("is-valid");
            productNameInput.classList.add("is-invalid");
        } else {
            productNameInput.setCustomValidity("");
            productNameInput.classList.remove("is-invalid");
            productNameInput.classList.add("is-valid");
        }
    });

    document.getElementById('price').addEventListener('input', function () {
        var priceInput = this.value.trim();

        // Expresión regular que permite solo números, comas y puntos en el precio
        var regex = /^[0-9.,]+$/;

        if (regex.test(priceInput)) {
            this.classList.remove('is-invalid');
            this.classList.add('is-valid');
        } else {
            this.classList.remove('is-valid');
            this.classList.add('is-invalid');
        }
    });
</script>
</body>
</html>
