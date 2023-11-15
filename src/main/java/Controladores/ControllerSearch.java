/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controladores;

import Modelos.Producto;
import ModelosDAO.ProductoDAO;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerSearch extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

    private void procesarSolicitud(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tiempo = request.getParameter("tiempo");
        String boton = request.getParameter("boton");

        try {
            ProductoDAO productoDAO = new ProductoDAO();
            List<Producto> listaPlatillos = null;
            String pagina = "";

            if (boton != null) {
                if (boton.equals("FiltrarAdmin")) {
                    listaPlatillos = productoDAO.listProductosPorTiempo(tiempo);
                    pagina = "menusadmin2.jsp";
                } else if (boton.equals("FiltrarMesero")) {
                    listaPlatillos = productoDAO.listProductosPorTiempo(tiempo); // Cambia esto si necesitas una lista diferente para meseros
                    pagina = "menus2.jsp";
                }
            }

            request.setAttribute("listaPlatillos", listaPlatillos);
            RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Este servlet maneja la búsqueda de productos por tiempo.";
    }
}
