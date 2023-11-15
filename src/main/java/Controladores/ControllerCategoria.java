/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controladores;

import Modelos.Categoria;
import ModelosDAO.CategoriaDAO;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerCategoria extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            CategoriaDAO categoriaDAO = new CategoriaDAO();

            // Eliminar categoría
                     if (request.getParameter("idcategoria") != null && request.getParameter("action").equals("delete")) {
                int idCategoria = Integer.parseInt(request.getParameter("idcategoria"));
                boolean deleted = categoriaDAO.remove(idCategoria);
                if (!deleted) {
                    request.setAttribute("error", "No se puede eliminar la categoría");
                }
            }

            // Consultar categorías
            List<Categoria> consulta = categoriaDAO.listCategorias();
            request.setAttribute("consulta", consulta);
             request.setAttribute("listacategorias", consulta);
            RequestDispatcher dispatcher = request.getRequestDispatcher("categoria.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombreCategoria = request.getParameter("Nombre");
        Categoria categoria = new Categoria();
        categoria.setNombreCategoria(nombreCategoria);

        try {
            CategoriaDAO categoriaDAO = new CategoriaDAO();
            categoriaDAO.add(categoria);
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

