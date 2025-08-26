package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.PostDto;
import test.util.DbcpBean;

public class PostDao {
	// 자신의 참조값을 저장할 static 필드
	private static PostDao dao;
	// static 초기화 블럭에서 객체 생성해서 static 필드에 저장
	static {
		dao=new PostDao();
	}
	// 외부에서 객체 생성 못하도록.
	private PostDao() {}
	// 참조값 리턴해주는 static 메소드
	public static PostDao getInstance() {
		return dao;
	}
	
	//게시글 리스트
	public List<PostDto> selectAll(){
		//list 객체
		List<PostDto> list=new ArrayList<>();
		//필요한 객체를 담을 지역변수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문
			String sql = """
						
					""";
			pstmt = conn.prepareStatement(sql);
			//? 에 값 바인딩

			// select 문 실행하고 결과를 ResultSet 으로 받아온다
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 에 담긴 데이터를 추출해서 리턴해줄 객체에 담는다
			while (rs.next()) {

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return list;
	}
	
	// 게시글 정보 리턴
	// 유저 데이터랑 INNER JOIN 해야함
	public PostDto getByPostNum(int num) {
		PostDto dto=null;
		//필요한 객체를 담을 지역변수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문
			String sql = """
					SELECT *
					FROM posts
					WHERE num=?

					""";
			pstmt = conn.prepareStatement(sql);
			//? 에 값 바인딩
			pstmt.setInt(1, num);
			// select 문 실행하고 결과를 ResultSet 으로 받아온다
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 에 담긴 데이터를 추출해서 리턴해줄 객체에 담는다
			if (rs.next()) {
				dto=new PostDto();
				dto.setPost_num(num);
				dto.setPost_writer_num(rs.getInt("post_writer_num"));
				dto.setPost_title(rs.getString("post_title"));
				dto.setPost_content(rs.getString("post_content"));
				dto.setPost_stay_num(rs.getInt("post_stay_num"));
				dto.setPost_type(rs.getInt("post_type"));
				dto.setPost_views(rs.getInt("post_views"));
				dto.setPost_created_at(rs.getString("post_created_at"));
				dto.setPost_updated_at(rs.getString("post_updated_at"));
				dto.setPost_deleted(rs.getString("post_deleted"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return dto;
	}
	
	// 게시글 저장
	public boolean insert(PostDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		//변화된 row 의 갯수를 담을 변수 선언하고 0으로 초기화
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					INSERT INTO posts
					(post_num, post_writer_num, post_title, post_content, post_stay_num)
					VALUES(?, ?, ?, ?, ?)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 순서대로 필요한 값 바인딩
			pstmt.setInt(1, dto.getPost_num());
			pstmt.setInt(2, dto.getPost_writer_num());
			pstmt.setString(3, dto.getPost_title());
			pstmt.setString(4, dto.getPost_content());
			pstmt.setInt(5, dto.getPost_stay_num());
			// sql 문 실행하고 변화된(추가된, 수정된, 삭제된) row 의 갯수 리턴받기
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		
		}

		//변화된 rowCount 값을 조사해서 작업의 성공 여부를 알아 낼수 있다.
		if (rowCount > 0) {
			return true; //작업 성공이라는 의미에서 true 리턴하기
		} else {
			return false; //작업 실패라는 의미에서 false 리턴하기
		}
	}
	
	
	
}



