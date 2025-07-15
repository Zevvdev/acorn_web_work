package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import test.dto.MusicDto;
import test.util.DbcpBean;

public class MusicDao {

	// 곡 정보 조회
	public MusicDto getbyNum(int num) {
		MusicDto dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();

			String sql = """
					SELECT title, artist, genre
					FROM music
					WHERE num=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ?값 바인딩
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto = new MusicDto();
				dto.setNum(num);
				dto.setTitle(rs.getString("title"));
				dto.setArtist(rs.getString("artist"));
				dto.setGenre(rs.getString("genre"));
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
			} catch (Exception e2) {
			}
		}
		return dto;
	}

	// List로 return
	public List<MusicDto> selectAll() {
		List<MusicDto> list = new ArrayList<MusicDto>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT num, title, artist, genre
					FROM music
					ORDER BY title ASC
					""";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MusicDto dto = new MusicDto();
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setArtist(rs.getString("artist"));
				dto.setGenre(rs.getString("genre"));

				list.add(dto);
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
			} catch (Exception e2) {
			}
		}
		return list;
	}

	// 추가
	public boolean insert(MusicDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					INSERT INTO music
					(num, title, artist, genre)
					VALUES(music_seq.NEXTVAL, ?, ?, ?)
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getArtist());
			pstmt.setString(3, dto.getGenre());

			rowCount = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}

	}

	// 수정
	public boolean update(MusicDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		int rowCount = 0;

		try {
			conn = new DbcpBean().getConn();
			String sql = """
					UPDATE music
					SET title=?, artist=?, genre=?
					WHERE num=?
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getArtist());
			pstmt.setString(3, dto.getGenre());
			pstmt.setInt(4, dto.getNum());

			rowCount = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}

	}

	// 삭제
	public boolean delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					DELETE FROM music
					WHERE num=?
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			rowCount = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}

	}

}
