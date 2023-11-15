/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controladores;

import ModelosDAO.EmpleadoDAO;
import Modelos.Empleado;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class ControllerEmpleado extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            EmpleadoDAO empleadoDAO = new EmpleadoDAO();

            // Eliminar empleado
            if (request.getParameter("idEmpleado") != null) {
                int idEmpleado = Integer.parseInt(request.getParameter("idEmpleado"));
                empleadoDAO.remove(idEmpleado);
            }

            // Consultar empleados
            List<Empleado> empleados = empleadoDAO.listEmpleados();
            request.setAttribute("empleados", empleados);
            request.setAttribute("totalEmpleados", empleados.size());
            RequestDispatcher dispatcher = request.getRequestDispatcher("empleados.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String operacion = request.getParameter("operacion");

        if (operacion.equals("Agregar")) {
            // Obtén los parámetros del formulario
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String correo = request.getParameter("correo");
            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");

            Part filePart = request.getPart("imagen");
            String fileName = getSubmittedFileName(filePart);

            // Crea el objeto Empleado y configúralo con los valores obtenidos del formulario
            Empleado empleado = new Empleado();
            empleado.setNombres(nombres);
            empleado.setApellidos(apellidos);
            empleado.setCorreo(correo);
            empleado.setUsuario(usuario);
            empleado.setPassword(password);
            empleado.setImagen(fileName);

            try {
                EmpleadoDAO empleadoDAO = new EmpleadoDAO();
                empleadoDAO.add(empleado);

                // Guarda la imagen en la carpeta "img" dentro del proyecto
                String imagePath = "src/main/webapp/img/" + fileName; // Asegúrate de ajustar la ruta según la estructura de tu proyecto y el nombre del archivo
                File file = new File(imagePath);

                // Escribe la imagen al disco
                try ( InputStream input = filePart.getInputStream();  FileOutputStream output = new FileOutputStream(file)) {
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = input.read(buffer)) > 0) {
                        output.write(buffer, 0, length);
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        } else if (operacion.equals("Editar")) {
            // Obtén los parámetros del formulario
            int idEmpleado = Integer.parseInt(request.getParameter("id"));
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String correo = request.getParameter("correo");
            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");

            Part filePart = request.getPart("imagen");
            String fileName = getSubmittedFileName(filePart);

            // Crea el objeto Empleado y configúralo con los valores obtenidos del formulario
            Empleado empleado = new Empleado();
            empleado.setIdEmpleado(idEmpleado);
            empleado.setNombres(nombres);
            empleado.setApellidos(apellidos);
            empleado.setCorreo(correo);
            empleado.setUsuario(usuario);
            empleado.setPassword(password);
            empleado.setImagen(fileName);

            try {
                EmpleadoDAO empleadoDAO = new EmpleadoDAO();
                empleadoDAO.update(empleado);

                // Guarda la imagen en la carpeta "img" dentro del proyecto
                String imagePath = "src/main/webapp/img/" + fileName; // Asegúrate de ajustar la ruta según la estructura de tu proyecto y el nombre del archivo
                File file = new File(imagePath);

                // Escribe la imagen al disco
                try ( InputStream input = filePart.getInputStream();  FileOutputStream output = new FileOutputStream(file)) {
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = input.read(buffer)) > 0) {
                        output.write(buffer, 0, length);
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        doGet(request, response);
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
