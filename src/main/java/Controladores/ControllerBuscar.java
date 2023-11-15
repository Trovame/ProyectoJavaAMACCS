/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controladores;

import Modelos.Pedido;
import ModelosDAO.PedidoDAO;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerBuscar extends HttpServlet {

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

        try {
            PedidoDAO pedidoDAO = new PedidoDAO();
            List<Pedido> listaPedidos;

            if (cliente != null && !cliente.isEmpty() && fecha != null && !fecha.isEmpty()) {
                listaPedidos = pedidoDAO.listPedidosPorClienteYFecha(cliente, fecha);
            } else if (cliente != null && !cliente.isEmpty()) {
                listaPedidos = pedidoDAO.listPedidosPorCliente(cliente);
            } else if (fecha != null && !fecha.isEmpty()) {
                listaPedidos = pedidoDAO.listPedidosPorFecha(fecha);
            } else {
                listaPedidos = pedidoDAO.listPedidos();
            }

            request.setAttribute("listaPedidos", listaPedidos);
            RequestDispatcher dispatcher = request.getRequestDispatcher("pedidos.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
