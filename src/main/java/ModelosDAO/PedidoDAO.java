/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModelosDAO;

import Database.Conexion;
import Modelos.Pedido;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PedidoDAO {

    private Conexion con;
    private Connection connect;
    private PreparedStatement ps;
    private ResultSet rs;

    public PedidoDAO() throws ClassNotFoundException {
        con = new Conexion();
    }

    // Consulta general
    public List<Pedido> listPedidos() {
        ArrayList<Pedido> listaPedidos = new ArrayList<>();
        String sql = "SELECT * FROM pedidos ORDER BY idPedido DESC";

        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("idPedido"));
                pedido.setCliente(rs.getString("Cliente"));
                pedido.setProductos(rs.getString("Productos"));
                pedido.setMesa(rs.getString("Mesa"));
                pedido.setTotal(rs.getInt("total"));
                pedido.setFecha(rs.getString("fecha"));
                pedido.setEstado(rs.getString("estado"));
                listaPedidos.add(pedido);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaPedidos;
    }

    // Agregar nuevo pedido
    public boolean add(Pedido pedido) {
        String sql = "INSERT INTO pedidos (Cliente, Productos, Mesa, total, fecha, estado) VALUES (?,?,?,?,?,?)";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, pedido.getCliente());
            ps.setString(2, pedido.getProductos());
            ps.setString(3, pedido.getMesa());
            ps.setInt(4, pedido.getTotal());
            ps.setString(5, pedido.getFecha());
            ps.setString(6, pedido.getEstado());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Eliminar un pedido
    public boolean remove(int id) {
        String sql = "DELETE FROM pedidos WHERE idPedido=?";
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

    // Actualizar estado de un pedido
    public boolean actualizarEstado(int id, String nuevoEstado) {
        String sql = "UPDATE pedidos SET estado = ? WHERE idPedido = ?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, nuevoEstado);
            ps.setInt(2, id);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    // Obtener pedido por ID

    public Pedido getPedidoById(int id) {
        String sql = "SELECT * FROM pedidos WHERE idPedido = ?";
        Pedido pedido = new Pedido();
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                pedido.setIdPedido(rs.getInt("idPedido"));
                pedido.setCliente(rs.getString("Cliente"));
                pedido.setProductos(rs.getString("Productos"));
                pedido.setMesa(rs.getString("Mesa"));
                pedido.setTotal(rs.getInt("total"));
                pedido.setFecha(rs.getString("fecha"));
                pedido.setEstado(rs.getString("estado"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pedido;
    }
// Búsqueda de pedidos por cliente y fecha

    public List<Pedido> listPedidos(String cliente, String fecha) {
        ArrayList<Pedido> listaPedidos = new ArrayList<>();
        String sql = "SELECT * FROM pedidos WHERE Cliente LIKE ? AND fecha LIKE ?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, "%" + cliente + "%");
            ps.setString(2, "%" + fecha + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("idPedido"));
                pedido.setCliente(rs.getString("Cliente"));
                pedido.setProductos(rs.getString("Productos"));
                pedido.setMesa(rs.getString("Mesa"));
                pedido.setTotal(rs.getInt("total"));
                pedido.setFecha(rs.getString("fecha"));
                pedido.setEstado(rs.getString("estado"));
                listaPedidos.add(pedido);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaPedidos;
    }
    // Listar pedidos por Cliente

    public List<Pedido> listPedidosPorCliente(String cliente) {
        ArrayList<Pedido> listaPedidos = new ArrayList<>();
        String sql = "SELECT * FROM pedidos WHERE Cliente LIKE ?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, "%" + cliente + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("idPedido"));
                pedido.setCliente(rs.getString("Cliente"));
                pedido.setProductos(rs.getString("Productos"));
                pedido.setMesa(rs.getString("Mesa"));
                pedido.setTotal(rs.getInt("total"));
                pedido.setFecha(rs.getString("fecha"));
                pedido.setEstado(rs.getString("estado"));
                listaPedidos.add(pedido);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaPedidos;
    }

    // Listar pedidos por Fecha
    public List<Pedido> listPedidosPorFecha(String fecha) {
        ArrayList<Pedido> listaPedidos = new ArrayList<>();
        String sql = "SELECT * FROM pedidos WHERE fecha LIKE ?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, "%" + fecha + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("idPedido"));
                pedido.setCliente(rs.getString("Cliente"));
                pedido.setProductos(rs.getString("Productos"));
                pedido.setMesa(rs.getString("Mesa"));
                pedido.setTotal(rs.getInt("total"));
                pedido.setFecha(rs.getString("fecha"));
                pedido.setEstado(rs.getString("estado"));
                listaPedidos.add(pedido);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaPedidos;
    }
// Listar pedidos por Cliente y Fecha

  // Listar pedidos por Cliente y Fecha
public List<Pedido> listPedidosPorClienteYFecha(String cliente, String fecha) {
    ArrayList<Pedido> listaPedidos = new ArrayList<>();
    String sql = "SELECT * FROM pedidos WHERE 1=1";
    List<String> parameters = new ArrayList<>();
    try {
        if (cliente != null && !cliente.isEmpty()) {
            sql += " AND Cliente LIKE ?";
            parameters.add("%" + cliente + "%");
        }
        if (fecha != null && !fecha.isEmpty()) {
            sql += " AND fecha LIKE ?";
            parameters.add("%" + fecha + "%");
        }
        connect = con.getConnection();
        ps = connect.prepareStatement(sql);
        for (int i = 0; i < parameters.size(); i++) {
            ps.setString(i + 1, parameters.get(i));
        }
        rs = ps.executeQuery();
        while (rs.next()) {
            Pedido pedido = new Pedido();
            pedido.setIdPedido(rs.getInt("idPedido"));
            pedido.setCliente(rs.getString("Cliente"));
            pedido.setProductos(rs.getString("Productos"));
            pedido.setMesa(rs.getString("Mesa"));
            pedido.setTotal(rs.getInt("total"));
            pedido.setFecha(rs.getString("fecha"));
            pedido.setEstado(rs.getString("estado"));
            listaPedidos.add(pedido);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return listaPedidos;
}


}
