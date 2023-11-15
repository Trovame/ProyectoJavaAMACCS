/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModelosDAO;

import Database.Conexion;
import Modelos.Cliente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    private Conexion con;
    private Connection connect;
    private PreparedStatement ps;
    private ResultSet rs;

    public ClienteDAO() throws ClassNotFoundException {
        con = new Conexion();
    }

    // Consulta general
    public List<Cliente> list() {
        ArrayList<Cliente> listCliente = new ArrayList<>();
        String sql = "SELECT * FROM clientes";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setIdcliente(rs.getInt("idcliente"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellidos(rs.getString("apellidos"));
                cliente.setSexo(rs.getString("sexo"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setPais(rs.getString("pais"));
                cliente.setClave(rs.getString("clave"));
                cliente.setCorreo(rs.getString("correo"));
                listCliente.add(cliente);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listCliente;
    }

    // Buscar cliente por ID
    public Cliente search_by_id(int idcliente) {
        Cliente cliente = new Cliente();
        String sql = "SELECT * FROM clientes WHERE idcliente=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, idcliente);
            rs = ps.executeQuery();

            if (rs.next()) {
                cliente.setIdcliente(rs.getInt("idcliente"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellidos(rs.getString("apellidos"));
                cliente.setSexo(rs.getString("sexo"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setPais(rs.getString("pais"));
                cliente.setClave(rs.getString("clave"));
                cliente.setCorreo(rs.getString("correo"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cliente;
    }

    // Agregar nuevo cliente
    public boolean add(Cliente cliente) {
        String sql = "INSERT INTO clientes (nombre, apellidos, sexo, direccion, telefono, pais, clave, correo) VALUES (?,?,?,?,?,?,?,?)";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellidos());
            ps.setString(3, cliente.getSexo());
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getPais());
            ps.setString(7, cliente.getClave());
            ps.setString(8, cliente.getCorreo());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Actualizar un cliente
    public boolean update(Cliente cliente) {
        String sql = "UPDATE clientes SET nombre=?, apellidos=?, sexo=?, direccion=?, telefono=?, pais=?, clave=?, correo=? WHERE idcliente=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellidos());
            ps.setString(3, cliente.getSexo());
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getPais());
            ps.setString(7, cliente.getClave());
            ps.setString(8, cliente.getCorreo());
            ps.setInt(9, cliente.getIdcliente());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Eliminar un cliente
    public boolean remove(int idcliente) {
        String sql = "DELETE FROM clientes WHERE idcliente=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, idcliente);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
