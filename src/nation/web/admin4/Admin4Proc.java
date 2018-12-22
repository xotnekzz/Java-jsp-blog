package nation.web.admin4;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import nation.web.tool.AES256Util;

public class Admin4Proc {
  Admin4DAO adminDAO;
  Admin4VO admin4VO;
  ArrayList<Admin4VO> list;
  
  public Admin4Proc() {
    adminDAO = new Admin4DAO(); 
    admin4VO = new Admin4VO();
    list = new ArrayList<Admin4VO>();
  }
  
  /**
   * 관리자 등록
   * @param admin4VO 관리자 내용
   * @return 1: 등록 성공, 0: 등록 실패
   */
  public int insert(Admin4VO admin4VO){
 int count = 0;
    
    try {
      AES256Util aes256 = new AES256Util();
      String crypto_passwd = aes256.aesEncode(admin4VO.getPasswd());
      admin4VO.setPasswd(crypto_passwd);
      count = adminDAO.insert(admin4VO);
       
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    } catch (InvalidKeyException e) {
      e.printStackTrace();
    } catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
    } catch (NoSuchPaddingException e) {
      e.printStackTrace();
    } catch (InvalidAlgorithmParameterException e) {
      e.printStackTrace();
    } catch (IllegalBlockSizeException e) {
      e.printStackTrace();
    } catch (BadPaddingException e) {
      e.printStackTrace();
    }
    
    return count;
    }

  /**
   * 키를 조합합니다. 예) ABC + 현재시간: ABC1234567890123
   * @return
   */
  public String key(){
    String code = "";
    
    //  ASCII: 65 ~ 90, (A ~ Z: 26자)
    Random rnd = new Random();
    int su = rnd.nextInt(26) + 65; // 0 ~ 25 --> 65 ~ 90
    // System.out.println((char)su);
    code = code + (char)su;
    
    su = rnd.nextInt(26) + 65; // 0 ~ 25 --> 65 ~ 90
    // System.out.println((char)su);
    code = code + (char)su;
    
    su = rnd.nextInt(26) + 65; // 0 ~ 25 --> 65 ~ 90
    // System.out.println((char)su);
    code = code + (char)su;
 
    code = code + new Date().getTime();
    // System.out.println("CODE: " + code); // CODE: XGL1449819012230 
    
    return code;
  }
  
  /**
   * Master 계정이 있는지 검사합니다.
   * @return true: 마스터 계정 존재, false: 존재하지 않음.
   */
  public boolean isMaster(){
    boolean sw = false;
    
    if (adminDAO.isMaster() == 1 ){ // 마스터 계정이 이미 있다면
      sw = true; // 계정 존재
    }
    
    return sw;
  }
  
  /** 
   * 단순 목록을 구합니다.
   * @return 목록
   */
  public ArrayList<Admin4VO> list(){
    list = adminDAO.list();
    return list;
  }
  
  /**
   * 권한을 변경합니다.
   * @param admin4no 변경할 회원 번호
   * @param act 권한
   * @return 변경된 레코드 수
   */
  public int updateAct(int admin4no, String act){
    int count = adminDAO.updateAct(admin4no, act);
    return count;   
  }
  
  /**
   * 사용자가 회원 가입 이메일 링크를 눌렀을 경우의 처리
   * @param email 이메일
   * @param auth 인증 코드
   * @return 처리된 레코드 갯수
   */
  public int confirm(String email, String auth){
     int count = adminDAO.confirm(email, auth);
     return count;
  }
  
  /**
   * 한건의 레코드 조회
   * @param admin4no 조회할 번호
   * @return
   */
  public Admin4VO read(int admin4no){
    admin4VO = adminDAO.read(admin4no);
    return admin4VO;
  }
  
  /**
   * 회원을 삭제합니다.
   * @param admin4no 삭제할 회원 번호
   * @return 삭제된 레코드 갯수
   */
  public int delete(int admin4no){
    int count = adminDAO.delete(admin4no);
    return count;
  }
  
  /**
   * 중복 이메일 갯수를 구합니다.
   * @param col 검색 컬럼
   * @param word 검색어
   * @return 검색된 갯수
   */
  public int countEmail(String word){ 
    int count = 0;
    
    count = adminDAO.count("email", word);
    
    return count;
  }
  
  /**
   * 한건의 레코드 조회
   * @param email 조회할 이메일
   * @return
   */
  public Admin4VO read(String email){
    Admin4VO admin4VO = null;
    
    admin4VO = adminDAO.read(email);
    
    return admin4VO;
  }
  
  /** 
   * 로그인 처리
   * @param email 이메일
   * @param passwd 패스워드
   * @return 레코드 갯수
   */
  public int login(String email, String passwd){
    int count = 0;              // 레코드 갯수
    
    try {
      AES256Util aes256 = new AES256Util();
      String crypto_passwd = aes256.aesEncode(passwd);
      // System.out.println("--> crypto_passwd: " + crypto_passwd);
      count = adminDAO.login(email, crypto_passwd);
      System.out.println("AdimProc.java -> crpyto_passwd : " + crypto_passwd );
      
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    } catch (InvalidKeyException e) {
      e.printStackTrace();
    } catch (NoSuchAlgorithmException e) { 
      e.printStackTrace(); 
    } catch (NoSuchPaddingException e) {
      e.printStackTrace();
    } catch (InvalidAlgorithmParameterException e) {
      e.printStackTrace();
    } catch (IllegalBlockSizeException e) {
      e.printStackTrace();
    } catch (BadPaddingException e) {
      e.printStackTrace();
    }
     
    return count; 
  }
  
  /**
   * 패스워드가 일치하는지 확인합니다.
   * @param admin4no 회원 번호
   * @param passwd 패스워드
   * @return 1: 일치, 0: 불일치
   */
  public int countPasswd(int admin4no, String passwd){
    int count = 0;
    
    try {
      AES256Util aes256 = new AES256Util();
      String crypto_passwd = aes256.aesEncode(passwd);
      count = adminDAO.countPasswd(admin4no, crypto_passwd);
      
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    } catch (InvalidKeyException e) {
      e.printStackTrace();
    } catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
    } catch (NoSuchPaddingException e) {
      e.printStackTrace();
    } catch (InvalidAlgorithmParameterException e) {
      e.printStackTrace();
    } catch (IllegalBlockSizeException e) {
      e.printStackTrace();
    } catch (BadPaddingException e) {
      e.printStackTrace();
    }
    
    return count;
  }
  
  /**
   * 패스워드를 변경합니다.
   * @param admin4no 변경할 회원 번호
   * @param passwd 번경할 패스워드
   * @return 1: 변경 성공, 2: 변경 실패
   */
  public int updatePasswd(int admin4no, String passwd){
    int count = 0;
    
    try { 
      AES256Util aes256 = new AES256Util();
      String crypto_passwd = aes256.aesEncode(passwd);
      count = adminDAO.updatePasswd(admin4no, crypto_passwd);
      
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    } catch (InvalidKeyException e) {
      e.printStackTrace();
    } catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
    } catch (NoSuchPaddingException e) {
      e.printStackTrace();
    } catch (InvalidAlgorithmParameterException e) {
      e.printStackTrace();
    } catch (IllegalBlockSizeException e) {
      e.printStackTrace();
    } catch (BadPaddingException e) {
      e.printStackTrace();
    }
    
    return count;
  }
  
  /**
   * 회원 수정
   * @param admin4VO 회원 내용
   * @return 1: 등록 성공, 0: 등록 실패
   */
  public int update(Admin4VO admin4VO){
    int count = adminDAO.update(admin4VO);
    
    return count; 
  }
}
