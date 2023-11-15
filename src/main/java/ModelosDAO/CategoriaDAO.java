/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModelosDAO;

import Database.Conexion;
import Modelos.Categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    private Conexion con;
    private Connection connect;
    private PreparedStatement ps;
    private ResultSet rs;

    public CategoriaDAO() throws ClassNotFoundException {
        con = new Conexion();
    }

    // Consulta general
    public List<Categoria> listCategorias() {
        ArrayList<Categoria> listaCategorias = new ArrayList<>();
        String sql = "SELECT * FROM categoria";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("idCategoria"));
                categoria.setNombreCategoria(rs.getString("Nombre"));
                listaCategorias.add(categoria);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaCategorias;
    }

    // Buscar categoría por ID
    public Categoria search_by_id(int id) {
        Categoria categoria = new Categoria();
        String sql = "SELECT * FROM categoria WHERE idCategoria=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                categoria.setIdCategoria(rs.getInt("idCategoria"));
                categoria.setNombreCategoria(rs.getString("Nombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoria;
    }

    // Agregar nueva categoría
    public boolean add(Categoria categoria) {
        String sql = "INSERT INTO categoria (Nombre) VALUES (?)";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, categoria.getNombreCategoria());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Actualizar una categoría
    public boolean update(Categoria categoria) {
        String sql = "UPDATE categoria SET Nombre=? WHERE idCategoria=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, categoria.getNombreCategoria());
            ps.setInt(2, categoria.getIdCategoria());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Eliminar una categoría
    public boolean remove(int id) {
        String sql = "DELETE FROM categoria WHERE idCategoria=?";
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
}

