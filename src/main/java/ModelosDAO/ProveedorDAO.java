/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModelosDAO;

import Database.Conexion;
import Modelos.Proveedor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProveedorDAO {

    private Conexion con;
    private Connection connect;
    private PreparedStatement ps;
    private ResultSet rs;

    public ProveedorDAO() throws ClassNotFoundException {
        con = new Conexion();
    }

    // Consulta general
    public List<Proveedor> listProveedores() {
        ArrayList<Proveedor> listaProveedores = new ArrayList<>();
        String sql = "SELECT * FROM proveedor";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Proveedor proveedor = new Proveedor();
                proveedor.setIdProveedor(rs.getInt("idProveedor"));
                proveedor.setNombreProveedor(rs.getString("Nombre"));
                proveedor.setTelefono(rs.getString("Telefono"));
                proveedor.setCorreo(rs.getString("Correo"));
                proveedor.setDireccion(rs.getString("Direccion"));
                listaProveedores.add(proveedor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaProveedores;
    }

    // Buscar proveedor por ID
    public Proveedor searchById(int id) {
        Proveedor proveedor = new Proveedor();
        String sql = "SELECT * FROM proveedor WHERE idProveedor=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                proveedor.setIdProveedor(rs.getInt("idProveedor"));
                proveedor.setNombreProveedor(rs.getString("Nombre"));
                proveedor.setTelefono(rs.getString("Telefono"));
                proveedor.setCorreo(rs.getString("Correo"));
                proveedor.setDireccion(rs.getString("Direccion"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proveedor;
    }

    // Agregar nuevo proveedor
    public boolean add(Proveedor proveedor) {
        String sql = "INSERT INTO proveedor (Nombre, Telefono, Correo, Direccion) VALUES (?,?,?,?)";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, proveedor.getNombreProveedor());
            ps.setString(2, proveedor.getTelefono());
            ps.setString(3, proveedor.getCorreo());
            ps.setString(4, proveedor.getDireccion());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Actualizar un proveedor
    public boolean update(Proveedor proveedor) {
        String sql = "UPDATE proveedor SET Nombre=?, Telefono=?, Correo=?, Direccion=? WHERE idProveedor=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, proveedor.getNombreProveedor());
            ps.setString(2, proveedor.getTelefono());
            ps.setString(3, proveedor.getCorreo());
            ps.setString(4, proveedor.getDireccion());
            ps.setInt(5, proveedor.getIdProveedor());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Eliminar un proveedor
    public boolean remove(int id) {
        String sql = "DELETE FROM proveedor WHERE idProveedor=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, id);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
     // Buscar proveedor por ID
    public Proveedor search_by_id(int id) { // Cambiado el nombre del método a search_by_id
        Proveedor proveedor = new Proveedor();
        String sql = "SELECT * FROM proveedor WHERE idProveedor=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                proveedor.setIdProveedor(rs.getInt("idProveedor"));
                proveedor.setNombreProveedor(rs.getString("Nombre"));
                proveedor.setTelefono(rs.getString("Telefono"));
                proveedor.setCorreo(rs.getString("Correo"));
                proveedor.setDireccion(rs.getString("Direccion"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proveedor;
    }


}
