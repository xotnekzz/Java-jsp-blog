package nation.web.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class CommentDAO {
  private Connection con = null; // DBMS 연결
  private PreparedStatement pstmt = null; // SQL 실행
  private ResultSet rs = null; // SELECT 결과를 저장
  private StringBuffer sql = null; // SQL 저장

  private DBOpen dbopen = null;
  private DBClose dbclose = null;

  public CommentDAO() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
  }

  /**
   * 댓글 목록
   * 
   * @return CommentVO list
   */
  public ArrayList<CommentVO> list(int devdiaryno) {
    ArrayList<CommentVO> list = new ArrayList<CommentVO>();
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT cno, cdate, content, email, rname, good, devdiaryno, passwd");
      sql.append(" FROM comment");
      sql.append(" WHERE devdiaryno = ?");
      sql.append(" ORDER BY cno ASC");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devdiaryno);
      rs = pstmt.executeQuery();

      while (rs.next()) {
        CommentVO commentVO = new CommentVO();
        commentVO.setCno(rs.getInt("cno"));
        commentVO.setCdate(rs.getString("cdate"));
        commentVO.setContent(rs.getString("content"));
        commentVO.setEmail(rs.getString("email"));
        commentVO.setRname(rs.getString("rname"));
        commentVO.setGood(rs.getInt("good"));
        commentVO.setDevdiaryno(rs.getInt("devdiaryno"));
        commentVO.setPasswd(rs.getString("passwd"));
        list.add(commentVO);
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
   * @return CommentVO list
   */
  public CommentVO read(int cno) {
    CommentVO commentVO = new CommentVO();
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT cno, cdate, content, email, rname, good, devdiaryno, passwd");
      sql.append(" FROM comment");
      sql.append(" WHERE cno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, cno);
      rs = pstmt.executeQuery(); 

      if (rs.next()) {
        commentVO.setCno(rs.getInt("cno"));
        commentVO.setCdate(rs.getString("cdate"));
        commentVO.setContent(rs.getString("content"));
        commentVO.setEmail(rs.getString("email"));
        commentVO.setRname(rs.getString("rname"));
        commentVO.setGood(rs.getInt("good"));
        commentVO.setDevdiaryno(rs.getInt("devdiaryno"));
        commentVO.setPasswd(rs.getString("passwd"));
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return commentVO;
  }

  /**
   * 댓글 등록
   * @param commentVO
   * @return
   */
  public int insert(CommentVO commentVO) {
    int count = 0;

    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" INSERT INTO comment(cdate, content, email, devdiaryno, rname, passwd)");
      sql.append(" VALUES(now(), ?, ?, ?, ?, ?)");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, commentVO.getContent());
      pstmt.setString(2, commentVO.getEmail());
      pstmt.setInt(3, commentVO.getDevdiaryno());
      pstmt.setString(4, commentVO.getRname());
      pstmt.setString(5, commentVO.getPasswd());
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
   * @param commentVO
   * @return
   */
  public int update(CommentVO commentVO) {
    int count = 0;

    try { 
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE comment"); 
      sql.append(" SET cdate = now(), content = ?, email = ?, rname = ? ");
      sql.append(" WHERE cno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, commentVO.getContent());
      pstmt.setString(2, commentVO.getEmail());
      pstmt.setString(3, commentVO.getRname());
      pstmt.setInt(4, commentVO.getCno());
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
   * @param cno
   * @param passwd
   * @return
   */
  public int confirmPassword(int cno, String passwd) {
    int count = 0;
    
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT passwd");
      sql.append(" FROM comment");
      sql.append(" WHERE cno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, cno);
      rs = pstmt.executeQuery(); 
      
      if(rs.next()){
        String db_passwd = rs.getString("passwd");
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
   * @param devdiaryno
   * @return
   */
  public int count(int devdiaryno) {
    int cnt = 0;
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT count(*) as cnt");
      sql.append(" FROM comment");
      sql.append(" WHERE devdiaryno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devdiaryno);
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
   * @param col
   *          검색 컬럼
   * @param word
   *          검색어
   * @param offset
   *          skip할 레코드 갯수
   * @param recordPerPage
   *          페이지당 출력할 레코드 갯수
   * @return 검색 목록
   */
  public ArrayList<CommentVO> list_devdiary(int devdiaryno,  int offset, int recordPerPage) {
    ArrayList<CommentVO> list = new ArrayList<CommentVO>();

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT cno, cdate, content, email, rname, good, devdiaryno, passwd");
      sql.append(" FROM comment");
      sql.append(" WHERE devdiaryno = ?");
      sql.append(" ORDER BY cno ASC");
      sql.append(" LIMIT ?, ?"); 
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, devdiaryno);
      pstmt.setInt(2, offset);
      pstmt.setInt(3, recordPerPage);

      rs = pstmt.executeQuery(); // SELECT

      while (rs.next()) {
        CommentVO commentVO = new CommentVO();
        commentVO.setCno(rs.getInt("cno"));
        commentVO.setCdate(rs.getString("cdate"));
        commentVO.setContent(rs.getString("content"));
        commentVO.setEmail(rs.getString("email"));
        commentVO.setRname(rs.getString("rname"));
        commentVO.setGood(rs.getInt("good"));
        commentVO.setDevdiaryno(rs.getInt("devdiaryno"));
        commentVO.setPasswd(rs.getString("passwd"));
        list.add(commentVO);
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
   * @param cno
   * @return
   */
  public int delete(int cno) {
    int count =0;
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM comment");
      sql.append(" WHERE cno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, cno);
      count = pstmt.executeUpdate();
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt);
    }
    return count;
  }
  
  

}
