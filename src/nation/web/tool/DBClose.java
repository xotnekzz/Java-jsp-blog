package nation.web.tool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBClose {
  public void close(Connection con, PreparedStatement pstmt) {
    try {
      if (pstmt != null) {
        pstmt.close();
      }
    } catch (Exception e) {
    }
    try {
      if (con != null) {
        con.close();
      }
    } catch (Exception e) {
    }
  }
  
  public void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
    try {
      if (pstmt != null) {
        pstmt.close();
      }
    } catch (Exception e) {
    }
    try {
      if (con != null) {
        con.close();
      }
    } catch (Exception e) {
    }
    try {
      if (rs != null){
        rs.close();
      }
    }  catch (Exception e) {
    }
  }
}
