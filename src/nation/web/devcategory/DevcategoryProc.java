package nation.web.devcategory;

import java.util.ArrayList;

public class DevcategoryProc {
  
  DevcategoryDAO devcategoryDAO;
  ArrayList<DevcategoryVO> list;
  
  public DevcategoryProc() {
    devcategoryDAO = new DevcategoryDAO();
    list = new ArrayList<DevcategoryVO>();
  } 
  
  /**
   * 카테고리 항목 선택
   * @param devcategoryVO
   * @param devcategoryno
   */
  
  public DevcategoryVO selectOne(DevcategoryVO devcategoryVO ,int devcateno) {
    devcategoryVO = devcategoryDAO.selectOne(devcategoryVO, devcateno);
    return devcategoryVO;
  }
  
  /**
   * 카테고리 등록 
   * @param devcategoryVO
   * @return 등록된 개수 1 or 0
   */
  public int create(DevcategoryVO devcategoryVO) {
    int count = devcategoryDAO.create(devcategoryVO);
    return count;
  }
  
  /**
   * 회원 카테고리 목록 
   * @return
   */
  public ArrayList<DevcategoryVO> c_list() {
    list = devcategoryDAO.c_list();
    return list;
  }
  
  /**
   * 카테고리 목록 
   * @return
   */
  public ArrayList<DevcategoryVO> list() {
    list = devcategoryDAO.list();
    return list;
  }
  
  /**
   * 출력 순서의 최대값
   * @return seqno 최대값  + 1
   */
  public int getMaxSeqno() {
    int maxSeqno = devcategoryDAO.getMaxSeqno();
    return maxSeqno;
  }
  
  /**
   * 출력순서의 낮춤
   * @param devcateno
   * @return 수정된 갯수 1 or 0
   */
  public void increaseSeqno(int devcateno) {
    devcategoryDAO.increaseSeqno(devcateno); 
  }
   
  /**
   * 출력순서를 높임
   * @param devcateno
   * @return 수정된 갯수 1 or 0
   */
  public void decreaseSeqno(int devcateno) {
    devcategoryDAO.decreaseSeqno(devcateno);
  }
  
  /**
   * 게시판 출력
   * @param devcateno
   * @return 수정된 갯수 1 or 0
   */
  public int show(int devcateno) {
   int count = devcategoryDAO.show(devcateno);
   return count;
  }

  /**
   * 게시판 숨기기
   * @param devcateno
   * @return 수정된 갯수 1 or 0
   */
  public int hide(int devcateno) {
    int count = devcategoryDAO.hide(devcateno);
    return count;
  }

  /**
   * 카테고리 수정
   * @param devcategoryVO
   * @param devcateno
   * @return
   */
  public int update(DevcategoryVO devcategoryVO, int devcateno) {
    int count = devcategoryDAO.update(devcategoryVO, devcateno);
    return count;
  }
   
  /**
   * 카테고리 삭제
   * @param devcategoryno
   * @return
   */
  
  public int delete(int devcateno) {
    int count = devcategoryDAO.delete(devcateno);
    return count;
  }

  /**
   * 관련 게시판 글수의 증가
   * @param devcategoryno
   * @return
   */
  public int increaseCnt(int devcategoryno) { // call by reference
    int count = devcategoryDAO.increaseCnt(devcategoryno);                     // 처리된 레코드 갯수
    return count;
  }
  
  /**
   * 관련 게시판 글수의 감소
   * @param devcategoryno
   * @return
   */
  public int decreaseCnt(int devcategoryno) { // call by reference
    int count = devcategoryDAO.decreaseCnt(devcategoryno);
    return count;
  }
  
}
