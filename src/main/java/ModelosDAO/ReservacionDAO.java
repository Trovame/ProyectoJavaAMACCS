/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package ModelosDAO;

import Database.Conexion;
import Modelos.Reservacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReservacionDAO {

    private Conexion con;
    private Connection connect;
    private PreparedStatement ps;
    private ResultSet rs;

    public ReservacionDAO() throws ClassNotFoundException {
        con = new Conexion();
    }

    public List<Reservacion> listReservaciones() {
        List<Reservacion> listaReservaciones = new ArrayList<>();
        String sql = "SELECT * FROM reservacion";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Reservacion reservacion = new Reservacion();
                reservacion.setIdreser(rs.getInt("idreser"));
                reservacion.setCliente(rs.getString("Cliente"));
                reservacion.setFecha(rs.getString("fecha"));
                reservacion.setHoraLlegada(rs.getString("Hora_Llegada"));
                reservacion.setHoraSalida(rs.getString("Hora_Salida"));
                reservacion.setCantidad(rs.getInt("cantidad"));
                reservacion.setMesa(rs.getString("Mesa"));
                listaReservaciones.add(reservacion);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaReservaciones;
    }
    

    public boolean add(Reservacion reservacion) {
        if (existeReservacion(reservacion.getFecha(), reservacion.getHoraLlegada(), reservacion.getMesa())) {
            System.out.println("Ya hay una reservación con los mismos datos.");
            return false;
        }

        String sql = "INSERT INTO reservacion (Cliente, fecha, Hora_Llegada, Hora_Salida, cantidad, Mesa) VALUES (?,?,?,?,?,?)";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, reservacion.getCliente());
            ps.setString(2, reservacion.getFecha());
            ps.setString(3, reservacion.getHoraLlegada());
            ps.setString(4, reservacion.getHoraSalida());
            ps.setInt(5, reservacion.getCantidad());
            ps.setString(6, reservacion.getMesa());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean remove(int idReser) {
        String sql = "DELETE FROM reservacion WHERE idreser=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setInt(1, idReser);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean existeReservacion(String fecha, String horaLlegada, String mesa) {
        String sql = "SELECT * FROM reservacion WHERE fecha=? AND Hora_Llegada=? AND Mesa=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, fecha);
            ps.setString(2, horaLlegada);
            ps.setString(3, mesa);
            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Reservacion> listReservacionesPorCliente(String cliente) {
        List<Reservacion> listaReservaciones = new ArrayList<>();
        String sql = "SELECT * FROM reservacion WHERE Cliente=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, cliente);
            rs = ps.executeQuery();
            while (rs.next()) {
                Reservacion reservacion = new Reservacion();
                reservacion.setIdreser(rs.getInt("idreser"));
                reservacion.setCliente(rs.getString("Cliente"));
                reservacion.setFecha(rs.getString("fecha"));
                reservacion.setHoraLlegada(rs.getString("Hora_Llegada"));
                reservacion.setHoraSalida(rs.getString("Hora_Salida"));
                reservacion.setCantidad(rs.getInt("cantidad"));
                reservacion.setMesa(rs.getString("Mesa"));
                listaReservaciones.add(reservacion);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaReservaciones;
    }

    public List<Reservacion> listReservacionesPorFecha(String fecha) {
        List<Reservacion> listaReservaciones = new ArrayList<>();
        String sql = "SELECT * FROM reservacion WHERE fecha=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, fecha);
            rs = ps.executeQuery();
            while (rs.next()) {
                Reservacion reservacion = new Reservacion();
                reservacion.setIdreser(rs.getInt("idreser"));
                reservacion.setCliente(rs.getString("Cliente"));
                reservacion.setFecha(rs.getString("fecha"));
                reservacion.setHoraLlegada(rs.getString("Hora_Llegada"));
                reservacion.setHoraSalida(rs.getString("Hora_Salida"));
                reservacion.setCantidad(rs.getInt("cantidad"));
                reservacion.setMesa(rs.getString("Mesa"));
                listaReservaciones.add(reservacion);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaReservaciones;
    }

    public List<Reservacion> listReservacionesPorMesa(String mesa) {
        List<Reservacion> listaReservaciones = new ArrayList<>();
        String sql = "SELECT * FROM reservacion WHERE Mesa=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, mesa);
            rs = ps.executeQuery();
            while (rs.next()) {
                Reservacion reservacion = new Reservacion();
                reservacion.setIdreser(rs.getInt("idreser"));
                reservacion.setCliente(rs.getString("Cliente"));
                reservacion.setFecha(rs.getString("fecha"));
                reservacion.setHoraLlegada(rs.getString("Hora_Llegada"));
                reservacion.setHoraSalida(rs.getString("Hora_Salida"));
                reservacion.setCantidad(rs.getInt("cantidad"));
                reservacion.setMesa(rs.getString("Mesa"));
                listaReservaciones.add(reservacion);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaReservaciones;
    }
    
    public boolean edit(Reservacion reservacion) {
        String sql = "UPDATE reservacion SET Cliente=?, fecha=?, Hora_Llegada=?, Hora_Salida=?, cantidad=?, Mesa=? WHERE idreser=?";
        try {
            connect = con.getConnection();
            ps = connect.prepareStatement(sql);
            ps.setString(1, reservacion.getCliente());
            ps.setString(2, reservacion.getFecha());
            ps.setString(3, reservacion.getHoraLlegada());
            ps.setString(4, reservacion.getHoraSalida());
            ps.setInt(5, reservacion.getCantidad());
            ps.setString(6, reservacion.getMesa());
            ps.setInt(7, reservacion.getIdreser());
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Reservacion> listReservacionesPorClienteFechaMesa(String cliente, String fecha, String mesa) {
    List<Reservacion> listaReservaciones = new ArrayList<>();
    String sql = "SELECT * FROM reservacion WHERE Cliente=? AND fecha=? AND Mesa=?";
    try {
        connect = con.getConnection();
        ps = connect.prepareStatement(sql);
        ps.setString(1, cliente);
        ps.setString(2, fecha);
        ps.setString(3, mesa);
        rs = ps.executeQuery();
        while (rs.next()) {
            Reservacion reservacion = new Reservacion();
            reservacion.setIdreser(rs.getInt("idreser"));
            reservacion.setCliente(rs.getString("Cliente"));
            reservacion.setFecha(rs.getString("fecha"));
            reservacion.setHoraLlegada(rs.getString("Hora_Llegada"));
            reservacion.setHoraSalida(rs.getString("Hora_Salida"));
            reservacion.setCantidad(rs.getInt("cantidad"));
            reservacion.setMesa(rs.getString("Mesa"));
            listaReservaciones.add(reservacion);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return listaReservaciones;
}

}
