package nation.web.tool;
 
import java.sql.Connection;
import java.sql.DriverManager;
 
public class DBOpen {
  
  // MySQL Connection Pool ��� DBMS ���� 
  public Connection getConnection(){
    Connection con = null;          // DBMS ���� ��ü
 
    try{
      // blog_v2jq �� web.xml�� registerPool ������ ���̾�� �� 
      // <param-name>registerPool</param-name> <!-- ������ -->
      // <param-value>blog_v2jq</param-value>    <!-- ������ -->
      String poolName = "jdbc:apache:commons:dbcp:develop_v4jq";
      con = DriverManager.getConnection(poolName);
      System.out.println("Connection Mode 2: " + con.hashCode());
 
    }catch(Exception e){
      e.printStackTrace();
    }
     
    return con; // Void methods cannot return a value
  }
  
  public Connection getConnectionNormal(){
    Connection con = null; // �޸𸮰� �Ҵ���� ����.
    
    try{
      String jdbc = "org.gjt.mm.mysql.Driver"; // MySQL ���� Drvier 
      String url = "jdbc:mysql://localhost:3306/javadb?useUnicode=true&characterEncoding=euckr"; 
      String user = "root"; 
      String pass = "1234"; 
        
      Class.forName(jdbc); // memory�� ����̹� Ŭ������ �ε���.
      con = DriverManager.getConnection(url, user, pass); // MySQL ����
      System.out.println("Connection Mode 1: " + con.hashCode());
      
    }catch(Exception e){
      e.printStackTrace();
    }
    
    return con;
  }
}