package nation.web.tool;
 
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
 
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
 
 
import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
 
/**
 * HttpServletRequestWrapper 클래스는 HttpServletRequest
 * 인터페이스를 임시로 구현한 클래스로 개발자가 내부객체인
 * request를 사용하지않고 새로운 형태로 request 객체를
 * 만들어 사용할 경우 상속받는 클래스입니다.  
 * Apahce FileUpload 콤포넌트를 사용하기 편리하게 지원합니다.
 * FileUpload API를 사용하는 HttpServletRequestWrapper 클래스로서
 * HttpServletRequest에 기반한 API를 사용하기 위한 래퍼이다.
 * 
  ⓘServletRequest
  │       △ 
  │       │  
  │       │구현
  │       └ ⓒServletRequestWrapper
  │                          △
  │                          │                 
  └─ ⓘHttpServletRequest   │
       △     request         │상속 
       │                     │
       │구현                 │ 
       └─ ⓒHttpServletRequestWrapper 
            △
            │
            │상속   
            ⓒUploadSaveManager - uploadSaveManager
       
  request = requestWrap;
       
  public interface HttpServletRequest extends ServletRequest
 
  public class HttpServletRequestWrapper extends ServletRequestWrapper 
          implements HttpServletRequest
          
  public class UploadSaveManager extends HttpServletRequestWrapper
  
          
 */
public class UploadHTML5 extends HttpServletRequestWrapper {
    
    private boolean multipart = false;
    
    private HashMap parameterMap;  // 일반 <INPUT> 폼태그
    private HashMap fileItemMap;   // 전송된 <FILE> 태그 객체가 저장
    
    /**
     * 기본 생성자
     * @param request
     * @throws FileUploadException
     */
    public UploadHTML5(HttpServletRequest request) 
    throws FileUploadException{
        this(request, -1, -1, null);
    }
    
    /**
     * 생성자
     * @param request HttpServletRequest 객체
     * @param threshold 메모리에 저장할 최대크기
     * @param max 업로드할 최대 파일크기
     * @param repositoryPath 업로드 경로
     * @throws FileUploadException
     */
    public UploadHTML5(HttpServletRequest request,
        int threshold, int max, String repositoryPath) throws FileUploadException {
        super(request);
        
        parsing(request, threshold, max, repositoryPath);
    }
    
    /**
     * 일반 입력 필드와 파일 필드를 MAP에 저장
     * @param request HttpServletRequest 객체
     * @param threshold 메모리에 저장할 최대크기
     * @param max 업로드할 최대 파일크기
     * @param repositoryPath 업로드 경로
     * @throws FileUploadException
     */
    private void parsing(HttpServletRequest request,
        int threshold, int max, String repositoryPath) throws FileUploadException {
        
        int html5Count = 0;
        
        if (FileUpload.isMultipartContent(request)) {
            multipart = true;
            
            parameterMap = new java.util.HashMap(); // 일반 <INPUT> 폼태그
            fileItemMap = new java.util.HashMap();  // 전송된 <FILE> 태그 객체가 저장
            
            DiskFileUpload diskFileUpload = new DiskFileUpload();
            if (threshold != -1) {
                diskFileUpload.setSizeThreshold(threshold);
            }
            diskFileUpload.setSizeMax(max);
            if (repositoryPath != null) {
                diskFileUpload.setRepositoryPath(repositoryPath);
            }
            
            // Form안의 Input 태그의 이름과 값이 저장되어 있음
            java.util.List list = diskFileUpload.parseRequest(request);
            for (int i = 0 ; i < list.size() ; i++) {
                FileItem fileItem = (FileItem) list.get(i);
                String name = fileItem.getFieldName();
 
                if (fileItem.isFormField()) { // 일반 Input 태그인지 검사
                    // 일반 폼태그라면 처리
                    String value = fileItem.getString();
                    String[] values = (String[]) parameterMap.get(name);
                    if (values == null) {
                        values = new String[] { value };
                    } else { // 태그의 값이 여러개 인 경우 배열 처리
                        String[] tempValues = new String[values.length + 1];
                        System.arraycopy(values, 0, tempValues, 0, 1);
                        tempValues[tempValues.length - 1] = value;
                        values = tempValues;
                    }
                 // name: 태그의 이름, values: 태그의 값
                 // <input type='text' name='title' size='80' value=''>
                 // name --> title, values --> value
                    parameterMap.put(name, values); 
                } else {
                    // 파일 태그라면 처리
                    // System.out.println("전송 파일 발견됨 저장명: " + name);
                    // System.out.println("전송 파일 발견됨 파일명: " + fileItem.getName());
                    
                    // -------------------------------------------------------------
                    // 다중 파일 업로드시 태그 이름에  숫자로된 id 결합 
                    // -------------------------------------------------------------
                    // name --> filename, 파일 객체
                    html5Count++;
                    name = name + html5Count;  // files1, files2, files3...
                    fileItemMap.put(name, fileItem); // id와 파일 객체 저장
                    // -------------------------------------------------------------
 
                }
            }
            addTo(); // request 속성으로 설정한다.
        }
    }
    
