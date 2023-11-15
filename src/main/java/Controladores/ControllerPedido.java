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

public class ControllerPedido extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            PedidoDAO pedidoDAO = new PedidoDAO();

            // Eliminar pedido
            if (request.getParameter("idPedido") != null && request.getParameter("accion").equals("eliminar")) {
                int idPedido = Integer.parseInt(request.getParameter("idPedido"));
                pedidoDAO.remove(idPedido);
            }

             // Consultar pedidos
            List<Pedido> consulta = pedidoDAO.listPedidos();
            request.setAttribute("consulta", consulta);
            request.setAttribute("Pedido", consulta.size());
            RequestDispatcher dispatcher = request.getRequestDispatcher("pedido.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String Cliente = request.getParameter("Cliente");
    String Productos = request.getParameter("Productos");
    String Mesa = request.getParameter("Mesa");
    double total = Double.parseDouble(request.getParameter("total"));
    String fecha = request.getParameter("fecha");
    String estado = "Ordenado"; // Valor fijo según tu requisito

    Pedido pedido = new Pedido();
    pedido.setCliente(Cliente);
    pedido.setProductos(Productos);
    pedido.setMesa(Mesa);
    pedido.setTotal((int) total);
    pedido.setFecha(fecha);
    pedido.setEstado(estado);

    try {
        PedidoDAO pedidoDAO = new PedidoDAO();
        pedidoDAO.add(pedido);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    // Redirigir según el botón presionado en el formulario
    String buttonValue = request.getParameter("eliminar");
    if (buttonValue != null) {
        if (buttonValue.equals("PedidoAdmin")) {
            String path = request.getContextPath() + "/pedido.jsp";
            response.sendRedirect(path);
        } else if (buttonValue.equals("PedidoMesero")) {
                String path = request.getContextPath() + "/carrito.jsp";
                response.sendRedirect(path);
                // Guardar un mensaje en la sesión
                request.getSession().setAttribute("pedidoRealizado", "Su pedido ha sido realizado");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}





