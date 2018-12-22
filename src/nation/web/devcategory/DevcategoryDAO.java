package nation.web.devcategory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class DevcategoryDAO {
  private Connection con = null;              // DBMS 연결   
  private PreparedStatement pstmt = null; // SQL 실행
  private ResultSet rs = null;                   // SELECT 결과를 저장
  private StringBuffer sql = null;              // SQL 저장
  
  private DBOpen dbopen = null;
  private DBClose dbclose = null;
  
  public DevcategoryDAO() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
  }
  
  /**
   * 카테고리 등록 
   * @param devcategoryVO
   * @return 등록된 개수 1 or 0
   */
  
  public int create(DevcategoryVO devcategoryVO) {
    int count = 0;

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();
      sql.append(" INSERT INTO devcategory(title, seqno, visible, ids, cnt)");
      sql.append(" VALUES(?, ?, ?, ?, 0)");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, devcategoryVO.getTitle());
      pstmt.setInt(2, devcategoryVO.getSeqno());
      pstmt.setString(3, devcategoryVO.getVisible());
      pstmt.setString(4, devcategoryVO.getIds());

      count = pstmt.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    return count;
  }
  
  /**
   * 카테고리 항목 선택
   * @param devcategoryVO
   * @param devcategoryno
   */
  
  public DevcategoryVO selectOne(DevcategoryVO devcategoryVO ,int devcateno) {

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT devcateno, title, seqno, visible, ids, cnt");
      sql.append(" FROM devcategory");
      sql.append(" WHERE devcateno = ?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcateno);
      rs = pstmt.executeQuery();
       
      rs.next();
      devcategoryVO.setDevcateno(rs.getInt("devcateno"));
      devcategoryVO.setTitle(rs.getString("title"));
      devcategoryVO.setSeqno(rs.getInt("seqno"));
      devcategoryVO.setVisible(rs.getString("visible"));
      devcategoryVO.setIds(rs.getString("ids"));
      devcategoryVO.setCnt(rs.getInt("cnt"));
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    return devcategoryVO;
  }
  

  /**
   * 카테고리 목록 
   * @return
   */
  
  public ArrayList<DevcategoryVO> list() {
    ArrayList<DevcategoryVO> devcategorys = new ArrayList<DevcategoryVO>();
    
    try {
      con = dbopen.getConnection();
      pstmt = con.prepareStatement("select * from devcategory ORDER BY seqno asc");
      rs = pstmt.executeQuery();
      
      while(rs.next()) {
        DevcategoryVO devcategoryVO = new DevcategoryVO();
        devcategoryVO.setDevcateno(rs.getInt("devcateno"));
        devcategoryVO.setTitle(rs.getString("title"));
        devcategoryVO.setSeqno(rs.getInt("seqno"));
        devcategoryVO.setVisible(rs.getString("visible"));
        devcategoryVO.setIds(rs.getString("ids"));
        devcategoryVO.setCnt(rs.getInt("cnt"));
        devcategorys.add(devcategoryVO);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    return devcategorys;
  }
  
  /**
   * 회원 카테고리 목록 
   * @return
   */
  
  public ArrayList<DevcategoryVO> c_list() {
    ArrayList<DevcategoryVO> devcategorys = new ArrayList<DevcategoryVO>();
    
    try {
      con = dbopen.getConnection();
      pstmt = con.prepareStatement("select * from devcategory WHERE visible='Y' ORDER BY seqno asc");
      rs = pstmt.executeQuery();
      
      while(rs.next()) {
        DevcategoryVO devcategoryVO = new DevcategoryVO();
        devcategoryVO.setDevcateno(rs.getInt("devcateno"));
        devcategoryVO.setTitle(rs.getString("title"));
        devcategoryVO.setSeqno(rs.getInt("seqno"));
        devcategoryVO.setVisible(rs.getString("visible"));
        devcategoryVO.setIds(rs.getString("ids"));
        devcategoryVO.setCnt(rs.getInt("cnt"));
        devcategorys.add(devcategoryVO);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    return devcategorys;
  }
  
  /**
   * 출력 순서의 최대값
   * @return seqno 최대값  + 1
   */
  public int getMaxSeqno() {
    int maxSeqno = 0;
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT MAX(seqno)+1 as seqno");
      sql.append(" FROM devcategory");

      pstmt = con.prepareStatement(sql.toString());
      rs = pstmt.executeQuery();
       
      if(rs.next()) {
        maxSeqno = rs.getInt("seqno");
      }
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    return maxSeqno;
  }
  
  /**
   * 카테고리 수정
   * @param devcategoryVO
   * @param devcateno
   * @return
   */
  public int update(DevcategoryVO devcategoryVO, int devcateno) {
    int count = 0;
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devcategory SET title=?, seqno=?, visible=?, ids=?");
      sql.append(" WHERE devcateno=?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, devcategoryVO.getTitle());
      pstmt.setInt(2, devcategoryVO.getSeqno());
      pstmt.setString(3, devcategoryVO.getVisible());
      pstmt.setString(4, devcategoryVO.getIds());
      pstmt.setInt(5, devcateno);
      count = pstmt.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    return count;
  }
 
  /**
   * 출력순서의 낮춤
   * @param devcateno
   * @return 수정된 갯수 1 or 0
   */
  public void increaseSeqno(int devcateno) {
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devcategory");
      sql.append(" SET seqno = seqno + 1");
      sql.append(" WHERE devcateno = ?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcateno);
      pstmt.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
  }
  
  /**
   * 출력순서를 높임
   * @param devcateno
   * @return 수정된 갯수 1 or 0
   */
  public void decreaseSeqno(int devcateno) {
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devcategory");
      sql.append(" SET seqno = seqno - 1");
      sql.append(" WHERE devcateno = ? AND seqno > 1");  

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcateno);
      pstmt.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
  }
  
  /**
   * 게시판 출력
   * @param devcateno
   * @return 수정된 갯수 1 or 0
   */
  public int show(int devcateno) {
    int count = 0;
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devcategory");
      sql.append(" SET visible = 'Y'");
      sql.append(" WHERE devcateno = ?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcateno);
      count = pstmt.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    return count;
  }

  /**
   * 게시판 숨기기
   * @param devcateno
   * @return 수정된 갯수 1 or 0
   */
  public int hide(int devcateno) {
    int count = 0;
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devcategory");
      sql.append(" SET visible = 'N'");
      sql.append(" WHERE devcateno = ?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcateno);
      count = pstmt.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    return count;
  }

  
  /**
   * 카테고리 삭제
   * @param devcategoryno
   * @return
   */
  
  public int delete(int devcateno) {
    int count = 0;
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM devcategory WHERE devcateno = ?");
      
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcateno);
      count = pstmt.executeUpdate();
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    return count;
  }
  
  /**
   * 관련 게시판 글수의 증가
   * @param devcategoryno
   * @return
   */
  public int increaseCnt(int devcategoryno) { // call by reference
    int count = 0;                     // 처리된 레코드 갯수
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devcategory");
      sql.append(" SET cnt = cnt + 1");
      sql.append(" WHERE devcateno=?");
      
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcategoryno);
  
      count = pstmt.executeUpdate();
      
    } catch (SQLException e) {  
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
 
  /**
   * 관련 게시판 글수의 감소
   * @param devcategoryno
   * @return
   */
  public int decreaseCnt(int devcategoryno) { // call by reference
    int count = 0;                     // 처리된 레코드 갯수
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devcategory");
      sql.append(" SET cnt = cnt - 1");
      sql.append(" WHERE devcategoryno=?");
      
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcategoryno);
  
      count = pstmt.executeUpdate();
      
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
  
  /**
   * 관련 게시판 글수의 초기화
   * @param devcategoryno
   * @return
   */
  public int clearCnt(int devcategoryno) { // call by reference
    int count = 0;                     // 처리된 레코드 갯수
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devcategory");
      sql.append(" SET cnt = 0");
      sql.append(" WHERE devcategoryno=?");
      
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcategoryno);
  
      count = pstmt.executeUpdate();
      
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
}