    /**
     * 파일을 전송하는 enctype="multipart/form-data"인경우 true리턴
     * @return enctype="multipart/form-data"인경우 true리턴
     */
    public boolean isMultipartContent() {
        return multipart;
    }
    
    /**
     * 주어진 파라미터에 대한 값을 리턴
     */
    public String getParameter(String name) {
        if (multipart) {
            String[] values = (String[])parameterMap.get(name);
            if (values == null) return null;
            return values[0];
        } else
            return super.getParameter(name);
    }
    
    /**
     * 파라미터의 값들을 리턴
     */
    public String[] getParameterValues(String name) {
        if (multipart)
            return (String[])parameterMap.get(name);
        else
            return super.getParameterValues(name);
    }
    
    /**
     * 전체 파라미터의 이름을 리턴
     */
    public Enumeration getParameterNames() {
        if (multipart) {
            return new Enumeration() {
                Iterator iter = parameterMap.keySet().iterator();
                
                public boolean hasMoreElements() {
                    return iter.hasNext();
                }
                public Object nextElement() {
                    return iter.next();
                }
            };
        } else {
            return super.getParameterNames();
        }
    }
    
    public Map getParameterMap() {
        if (multipart)
            return parameterMap;
        else
            return super.getParameterMap();
    }
    
    /**
     * 지정한 파라미터 이름과 관련된 FileItem을 리턴합니다.
     * @param name
     * @return
     */
    public FileItem getFileItem(String name) {
        if (multipart)
            return (FileItem) fileItemMap.get(name);
        else
            return null;
    }
    
    /**
     * 임시로 사용된 업로드 파일을 삭제합니다.
     */
    public void delete() {
        if (multipart) {
            Iterator fileItemIter = fileItemMap.values().iterator();
            while( fileItemIter.hasNext()) {
                FileItem fileItem = (FileItem)fileItemIter.next();
                fileItem.delete();
            }
        }
    }
    
    /**
     * 래퍼객체 자체를 request 객체에 저장합니다.
     */
    public void addTo() {
        super.setAttribute(UploadHTML5.class.getName(), this);
    }
    
    /**
     * request 속성에 저장된 FileUploadRequestWrapper를 리턴합니다.
     * @param request
     * @return
     */
    public static UploadHTML5 
                  getFrom(HttpServletRequest request) {
        return (UploadHTML5)
            request.getAttribute(UploadHTML5.class.getName());
    }
    
    /**
     * 지정한 request가 래퍼를 속성으로 포함하고 있으면 true를 리턴합니다.
     * @param request
     * @return
     */
    public static boolean hasWrapper(HttpServletRequest request) {
        if (UploadHTML5.getFrom(request) == null) {
            return false;
        } else {
            return true;
        }
    }
    
