package pe.edu.vallegrande.app.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pe.edu.vallegrande.app.dao.ProductDAO;
import pe.edu.vallegrande.app.models.Product;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "listActive"; // Acción predeterminada: mostrar la lista de productos activos
        }

        if ("update".equals(action)) {
            updateProduct(request, response);
        }

        switch (action) {
            case "list":
                listProducts(request, response);
                break;
            case "showForm":
                showProductForm(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            case "add":
                addProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "listActive":
                listActiveProducts(request, response);
                break;
            case "listInactive":
                listInactiveProducts(request, response);
                break;
            case "getById":
                getProductById(request, response);
                break;
            case "reactivar":
                reactivateProduct(request, response);
                break; // Agrega este caso para manejar la acción de reactivar
            case "search":
                searchProducts(request, response);
                break;
            default:
                listProducts(request, response);
        }
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros de búsqueda
        String nameFilter = request.getParameter("nameFilter");
        String brandFilter = request.getParameter("brandFilter");

        // Validar los parámetros de búsqueda
        if (nameFilter == null && brandFilter == null) {
            // Redirigir a la lista predeterminada si no se proporcionan filtros
            listProducts(request, response);
            return;
        }

        // Obtener la lista de productos filtrados
        ProductDAO productDAO = new ProductDAO();
        List<Product> filteredProducts = productDAO.getFilteredProducts(nameFilter, brandFilter);

        // Enviar la lista de productos filtrados a la vista
        request.setAttribute("products", filteredProducts);
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }

    private void reactivateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        ProductDAO productDAO = new ProductDAO();
        boolean reactivated = productDAO.reactivateProduct(productId);

        if (reactivated) {
            response.sendRedirect(request.getContextPath() + "/ProductServlet?action=listActive");
        } else {
            // Manejar el error
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }

    private void listActiveProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<Product> activeProducts = productDAO.getActiveProducts();
        request.setAttribute("products", activeProducts);
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }

    private void listInactiveProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<Product> inactiveProducts = productDAO.getInactiveProducts();
        request.setAttribute("products", inactiveProducts);
        request.getRequestDispatcher("/Product-inacti.jsp").forward(request, response);
    }

    private void getProductById(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product != null) {
                List<Product> products = new ArrayList<>();
                products.add(product);
                request.setAttribute("products", products);
            } else {
                request.setAttribute("errorMessage", "No product found with the provided ID");
            }

            request.getRequestDispatcher("/products.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Manejar la excepción si el parámetro productId no es un número válido
            request.setAttribute("errorMessage", "Ingrese un ID de producto válido");
            request.getRequestDispatcher("/products.jsp").forward(request, response);
        } catch (Exception e) {
            // Manejar otras excepciones
            e.printStackTrace();
            request.setAttribute("errorMessage", "Se produjo un error al buscar el producto");
            request.getRequestDispatcher("/products.jsp").forward(request, response);
        }
    }

    private void showProductForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/product-form.jsp").forward(request, response);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String storeType = request.getParameter("storeType");

        ProductDAO productDAO = new ProductDAO();
        Product product = new Product(productId, code, name, price, description, status, storeType);

        boolean updated = productDAO.updateProduct(product);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/ProductServlet?action=listActive");
        } else {
            // Manejar el error
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String storeType = request.getParameter("storeType");

        ProductDAO productDAO = new ProductDAO();
        Product product = new Product(0, code, name, price, description, status, storeType);

        boolean added = productDAO.insertProduct(product);

        if (added) {
            response.sendRedirect(request.getContextPath() + "/ProductServlet?action=listActive");
        } else {
            // Manejar el error
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        ProductDAO productDAO = new ProductDAO();
        boolean deleted = productDAO.deleteProduct(productId);

        if (deleted) {
            response.sendRedirect(request.getContextPath() + "/ProductServlet?action=listInactive");
        } else {
            // Manejar el error
        }
    }
}
