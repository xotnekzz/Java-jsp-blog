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
   * 리스트 조회
   * @param devcateno
   * @return
   */
  public ArrayList<DevdiaryVO> list(int devcateno) {
    list = devdiaryDAO.list(devcateno); 
    return list;
  }
  
  /**
   * 게시글 등록
   * @param devdiaryVO
   * @return
   */
   public int insert(DevdiaryVO devdiaryVO) {
     int count = devdiaryDAO.insert(devdiaryVO);
     return count;
   }
   
   /**
    * 게시글 1건 조회
    * @param devdiaryno
    * @return
    */
   public DevdiaryVO read(int devdiaryno) {
     DevdiaryVO devdiaryVO = devdiaryDAO.read(devdiaryno);
     return devdiaryVO; 
   }
   
   /**
    * 조회수 증가
    * @param devdiaryno
    * @return
    */
   public int increaseCnt(int devdiaryno) {
     int count = devdiaryDAO.increaseCnt(devdiaryno);
     return count;
   }
   
   /**
    * 패스워드를 검사합니다.
    * @param pdsno
    * @param passwd
    * @return 레코드 갯수, 1 or 0
    */
   public int passwordCheck(int devdiaryno, String passwd){
     int count = devdiaryDAO.passwordCheck(devdiaryno, passwd);
     return count;
   }
   
   /**
    * 게시글 삭제
    * @param pdsno
    * @param passwd
    * @return 레코드 갯수, 1 or 0
    */
   public int delete(int devdiaryno){
     int count = devdiaryDAO.delete(devdiaryno);
     return count;
   }
   
   /**
    * 게시글 수정
    * @param devdiaryVO
    * @return
    */
    public int update(DevdiaryVO devdiaryVO) {
      int count = devdiaryDAO.update(devdiaryVO);
      return count;
    }
    
    /**
     * 파일 수정
     * @param devdiaryVO
     * @return
     */ 
      public int create_file1(DevdiaryVO devdiaryVO) {
        int count = devdiaryDAO.create_file1(devdiaryVO);
        return count;
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
      public ArrayList<DevdiaryVO> list_category(
          int categoryno, 
          String col, 
          String word, 
          int nowPage,
          int recordPerPage) {
        
        col = Tool.checkNull(col); 
        word = Tool.checkNull(word);
        int offset  = (nowPage - 1) * recordPerPage; // skip할 레코드 수
        
        list = devdiaryDAO.list_category(categoryno, col, word, offset, recordPerPage);
        return list;
      }
      
      /**
       * 카테고리별로 검색된 레코드
       * 
       * @return
       */
      public int count(int devcateno, String col, String word) {
        int count = 0;
        
        count = devdiaryDAO.count(devcateno, col, word);
        
        return count;
      }
      
      /**
       * 최근 게시글 5건 조회
       * @param devdiaryno
       * @return
       */
      public ArrayList<DevdiaryVO> recent_read() {
          list = devdiaryDAO.recent_read();
          return list;
      }
      
      /**
       * 인기 게시글 5건 조회
       * @param devdiaryno
       * @return
       */
      public ArrayList<DevdiaryVO> pop_read() {
        list = devdiaryDAO.pop_read();
        return list;
      } 
      
      /**
       * 파일 삭제
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
