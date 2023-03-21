package com.yeon.myhome4;

public class CommonUtil {
	private CommonUtil() {} // 클래스 밖에서 객체 생성 못하게 하기 위한 코드
	static public String nullToVal(Object ob1, String value) {
		if (ob1 == null || ob1.toString().equals("")) {
			return value;
		} else
			return ob1.toString();
	}
}
