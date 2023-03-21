package com.yeon.shop.index;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.yeon.shop.index.*;
import com.yeon.shop.common.*;

public class ShopDao {
	
	public ShopDao() {
	try {
		Class.forName(DBUtil.DRIVER);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
}

public List<ShopDto> getList(ShopDto paramDto) {
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	List<ShopDto> list = new ArrayList<ShopDto>();
	
	try {
		conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
		stmt = conn.createStatement();
		
		StringBuffer buffer = new StringBuffer();
		buffer.append("select A.seq, A.rnum, A.pro_name, A.pro_price, A.pro_size,");
		buffer.append(" A.pg, A.pro_image");
		buffer.append(" from ");
		buffer.append("( ");
		buffer.append("    select seq, pro_name, pro_price, pro_size, ");
		buffer.append(" pro_image, ");
		buffer.append("   row_number() over(order by seq desc) as rnum, ");
		buffer.append("   ceil(row_number() over(order by seq desc)/12)-1 pg ");
		buffer.append("   from tb_shop A ");
		buffer.append(" )A ");
		list.add(paramDto);
		
		System.out.println(buffer.toString()); 
		
		rs = stmt.executeQuery(buffer.toString());
		
		while(rs.next())
		{
			ShopDto dto = new ShopDto();
			dto.setSeq(rs.getString("seq"));
			dto.setPro_name(rs.getString(("name"));
			dto.setPro_price(rs.getString("price"));
			dto.setPro_size(rs.getString("size"));
			dto.setPro_image(rs.getString("image"));
			list.add(dto);
		}
		
	} catch (SQLException e) {
		e.printStackTrace();
	} catch(Exception e) {
		e.printStackTrace();
	}
	finally
	{
		try
		{
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		} 
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	return list;
}


public ShopDto getView(String seq) {
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	ShopDto dto = new ShopDto();
	
	try {
		conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
		stmt = conn.createStatement();
		
		
		// 데이터 가져오기
		String sql = "select seq, pro_name, pro_price, pro_size, "
				+" pro_image"
				+ " from tb_shop "
				+ " where seq="+seq;
		
		System.out.println(sql); 
		
		rs = stmt.executeQuery(sql);
		if(rs.next())
		{
			dto.setSeq(rs.getString("seq"));
			dto.setPro_name(rs.getString("name"));
			dto.setPro_price(rs.getString("price"));
			dto.setPro_size(rs.getString("size"));
			dto.setPro_image(rs.getString("image"));
		}
		
	} catch (SQLException e) {
		e.printStackTrace();
	} catch(Exception e) {
		e.printStackTrace();
	}
	finally
	{
		try
		{
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		} 
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	return dto;
}

public void insert(ShopDto dto)
{
	 Connection conn=null;
	 Statement stmt = null;
	 try
	 {
		 //String클래스는 내부 메모리를 데이터 하나 추가될때마다 
		 //새로 잡아서 데이터넣고 
		 StringBuffer buffer = new StringBuffer();
		 buffer.append("insert into tb_shop( ");
		 buffer.append("seq, pro_name, pro_price, pro_size");
		 buffer.append(" ,pro_image  ) ");
		 buffer.append(" values ( sq_shop.nextval,");
		 buffer.append(" '"+dto.getPro_name()+"', ");
		 buffer.append(" '"+dto.getPro_price()+"', ");
		 buffer.append(" '"+dto.getPro_size()+"', ");
		 buffer.append(" '"+dto.getPro_image()+"' ");
		 buffer.append(" ) ");
		 System.out.println(buffer.toString());
		 
		 conn = DriverManager.getConnection(DBUtil.URL, 
				 DBUtil.USERID, DBUtil.PWD);
		 
		 stmt = conn.createStatement();
		 stmt.execute(buffer.toString());
		 
	 }
	 catch (SQLException e) 
	 {
			e.printStackTrace();
	 }
	 catch(Exception e)
	 {
			e.printStackTrace();
	 }
	 finally //예외가 발생하던 말던 무조건 수행한다. - 디비를 닫아주자
	 {
		try
		{
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}

}


