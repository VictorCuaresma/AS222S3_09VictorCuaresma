package pe.edu.vallegrande.app.dao;

import pe.edu.vallegrande.app.models.Product;
import pe.edu.vallegrande.app.AccesoDB.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private static final String GET_ALL_PRODUCTS_QUERY = "SELECT * FROM PRODUCT";
    private static final String GET_ACTIVE_PRODUCTS_QUERY = "SELECT * FROM PRODUCT WHERE status = 'ALTA'";
    private static final String GET_INACTIVE_PRODUCTS_QUERY = "SELECT * FROM PRODUCT WHERE status = 'BAJA'";
    private static final String GET_PRODUCT_BY_ID_QUERY = "SELECT * FROM PRODUCT WHERE id = ?";
    private static final String INSERT_PRODUCT_QUERY = "INSERT INTO PRODUCT (code, name, price, description, status, store_type) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_PRODUCT_QUERY = "UPDATE PRODUCT SET code = ?, name = ?, price = ?, description = ?, status = ?, store_type = ? WHERE id = ?";
    private static final String DELETE_PRODUCT_QUERY = "DELETE FROM PRODUCT WHERE id = ?";
    private static final String GET_FILTERED_PRODUCTS_QUERY = "SELECT * FROM PRODUCT WHERE (:nameFilter IS NULL OR name LIKE ?) AND (:brandFilter IS NULL OR store_type LIKE ?)";
    private static final String REACTIVATE_PRODUCT_QUERY = "UPDATE PRODUCT SET status = 'A' WHERE id = ?";

    public List<Product> getFilteredProducts(String nameFilter, String brandFilter) {
        List<Product> filteredProductList = new ArrayList<>();

        try (Connection connection = Conexion.getConnection();
             PreparedStatement preparedStatement = buildFilteredProductsQuery(connection, nameFilter, brandFilter);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Product product = extractProductFromResultSet(resultSet);
                filteredProductList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return filteredProductList;
    }

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();

        try (Connection connection = Conexion.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(GET_ALL_PRODUCTS_QUERY)) {

            while (resultSet.next()) {
                Product product = extractProductFromResultSet(resultSet);
                productList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public List<Product> getActiveProducts() {
        List<Product> activeProductList = new ArrayList<>();

        try (Connection connection = Conexion.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(GET_ACTIVE_PRODUCTS_QUERY)) {

            while (resultSet.next()) {
                Product product = extractProductFromResultSet(resultSet);
                activeProductList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return activeProductList;
    }

    public List<Product> getInactiveProducts() {
        List<Product> inactiveProductList = new ArrayList<>();

        try (Connection connection = Conexion.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(GET_INACTIVE_PRODUCTS_QUERY)) {

            while (resultSet.next()) {
                Product product = extractProductFromResultSet(resultSet);
                inactiveProductList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return inactiveProductList;
    }

    public Product getProductById(int productId) {
        Product product = null;

        try (Connection connection = Conexion.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCT_BY_ID_QUERY)) {

            preparedStatement.setInt(1, productId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    product = extractProductFromResultSet(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    public boolean insertProduct(Product product) {
        try (Connection connection = Conexion.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCT_QUERY, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, product.getCode());
            preparedStatement.setString(2, product.getName());
            preparedStatement.setString(3, product.getPrice());
            preparedStatement.setString(4, product.getDescription());
            preparedStatement.setString(5, product.getStatus());
            preparedStatement.setString(6, product.getStoreType());

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        product.setId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateProduct(Product product) {
        try (Connection connection = Conexion.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT_QUERY)) {

            preparedStatement.setString(1, product.getCode());
            preparedStatement.setString(2, product.getName());
            preparedStatement.setString(3, product.getPrice());
            preparedStatement.setString(4, product.getDescription());
            preparedStatement.setString(5, product.getStatus());
            preparedStatement.setString(6, product.getStoreType());
            preparedStatement.setInt(7, product.getId());

            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteProduct(int productId) {
        Product product = getProductById(productId);

        if (product != null) {
            if ("A".equals(product.getStatus())) {
                product.setStatus("I");
                return updateProduct(product);
            } else {
                return false;
            }
        }

        return false;
    }

    public boolean reactivateProduct(int productId) {
        try (Connection connection = Conexion.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(REACTIVATE_PRODUCT_QUERY)) {

            preparedStatement.setInt(1, productId);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected == 0) {
                throw new RuntimeException("No se encontró el registro con ID: " + productId);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
		return false;
    }

    private Product extractProductFromResultSet(ResultSet resultSet) throws SQLException {
        String amount = resultSet.getString("amount");
        String code = resultSet.getString("code");
        String area = resultSet.getString("area");
        String detailsGoods = resultSet.getString("detailsGoods");
        String admissionDate =resultSet.getString("admissionDate");
        String dateDepreciation =resultSet.getString("dateDepreciation");
        int worth = Integer.parseInt(resultSet.getString("worth"));
        String annualDepreciation = resultSet.getString("annualDepreciation");
        String monthlyDepreciation = resultSet.getString("monthlyDepreciation");
        String accumulatedDepreciation = resultSet.getString("accumulatedDepreciation");
 
        return new Product(amount, code, area, detailsGoods, admissionDate, dateDepreciation, worth, annualDepreciation, monthlyDepreciation, accumulatedDepreciation);
    }

    private PreparedStatement buildFilteredProductsQuery(Connection connection, String nameFilter, String brandFilter) throws SQLException {
        String query = GET_FILTERED_PRODUCTS_QUERY;
        PreparedStatement preparedStatement = connection.prepareStatement(query);

        if (nameFilter != null) {
            preparedStatement.setString(1, "%" + nameFilter + "%");
        } else {
            preparedStatement.setNull(1, Types.VARCHAR);
        }

        if (brandFilter != null) {
            preparedStatement.setString(2, "%" + brandFilter + "%");
        } else {
            preparedStatement.setNull(2, Types.VARCHAR);
        }

        return preparedStatement;
    }
}
