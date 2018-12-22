package nation.web.devdiary;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class DevdiaryDAO {
  private Connection con = null;              // DBMS ����   
  private PreparedStatement pstmt = null; // SQL ����
  private ResultSet rs = null;                   // SELECT ����� ����
  private StringBuffer sql = null;              // SQL ����
  
  private DBOpen dbopen = null;
  private DBClose dbclose = null; 
  private ArrayList<DevdiaryVO> list =null;
  
  public DevdiaryDAO() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
    list = new ArrayList<DevdiaryVO>();
  }
  
  /**
   * ����Ʈ ��ȸ
   * @param devcateno
   * @return
   */ 
  public ArrayList<DevdiaryVO> list(int devcateno) {
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT devdiaryno, title_main, title_sub, content, SUBSTRING(rdate, 1, 10) as rdate, rname, email,");
      sql.append(" file, fstor1, thumb, size1, cnt, visible"); 
      sql.append(" FROM devdiary");
      sql.append(" WHERE devcateno = ?");
      sql.append(" ORDER BY devdiaryno DESC");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devcateno);
      rs = pstmt.executeQuery();
      
      while(rs.next()) {
        DevdiaryVO devdiaryVO = new DevdiaryVO();
        devdiaryVO.setDevdiaryno(rs.getInt("devdiaryno"));
        devdiaryVO.setTitle_main(rs.getString("title_main"));
        devdiaryVO.setTitle_sub(rs.getString("title_sub"));
        devdiaryVO.setContent(rs.getString("content"));
        devdiaryVO.setRdate(rs.getString("rdate"));
        devdiaryVO.setRname(rs.getString("rname"));
        devdiaryVO.setEmail(rs.getString("email"));
        devdiaryVO.setFile(rs.getString("file"));
        devdiaryVO.setFstor1(rs.getString("fstor1"));
        devdiaryVO.setThumb(rs.getString("thumb"));   
        devdiaryVO.setSize1(rs.getLong("size1")); 
        devdiaryVO.setCnt(rs.getInt("cnt")); 
        devdiaryVO.setVisible(rs.getString("visible"));
        list.add(devdiaryVO);
      } 
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return list;
  }
  
 /**
  * �Խñ� ���
  * @param devdiaryVO
  * @return
  */
  public int insert(DevdiaryVO devdiaryVO) {
    int count = 0;
    
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" INSERT INTO devdiary(title_main, title_sub, rname, content, rdate, email, passwd, devcateno, visible, file, fstor1, thumb, size1)");
      sql.append(" VALUES(?, ?, ?, ?, now() , ?, ? , ? , ?, ?, ?, ?, ?)"); 
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, devdiaryVO.getTitle_main());
      pstmt.setString(2, devdiaryVO.getTitle_sub());
      pstmt.setString(3, devdiaryVO.getRname());
      pstmt.setString(4, devdiaryVO.getContent());
      pstmt.setString(5, devdiaryVO.getEmail());
      pstmt.setString(6, devdiaryVO.getPasswd());
      pstmt.setInt(7, devdiaryVO.getDevcateno());
      pstmt.setString(8, devdiaryVO.getVisible());
      pstmt.setString(9, devdiaryVO.getFile()); 
      pstmt.setString(10, devdiaryVO.getFstor1());
      pstmt.setString(11, devdiaryVO.getThumb());
      pstmt.setLong(12, devdiaryVO.getSize1());
      count = pstmt.executeUpdate();
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return count;
  }
  
  /**
   * �Խñ� 1�� ��ȸ
   * @param devdiaryno
   * @return
   */
  public DevdiaryVO read(int devdiaryno) {
    DevdiaryVO devdiaryVO = new DevdiaryVO();
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT devdiaryno, title_main, title_sub, content, SUBSTRING(rdate, 1, 10) as rdate, rname, email,");
      sql.append(" file, fstor1, thumb, size1, cnt, visible"); 
      sql.append(" FROM devdiary"); 
      sql.append(" WHERE devdiaryno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devdiaryno);
      rs = pstmt.executeQuery();
      if(rs.next()) { 
        devdiaryVO.setDevdiaryno(rs.getInt("devdiaryno"));
        devdiaryVO.setTitle_main(rs.getString("title_main"));
        devdiaryVO.setTitle_sub(rs.getString("title_sub"));
        devdiaryVO.setContent(rs.getString("content"));
        devdiaryVO.setRdate(rs.getString("rdate"));
        devdiaryVO.setRname(rs.getString("rname"));
        devdiaryVO.setEmail(rs.getString("email"));
        devdiaryVO.setFile(rs.getString("file"));
        devdiaryVO.setFstor1(rs.getString("fstor1"));
        devdiaryVO.setThumb(rs.getString("thumb"));   
        devdiaryVO.setSize1(rs.getLong("size1")); 
        devdiaryVO.setCnt(rs.getInt("cnt")); 
        devdiaryVO.setVisible(rs.getString("visible"));
      } 
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return devdiaryVO;
  }
 
  /** 
   * ��ȸ�� ����
   * @param devdiaryno
   * @return
   */
  public int increaseCnt(int devdiaryno) {
    int count = 0;
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devdiary");
      sql.append(" SET cnt = cnt + 1"); 
      sql.append(" WHERE devdiaryno = ?"); 
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devdiaryno);
      count = pstmt.executeUpdate();
       
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return count;
  }
  
  /**
   * �н����带 �˻��մϴ�.
   * @param pdsno
   * @param passwd
   * @return ���ڵ� ����, 1 or 0
   */
  public int passwordCheck(int devdiaryno, String passwd){
    int count = 0;
    try {
      con = dbopen.getConnection();
 
      sql = new StringBuffer();

      sql.append(" SELECT count(*) as cnt");
      sql.append(" FROM devdiary");
      sql.append(" WHERE devdiaryno = ? AND passwd= ?");
   
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devdiaryno);
      pstmt.setString(2, passwd);
      rs = pstmt.executeQuery(); // SELECT
 
      if(rs.next()){
        count = rs.getInt("cnt");
      }
 
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
 
    return count;
  }
  
  /**
   * �Խñ� ����
   * @param pdsno
   * @param passwd
   * @return ���ڵ� ����, 1 or 0
   */
  public int delete(int devdiaryno){
    int count = 0;
    try {
      con = dbopen.getConnection();
 
      sql = new StringBuffer();

      sql.append(" DELETE FROM devdiary");
      sql.append(" WHERE devdiaryno = ?");
 
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devdiaryno);
      count = pstmt.executeUpdate();
 
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
  
    return count;
  }
  
