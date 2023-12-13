package pe.edu.vallegrande.app.prueba;

import pe.edu.vallegrande.app.AccesoDB.Conexion;

import java.sql.Connection;

import java.sql.SQLException;

public class PruebaConexion {
    public static void main(String[] args) {
        Connection connection = Conexion.getConnection();

        if (connection != null) {
            System.out.println("conexión exitosa gaaaaaaa");
            try {
                connection.close();
                System.out.println("listo chau");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("tmr no c conecto a la bate de basos pi pi piiiiii");
        }
    }
}


