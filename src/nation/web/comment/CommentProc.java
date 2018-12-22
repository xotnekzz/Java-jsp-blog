package nation.web.comment;

import java.util.ArrayList;

public class CommentProc {
  CommentDAO commentDAO = null;
  ArrayList<CommentVO> list = null;
  
  public CommentProc() {
    commentDAO = new CommentDAO();
  }
  
  /**
   * ��� ��� 
   * @return CommentVO list
   */
  public ArrayList<CommentVO> list(int devdiaryno) { 
    list = commentDAO.list(devdiaryno);
    return list;
  } 
   
  /**
   * ��� ���
   * @param commentVO
   * @return
   */
  public int insert(CommentVO commentVO) {
    int count = commentDAO.insert(commentVO);
    return count;
  } 
  
  /**
   * �Խñۺ� ��� ����
   * @param devdiaryno
   * @return
   */
  public int count(int devdiaryno) {
    int cnt = commentDAO.count(devdiaryno);
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
  public ArrayList<CommentVO> list_devdiary(
      int devdiaryno, 
      int nowPage,
      int recordPerPage) {
    
    int offset  = (nowPage - 1) * recordPerPage; // skip�� ���ڵ� ��
    
    list = commentDAO.list_devdiary(devdiaryno, offset, recordPerPage);
    return list;
  }
  
  /**
   * ��� ��ȸ
   * 
   * @return CommentVO list
   */
  public CommentVO read(int cno) {
    CommentVO comentVO = commentDAO.read(cno);
    return comentVO;
  }
  
  /**
   * ��� ����
   * @param commentVO
   * @return
   */
  public int update(CommentVO commentVO) {
    int count = commentDAO.update(commentVO);
    return count; 
  }
  
  /**
   * ��й�ȣ Ȯ��
   * @param cno
   * @param passwd
   * @return
   */ 
  public int confirmPassword(int cno, String passwd) {
    int count = commentDAO.confirmPassword(cno, passwd);
    return count;
  }
  
  /**
   * ��� ����
   * @param cno
   * @return
   */
  public int delete(int cno) {
    int count = commentDAO.delete(cno);
    return count;
  }
}
  