/**
 * �Խñ� ����
 * @param devdiaryVO
 * @return
 */
  public int update(DevdiaryVO devdiaryVO) {
    int count = 0;
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE devdiary");
      sql.append(" SET title_main = ? , title_sub = ?, content = ?"); 
      sql.append(" WHERE devdiaryno = ?"); 
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, devdiaryVO.getTitle_main());
      pstmt.setString(2, devdiaryVO.getTitle_sub());
      pstmt.setString(3, devdiaryVO.getContent()); 
      pstmt.setInt(4, devdiaryVO.getDevdiaryno());
      count = pstmt.executeUpdate(); 
       
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return count;
  }
  
  /**
   * ���� ����
   * @param devdiaryVO
   * @return
   */
    public int create_file1(DevdiaryVO devdiaryVO) {
      int count = 0;
      try {
        con = new DBOpen().getConnection();
        sql = new StringBuffer();
        sql.append(" UPDATE devdiary");
        sql.append(" SET file = ?, fstor1 = ?, thumb = ?, size1 = ?"); 
        sql.append(" WHERE devdiaryno = ?"); 
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setString(1, devdiaryVO.getFile());
        pstmt.setString(2, devdiaryVO.getFstor1()); 
        pstmt.setString(3, devdiaryVO.getThumb());
        pstmt.setLong(4, devdiaryVO.getSize1());
        pstmt.setInt(5, devdiaryVO.getDevdiaryno()); 
        count = pstmt.executeUpdate();
        System.out.println("DevdiaryDAO -> create_file() ȣ��");
      } catch (Exception e) {
        e.printStackTrace();
      } finally {
        new DBClose().close(con, pstmt);
      }
      return count;
    }
    
    /**
     * ī�װ����� �˻� �� ����¡�� ������ ���, SELECT�� ����߿�
     * ����¡ ����� �̿��Ͽ� Ư�� ���ڵ� �κ�(10��)�� �����ɴϴ�. 
     * @param categoryno ī�װ� ��ȣ
     * @param col �˻� �÷�
     * @param word �˻���
     * @param offset skip�� ���ڵ� ����
     * @param recordPerPage �������� ����� ���ڵ� ����
     * @return �˻� ���
     */
    public ArrayList<DevdiaryVO> list_category(
        int devcateno, 
        String col, 
        String word,  
        int offset,
        int recordPerPage) {
      ArrayList<DevdiaryVO> list = new ArrayList<DevdiaryVO>();

      try {
        con = dbopen.getConnection();
    
        sql = new StringBuffer();
        sql.append(" SELECT devdiaryno, title_main, title_sub, content, SUBSTRING(rdate, 1, 10) as rdate, rname, email,");
        sql.append(" file, fstor1, thumb, size1, cnt, visible"); 
        sql.append(" FROM devdiary");
        
        if (col.equals("rname")) {
          sql.append(" WHERE devcateno = ? AND rname LIKE ?");
          sql.append(" ORDER BY devdiaryno DESC");
          // sql.append(" LIMIT " + offset + ", " + record_per_page);
          sql.append(" LIMIT ?, ?");
          pstmt = con.prepareStatement(sql.toString());
          pstmt.setInt(1, devcateno);
          pstmt.setString(2, "%" + word + "%");
          pstmt.setInt(3, offset);
          pstmt.setInt(4, recordPerPage);
        } else if (col.equals("title")) {
          sql.append(" WHERE devcateno = ? AND  title_main LIKE ?");
          sql.append(" ORDER BY devdiaryno DESC");
          sql.append(" LIMIT ?, ?");
          pstmt = con.prepareStatement(sql.toString());
          pstmt.setInt(1, devcateno);
          pstmt.setString(2, "%" + word + "%");
          pstmt.setInt(3, offset);
          pstmt.setInt(4, recordPerPage);
        } else if (col.equals("content")) {
          sql.append(" WHERE devcateno = ? AND  content LIKE ?");
          sql.append(" ORDER BY devdiaryno DESC");
          sql.append(" LIMIT ?, ?");
          pstmt = con.prepareStatement(sql.toString());
          pstmt.setInt(1, devcateno);
          pstmt.setString(2, "%" + word + "%");
          pstmt.setInt(3, offset);
          pstmt.setInt(4, recordPerPage);
        } else if (col.equals("title_content")) {
          sql.append(" WHERE devcateno = ? AND (title_main LIKE ? OR content LIKE ?)");
          sql.append(" ORDER BY gdevdiaryno DESC");
          sql.append(" LIMIT ?, ?");
          pstmt = con.prepareStatement(sql.toString());
          pstmt.setInt(1, devcateno);
          pstmt.setString(2, "%" + word + "%");
          pstmt.setString(3, "%" + word + "%");
          pstmt.setInt(4, offset); 
          pstmt.setInt(5, recordPerPage);
        } else { // �˻����� �ʴ� ���
          sql.append(" WHERE devcateno = ?");
          sql.append(" ORDER BY devdiaryno DESC");
          sql.append(" LIMIT ?, ?");
          pstmt = con.prepareStatement(sql.toString());
          pstmt.setInt(1, devcateno); 
          pstmt.setInt(2, offset);
          pstmt.setInt(3, recordPerPage);
        }
    
        rs = pstmt.executeQuery(); // SELECT
    
        while (rs.next() == true) {
          DevdiaryVO devdiaryVO = new DevdiaryVO();
          devdiaryVO.setDevdiaryno(rs.getInt("devdiaryno"));
          devdiaryVO.setTitle_main(rs.getString("title_main"));
          devdiaryVO.setTitle_sub(rs.getString("title_sub"));
          devdiaryVO.setContent(rs.getString("content"));
          devdiaryVO.setRdate(rs.getString("rdate"));
          devdiaryVO.setRname(rs.getString("rname"));
          devdiaryVO.setEmail(rs.getString("email"));
          devdiaryVO.setFile(rs.getString("file"));
          devdiaryVO.setFstor1(rs.getString("fstor1"));
          devdiaryVO.setThumb(rs.getString("thumb"));   
          devdiaryVO.setSize1(rs.getLong("size1")); 
          devdiaryVO.setCnt(rs.getInt("cnt")); 
          devdiaryVO.setVisible(rs.getString("visible"));
          list.add(devdiaryVO);
        }
    
      } catch (Exception e) {
        e.printStackTrace();
      } finally {
        dbclose.close(con, pstmt, rs);
      }
    
      return list;
    }
    
    /**
     * ī�װ����� �˻��� ���ڵ� ����
     * 
     * @return 
     */
    public int count(int devcateno, String col, String word) {
      int count = 0;
    
      try {
        con = dbopen.getConnection();
    
        sql = new StringBuffer();
        sql.append(" SELECT COUNT(*) as cnt ");
        sql.append(" FROM devdiary");
        
        if (col.equals("rname")) {
          sql.append(" WHERE devcateno = ? AND rname LIKE ?");
          sql.append(" ORDER BY devdiaryno DESC");
          pstmt = con.prepareStatement(sql.toString());
          pstmt.setInt(1, devcateno);
          pstmt.setString(2, "%" + word + "%");
        } else if (col.equals("title")) {
          sql.append(" WHERE devcateno = ? AND  title_main LIKE ?");
          sql.append(" ORDER BY devdiaryno DESC");
          pstmt = con.prepareStatement(sql.toString());
          pstmt.setInt(1, devcateno);
          pstmt.setString(2, "%" + word + "%");
        } else if (col.equals("content")) {
          sql.append(" WHERE devcateno = ? AND  content LIKE ?");
          sql.append(" ORDER BY devdiaryno DESC");
          pstmt = con.prepareStatement(sql.toString());
          pstmt.setInt(1, devcateno);
          pstmt.setString(2, "%" + word + "%");
        } else if (col.equals("title_content")) {
          sql.append(" WHERE devcateno = ? AND (title_main LIKE ? OR content LIKE ?)");
          sql.append(" ORDER BY devdiaryno DESC");
          pstmt = con.prepareStatement(sql.toString());
          pstmt.setInt(1, devcateno);
          pstmt.setString(2, "%" + word + "%");
          pstmt.setString(3, "%" + word + "%");
        } else { // �˻����� �ʴ� ���
          sql.append(" WHERE devcateno = ?"); 
          sql.append(" ORDER BY devdiaryno DESC");
          pstmt = con.prepareStatement(sql.toString());  
          pstmt.setInt(1, devcateno);
        }
    
        rs = pstmt.executeQuery(); // SELECT
    
        if (rs.next() == true) {
          count = rs.getInt("cnt");
        }
    
      } catch (Exception e) {
        e.printStackTrace();
      } finally {
        dbclose.close(con, pstmt, rs);
      }
    
      return count;
    }
     
    /**
     * �ֱ� �Խñ� 5�� ��ȸ
     * @param devdiaryno
     * @return
     */
    public ArrayList<DevdiaryVO> recent_read() {
      try {
        con = new DBOpen().getConnection();
        sql = new StringBuffer();
        sql.append(" SELECT devdiaryno, title_main, substr(rdate, 3, 8) AS rdate, devcateno,");
        sql.append(" (SELECT count(*)+1 FROM devdiary WHERE devdiaryno > t.devdiaryno ) AS rank"); 
        sql.append(" FROM devdiary AS t"); 
        sql.append(" ORDER BY rank limit 0, 5");  
        pstmt = con.prepareStatement(sql.toString()); 
        rs = pstmt.executeQuery();
        while(rs.next()) {
          DevdiaryVO devdiaryVO = new DevdiaryVO();
          devdiaryVO.setDevdiaryno(rs.getInt("devdiaryno"));
          devdiaryVO.setTitle_main(rs.getString("title_main"));
          devdiaryVO.setRdate(rs.getString("rdate"));
          devdiaryVO.setDevcateno(rs.getInt("devcateno"));
          list.add(devdiaryVO);
        }  
      } catch (Exception e) {
        e.printStackTrace(); 
      } finally {
        new DBClose().close(con, pstmt);
      }
      return list;
    }
    
    /**
     * �α� �Խñ� 5�� ��ȸ
     * @param devdiaryno
     * @return
     */
    public ArrayList<DevdiaryVO> pop_read() {
      try {
        con = new DBOpen().getConnection();
        sql = new StringBuffer();
        sql.append(" SELECT devdiaryno, title_main, cnt, devcateno,");
        sql.append(" (SELECT count(*)+1 FROM devdiary WHERE cnt > t.cnt ) AS rank"); 
        sql.append(" FROM devdiary AS t");  
        sql.append(" ORDER BY rank limit 0, 5");
        pstmt = con.prepareStatement(sql.toString());
        rs = pstmt.executeQuery();
        while(rs.next()) {
          DevdiaryVO devdiaryVO = new DevdiaryVO();
          devdiaryVO.setDevdiaryno(rs.getInt("devdiaryno"));
          devdiaryVO.setTitle_main(rs.getString("title_main"));
          devdiaryVO.setCnt(rs.getInt("cnt"));
          devdiaryVO.setDevcateno(rs.getInt("devcateno"));
          list.add(devdiaryVO);
        }  
      } catch (Exception e) {
        e.printStackTrace(); 
      } finally {
        new DBClose().close(con, pstmt);
      }
      return list;
    }
}
