package com.kosa.mvc1.gallery;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kosa.mvc1.DBUtil;

public class GalleryDao {
	

	public GalleryDao() {
		// 예외처리 - jsp 안해도됨, java 반드시 해줘야함
		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public String getSearch(GalleryDto paramDto)
	{
		String searchText=" where 1=1 "; // 모든데이터
		if(paramDto.getSearchOpt().equals("1"))
			searchText += " and title like '%"+paramDto.getSearchKeyword()+ "%' ";
		else if(paramDto.getSearchOpt().equals("2"))
			searchText += " and contents like '%"+paramDto.getSearchKeyword()+ "%' ";
		else if(paramDto.getSearchOpt().equals("3"))
		{
			searchText += " and (title like '%"+paramDto.getSearchKeyword()+ "%' ";
			searchText += " or contents like '%"+paramDto.getSearchKeyword()+ "%' )";
		}
		
		return searchText;
	}
	
	
	public List<GalleryDto> getList(GalleryDto paramDto) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List<GalleryDto> list = new ArrayList<GalleryDto>();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			StringBuffer buffer = new StringBuffer();
			buffer.append("select A.seq, A.rnum, A.title, A.writer, A.user_name,");
			buffer.append("to_char(A.wdate, 'yyyy-mm-dd') wdate, A.hit, A.pg, A.image");
			buffer.append(" from ");
			buffer.append("( ");
			buffer.append("    select seq, title, writer, contents, hit, wdate, ");
			buffer.append(" B.user_name, A.image, ");
			buffer.append("   row_number() over(order by seq desc) as rnum, ");
			buffer.append("   ceil(row_number() over(order by seq desc)/12)-1 pg ");
			buffer.append("   from tb_gallery A ");
			buffer.append("   left outer join tb_member B  on A.writer=B.user_id ");
			buffer.append(getSearch(paramDto));
			buffer.append(" )A where pg="+paramDto.getPg());
			
			System.out.println(buffer.toString()); 
			
			rs = stmt.executeQuery(buffer.toString());
			
			while(rs.next())
			{
				GalleryDto dto = new GalleryDto();
				dto.setSeq(rs.getString("seq"));
				dto.setRnum(rs.getInt("rnum"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setImage(rs.getString("image"));
				dto.setUser_name(rs.getString("user_name"));
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
	
	public int getTotalCnt(GalleryDto paramDto) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int totalCnt = 0;
		List<GalleryDto> list = new ArrayList<GalleryDto>();
		
		try {
			conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
			stmt = conn.createStatement();
			
			StringBuffer buffer = new StringBuffer();
			buffer.append("select count(*) ");
			buffer.append("   from tb_gallery A ");
			buffer.append(getSearch(paramDto));
			
			System.out.println(buffer.toString()); 
			
			rs = stmt.executeQuery(buffer.toString());
			if(rs.next())
				totalCnt = rs.getInt(1);
			
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
		
		return totalCnt;
	}
	
		public GalleryDto getView(String seq) {
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			GalleryDto dto = new GalleryDto();
			
			try {
				conn = DriverManager.getConnection(DBUtil.URL, DBUtil.USERID, DBUtil.PWD);
				stmt = conn.createStatement();
				
				String sql = "update tb_gallery set hit=hit+1 where "
						+ "seq="+seq;
				System.out.println(sql); 
				stmt.execute(sql); // insert, update, delete시 호출 함수
				
				// 데이터 가져오기
				sql = "select A.seq, A.title, A.writer, A.contents, "
						+" A.wdate, A.hit, B.user_name, A.image"
						+ " from tb_gallery A "
						+ " left outer join tb_member B on A.writer=B.user_id "
						+ " where seq="+seq;
				// where조건절이 먼저 실행되고, 그 후에 조인 실행
				System.out.println(sql); 
				
				rs = stmt.executeQuery(sql);
				if(rs.next())
				{
					dto.setSeq(rs.getString("seq"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setTitle(rs.getString("title"));
					dto.setWriter(rs.getString("writer"));
					dto.setContents(rs.getString("contents"));
					dto.setImage(rs.getString("image"));
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
		
		public void insert(GalleryDto dto)
		 {
			 Connection conn=null;
			 Statement stmt = null;
			 try
			 {
				 //String클래스는 내부 메모리를 데이터 하나 추가될때마다 
				 //새로 잡아서 데이터넣고 
				 StringBuffer buffer = new StringBuffer();
				 buffer.append("insert into tb_gallery( ");
				 buffer.append("seq, title, writer, contents ");
				 buffer.append(" ,image , wdate, hit ) ");/////
				 buffer.append(" values ( sq_gallery.nextval,");/////
				 buffer.append(" '"+dto.getTitle()+"', ");
				 buffer.append(" '"+dto.getWriter()+"', ");
				 buffer.append(" '"+dto.getContents()+"', ");
				 buffer.append(" '"+dto.getImage()+"', ");//////
				 buffer.append(" sysdate, 0) ");
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
		
		public void update(GalleryDto dto)
		{
			Connection conn = null;
			Statement stmt = null;
			try {
				// String클래스는 데이터 하나 추가될때마다 내부 메모리를 새로 잡아서 데이터 넣음
				StringBuffer buffer = new StringBuffer();
				buffer.append("update tb_gallery set ");
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
