package com.yeon.shop.common;

public final class DBUtil {
	// 외부에서 접근가능, final 상수, static - DBUtil 객체 만들지 않고 사용하기위해
  public final static String DRIVER = "oracle.jdbc.driver.OracleDriver";
  public final static String URL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
  public final static String USERID = "user01";
  public final static String PWD = "1234";
  
  private DBUtil() {
	  // 클래스 외부에서 객체 생성 못하도록 
  }
}