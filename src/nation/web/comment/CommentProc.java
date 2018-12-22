package nation.web.comment;

import java.util.ArrayList;

public class CommentProc {
  CommentDAO commentDAO = null;
  ArrayList<CommentVO> list = null;
  
  public CommentProc() {
    commentDAO = new CommentDAO();
  }
  
  /**
   * 댓글 목록 
   * @return CommentVO list
   */
  public ArrayList<CommentVO> list(int devdiaryno) { 
    list = commentDAO.list(devdiaryno);
    return list;
  } 
   
  /**
   * 댓글 등록
   * @param commentVO
   * @return
   */
  public int insert(CommentVO commentVO) {
    int count = commentDAO.insert(commentVO);
    return count;
  } 
  
  /**
   * 게시글별 댓글 갯수
   * @param devdiaryno
   * @return
   */
  public int count(int devdiaryno) {
    int cnt = commentDAO.count(devdiaryno);
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
  public ArrayList<CommentVO> list_devdiary(
      int devdiaryno, 
      int nowPage,
      int recordPerPage) {
    
    int offset  = (nowPage - 1) * recordPerPage; // skip할 레코드 수
    
    list = commentDAO.list_devdiary(devdiaryno, offset, recordPerPage);
    return list;
  }
  
  /**
   * 댓글 조회
   * 
   * @return CommentVO list
   */
  public CommentVO read(int cno) {
    CommentVO comentVO = commentDAO.read(cno);
    return comentVO;
  }
  
  /**
   * 댓글 수정
   * @param commentVO
   * @return
   */
  public int update(CommentVO commentVO) {
    int count = commentDAO.update(commentVO);
    return count; 
  }
  
  /**
   * 비밀번호 확인
   * @param cno
   * @param passwd
   * @return
   */ 
  public int confirmPassword(int cno, String passwd) {
    int count = commentDAO.confirmPassword(cno, passwd);
    return count;
  }
  
  /**
   * 댓글 삭제
   * @param cno
   * @return
   */
  public int delete(int cno) {
    int count = commentDAO.delete(cno);
    return count;
  }
}
  