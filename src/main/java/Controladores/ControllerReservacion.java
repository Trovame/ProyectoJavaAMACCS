/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controladores;

import Modelos.Reservacion;
import ModelosDAO.ReservacionDAO;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerReservacion extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ReservacionDAO reservacionDAO = new ReservacionDAO();

            // Eliminar reservación
            if (request.getParameter("idreser") != null && request.getParameter("accion").equals("eliminar")) {
                int idReser = Integer.parseInt(request.getParameter("idreser"));
                reservacionDAO.remove(idReser);
            }

            // Consultar reservaciones
            List<Reservacion> listaReservaciones = reservacionDAO.listReservaciones();
            request.setAttribute("reservaciones", listaReservaciones);
            request.setAttribute("Reservar", listaReservaciones.size());
            RequestDispatcher dispatcher = request.getRequestDispatcher("reservar.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operacion = request.getParameter("operacion");

        if (operacion.equals("Agregar")) {
            String cliente = request.getParameter("cliente");
            String fecha = request.getParameter("fecha");
            String horaLlegada = request.getParameter("hora_llegada");
            String horaSalida = request.getParameter("hora_salida");
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            String mesa = request.getParameter("mesa");

            Reservacion reservacion = new Reservacion();
            reservacion.setCliente(cliente);
            reservacion.setFecha(fecha);
            reservacion.setHoraLlegada(horaLlegada);
            reservacion.setHoraSalida(horaSalida);
            reservacion.setCantidad(cantidad);
            reservacion.setMesa(mesa);

            try {
                ReservacionDAO reservacionDAO = new ReservacionDAO();
                boolean existeReservacion = reservacionDAO.existeReservacion(fecha, horaLlegada, mesa);
                if (existeReservacion) {
                    response.sendRedirect("reservar.jsp?error=true");
                } else {
                    reservacionDAO.add(reservacion);
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        } else if (operacion.equals("Editar")) {
            int idReser = Integer.parseInt(request.getParameter("idReser"));
            String cliente = request.getParameter("cliente");
            String fecha = request.getParameter("fecha");
            String horaLlegada = request.getParameter("hora_llegada");
            String horaSalida = request.getParameter("hora_salida");
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            String mesa = request.getParameter("mesa");

            Reservacion reservacion = new Reservacion();
            reservacion.setIdreser(idReser);
            reservacion.setCliente(cliente);
            reservacion.setFecha(fecha);
            reservacion.setHoraLlegada(horaLlegada);
            reservacion.setHoraSalida(horaSalida);
            reservacion.setCantidad(cantidad);
            reservacion.setMesa(mesa);

          try {
            ReservacionDAO reservacionDAO = new ReservacionDAO();
            boolean existeReservacion = reservacionDAO.existeReservacion(fecha, horaLlegada, mesa);

            if (existeReservacion) {
                response.sendRedirect("reservar.jsp?errorEdi=true");
            } else {
                reservacionDAO.edit(reservacion);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    doGet(request, response);
}

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