    // 파일이 중복되면 자동으로 일련번호를 생성하여 추가
    // fileItem: 전송된 파일객체
    // upDir: 저장할 디렉토리
    public static String saveFile(FileItem fileItem, String upDir){
        
        String filename = "";       //업로드 파일명
       
        // 파일 태그
        System.out.println("전송된 파일명: " + fileItem.getName());
 
        // 폴더 구분자 추출
        int idx = fileItem.getName().lastIndexOf("\\"); //윈도우 기반
 
        if (idx == -1) { // 유닉스, 리눅스 기반
            idx = fileItem.getName().lastIndexOf("/");
        }
          
        // 순수 파일명 추출
        filename = fileItem.getName().substring(idx + 1);
          
        try {
            //-----------------------------------------------
            //대상 폴더에 저장할 파일 객체 생성, 폴더 + 파일명
            //-----------------------------------------------
            File uploadedFile = new File(upDir, filename);
              
            //올릴려는 파일과 같은 이름이 존재하면 중복파일 처리
            if ( uploadedFile.exists() == true ){
                for(int k=0; true; k++){
                    // 파일명 중복을 피하기 위한 일련 번호를 생성하여
                    // 파일명으로 조합
                    uploadedFile = new File(upDir, k+"_"+filename);
                    // 조합된 파일명이 존재하지 않는다면, 일련번호가
                    // 붙은 파일명 다시 생성
                    // 존재하지 않는 경우
                    // !을 이용해 false일 경우 참으로 처리되도록 변환
                    boolean bol = uploadedFile.exists();
                    if(bol == false){
                        // 존재하지 않는 새로운 파일명 확정
                        // (0)abc.txt
                        filename = k+"_"+filename;
                        break;
                    }
                }
            }
               
            // storage 폴더에 파일명 저장
            fileItem.write(uploadedFile);
        } catch(Exception e) {
              System.out.println(e.toString());    
        }
 
        return filename; // 업로드된 파일명 리턴
    }
 
    // 파일명을 날짜에 의해서 새로 생성, 한글 파일명 깨짐 문제 해결
    // fileItem: 전송된 파일객체
    // upDir: 저장할 디렉토리
    public static String saveFile2(FileItem fileItem, String upDir){
        String filename = "";   // 업로드 파일명
        String extention = "";  // 업로드 파일 확장자
       
        // 파일 태그
        System.out.println("전송된 파일명: " + fileItem.getName());
 
        // 폴더 구분자 추출
        int idx = fileItem.getName().lastIndexOf("."); 
 
        // 순수 파일명 추출. abc.txt -> 파일 확장자 추출
        extention = fileItem.getName().substring(idx); // .jpg
        filename = getNewPDSFilename(extention);
          
        try {
            //대상 폴더에 저장할 파일 객체 생성, 폴더 + 파일명
            File uploadedFile = new File(upDir, filename);
              
            // storage 폴더에 파일명 저장
            fileItem.write(uploadedFile);
        } catch(Exception e) {
              System.out.println(e.toString());    
        }
 
        return filename; // 업로드된 파일명 리턴
    }
    //---------------------------------------------------------------
    //Fileupload 콤포넌트 관련 코드 끝
    //---------------------------------------------------------------
 
    public HashMap getFileItemMap() {
        return fileItemMap;
    }
 
    public void setFileItemMap(HashMap fileItemMap) {
        this.fileItemMap = fileItemMap;
    }
    
    /**
     * 전송받은 파일의 갯수를 리턴
     * @return
     */
    public int getFileCount(){
        return this.fileItemMap.size();
    }
    
    /**
     * 새로운 이미지 파일을 생성합니다.
     * @return 20110601_121003_A85 형식의 문자열 리턴
     */
    public static String getNewPDSFilename(String extention){
        String filename = "";
        Random rnd = new Random();
 
        //  ASCII: 65 ~ 90, (A ~ Z: 26자)
        int su = rnd.nextInt(26) + 65; // 0 ~ 25 --> 65 ~ 90
        // System.out.println((char)su);
        char code = (char)su; // 문자로 변환
        
        // filename = ""+rnd.nextInt(10)+1;
        String rndStr = String.valueOf((rnd.nextInt(100))+1); // 1 ~ 100
        
        filename = getDate3() + "_" + code + rndStr + extention;
        
        return filename;
    }
      
    /**
     * yyyyMMdd_hhmiss 형식의 날짜를 리턴합니다.
     * @return 20110601_121003 형식의 문자열 리턴
     */
    public static String getDate3(){
        SimpleDateFormat sd = new SimpleDateFormat("yyyyMMdd_hhmmss");
        
        String date = sd.format(new Date());
 
        // System.out.println(date);        
        return date;
    }    
 
    /**
     * FileUpload 1.2 한글 변환
     * @param str
     * @return
     */
    public String encodeFileUpload12(String str) {
      String corean = null;
      try {
        corean = new String(str.getBytes("ISO-8859-1"), "UTF-8");
        // corean= new String(str.getBytes("ISO-8859-1"), "KSC5601");
      } catch (Exception e) {
        return corean;
      }
      return corean;
    }
}