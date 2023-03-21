package com.kosa.mvc1.score;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kosa.mvc1.DBUtil;
import com.kosa.mvc1.guestbook.GuestbookDto;

public class ScoreDao {
	public ScoreDao() {
		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public List<ScoreDto> getList() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List<ScoreDto> list = new ArrayList<ScoreDto>();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			String sql = "select seq, name, kor, eng, mat "
					+ ", to_char(wdate, 'yyyy-mm-dd') wdate "
					+ " from tb_score ";
			
			// 디버깅용
			// 콘솔창에서 쿼리가 제대로 작동하는지 확인
			// 나중에는 log4j 라는 라이브러리를 연결해서 확인
			System.out.println(sql); 
			
			rs = stmt.executeQuery(sql);
			
			// 맨 앞에는 데이터가 아님. 한번 next호출해야 데이터
			while(rs.next())
			{
				ScoreDto dto = new ScoreDto();
				dto.setSeq(rs.getString("seq"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getString("kor"));
				dto.setEng(rs.getString("eng"));
				dto.setMat(rs.getString("mat"));
				dto.setWdate(rs.getString("wdate"));
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
	
	public ScoreDto getView(String seq) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ScoreDto dto = new ScoreDto();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			String sql = "select * from tb_score where seq="+seq;
			
			System.out.println(sql); 
			
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				dto.setSeq(rs.getString("seq"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getString("kor"));
				dto.setEng(rs.getString("eng"));
				dto.setMat(rs.getString("mat"));
				dto.setWdate(rs.getString("wdate"));
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
	
	public void insert(ScoreDto dto)
	{
		Connection conn = null;
		Statement stmt = null;
		try {
			// String클래스는 데이터 하나 추가될때마다 내부 메모리를 새로 잡아서 데이터 넣음
			StringBuffer buffer = new StringBuffer();
			buffer.append("insert into tb_score( ");
			buffer.append(" seq, name, kor, eng, mat");
			buffer.append(" , wdate) ");
			buffer.append(" values (sq_guest.nextval, ");
			buffer.append(" '"+dto.getName()+"', ");
			buffer.append(" '"+dto.getKor()+"', ");
			buffer.append(" '"+dto.getEng()+"', ");
			buffer.append(" '"+dto.getMat()+"', ");
			buffer.append(" sysdate) ");
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
	
	public void update(ScoreDto dto)
	{
		Connection conn = null;
		Statement stmt = null;
		try {
			// String클래스는 데이터 하나 추가될때마다 내부 메모리를 새로 잡아서 데이터 넣음
			StringBuffer buffer = new StringBuffer();
			buffer.append("update tb_score set ");
			buffer.append(" name = '"+dto.getName()+"', ");
			buffer.append(" kor = '"+dto.getKor()+"', ");
			buffer.append(" eng = '"+dto.getEng()+"' ");
			buffer.append(" mat = '"+dto.getMat()+"' ");
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
