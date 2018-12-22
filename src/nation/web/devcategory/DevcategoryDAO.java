package nation.web.devcategory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class DevcategoryDAO {
  private Connection con = null;              // DBMS ����   
  private PreparedStatement pstmt = null; // SQL ����
  private ResultSet rs = null;                   // SELECT ����� ����
  private StringBuffer sql = null;              // SQL ����
  
  private DBOpen dbopen = null;
  private DBClose dbclose = null;
  
  public DevcategoryDAO() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
  }
  
  /**
   * ī�װ� ��� 
   * @param devcategoryVO
   * @return ��ϵ� ���� 1 or 0
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
   * ī�װ� �׸� ����
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
   * ī�װ� ��� 
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
   * ȸ�� ī�װ� ��� 
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
   * ��� ������ �ִ밪
   * @return seqno �ִ밪  + 1
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
   * ī�װ� ����
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
   * ��¼����� ����
   * @param devcateno
   * @return ������ ���� 1 or 0
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
   * ��¼����� ����
   * @param devcateno
   * @return ������ ���� 1 or 0
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
   * �Խ��� ���
   * @param devcateno
   * @return ������ ���� 1 or 0
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
   * �Խ��� �����
   * @param devcateno
   * @return ������ ���� 1 or 0
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
   * ī�װ� ����
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
   * ���� �Խ��� �ۼ��� ����
   * @param devcategoryno
   * @return
   */
  public int increaseCnt(int devcategoryno) { // call by reference
    int count = 0;                     // ó���� ���ڵ� ����
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
   * ���� �Խ��� �ۼ��� ����
   * @param devcategoryno
   * @return
   */
  public int decreaseCnt(int devcategoryno) { // call by reference
    int count = 0;                     // ó���� ���ڵ� ����
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
   * ���� �Խ��� �ۼ��� �ʱ�ȭ
   * @param devcategoryno
   * @return
   */
  public int clearCnt(int devcategoryno) { // call by reference
    int count = 0;                     // ó���� ���ڵ� ����
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
