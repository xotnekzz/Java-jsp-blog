package nation.web.devcategory;

public class DevcategoryVO {
  private int devcateno; // 카테고리번호
  private String title; // 카테고리명
  private String ids; // 관리자아이디
  private String visible; // 출력 여부 
  private int seqno; // 출력 순서
  private int cnt; // 조회수
  
  public int getDevcateno() {
    return devcateno;
  }
  public void setDevcateno(int devcateno) {
    this.devcateno = devcateno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getIds() {
    return ids;
  }
  public void setIds(String ids) {
    this.ids = ids;
  }
  public String getVisible() {
    return visible;
  }
  public void setVisible(String visible) {
    this.visible = visible;
  }
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  
}
