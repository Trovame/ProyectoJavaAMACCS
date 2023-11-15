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

public class ControllerBusca extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

    private void procesarSolicitud(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cliente = request.getParameter("Cliente");
        String fecha = request.getParameter("fecha");
        String mesa = request.getParameter("Mesa");
        String boton = request.getParameter("boton");

        try {
            ReservacionDAO reservacionDAO = new ReservacionDAO();
            List<Reservacion> listaReservaciones;

            if (boton.equals("buscarPorAparte")) {
                listaReservaciones = reservacionDAO.listReservacionesPorClienteFechaMesa(cliente, fecha, mesa);
                request.setAttribute("reservaciones", listaReservaciones);
                RequestDispatcher dispatcher = request.getRequestDispatcher("consulta.jsp");
                dispatcher.forward(request, response);
            } else if (boton.equals("BuscarJunto")) {
                if (cliente != null && !cliente.isEmpty() && fecha != null && !fecha.isEmpty() && mesa != null && !mesa.isEmpty()) {
                    listaReservaciones = reservacionDAO.listReservacionesPorClienteFechaMesa(cliente, fecha, mesa);
                    request.setAttribute("reservaciones", listaReservaciones);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("reservar2.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
