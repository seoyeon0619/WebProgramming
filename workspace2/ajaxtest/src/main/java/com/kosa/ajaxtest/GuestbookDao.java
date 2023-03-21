package com.kosa.ajaxtest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class GuestbookDao {
	

	public GuestbookDao() {
		// 예외처리 - jsp 안해도됨, java 반드시 해줘야함
		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public List<GuestbookDto> getList() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List<GuestbookDto> list = new ArrayList<GuestbookDto>();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			String sql = "select seq, title, writer, contents "
					+ ", to_char(wdate, 'yyyy-mm-dd') wdate "
					+ ", hit from tb_guestbook ";
			
			// 디버깅용
			// 콘솔창에서 쿼리가 제대로 작동하는지 확인
			// 나중에는 log4j 라는 라이브러리를 연결해서 확인
			System.out.println(sql); 
			
			rs = stmt.executeQuery(sql);
			
			// 맨 앞에는 데이터가 아님. 한번 next호출해야 데이터
			while(rs.next())
			{
				GuestbookDto dto = new GuestbookDto();
				dto.setSeq(rs.getString("seq"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setContents(rs.getString("contents"));
				dto.setWdate(rs.getString("wdate"));
				dto.setHit(rs.getString("hit"));
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
		public GuestbookDto getView(String seq) {
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			GuestbookDto dto = new GuestbookDto();
			
			try {
				conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
				stmt = conn.createStatement();
				
				String sql = "update tb_guestbook set hit=hit+1 where "
						+ "seq="+seq;
				System.out.println(sql); 
				stmt.execute(sql); // insert, update, delete시 호출 함수
				
				// 데이터 가져오기
				sql = "select * from tb_guestbook where seq="+seq;
				System.out.println(sql); 
				
				rs = stmt.executeQuery(sql);
				if(rs.next())
				{
					dto.setSeq(rs.getString("seq"));
					dto.setTitle(rs.getString("title"));
					dto.setWriter(rs.getString("writer"));
					dto.setContents(rs.getString("contents"));
					dto.setWdate(rs.getString("wdate"));
					dto.setHit(rs.getString("hit"));
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
		
		public void insert(GuestbookDto dto)
		{
			Connection conn = null;
			Statement stmt = null;
			try {
				// String클래스는 데이터 하나 추가될때마다 내부 메모리를 새로 잡아서 데이터 넣음
				StringBuffer buffer = new StringBuffer();
				buffer.append("insert into tb_guestbook( ");
				buffer.append(" seq, title, writer, contents ");
				buffer.append(" , wdate, hit ) ");
				buffer.append(" values (sq_guest.nextval, ");
				buffer.append(" '"+dto.getTitle()+"', ");
				buffer.append(" '"+dto.getWriter()+"', ");
				buffer.append(" '"+dto.getContents()+"', ");
				buffer.append(" sysdate, 0) ");
				System.out.println(buffer.toString());
				
				conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
				
				stmt = conn.createStatement();
				stmt.execute(buffer.toString());
				
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
		}
		
		public void update(GuestbookDto dto)
		{
			Connection conn = null;
			Statement stmt = null;
			try {
				// String클래스는 데이터 하나 추가될때마다 내부 메모리를 새로 잡아서 데이터 넣음
				StringBuffer buffer = new StringBuffer();
				buffer.append("update tb_guestbook set ");
				buffer.append(" title = '"+dto.getTitle()+"', ");
				buffer.append(" writer = '"+dto.getWriter()+"', ");
				buffer.append(" contents = '"+dto.getContents()+"' ");
				buffer.append(" where seq="+dto.getSeq());
				System.out.println(buffer.toString());
				
				conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
				
				stmt = conn.createStatement();
				stmt.execute(buffer.toString());
				
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
		}
		
}
