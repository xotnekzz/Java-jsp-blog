package nation.web.comment_reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class Comment_ReplyDAO {
  private Connection con = null; // DBMS 연결
  private PreparedStatement pstmt = null; // SQL 실행
  private ResultSet rs = null; // SELECT 결과를 저장
  private StringBuffer sql = null; // SQL 저장

  private DBOpen dbopen = null;
  private DBClose dbclose = null;

  public Comment_ReplyDAO() { 
    dbopen = new DBOpen();
    dbclose = new DBClose();
  }
 
  /**
   * 댓글 목록
   * 
   * @return comment_replyVO list
   */
  public ArrayList<Comment_replyVO> list(int cno) {
    ArrayList<Comment_replyVO> list = new ArrayList<Comment_replyVO>();
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT crno, cdate, content, email, rname, cno, passwd");
      sql.append(" FROM comment_reply");
      sql.append(" WHERE cno = ?");
      sql.append(" ORDER BY crno ASC");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, cno);
      rs = pstmt.executeQuery(); 
 
      while (rs.next()) {
        Comment_replyVO comment_replyVO = new Comment_replyVO();
        comment_replyVO.setCrno(rs.getInt("crno")); 
        comment_replyVO.setCdate(rs.getString("cdate"));
        comment_replyVO.setContent(rs.getString("content"));
        comment_replyVO.setEmail(rs.getString("email"));
        comment_replyVO.setRname(rs.getString("rname"));
        comment_replyVO.setCno(rs.getInt("cno"));
        comment_replyVO.setPasswd(rs.getString("passwd"));
        list.add(comment_replyVO);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return list;
  }
  
  /**
   * 댓글 조회
   * 
   * @return comment_replyVO list
   */
  public Comment_replyVO read(int crno) {
    Comment_replyVO comment_replyVO = new Comment_replyVO();
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT crno, cdate, content, email, rname, cno, passwd");
      sql.append(" FROM comment_reply");
      sql.append(" WHERE crno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, crno);
      rs = pstmt.executeQuery(); 

      if (rs.next()) {
        comment_replyVO.setCrno(rs.getInt("crno"));
        comment_replyVO.setCdate(rs.getString("cdate"));
        comment_replyVO.setContent(rs.getString("content"));
        comment_replyVO.setEmail(rs.getString("email"));
        comment_replyVO.setRname(rs.getString("rname"));
        comment_replyVO.setCno(rs.getInt("cno"));
        comment_replyVO.setPasswd(rs.getString("passwd"));
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return comment_replyVO;
  }

  /**
   * 댓글 등록
   * @param comment_replyVO
   * @return
   */
  public int insert(Comment_replyVO comment_replyVO) {
    int count = 0;

    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" INSERT INTO comment_reply(cdate, content, email, cno, rname, passwd)");
      sql.append(" VALUES(now(), ?, ?, ?, ?, ?)");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, comment_replyVO.getContent());
      pstmt.setString(2, comment_replyVO.getEmail());
      pstmt.setInt(3, comment_replyVO.getCno());
      pstmt.setString(4, comment_replyVO.getRname());
      pstmt.setString(5, comment_replyVO.getPasswd());
      count = pstmt.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }

    return count;
  }
  
  /**
   * 댓글 수정
   * @param comment_replyVO
   * @return
   */
  public int update(Comment_replyVO comment_replyVO) {
    int count = 0;

    try { 
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE comment_reply"); 
      sql.append(" SET cdate = now(), content = ?, email = ?, rname = ? ");
      sql.append(" WHERE crno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, comment_replyVO.getContent());
      pstmt.setString(2, comment_replyVO.getEmail());
      pstmt.setString(3, comment_replyVO.getRname());
      pstmt.setInt(4, comment_replyVO.getCrno());
      count = pstmt.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace(); 
    } finally {
      new DBClose().close(con, pstmt);
    }

    return count;
  }
  
  /**
   * 비밀번호 확인
   * @param crno
   * @param passwd
   * @return
   */
  public int confirmPassword(int crno, String passwd) {
    int count = 0;
    System.out.println("passwd : " + passwd);  
     
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT passwd"); 
      sql.append(" FROM comment_reply");
      sql.append(" WHERE crno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, crno);
      rs = pstmt.executeQuery(); 
      
      if(rs.next()){
        String db_passwd = rs.getString("passwd");
        System.out.println("db_passwd : " + db_passwd);
        if( passwd.equals(db_passwd) ) {
          count = 1;
        }
      }
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return count;
  }

  /**
   * 게시글별 댓글 갯수
   * 
   * @param cno
   * @return
   */
  public int count(int cno) {
    int cnt = 0;
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT count(*) as cnt");
      sql.append(" FROM comment_reply");
      sql.append(" WHERE cno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, cno);
      rs = pstmt.executeQuery();

      if (rs.next()) {
        cnt = rs.getInt("cnt");
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return cnt;
  }

  /**
   * 카테고리별로 검색 및 페이징이 구현된 목록, SELECT된 목록중에 페이징 기법을 이용하여 특정 레코드 부분(10개)만 가져옵니다.
   * 
   * @param categoryno
   *          카테고리 번호
   * @param offset
   *          skip할 레코드 갯수
   * @param recordPerPage
   *          페이지당 출력할 레코드 갯수
   * @return 검색 목록
   */
  public ArrayList<Comment_replyVO> list_devdiary(int cno,  int offset, int recordPerPage) {
    ArrayList<Comment_replyVO> list = new ArrayList<Comment_replyVO>();

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT crno, cdate, content, email, rname, cno, passwd");
      sql.append(" FROM comment_reply");
      sql.append(" WHERE cno = ?");
      sql.append(" ORDER BY crno ASC");
      sql.append(" LIMIT ?, ?"); 
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, cno);
      pstmt.setInt(2, offset);
      pstmt.setInt(3, recordPerPage);

      rs = pstmt.executeQuery(); // SELECT

      while (rs.next()) {
        Comment_replyVO comment_replyVO = new Comment_replyVO();
        comment_replyVO.setCrno(rs.getInt("crno"));
        comment_replyVO.setCdate(rs.getString("cdate"));
        comment_replyVO.setContent(rs.getString("content"));
        comment_replyVO.setEmail(rs.getString("email"));
        comment_replyVO.setRname(rs.getString("rname"));
        comment_replyVO.setCno(rs.getInt("cno"));
        comment_replyVO.setPasswd(rs.getString("passwd"));
        list.add(comment_replyVO);
      }

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

    return list;
  }
  
  /**
   * 댓글 삭제
   * @param crno
   * @return
   */
  public int delete(int crno) {
    int count =0;
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM comment_reply");
      sql.append(" WHERE crno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, crno);
      count = pstmt.executeUpdate();
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return count;
  }

}
