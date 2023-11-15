/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModelosDAO;

import Database.Conexion;
import Modelos.Jefe;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class JefeDAO {

    private Conexion con;
    private Connection connect;
    private PreparedStatement ps;
    private ResultSet rs;

    public JefeDAO() throws ClassNotFoundException {
        con = new Conexion();
    }

    public List<Jefe> listJefes() {
        List<Jefe> listaJefes = new ArrayList<>();
        String sql = "SELECT * FROM jefe";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Jefe jefe = new Jefe();
                jefe.setIdJefe(rs.getInt("idJefe"));
                jefe.setNombres(rs.getString("Nombres"));
                jefe.setApellidos(rs.getString("Apellidos"));
                jefe.setCorreo(rs.getString("Correo"));
                jefe.setUsuario(rs.getString("usuario"));
                jefe.setPassword(rs.getString("password"));
                jefe.setImagen(rs.getString("imagen"));
                listaJefes.add(jefe);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaJefes;
    }

    public boolean add(Jefe jefe) {
        String sql = "INSERT INTO jefe (Nombres, Apellidos, Correo, usuario, password, imagen) VALUES (?,?,?,?,?,?)";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, jefe.getNombres());
            ps.setString(2, jefe.getApellidos());
            ps.setString(3, jefe.getCorreo());
            ps.setString(4, jefe.getUsuario());
            ps.setString(5, jefe.getPassword());
            ps.setString(6, jefe.getImagen());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean remove(int idJefe) {
        String sql = "DELETE FROM jefe WHERE idJefe=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, idJefe);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean update(Jefe jefe) {
        String sql = "UPDATE jefe SET Nombres=?, Apellidos=?, Correo=?, usuario=?, password=?, imagen=? WHERE idJefe=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, jefe.getNombres());
            ps.setString(2, jefe.getApellidos());
            ps.setString(3, jefe.getCorreo());
            ps.setString(4, jefe.getUsuario());
            ps.setString(5, jefe.getPassword());
            ps.setString(6, jefe.getImagen());
            ps.setInt(7, jefe.getIdJefe());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }}
