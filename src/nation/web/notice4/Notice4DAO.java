package nation.web.notice4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class Notice4DAO {
  Connection con = null; // DBMS 연결
  PreparedStatement pstmt = null; // SQL 실행
  ResultSet rs = null; // SELECT 결과를 저장
  StringBuffer sql = null; // SQL 저장

  public int create(Notice4VO notice4VO) {
    int count = 0;
 
    try {
      con = new DBOpen().getConnection();

      sql = new StringBuffer();
      sql.append(" INSERT INTO notice4(title, rname, rdate) VALUES(?,?,now())");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, notice4VO.getTitle());
      pstmt.setString(2, notice4VO.getRname());

      count = pstmt.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return count;
  }

  public void selectOne(Notice4VO notice4VO ,int notice4no) {

    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT title, rname FROM notice4 WHERE notice4no = ?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, notice4no);
      rs = pstmt.executeQuery();
       
      rs.next();
      notice4VO.setTitle(rs.getString("title"));
      notice4VO.setRname(rs.getString("rname"));

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
  }
  
  public ArrayList<Notice4VO> list() {
    ArrayList<Notice4VO> notice4s = new ArrayList<Notice4VO>();
    
    try {
      con = new DBOpen().getConnection();
      pstmt = con.prepareStatement("select * from notice4 ORDER BY notice4no asc");
      rs = pstmt.executeQuery();
      
      while(rs.next()) {
        Notice4VO notice4VO = new Notice4VO();
        notice4VO.setNotice4no(rs.getInt("notice4no"));
        notice4VO.setTitle(rs.getString("title"));
        notice4VO.setRname(rs.getString("rname"));
        notice4VO.setRdate(rs.getString("rdate"));
        notice4s.add(notice4VO);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return notice4s;
  }
  
  public int update(Notice4VO notice4VO, int notice4no) {
    int count = 0;
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE notice4 SET title=?, rname=?");
      sql.append(" WHERE notice4no=?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, notice4VO.getTitle());
      pstmt.setString(2, notice4VO.getRname());
      pstmt.setInt(3, notice4no);

      count = pstmt.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return count;
  }
  
  public int delete(int notice4no) {
    int count = 0;
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM notice4 WHERE notice4no = ?");
      
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, notice4no);
      count = pstmt.executeUpdate();
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return count;
  }
}
