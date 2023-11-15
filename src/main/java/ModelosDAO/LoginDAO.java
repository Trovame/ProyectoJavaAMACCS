/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModelosDAO;

import Database.Conexion;
import Modelos.Empleado;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO {

    public boolean validarCredenciales(String usuario, String password) {
        boolean isValid = false;
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConnection();

            String query = "SELECT * FROM empleado WHERE usuario=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, usuario);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                isValid = true;
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }

    public Empleado obtenerEmpleadoPorUsuario(String usuario) {
        Empleado empleado = new Empleado();
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConnection();

            String query = "SELECT * FROM empleado WHERE usuario=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, usuario);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                empleado.setNombres(rs.getString("Nombres"));
                empleado.setCorreo(rs.getString("Correo"));
                empleado.setImagen(rs.getString("imagen"));
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return empleado;
    }
}
