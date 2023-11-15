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

public class ControllerHecho extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

      private void procesarSolicitud(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idPedido = Integer.parseInt(request.getParameter("idPedido"));
        String estado = request.getParameter("estado");

        try {
            PedidoDAO pedidoDAO = new PedidoDAO();
            if (estado.equals("Ordenado")) {
                pedidoDAO.actualizarEstado(idPedido, "Cancelado");
                Pedido pedido = pedidoDAO.getPedidoById(idPedido);
                request.setAttribute("pedido", pedido);
                RequestDispatcher dispatcher = request.getRequestDispatcher("factura.jsp");
                dispatcher.forward(request, response);
            } else if (estado.equals("Cancelado")) {
                Pedido pedido = pedidoDAO.getPedidoById(idPedido);
                request.setAttribute("pedido", pedido);
                RequestDispatcher dispatcher = request.getRequestDispatcher("detalle.jsp");
                dispatcher.forward(request, response);
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

