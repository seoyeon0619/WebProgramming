package com.kosa.mvc1.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.kosa.mvc1.DBUtil;

public class MemberDao {
	// 아이디 중복체크 
	// 이미 존재하면 true 없으면 flase 반환
	// 이 함수의 호출값이 false일 때 사용가능한 아이디
	boolean isDuplicate(String user_id)
	{
		String sql = "select count(*) cnt from tb_member "
				+ " where user_id='"+user_id+"' ";
		System.out.println(sql);
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				if(rs.getInt("cnt")==0)
					return false;
				else
					return true;
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
		
		return true;
}
	
	public boolean insert(MemberDto dto)
	{
		StringBuffer buffer = new StringBuffer();
		
		buffer.append("insert into tb_member(" );
		buffer.append(" member_id, user_id, user_name, password" );
		buffer.append(" , email, phone) values ( " );
		buffer.append(" sq_member.nextval ");
		buffer.append(" , '" + dto.getUSER_ID() + "' ");
		buffer.append(" , '" + dto.getUSER_NAME() + "' ");
		buffer.append(" , '" + dto.getPASSWORD() + "' ");
		buffer.append(" , '" + dto.getEMAIL() + "' ");
		buffer.append(" , '" + dto.getPHONE() + "') ");
		
		System.out.println(buffer);
		
		Connection conn = null;
		Statement stmt = null;
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			stmt.execute(buffer.toString());
			return true;
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		}
		finally
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
		
		return false;
}
	
	MemberDto logon(String user_id, String password)
	{
		String sql = "select * from tb_member "
				+ " where user_id='"+user_id+"' "
				+" and password='" + password+"' ";
		
		System.out.println(sql);
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		MemberDto dto = new MemberDto();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				dto.setUSER_ID(rs.getString("user_id"));
				dto.setUSER_NAME(rs.getString("user_name"));
				dto.setEMAIL(rs.getString("email"));
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
		
		return dto; // getUSER_ID() 공백이면 로그온 실패, 공백아니면 로그온성공
}
	
	MemberDto findid(String user_name, String email)
	{
		String sql = "select * from tb_member "
				+ " where user_name='"+user_name+"' "
				+" and email='" + email+"' ";
		
		System.out.println(sql);
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		MemberDto dto = new MemberDto();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				dto.setUSER_ID(rs.getString("user_id"));
				dto.setUSER_NAME(rs.getString("user_name"));
				dto.setEMAIL(rs.getString("email"));
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
		
		return dto; // getUSER_ID() 공백이면 로그온 실패, 공백아니면 로그온성공
}
	
	MemberDto findpassword(String user_id, String email)
	{
		String sql = "select * from tb_member "
				+ " where user_id='"+user_id+"' "
				+" and email='" + email+"' ";
		
		System.out.println(sql);
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		MemberDto dto = new MemberDto();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				dto.setUSER_ID(rs.getString("user_id"));
				dto.setUSER_NAME(rs.getString("user_name"));
				dto.setEMAIL(rs.getString("email"));
				dto.setPASSWORD(rs.getString("password"));
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
		
		return dto; // getUSER_ID() 공백이면 로그온 실패, 공백아니면 로그온성공
}
}

