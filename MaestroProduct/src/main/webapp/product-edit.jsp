<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Editar Producto</title>
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

        form {
            max-width: 800px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 30px;
        }

        label {
            font-weight: bold;
        }

        .btn-primary {
            width: 30%; /* Hacer que el botón ocupe todo el ancho */
        }

        #mensaje {
            display: none;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="container mt-5">
        <h2>Editar Producto</h2>
        <form action="ProductServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="productId" value="${param.productId}">

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="code">Código</label>
                    <input type="text" class="form-control" id="code" name="code" value="${param.code}" pattern="[A-Za-z0-9]+" title="Solo se permiten letras y números" required>
                    <div class="valid-feedback">¡Correcto!</div>
                    <div class="invalid-feedback">Solo se permiten letras y números en el código.</div>
                </div>

                <div class="form-group col-md-6">
                    <label for="name">Nombre del Producto</label>
                    <input type="text" class="form-control" id="name" name="name" value="${param.name}" pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios" required>
                    <div class="valid-feedback">¡Correcto!</div>
                    <div class="invalid-feedback">Solo se permiten letras y espacios en el nombre.</div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="price">Precio</label>
                    <input type="text" class="form-control" id="price" name="price" value="${param.price}" pattern="[0-9]+([,.][0-9]+)?" title="Solo se permiten números, comas y puntos en el precio" required>
                    <div class="valid-feedback">¡Correcto!</div>
                    <div class="invalid-feedback">Solo se permiten números, comas y puntos en el precio.</div>
                </div>
                <div class="form-group col-md-6">
                    <label for="storeType">Tipo de Tienda</label>
                    <input type="text" class="form-control" id="storeType" name="storeType" value="${param.storeType}" required>
                    <div class="valid-feedback">¡Correcto!</div>
                    <div class="invalid-feedback">Este campo no puede estar vacío.</div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="description">Descripción</label>
                    <textarea class="form-control" id="description" name="description" required>${param.description}</textarea>
                </div>
                	<div class="form-group col-md-6">
					<label for="status">Estado</label> <input type="text" name="status"
						class="form-control" value="${param.status}" readonly />
				</div>
			</div>
            </div>

            <div class="text-center">
                <input type="submit" class="btn btn-primary" value="Actualizar">
                <br> <br>
                <button type="button" class="btn btn-primary" onclick="location.href='ProductServlet?action=listActive'">
                    Cancelar</button>
            </div>

            
        </form>
    </div>
       </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    <script>
        document.getElementById("code").addEventListener("input", function() {
            var codeInput = this.value.trim();
            var regex = /^[A-Za-z0-9]+$/;

            if (!regex.test(codeInput)) {
                this.setCustomValidity("Solo se permiten letras y números en el código.");
                this.classList.remove("is-valid");
                this.classList.add("is-invalid");
            } else {
                this.setCustomValidity("");
                this.classList.remove("is-invalid");
                this.classList.add("is-valid");
            }
        });

   
    </script>

</body>
</html>
