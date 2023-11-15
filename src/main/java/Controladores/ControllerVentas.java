/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controladores;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ControllerVentas extends HttpServlet {

    // Configura tus credenciales y URL de la base de datos
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/ProyectoJava";
    static final String USER = "root";
    static final String PASS = "";

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Obtén la fecha del parámetro
        String fechaConsulta = request.getParameter("fecha");

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            // Paso 1: Registrar JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Paso 2: Abrir la conexión
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // Paso 3: Ejecutar la consulta
            String sql = "SELECT SUM(total) AS totalVentas FROM pedidos WHERE fecha=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fechaConsulta);
            ResultSet rs = pstmt.executeQuery();

            // Paso 4: Procesar el conjunto de resultados
            if (rs.next()) {
                int totalVentas = rs.getInt("totalVentas");
                request.setAttribute("totalVentas", totalVentas);
                request.setAttribute("fechaConsulta", fechaConsulta);
                RequestDispatcher rd = request.getRequestDispatcher("ventas.jsp");
                rd.forward(request, response);
            } else {
                out.println("<html><body>");
                out.println("<h2>No se encontraron ventas para la fecha especificada.</h2>");
                out.println("</body></html>");
            }

            // Paso 5: Cerrar la conexión
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null)
                    pstmt.close();
            } catch (SQLException se2) {
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}

