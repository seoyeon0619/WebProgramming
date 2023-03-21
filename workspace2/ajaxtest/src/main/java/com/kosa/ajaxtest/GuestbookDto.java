package com.kosa.ajaxtest;

public class GuestbookDto {
	private String seq = "";
	private String title = "";
	private String writer = "";
	private String contents = "";
	private String wdate = "";
	private String hit = "";
	
	public GuestbookDto() {
		super();
	}
	public GuestbookDto(String seq, String title, String writer, String contents, String wdate, String hit) {
		super();
		this.seq = seq;
		this.title = title;
		this.writer = writer;
		this.contents = contents;
		this.wdate = wdate;
		this.hit = hit;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	
	
}
