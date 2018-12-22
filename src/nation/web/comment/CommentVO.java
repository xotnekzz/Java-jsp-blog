package nation.web.comment;

public class CommentVO {
  private int cno;
  private String cdate;
  private String content;
  private String email;
  private int devdiaryno; 
  private String rname;
  private int good; 
  private String passwd;
   
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public int getCno() {
    return cno;
  }
  public void setCno(int cno) {
    this.cno = cno;
  }
  public String getCdate() {
    return cdate;
  }
  public void setCdate(String cdate) {
    this.cdate = cdate;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getEmail() {
    return email;
  }
  public void setEmail(String email) {
    this.email = email;
  }
  public int getDevdiaryno() {
    return devdiaryno;
  }
  public void setDevdiaryno(int devdiaryno) {
    this.devdiaryno = devdiaryno;
  }
  public String getRname() {
    return rname;
  }
  public void setRname(String rname) {
    this.rname = rname;
  }
  public int getGood() {
    return good;
  }
  public void setGood(int good) {
    this.good = good;
  }
  
}
