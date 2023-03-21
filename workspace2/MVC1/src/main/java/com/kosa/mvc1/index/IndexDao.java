package com.kosa.mvc1.index;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kosa.mvc1.DBUtil;
import com.kosa.mvc1.guestbook.GuestbookDto;

public class IndexDao {
	public IndexDao() {
		// 생성자에서 DB모듈 불러오기
		// 객체 자동 생성
		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public List<IndexDto> getList() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List<IndexDto> list = new ArrayList<IndexDto>();
		
		String sql = "select seq, image from "
				+ " (select * "
				+ " from tb_gallery "
				+ " order by seq desc) "
				+ " where rownum<=5";
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				IndexDto dto = new IndexDto();
				dto.setSeq(rs.getString("seq"));
				dto.setImage(rs.getString("image"));
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
	
	public List<IndexDto2> getGusetbookList() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List<IndexDto2> list = new ArrayList<IndexDto2>();
		
		String sql = "select A.seq, A.title, A.writer, "
					+ " (select user_name from tb_member B where A.writer=B.user_id) user_name "
					+ " from ( "
					+ " select seq, title, writer  "
					+ " from tb_guestbook A "
					+ " order by seq desc "
					+ " )A where rownum<=9";
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				IndexDto2 dto = new IndexDto2();
				dto.setSeq(rs.getString("seq"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setUser_name(rs.getString("user_name"));
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
	
	
}
