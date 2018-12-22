package nation.web.tool;
 
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
 
import org.apache.commons.dbcp.ConnectionFactory;
import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDriver;
import org.apache.commons.pool.impl.GenericObjectPool;
  
public class DBCPServlet extends HttpServlet {
   
    // ServletConfig config: web.xml에 접근가능 객체
    @Override
    public void init(ServletConfig config) throws ServletException {
        String registerPool = ""; // Pool 이름
        String jdbcDriver = "";   // Driver Class
        String jdbcURL = "";      // DBMS server URL
        String user = "";           // 계정 아이디
        String password = "";     // 계정 password
        
        int maxActive = 0;        // 최대 연결수 
        int maxIdle = 0;           // 대기중인 연결수 
        
        // web.xml에서 값을 가져옵니다.
        registerPool = config.getInitParameter("registerPool");
        jdbcDriver = config.getInitParameter("jdbcDriver"); 
        jdbcURL = config.getInitParameter("jdbcURL");
        user = config.getInitParameter("user");
        password = config.getInitParameter("password");
        
        maxActive = Integer.parseInt(config.getInitParameter("maxActive"));
        maxIdle = Integer.parseInt(config.getInitParameter("maxIdle"));
        
        try {
            // JDBC 드라이버 로딩, oracle.jdbc.driver.OracleDriver
            Class.forName(jdbcDriver);
            
            // Connection Pool 생성
            GenericObjectPool connectionPool = new GenericObjectPool(null);
            connectionPool.setMaxActive(maxActive); // 최대 동시 연결수 
            connectionPool.setMaxIdle(maxIdle);     // 접속 대기 연결수
            
            // 실제 DB와의 커넥션을 연결해주는 팩토리 생성
            ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(
                jdbcURL,    // JDBC URL
                user,       // 사용자
                password);
            
            // Connection Pool이 PoolableConnection 객체를 생성할 때 사용할
            // PoolableConnectionFactory 생성
            PoolableConnectionFactory poolableConnectionFactory = new PoolableConnectionFactory(
                connectionFactory,
                connectionPool,
                null,  // statement pool
                null,  // 커넥션 테스트 쿼리: 커넥션이 유효한지 테스트할 때 사용되는 쿼리.
                false, // read only 여부
                true); // auto commit 여부
 
            // Pooling을 위한 JDBC 드라이버 생성 및 등록
            PoolingDriver driver = new PoolingDriver();
            
            // JDBC 드라이버에 커넥션 풀 등록
            // ora10g2는 Connection 연결 요구시 사용하게 됩니다.
            driver.registerPool(registerPool, connectionPool);
            
            System.out.println("--------------------------------------------------------------------");
            System.out.println("blog_v3jq DBCP Connection Pool이 실행되었습니다.");
            System.out.println("--------------------------------------------------------------------");
            
        } catch(Exception ex) {
            //throw new ServletException(ex);
            ex.printStackTrace();
        }
 
    }
}