package nation.web.devdiary;

import java.util.ArrayList;

import nation.web.tool.Tool;

public class DevdiaryProc {
  
  DevdiaryDAO devdiaryDAO;
  ArrayList<DevdiaryVO> list;
  
  public DevdiaryProc() {
    devdiaryDAO = new DevdiaryDAO();
    list = new ArrayList<DevdiaryVO>();
  }
  
  /** 
   * ����Ʈ ��ȸ
   * @param devcateno
   * @return
   */
  public ArrayList<DevdiaryVO> list(int devcateno) {
    list = devdiaryDAO.list(devcateno); 
    return list;
  }
  
  /**
   * �Խñ� ���
   * @param devdiaryVO
   * @return
   */
   public int insert(DevdiaryVO devdiaryVO) {
     int count = devdiaryDAO.insert(devdiaryVO);
     return count;
   }
   
   /**
    * �Խñ� 1�� ��ȸ
    * @param devdiaryno
    * @return
    */
   public DevdiaryVO read(int devdiaryno) {
     DevdiaryVO devdiaryVO = devdiaryDAO.read(devdiaryno);
     return devdiaryVO; 
   }
   
   /**
    * ��ȸ�� ����
    * @param devdiaryno
    * @return
    */
   public int increaseCnt(int devdiaryno) {
     int count = devdiaryDAO.increaseCnt(devdiaryno);
     return count;
   }
   
   /**
    * �н����带 �˻��մϴ�.
    * @param pdsno
    * @param passwd
    * @return ���ڵ� ����, 1 or 0
    */
   public int passwordCheck(int devdiaryno, String passwd){
     int count = devdiaryDAO.passwordCheck(devdiaryno, passwd);
     return count;
   }
   
   /**
    * �Խñ� ����
    * @param pdsno
    * @param passwd
    * @return ���ڵ� ����, 1 or 0
    */
   public int delete(int devdiaryno){
     int count = devdiaryDAO.delete(devdiaryno);
     return count;
   }
   
   /**
    * �Խñ� ����
    * @param devdiaryVO
    * @return
    */
    public int update(DevdiaryVO devdiaryVO) {
      int count = devdiaryDAO.update(devdiaryVO);
      return count;
    }
    
    /**
     * ���� ����
     * @param devdiaryVO
     * @return
     */ 
      public int create_file1(DevdiaryVO devdiaryVO) {
        int count = devdiaryDAO.create_file1(devdiaryVO);
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
          int categoryno, 
          String col, 
          String word, 
          int nowPage,
          int recordPerPage) {
        
        col = Tool.checkNull(col); 
        word = Tool.checkNull(word);
        int offset  = (nowPage - 1) * recordPerPage; // skip�� ���ڵ� ��
        
        list = devdiaryDAO.list_category(categoryno, col, word, offset, recordPerPage);
        return list;
      }
      
      /**
       * ī�װ����� �˻��� ���ڵ�
       * 
       * @return
       */
      public int count(int devcateno, String col, String word) {
        int count = 0;
        
        count = devdiaryDAO.count(devcateno, col, word);
        
        return count;
      }
      
      /**
       * �ֱ� �Խñ� 5�� ��ȸ
       * @param devdiaryno
       * @return
       */
      public ArrayList<DevdiaryVO> recent_read() {
          list = devdiaryDAO.recent_read();
          return list;
      }
      
      /**
       * �α� �Խñ� 5�� ��ȸ
       * @param devdiaryno
       * @return
       */
      public ArrayList<DevdiaryVO> pop_read() {
        list = devdiaryDAO.pop_read();
        return list;
      } 
      
      /**
       * ���� ����
       * @param devdiaryVO
       * @return
       */
      public int delete_file1(int devdiaryno) {
        DevdiaryVO devdiaryVO = new DevdiaryVO();
        devdiaryVO.setFile("");
        devdiaryVO.setFstor1("");
        devdiaryVO.setSize1(0); 
        devdiaryVO.setDevdiaryno(devdiaryno);
        int count= devdiaryDAO.create_file1(devdiaryVO);
         
        return count;
      }
}
