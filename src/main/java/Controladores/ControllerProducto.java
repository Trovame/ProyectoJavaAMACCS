/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controladores;

import ModelosDAO.ProductoDAO;
import Modelos.Producto;
import ModelosDAO.ProveedorDAO;
import ModelosDAO.CategoriaDAO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

public class ControllerProducto extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            ProductoDAO productoDAO = new ProductoDAO();
            ProveedorDAO proveedorDAO = new ProveedorDAO();
            CategoriaDAO categoriaDAO = new CategoriaDAO();

            // Eliminar producto
            if (request.getParameter("idproducto") != null) {
                int idproducto = Integer.parseInt(request.getParameter("idproducto"));
                productoDAO.remove(idproducto);
            }




            // Consultar productos
            List<Producto> consulta = productoDAO.listProductos();
            request.setAttribute("consulta", consulta);
            request.setAttribute("totalProductos", consulta.size());
            request.setAttribute("proveedores", proveedorDAO.listProveedores());
            request.setAttribute("categorias", categoriaDAO.listCategorias());
            RequestDispatcher dispatcher = request.getRequestDispatcher("productos.jsp");
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
            String nombreProducto = request.getParameter("Nombre");
            String descripcion = request.getParameter("Descripcion");
            String precio = request.getParameter("Precio");
            String tiempo = request.getParameter("tiempo");
            String idProveedorString = request.getParameter("idProveedor");
            String idCategoriaString = request.getParameter("idCategoria");
            String imagen = request.getParameter("imagen");

            // Realiza la validación para evitar el error de NumberFormatException
            int idProveedor = 0;
            if (idProveedorString != null && !idProveedorString.isEmpty()) {
                idProveedor = Integer.parseInt(idProveedorString);
            }

            int idCategoria = 0;
            if (idCategoriaString != null && !idCategoriaString.isEmpty()) {
                idCategoria = Integer.parseInt(idCategoriaString);
            }

            // Crea el objeto Producto y configúralo con los valores obtenidos del formulario
            Producto producto = new Producto();
            producto.setNombreProducto(nombreProducto);
            producto.setDescripcion(descripcion);
            producto.setPrecio(precio);
            producto.setTiempo(tiempo);
            producto.setIdProveedor(idProveedor);
            producto.setIdCategoria(idCategoria);
            producto.setImagen(imagen);

            try {
                ProductoDAO productoDAO = new ProductoDAO();
                productoDAO.add(producto);

                // Guarda la imagen en la carpeta "img" dentro del proyecto
                String imagePath = "src/main/webapp/img/" + imagen; // Asegúrate de ajustar la ruta según la estructura de tu proyecto
                File file = new File(imagePath);

                // Obtén la entrada de flujo de datos de la imagen cargada
                Part filePart = request.getPart("imagen");
                InputStream inputStream = filePart.getInputStream();

                // Escribe la imagen al disco
                OutputStream outputStream = new FileOutputStream(file);
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                outputStream.close();
                inputStream.close();

            } catch (Exception e) {
                e.printStackTrace();
            }

        } else if (operacion.equals("Editar")) {
            // Obtén los parámetros del formulario
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            String nombreProducto = request.getParameter("Nombre");
            String descripcion = request.getParameter("Descripcion");
            String precio = request.getParameter("Precio");
            String tiempo = request.getParameter("tiempo");
            String idProveedorString = request.getParameter("idProveedor");
            String idCategoriaString = request.getParameter("idCategoria");
            String imagen = request.getParameter("imagen");

            // Realiza la validación para evitar el error de NumberFormatException
            int idProveedor = 0;
            if (idProveedorString != null && !idProveedorString.isEmpty()) {
                idProveedor = Integer.parseInt(idProveedorString);
            }

            int idCategoria = 0;
            if (idCategoriaString != null && !idCategoriaString.isEmpty()) {
                idCategoria = Integer.parseInt(idCategoriaString);
            }

            // Crea el objeto Producto y configúralo con los valores obtenidos del formulario
            Producto producto = new Producto();
            producto.setIdProducto(idProducto);
            producto.setNombreProducto(nombreProducto);
            producto.setDescripcion(descripcion);
            producto.setPrecio(precio);
            producto.setTiempo(tiempo);
            producto.setIdProveedor(idProveedor);
            producto.setIdCategoria(idCategoria);
            producto.setImagen(imagen);

              try {
                ProductoDAO productoDAO = new ProductoDAO();
                productoDAO.update(producto);

                // Guarda la imagen en la carpeta "img" dentro del proyecto
                String imagePath = "src/main/webapp/img/" + imagen; // Asegúrate de ajustar la ruta según la estructura de tu proyecto
                File file = new File(imagePath);

                // Obtén la entrada de flujo de datos de la imagen cargada
                Part filePart = request.getPart("imagen");
                InputStream inputStream = filePart.getInputStream();

                // Escribe la imagen al disco
                OutputStream outputStream = new FileOutputStream(file);
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                outputStream.close();
                inputStream.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}