package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import domain.Comment;

public class CommentDao {
	
	private static CommentDao instance = new CommentDao();
	
	private CommentDao() {
		
	}
	
	public static CommentDao getInstance() {
		return instance;
	}


	private Connection getConnection() throws Exception {
		Connection con = null;
		
		// DB 연결에 필요한 정보
//		String url = "jdbc:oracle:thin:@127.0.0.1:1521:testDB";
//		String user = "scott";
//		String password = "1234";
		// 드라이버 로딩
//		Class.forName("oracle.jdbc.driver.OracleDriver");
		// 연결
//		con = DriverManager.getConnection(url, user, password);
		
		
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/oracle");
		con = ds.getConnection();
		return con;
	} // getConnection() 끝
	//댓글 등록
	public void insertCommend(Comment bean) {
		 Connection con = null;
		 PreparedStatement pstmt = null;  // select용
		 PreparedStatement pstmt2 = null; // insert용
		 ResultSet rs = null;
		 String sql = "";
		 
		 try {
			con = getConnection();
			// num구하기  글이없을경우 1
			//         글이있을경우 최근글번호(번호가 가장큰값)+1
			sql = "SELECT MAX(comment_num) FROM ex_reply";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			// 실행
			if (rs.next()) {
				// 글이 있는경우  최대값+1
				int num = rs.getInt(1) + 1;
				bean.setComment_num(num);
			} else {
				bean.setComment_num(1); // 글이 없는경우 글번호 1
			}
			
			
			// sql insert
			sql = "insert into ex_reply (Comment_num, comment_id, comment_content, comment_date, comment_board,comment_parent,comment_level) "
					+ " values (?,?,?,?,?,?,?)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, bean.getComment_num());
			pstmt2.setString(2, bean.getComment_id());
			pstmt2.setString(3, bean.getComment_content());
			pstmt2.setTimestamp(4, bean.getComment_date());
			pstmt2.setInt(5, bean.getComment_board());
			pstmt2.setInt(6, bean.getComment_parent());
			pstmt2.setInt(7, bean.getComment_level());
			
			// 실행
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {}
			}
			if (pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (SQLException e) {}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {}
			}
		}
	} // insertBoard() 끝
			
	
    // 댓글 목록 가져오기
    public ArrayList<Comment> getCommentList(int boardNum){
    	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
    	ArrayList<Comment> list = new ArrayList<Comment>();
        
        try {
            conn = getConnection();
            
            StringBuffer sql = new StringBuffer();
            sql.append("    SELECT LEVEL, COMMENT_NUM, COMMENT_BOARD,");
            sql.append("            COMMENT_ID, COMMENT_DATE,");
            sql.append("            COMMENT_PARENT, COMMENT_CONTENT");
            sql.append("    FROM BOARD_COMMENT");
            sql.append("    WHERE COMMENT_BOARD = ?");
            sql.append("    START WITH COMMENT_PARENT = 0");
            sql.append("    CONNECT BY PRIOR COMMENT_NUM = COMMENT_PARENT");         
            
            pstmt = conn.prepareStatement(sql.toString());
            pstmt.setInt(1, boardNum);
            
            rs = pstmt.executeQuery();
            while(rs.next())
            {
                Comment comment = new Comment();
                comment.setComment_level(rs.getInt("LEVEL"));
                comment.setComment_num(rs.getInt("COMMENT_NUM"));
                comment.setComment_board(rs.getInt("COMMENT_BOARD"));
                comment.setComment_id(rs.getString("COMMENT_ID"));
                comment.setComment_date(rs.getTimestamp("comment_date"));
                comment.setComment_parent(rs.getInt("COMMENT_PARENT"));
                comment.setComment_content(rs.getString("COMMENT_CONTENT"));
                list.add(comment);
            }
                
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {}
			}
		}
        
        return list;
    } // end getCommentList
    public List<Comment> getCommend(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		ResultSet rs = null;
		List<Comment> list = new ArrayList<>();
		
		try {
			con = getConnection();
			// sql
			// select * from board order by re_ref desc, re_seq asc
			StringBuilder sb = new StringBuilder();
			sb.append("select * ");
			sb.append("from (select rownum as rnum, a.* ");
			sb.append("        from (select * from ex_reply order by Comment_num ) a ");
			sb.append("       where rownum <= ? ");
			sb.append("        ) a ");
			sb.append("where rnum >= ? ");
			
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, startRow);
			// 실행
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// 자바빈 객체생성
				Comment bean = new Comment();
				// rs => 자바빈에 저장
				bean.setComment_num(rs.getInt("comment_num"));
				bean.setComment_board(rs.getInt("comment_board"));
				bean.setComment_id(rs.getString("comment_id"));
				bean.setComment_date(rs.getTimestamp("comment_date"));
				bean.setComment_content(rs.getString("comment_content"));
				bean.setComment_level(rs.getInt("comment_level"));
				// 자바빈 => list 에 추가
				list.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {}
			}
		}
		return list;
	} // getBoards() 끝
 // 전체 글개수 가져오기 메소드
 	public int getCommendCount() {
 		Connection con = null;
 		PreparedStatement pstmt = null;  // select용
 		ResultSet rs = null;
 		String sql = "";
 		int count = 0;
 		
 		try {
 			con = getConnection();
 			// sql  전체글개수 가져오기  select count(*)
 			sql = "select count(*) from ex_reply";
 			pstmt = con.prepareStatement(sql);
 			// 실행
 			rs = pstmt.executeQuery();
 			// rs 데이터 있으면 count 저장
 			if (rs.next()) {
 				count = rs.getInt(1);
 			}
 		} catch (Exception e) {
 			e.printStackTrace();
 		} finally {
 			if (rs != null) {
 				try {
 					rs.close();
 				} catch (SQLException e) {}
 			}
 			if (pstmt != null) {
 				try {
 					pstmt.close();
 				} catch (SQLException e) {}
 			}
 			if (con != null) {
 				try {
 					con.close();
 				} catch (SQLException e) {}
 			}
 		}
 		return count;
 	} // getBoardCount() 끝
 	
 	
	

}