/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModelosDAO;

import Database.Conexion;
import Modelos.Producto;
import Modelos.Proveedor;
import Modelos.Categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    private Conexion con;
    private Connection connect;
    private PreparedStatement ps;
    private ResultSet rs;

    public ProductoDAO() throws ClassNotFoundException {
        con = new Conexion();
    }

    public List<Producto> listProductos() {
        ArrayList<Producto> listaProductos = new ArrayList<>();
        String sql = "SELECT * FROM platillos";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("idplatillo"));
                producto.setIdCategoria(rs.getInt("idCategoria"));
                producto.setIdProveedor(rs.getInt("idProveedor"));
                producto.setNombreProducto(rs.getString("Nombre"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setPrecio(rs.getString("Precio"));
                producto.setTiempo(rs.getString("tiempo"));
                producto.setImagen(rs.getString("imagen"));
                listaProductos.add(producto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaProductos;
    }

    public Producto searchById(int idProducto) {
        Producto producto = new Producto();
        String sql = "SELECT * FROM platillos WHERE idplatillo=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, idProducto);
            rs = ps.executeQuery();

            if (rs.next()) {
                producto.setIdProducto(rs.getInt("idplatillo"));
                producto.setIdCategoria(rs.getInt("idCategoria"));
                producto.setIdProveedor(rs.getInt("idProveedor"));
                producto.setNombreProducto(rs.getString("Nombre"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setPrecio(rs.getString("Precio"));
                producto.setTiempo(rs.getString("tiempo"));
                producto.setImagen(rs.getString("imagen"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return producto;
    }

    public boolean existsProducto(String nombre) {
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement("SELECT * FROM platillos WHERE Nombre = ?");
            ps.setString(1, nombre);
            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean add(Producto producto) {
        if (existsProducto(producto.getNombreProducto())) {
            return false;
        }
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement("INSERT INTO platillos (Nombre, Descripcion, Precio, tiempo, imagen, idProveedor, idCategoria) VALUES (?,?,?,?,?,?,?)");
            ps.setString(1, producto.getNombreProducto());
            ps.setString(2, producto.getDescripcion());
            ps.setString(3, producto.getPrecio());
            ps.setString(4, producto.getTiempo());
            ps.setString(5, producto.getImagen());
            ps.setInt(6, producto.getIdProveedor());
            ps.setInt(7, producto.getIdCategoria());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Producto producto) {
        String sql = "UPDATE platillos SET Nombre=?, Descripcion=?, Precio=?, tiempo=?, imagen=?, idProveedor=?, idCategoria=? WHERE idplatillo=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, producto.getNombreProducto());
            ps.setString(2, producto.getDescripcion());
            ps.setString(3, producto.getPrecio());
            ps.setString(4, producto.getTiempo());
            ps.setString(5, producto.getImagen());
            ps.setInt(6, producto.getIdProveedor());
            ps.setInt(7, producto.getIdCategoria());
            ps.setInt(8, producto.getIdProducto());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean remove(int idProducto) {
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement("DELETE FROM platillos WHERE idplatillo=?");
            ps.setInt(1, idProducto);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Proveedor> listProveedores() {
        List<Proveedor> proveedores = new ArrayList<>();
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement("SELECT * FROM proveedor");
            rs = ps.executeQuery();
            while (rs.next()) {
                Proveedor proveedor = new Proveedor();
                proveedor.setIdProveedor(rs.getInt("idProveedor"));
                proveedor.setNombreProveedor(rs.getString("Nombre"));
                proveedor.setTelefono(rs.getString("Telefono"));
                proveedor.setCorreo(rs.getString("Correo"));
                proveedor.setDireccion(rs.getString("Direccion"));
                proveedores.add(proveedor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proveedores;
    }

    public List<Categoria> listCategorias() {
        List<Categoria> categorias = new ArrayList<>();
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement("SELECT * FROM categoria");
            rs = ps.executeQuery();
            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("idCategoria"));
                categoria.setNombreCategoria(rs.getString("Nombre"));
                categorias.add(categoria);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categorias;
    }

    public List<Producto> listProductosPorTiempo(String tiempo) {
        List<Producto> listaPlatillos = new ArrayList<>();
        String sql = "SELECT * FROM platillos WHERE tiempo = ?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, tiempo);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("idplatillo"));
                producto.setIdCategoria(rs.getInt("idCategoria"));
                producto.setIdProveedor(rs.getInt("idProveedor"));
                producto.setNombreProducto(rs.getString("Nombre"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setPrecio(rs.getString("Precio"));
                producto.setTiempo(rs.getString("tiempo"));
                producto.setImagen(rs.getString("imagen"));
                listaPlatillos.add(producto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaPlatillos;
    }

}
