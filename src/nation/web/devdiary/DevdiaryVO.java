package nation.web.devdiary;

public class DevdiaryVO {
  private int devdiaryno;
  private String title_main;
  private String title_sub;
  private String content;
  private String rdate;
  private String rname;
  private String file;
  private String fstor1;
  private String thumb;
  private long size1;
  private String email;
  private String passwd;
  private int devcateno;
  private int cnt;
  private String visible;

  public String getRname() {
    return rname;
  }

  public void setRname(String rname) {
    this.rname = rname;
  }

  public int getDevdiaryno() {
    return devdiaryno;
  }

  public void setDevdiaryno(int devdiaryno) {
    this.devdiaryno = devdiaryno;
  }

  public String getTitle_main() {
    return title_main;
  }

  public void setTitle_main(String title_main) {
    this.title_main = title_main;
  }

  public String getTitle_sub() {
    return title_sub;
  }

  public void setTitle_sub(String title_sub) {
    this.title_sub = title_sub;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  public String getFile() {
    return file;
  }

  public void setFile(String file) {
    this.file = file;
  }

  public String getFstor1() {
    return fstor1;
  }

  public void setFstor1(String fstor1) {
    this.fstor1 = fstor1;
  }

  public String getThumb() {
    return thumb;
  }

  public long getSize1() {
    return size1;
  }

  public void setSize1(long size1) {
    this.size1 = size1;
  }

  public void setThumb(String thumb) {
    this.thumb = thumb;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPasswd() {
    return passwd;
  }

  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }

  public int getDevcateno() {
    return devcateno;
  }

  public void setDevcateno(int devcateno) {
    this.devcateno = devcateno;
  }

  public int getCnt() {
    return cnt;
  }

  public void setCnt(int cnt) {
    this.cnt = cnt;
  }

  public String getVisible() {
    return visible;
  }

  public void setVisible(String visible) {
    this.visible = visible;
  }

}
