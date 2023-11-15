/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controladores;

import ModelosDAO.ClienteDAO; // Asegúrate de importar la clase ClienteDAO
import Modelos.Cliente; // Asegúrate de importar la clase Cliente
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerCliente extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ClienteDAO clienteDAO = new ClienteDAO();

            // Eliminar cliente
            if (request.getParameter("idcliente") != null) {
                int idcliente = Integer.parseInt(request.getParameter("idcliente"));
                clienteDAO.remove(idcliente);
            }

            // Actualizar cliente
            if (request.getParameter("idclienteActualizar") != null) {
                int idclienteActualizar = Integer.parseInt(request.getParameter("idclienteActualizar"));
                Cliente cliente = clienteDAO.search_by_id(idclienteActualizar);
                request.setAttribute("cliente", cliente);
                RequestDispatcher dispatcher2 = request.getRequestDispatcher("editar.jsp");
                dispatcher2.forward(request, response);
            }

            // Consultar clientes
            List<Cliente> consulta = clienteDAO.list();
            request.setAttribute("consulta", consulta);
            RequestDispatcher dispatcher = request.getRequestDispatcher("clientes.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String sexo = request.getParameter("sexo");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String pais = request.getParameter("pais");
        String clave = request.getParameter("clave");
        String correo = request.getParameter("correo");

        Cliente cliente = new Cliente();
        cliente.setNombre(nombre);
        cliente.setApellidos(apellidos);
        cliente.setSexo(sexo);
        cliente.setDireccion(direccion);
        cliente.setTelefono(telefono);
        cliente.setPais(pais);
        cliente.setClave(clave);
        cliente.setCorreo(correo);

        try {
            ClienteDAO clienteDAO = new ClienteDAO();
            clienteDAO.add(cliente);
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
