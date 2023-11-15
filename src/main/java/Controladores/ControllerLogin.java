/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controladores;

import ModelosDAO.EmpleadoDAO;
import ModelosDAO.JefeDAO;
import Modelos.Empleado;
import Modelos.Jefe;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ControllerLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String accion = request.getParameter("accion");
        // Obtén los parámetros del formulario
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        
          if (accion != null && accion.equals("removeUserDetails")) {
            HttpSession session = request.getSession();
            session.removeAttribute("nombreUsuario");
            session.removeAttribute("correoUsuario");
            session.removeAttribute("imagenUsuario");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            EmpleadoDAO empleadoDAO = new EmpleadoDAO();
            JefeDAO jefeDAO = new JefeDAO();

            // Verificar si el usuario y la contraseña existen en la tabla Empleado
            List<Empleado> empleados = empleadoDAO.listEmpleados();
            for (Empleado emp : empleados) {
                if (emp.getUsuario().equals(usuario) && emp.getPassword().equals(password)) {
                    // Guarda la información del empleado en la sesión
                    HttpSession session = request.getSession();
                    session.setAttribute("nombreUsuario", emp.getNombres());
                    session.setAttribute("correoUsuario", emp.getCorreo());
                    session.setAttribute("imagenUsuario", emp.getImagen());
                    response.sendRedirect("index2.jsp");
                    return;
                }
            }

            // Verificar si el usuario y la contraseña existen en la tabla Jefe
            List<Jefe> jefes = jefeDAO.listJefes();
            for (Jefe jefe : jefes) {
                if (jefe.getUsuario().equals(usuario) && jefe.getPassword().equals(password)) {
                    // Guarda la información del jefe en la sesión
                    HttpSession session = request.getSession();
                    session.setAttribute("nombreUsuario", jefe.getNombres());
                    session.setAttribute("correoUsuario", jefe.getCorreo());
                    session.setAttribute("imagenUsuario", jefe.getImagen());
                    response.sendRedirect("index3.jsp");
                    return;
                }
            }

            // Mostrar mensaje de error si no se encuentra en ninguna tabla
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Usuario o contraseña incorrectos');");
            response.getWriter().println("location='login.jsp';");
            response.getWriter().println("</script>");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
