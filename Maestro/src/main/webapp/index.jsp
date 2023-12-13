<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Agregar Producto</title>
</head>
<body>
    <h2>Agregar Nuevo Producto</h2>

    <form action="ProductServlet" method="post">
        <!-- Campos del formulario para agregar un nuevo producto -->
        Nombre: <input type="text" name="names" required><br>
        Precio: <input type="text" name="price" required><br>
        Marca: <input type="text" name="brand" required><br>
        Stock: <input type="text" name="stock" required><br>
        Descripción: <input type="text" name="description" required><br>
        Estado: <input type="text" name="status" required><br>
        Categoría: <input type="text" name="id_category" required><br>

        <input type="hidden" name="action" value="add">
        <input type="submit" value="Agregar Producto">
    </form>

    <br>
    <a href="ProductServlet?action=list">Volver a la lista de productos</a>
</body>
</html>
