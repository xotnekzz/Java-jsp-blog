package nation.web.comment_reply;

import java.util.ArrayList;

public class Comment_replyProc {
  Comment_ReplyDAO comment_replyDAO = null;
  ArrayList<Comment_replyVO> list = null;
  
  public Comment_replyProc() {
    comment_replyDAO = new Comment_ReplyDAO();
  }
  
  /**
   * 댓글 목록 
   * @return comment_replyVO list
   */
  public ArrayList<Comment_replyVO> list(int cno) { 
    list = comment_replyDAO.list(cno);
    return list;
  } 
   
  /**
   * 댓글 등록
   * @param comment_replyVO
   * @return
   */
  public int insert(Comment_replyVO comment_replyVO) {
    int count = comment_replyDAO.insert(comment_replyVO);
    return count;
  } 
  
  /**
   * 게시글별 댓글 갯수
   * @param cno
   * @return
   */
  public int count(int cno) {
    int cnt = comment_replyDAO.count(cno);
    return cnt;
  }
  
  /**
   * 카테고리별로 검색 및 페이징이 구현된 목록, SELECT된 목록중에
   * 페이징 기법을 이용하여 특정 레코드 부분(10개)만 가져옵니다. 
   * @param categoryno 카테고리 번호
   * @param col 검색 컬럼
   * @param word 검색어
   * @param offset skip할 레코드 갯수
   * @param recordPerPage 페이지당 출력할 레코드 갯수
   * @return 검색 목록
   */
  public ArrayList<Comment_replyVO> list_devdiary(
      int cno, 
      int nowPage,
      int recordPerPage) {
    
    int offset  = (nowPage - 1) * recordPerPage; // skip할 레코드 수
    
    list = comment_replyDAO.list_devdiary(cno, offset, recordPerPage);
    return list;
  }
  
  /**
   * 댓글 조회
   * 
   * @return comment_replyVO list
   */
  public Comment_replyVO read(int crno) {
    Comment_replyVO comentVO = comment_replyDAO.read(crno);
    return comentVO;
  }
  
  /**
   * 댓글 수정
   * @param comment_replyVO
   * @return
   */
  public int update(Comment_replyVO comment_replyVO) {
    int count = comment_replyDAO.update(comment_replyVO);
    return count; 
  }
  
  /**
   * 비밀번호 확인
   * @param crno
   * @param passwd
   * @return
   */ 
  public int confirmPassword(int crno, String passwd) {
    System.out.println("crno : " + crno + " / passwd : " + passwd);
    int count = comment_replyDAO.confirmPassword(crno, passwd);
    return count;
  }
  
  /**
   * 댓글 삭제
   * @param crno
   * @return
   */
  public int delete(int crno) {
    int count = comment_replyDAO.delete(crno);
    return count;
  }
}
  