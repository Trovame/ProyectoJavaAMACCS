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
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO {

    private Conexion con;
    private Connection connect;
    private PreparedStatement ps;
    private ResultSet rs;

    public EmpleadoDAO() throws ClassNotFoundException {
        con = new Conexion();
    }

    public List<Empleado> listEmpleados() {
        ArrayList<Empleado> listaEmpleados = new ArrayList<>();
        String sql = "SELECT * FROM empleado";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Empleado empleado = new Empleado();
                empleado.setIdEmpleado(rs.getInt("idEmpleado"));
                empleado.setNombres(rs.getString("Nombres"));
                empleado.setApellidos(rs.getString("Apellidos"));
                empleado.setCorreo(rs.getString("Correo"));
                empleado.setUsuario(rs.getString("usuario"));
                empleado.setPassword(rs.getString("password"));
                empleado.setImagen(rs.getString("imagen"));
                listaEmpleados.add(empleado);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaEmpleados;
    }

    public Empleado searchById(int idEmpleado) {
        Empleado empleado = new Empleado();
        String sql = "SELECT * FROM empleado WHERE idEmpleado=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, idEmpleado);
            rs = ps.executeQuery();

            if (rs.next()) {
                empleado.setIdEmpleado(rs.getInt("idEmpleado"));
                empleado.setNombres(rs.getString("Nombres"));
                empleado.setApellidos(rs.getString("Apellidos"));
                empleado.setCorreo(rs.getString("Correo"));
                empleado.setUsuario(rs.getString("usuario"));
                empleado.setPassword(rs.getString("password"));
                empleado.setImagen(rs.getString("imagen"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return empleado;
    }

    public boolean add(Empleado empleado) {
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement("INSERT INTO empleado (Nombres, Apellidos, Correo, usuario, password, imagen) VALUES (?,?,?,?,?,?)");
            ps.setString(1, empleado.getNombres());
            ps.setString(2, empleado.getApellidos());
            ps.setString(3, empleado.getCorreo());
            ps.setString(4, empleado.getUsuario());
            ps.setString(5, empleado.getPassword());
            ps.setString(6, empleado.getImagen());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Empleado empleado) {
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement("UPDATE empleado SET Nombres=?, Apellidos=?, Correo=?, usuario=?, password=?, imagen=? WHERE idEmpleado=?");
            ps.setString(1, empleado.getNombres());
            ps.setString(2, empleado.getApellidos());
            ps.setString(3, empleado.getCorreo());
            ps.setString(4, empleado.getUsuario());
            ps.setString(5, empleado.getPassword());
            ps.setString(6, empleado.getImagen());
            ps.setInt(7, empleado.getIdEmpleado());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean remove(int idEmpleado) {
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement("DELETE FROM empleado WHERE idEmpleado=?");
            ps.setInt(1, idEmpleado);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
