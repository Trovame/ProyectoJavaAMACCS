/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controladores;

import Modelos.Proveedor;
import ModelosDAO.ProveedorDAO;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerProveedor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ProveedorDAO proveedorDAO = new ProveedorDAO();

            // Eliminar proveedor
            if (request.getParameter("idProveedor") != null && request.getParameter("accion").equals("eliminar")) {
                int idProveedor = Integer.parseInt(request.getParameter("idProveedor"));
                proveedorDAO.remove(idProveedor);
            }

            // Consultar proveedores
            List<Proveedor> consulta = proveedorDAO.listProveedores();
            request.setAttribute("consulta", consulta);
            request.setAttribute("totalProveedores", consulta.size());
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombreProveedor = request.getParameter("Nombre");
        String telefono = request.getParameter("Telefono");
        String correo = request.getParameter("Correo");
        String direccion = request.getParameter("Direccion");
        Proveedor proveedor = new Proveedor();
        proveedor.setNombreProveedor(nombreProveedor);
        proveedor.setTelefono(telefono);
        proveedor.setCorreo(correo);
        proveedor.setDireccion(direccion);

        try {
            ProveedorDAO proveedorDAO = new ProveedorDAO();
            proveedorDAO.add(proveedor);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
