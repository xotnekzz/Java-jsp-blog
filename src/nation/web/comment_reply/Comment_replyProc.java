package nation.web.comment_reply;

import java.util.ArrayList;

public class Comment_replyProc {
  Comment_ReplyDAO comment_replyDAO = null;
  ArrayList<Comment_replyVO> list = null;
  
  public Comment_replyProc() {
    comment_replyDAO = new Comment_ReplyDAO();
  }
  
  /**
   * ��� ��� 
   * @return comment_replyVO list
   */
  public ArrayList<Comment_replyVO> list(int cno) { 
    list = comment_replyDAO.list(cno);
    return list;
  } 
   
  /**
   * ��� ���
   * @param comment_replyVO
   * @return
   */
  public int insert(Comment_replyVO comment_replyVO) {
    int count = comment_replyDAO.insert(comment_replyVO);
    return count;
  } 
  
  /**
   * �Խñۺ� ��� ����
   * @param cno
   * @return
   */
  public int count(int cno) {
    int cnt = comment_replyDAO.count(cno);
    return cnt;
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
  public ArrayList<Comment_replyVO> list_devdiary(
      int cno, 
      int nowPage,
      int recordPerPage) {
    
    int offset  = (nowPage - 1) * recordPerPage; // skip�� ���ڵ� ��
    
    list = comment_replyDAO.list_devdiary(cno, offset, recordPerPage);
    return list;
  }
  
  /**
   * ��� ��ȸ
   * 
   * @return comment_replyVO list
   */
  public Comment_replyVO read(int crno) {
    Comment_replyVO comentVO = comment_replyDAO.read(crno);
    return comentVO;
  }
  
  /**
   * ��� ����
   * @param comment_replyVO
   * @return
   */
  public int update(Comment_replyVO comment_replyVO) {
    int count = comment_replyDAO.update(comment_replyVO);
    return count; 
  }
  
  /**
   * ��й�ȣ Ȯ��
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
   * ��� ����
   * @param crno
   * @return
   */
  public int delete(int crno) {
    int count = comment_replyDAO.delete(crno);
    return count;
  }
}
  