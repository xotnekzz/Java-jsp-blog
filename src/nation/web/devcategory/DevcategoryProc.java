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
   * ī�װ� �׸� ����
   * @param devcategoryVO
   * @param devcategoryno
   */
  
  public DevcategoryVO selectOne(DevcategoryVO devcategoryVO ,int devcateno) {
    devcategoryVO = devcategoryDAO.selectOne(devcategoryVO, devcateno);
    return devcategoryVO;
  }
  
  /**
   * ī�װ� ��� 
   * @param devcategoryVO
   * @return ��ϵ� ���� 1 or 0
   */
  public int create(DevcategoryVO devcategoryVO) {
    int count = devcategoryDAO.create(devcategoryVO);
    return count;
  }
  
  /**
   * ȸ�� ī�װ� ��� 
   * @return
   */
  public ArrayList<DevcategoryVO> c_list() {
    list = devcategoryDAO.c_list();
    return list;
  }
  
  /**
   * ī�װ� ��� 
   * @return
   */
  public ArrayList<DevcategoryVO> list() {
    list = devcategoryDAO.list();
    return list;
  }
  
  /**
   * ��� ������ �ִ밪
   * @return seqno �ִ밪  + 1
   */
  public int getMaxSeqno() {
    int maxSeqno = devcategoryDAO.getMaxSeqno();
    return maxSeqno;
  }
  
  /**
   * ��¼����� ����
   * @param devcateno
   * @return ������ ���� 1 or 0
   */
  public void increaseSeqno(int devcateno) {
    devcategoryDAO.increaseSeqno(devcateno); 
  }
   
  /**
   * ��¼����� ����
   * @param devcateno
   * @return ������ ���� 1 or 0
   */
  public void decreaseSeqno(int devcateno) {
    devcategoryDAO.decreaseSeqno(devcateno);
  }
  
  /**
   * �Խ��� ���
   * @param devcateno
   * @return ������ ���� 1 or 0
   */
  public int show(int devcateno) {
   int count = devcategoryDAO.show(devcateno);
   return count;
  }

  /**
   * �Խ��� �����
   * @param devcateno
   * @return ������ ���� 1 or 0
   */
  public int hide(int devcateno) {
    int count = devcategoryDAO.hide(devcateno);
    return count;
  }

  /**
   * ī�װ� ����
   * @param devcategoryVO
   * @param devcateno
   * @return
   */
  public int update(DevcategoryVO devcategoryVO, int devcateno) {
    int count = devcategoryDAO.update(devcategoryVO, devcateno);
    return count;
  }
   
  /**
   * ī�װ� ����
   * @param devcategoryno
   * @return
   */
  
  public int delete(int devcateno) {
    int count = devcategoryDAO.delete(devcateno);
    return count;
  }

  /**
   * ���� �Խ��� �ۼ��� ����
   * @param devcategoryno
   * @return
   */
  public int increaseCnt(int devcategoryno) { // call by reference
    int count = devcategoryDAO.increaseCnt(devcategoryno);                     // ó���� ���ڵ� ����
    return count;
  }
  
  /**
   * ���� �Խ��� �ۼ��� ����
   * @param devcategoryno
   * @return
   */
  public int decreaseCnt(int devcategoryno) { // call by reference
    int count = devcategoryDAO.decreaseCnt(devcategoryno);
    return count;
  }
  
}
