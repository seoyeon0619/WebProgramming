package com.kosa.mvc1.common;

import javax.servlet.http.HttpServletRequest;

public class Pager {
	public static String makeTag(HttpServletRequest request, int totalCnt, int pgSize)
	{
		// totalCnt = 데이터전체개수
		//int pgSize = 10; // 한 페이지에 10개씩 보겠다
		int pgGroupSize = 5; // 한 그룹당 5개씩 보겠다
		int cpage; // 현재 페이지 
		String pg = request.getParameter("pg");
		if(pg==null || pg.equals(""))
			pg="0";
		cpage = Integer.parseInt(pg); // 현재 페이지 정보 저장
		
		// total을 float형으로 전환하면 pgSize도 float으로 전환해서 연산 수행
		// 0 1 2 3 ... 32 : 33페이지 (실제로는 32페이지까지 있음)
		int pageTotal = (int) Math.ceil((float)totalCnt/pgSize)-1 ;
		
		System.out.println(pageTotal);
		
		String path="";
		String firstLabel = "<<";
		String prevLabel = "<";
		String nextLabel = ">";
		String lastLabel = ">>";
		int start, end;
		
		start = cpage/pgGroupSize * pgGroupSize;
		end = start + pgGroupSize;
		if(end>pageTotal)
			end = pageTotal+1;
		System.out.println(String.format("start %d end %d cpage %d", start, end, cpage));
		
		StringBuffer buffer = new StringBuffer();
		buffer.append("<ul class='pagination justify-content-center'>");
		buffer.append(makeLink(0, firstLabel));
		
		if(cpage > 0)
			buffer.append(makeLink(cpage-1, prevLabel));
			
		
		for(int i=start; i<end; i++)
		{
			if(i==cpage) // 선택된 페이지는 css에 active가 있어야 함
				buffer.append(makeActiveLink(i, (i+1)+""));
			else
				buffer.append(makeLink(i, (i+1)+""));
		}
		
		if(cpage < pageTotal)
			buffer.append(makeLink(cpage+1, nextLabel));
		
		buffer.append(makeLink(pageTotal, lastLabel));
		buffer.append("</ul>");
		return buffer.toString();
	}
	
	static String makeLink(int page, String label)
	{
		String s = "<li class='page-item'>"
				+ "<a class='page-link' href='#none' "
				+ "onclick=goPage(" + page+ ") "
				+ " >"
				+ label
				+"</a></li>";
		return s;
	}
	
	static String makeActiveLink(int page, String label)
	{
		String s = "<li class='page-item active'>"
				+ "<a class='page-link' href='#none' "
				+ "onclick=goPage(" + page+ ") "
				+ " >"
				+ label
				+"</a></li>";
		return s;
	}
	
}
