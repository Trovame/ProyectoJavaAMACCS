
package Database;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    
    private Connection con;
    
   public Conexion() throws ClassNotFoundException{
   
       try{
       
           Class.forName("com.mysql.jdbc.Driver");
           con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ProyectoJava","root","");
       }catch(Exception e){
       
       }
   }

   public Connection getConnection(){
       return con;
   }
}
