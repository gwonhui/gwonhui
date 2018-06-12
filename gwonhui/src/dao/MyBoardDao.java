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

import domain.MyBoard;




public class MyBoardDao {
	
	private static MyBoardDao instance = new MyBoardDao();
	
	private MyBoardDao() {
		
	}
	
	
	public static MyBoardDao getInstance() {
		return instance;
	}



	// DB연결 메소드
	private Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	} // getConnection() 끝

	public void insertBoard(MyBoard bean) {
		 Connection con = null;
		 PreparedStatement pstmt = null;  // select용
		 PreparedStatement pstmt2 = null; // insert용
		 ResultSet rs = null;
		 String sql = "";
		 
		 try {
			con = getConnection();
			// num구하기  글이없을경우 1
			//         글이있을경우 최근글번호(번호가 가장큰값)+1
			sql = "SELECT MAX(num) FROM Myboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			// 실행
			if (rs.next()) {
				// 글이 있는경우  최대값+1
				int num = rs.getInt(1) + 1;
				bean.setNum(num);
			} else {
				bean.setNum(1); // 글이 없는경우 글번호 1
			}
			
			// 주글(일반글)  글번호==re_ref 같게
			bean.setRe_ref(bean.getNum());
			bean.setRe_lev(0); // 주글의 들여쓰기 레벨
			bean.setRe_seq(0); // 같은글그룹에서 순서
			
			// sql insert
			sql = "insert into myboard (num,name,passwd,subject,content,filename,re_ref,re_lev,re_seq,readcount,reg_date,ip) "
					+ "values (?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, bean.getNum());
			pstmt2.setString(2, bean.getName());
			pstmt2.setString(3, bean.getPasswd());
			pstmt2.setString(4, bean.getSubject());
			pstmt2.setString(5, bean.getContent());
			pstmt2.setString(6, bean.getFilename());
			pstmt2.setInt(7, bean.getRe_ref());
			pstmt2.setInt(8, bean.getRe_lev());
			pstmt2.setInt(9, bean.getRe_seq());
			pstmt2.setInt(10, bean.getReadcount());
			pstmt2.setTimestamp(11, bean.getReg_date());
			pstmt2.setString(12, bean.getIp());
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
	
	
	public List<MyBoard> getBoards(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		ResultSet rs = null;
		List<MyBoard> list = new ArrayList<>();
		
		try {
			con = getConnection();
			// sql
			// select * from board order by re_ref desc, re_seq asc
			StringBuilder sb = new StringBuilder();
			sb.append("select * ");
			sb.append("from (select rownum as rnum, a.* ");
			sb.append("        from (select * from myboard order by re_ref desc, re_seq asc) a ");
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
				MyBoard bean = new MyBoard();
				// rs => 자바빈에 저장
				bean.setContent(rs.getString("content"));
				bean.setReg_date(rs.getTimestamp("reg_date"));
				bean.setFilename(rs.getString("filename"));
				bean.setIp(rs.getString("ip"));
				bean.setName(rs.getString("name"));
				bean.setNum(rs.getInt("num"));
				bean.setPasswd(rs.getString("passwd"));
				bean.setRe_ref(rs.getInt("re_ref"));
				bean.setRe_lev(rs.getInt("re_lev"));
				bean.setRe_seq(rs.getInt("re_seq"));
				bean.setReadcount(rs.getInt("readcount"));
				bean.setSubject(rs.getString("subject"));
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
	
	public List<MyBoard> getBoards(int startRow, int endRow, String search) {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		ResultSet rs = null;
		List<MyBoard> list = new ArrayList<>();
		
		try {
			con = getConnection();
			// sql
			// select * from board order by re_ref desc, re_seq asc
			StringBuilder sb = new StringBuilder();
			sb.append(" select * ");
			sb.append(" from (select rownum as rnum, a.* ");
			sb.append("        from (select * from myboard  where subject like ? order by re_ref desc, re_seq asc) a ");
			sb.append("       where rownum <= ? ");
			sb.append("        ) a ");
			sb.append(" where rnum >= ? ");
			
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, endRow);
			pstmt.setInt(3, startRow);
			// 실행
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// 자바빈 객체생성
				MyBoard bean = new MyBoard();
				// rs => 자바빈에 저장
				bean.setContent(rs.getString("content"));
				bean.setReg_date(rs.getTimestamp("reg_date"));
				bean.setFilename(rs.getString("filename"));
				bean.setIp(rs.getString("ip"));
				bean.setName(rs.getString("name"));
				bean.setNum(rs.getInt("num"));
				bean.setPasswd(rs.getString("passwd"));
				bean.setRe_ref(rs.getInt("re_ref"));
				bean.setRe_lev(rs.getInt("re_lev"));
				bean.setRe_seq(rs.getInt("re_seq"));
				bean.setReadcount(rs.getInt("readcount"));
				bean.setSubject(rs.getString("subject"));
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
	public int getBoardCount() {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			con = getConnection();
			// sql  전체글개수 가져오기  select count(*)
			sql = "select count(*) from myboard";
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
	
	// 검색 글개수 가져오기 메소드
		public int getBoardCount(String search) {
			Connection con = null;
			PreparedStatement pstmt = null;  // select용
			ResultSet rs = null;
			String sql = "";
			int count = 0;
			
			try {
				con = getConnection();
				// sql  전체글개수 가져오기  select count(*)
				sql = "select count(*) from myboard where subject like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
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
		
	//조회수 1증가 메소드
	public void updateReadcount(int num){
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		String sql = "";
		try {
			con = getConnection();
			//sql update num에 해당하는 readcount 1증가하게 수정
			sql = "update myboard set readcount=readcount+1 where num =? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
		
	}//updateReadcount끝.
	
	//선택한 글1개 가져오는 메소드
	public MyBoard getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		ResultSet rs = null;
		String sql = "";
		MyBoard bean = null;
		
		try {
			con = getConnection(); //DB연결
			// sql num에 해당하는 글정보 가져오기
			sql = "select * from myboard where num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			// rs 결과 => 자바빈 객체 저장 
			if(rs.next()) {
				//자바빈 객체생성
				bean = new MyBoard();
				//자바빈 rs결과 저장
				bean.setContent(rs.getString("content"));
				bean.setReg_date(rs.getTimestamp("reg_date"));
				bean.setFilename(rs.getString("filename"));
				bean.setIp(rs.getString("ip"));
				bean.setName(rs.getString("name"));
				bean.setNum(rs.getInt("num"));
				bean.setPasswd(rs.getString("passwd"));
				bean.setRe_ref(rs.getInt("re_ref"));
				bean.setRe_lev(rs.getInt("re_lev"));
				bean.setRe_seq(rs.getInt("re_seq"));
				bean.setReadcount(rs.getInt("readcount"));
				bean.setSubject(rs.getString("subject"));
				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {}
			}
		}
		
		return bean;
	}//getBoard()의 끝
	
	public int updateBoard(MyBoard bean) {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		PreparedStatement pstmt2 = null; // update용
		ResultSet rs = null;
		String sql = "";
		int check =0;
		
		try {
			con =getConnection();
			sql = "select passwd from myboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			//실행
			rs = pstmt.executeQuery();
			//rs 데이터있으면 패스워드 비교 맞으면 수정완료 check ==1
			// update num에 해당하는 name,subject,content 수정
			//		 		패스워드 비교 틀리면 check == 0 
			if (rs.next()) {
				if (bean.getPasswd().equals(rs.getString("passwd"))) {
					sql = "update myboard set name=?, subject=?, content=?, filename=? where num=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, bean.getName());
					pstmt2.setString(2, bean.getSubject());
					pstmt2.setString(3, bean.getContent());
					pstmt2.setString(4, bean.getFilename());
					pstmt2.setInt(5, bean.getNum());
					// 실행
					pstmt2.executeUpdate();
					check = 1;
				}else {
					check = 0;
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
		
		return check;
	}//updateBoard끝.
	// 테이블 글삭제 메소드
		public int deleteBoard(int num, String passwd) {
			Connection con = null;
			PreparedStatement pstmt = null;  // SELECT용
			PreparedStatement pstmt2 = null; // DELETE용
			ResultSet rs = null;
			String sql = "";
			int check = 0;
			
			try { // DB연결
				con = getConnection();
				// num에 해당하는 passwd 가져오기
				sql = "SELECT passwd FROM myboard WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				// 실행
				rs = pstmt.executeQuery();
				// rs 데이터 있으면 패스워드비교 맞으면 check=1  글삭제
				//             패스워드비교 틀리면 check=0
				if (rs.next()) {
					if (passwd.equals(rs.getString("passwd"))) {
						sql = "DELETE FROM myboard WHERE num=?";
						pstmt2 = con.prepareStatement(sql);
						pstmt2.setInt(1, num);
						// 실행
						pstmt2.executeUpdate();
						
						check = 1;
					} else {
						check = 0;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return check;
		} // deleteBoard() 끝
		
		public int deleteBoard(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;  // SELECT용
			PreparedStatement pstmt2 = null; // DELETE용
			ResultSet rs = null;
			String sql = "";
			int check = 0;
			
			try { // DB연결
				con = getConnection();
				// num에 해당하는 passwd 가져오기
				sql = "SELECT passwd FROM myboard WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				// 실행
				rs = pstmt.executeQuery();
				// rs 데이터 있으면 패스워드비교 맞으면 check=1  글삭제
				//             패스워드비교 틀리면 check=0
				if (rs.next()) {
						sql = "DELETE FROM myboard WHERE num=?";
						pstmt2 = con.prepareStatement(sql);
						pstmt2.setInt(1, num);
						// 실행
						pstmt2.executeUpdate();
						
						check = 1;
					} 
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return check;
		} // deleteBoard() 끝
	// 답글 쓰기 메소드
	public void reInsertBoard(MyBoard bean) {
		Connection con = null;
		PreparedStatement pstmt = null;  // UPDATE용
		PreparedStatement pstmt2 = null; // SELECT용
		PreparedStatement pstmt3 = null; // INSERT용
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			// Connection 타입 객체의 기본 commit 속성은 Auto자동임.
			con.setAutoCommit(false);
			
			// 같은그룹내에서 기존답변글 순서 재배치. update re_seq
			sql = "UPDATE myboard SET re_seq=re_seq+1 WHERE re_ref=? AND re_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getRe_ref());
			pstmt.setInt(2, bean.getRe_seq());
			pstmt.executeUpdate(); // 실행
			
			// 글번호 만들기
			sql = "SELECT MAX(num) FROM myboard";
			pstmt2 = con.prepareStatement(sql);
			rs = pstmt2.executeQuery(); // 실행
			
			if (rs.next()) {
				int num = rs.getInt(1) + 1;
				bean.setNum(num); // 만든 글번호를 자바빈에 저장
			}
			
			// 답글 insert
			sql = "insert into myboard (num,name,passwd,subject,content,filename,re_ref,re_lev,re_seq,readcount,reg_date,ip) "
					+ "values (?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt3 = con.prepareStatement(sql);
			pstmt3.setInt(1, bean.getNum());
			pstmt3.setString(2, bean.getName());
			pstmt3.setString(3, bean.getPasswd());
			pstmt3.setString(4, bean.getSubject());
			pstmt3.setString(5, bean.getContent());
			pstmt3.setString(6, bean.getFilename());
			pstmt3.setInt(7, bean.getRe_ref());  // re_ref 같은그룹
			pstmt3.setInt(8, bean.getRe_lev() + 1);  // re_lev 들여쓰기 + 1
			pstmt3.setInt(9, bean.getRe_seq() + 1);  // re_seq 그룹내순서  + 1
			pstmt3.setInt(10, bean.getReadcount());  // 조회수 0
			pstmt3.setTimestamp(11, bean.getReg_date());
			pstmt3.setString(12, bean.getIp());
			// 실행
			pstmt3.executeUpdate();
			
			con.commit();
			// 트랜잭션(테이블 상태변경하는 여러개의 쿼리를 하나의 작업단위로 취급하는) 처리
			
			// 커넥션을 원래 상태인 자동커밋하도록 복구시킴
			con.setAutoCommit(true);
		} catch (Exception e) {
			e.printStackTrace();
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {}
			}
			if (pstmt3 != null) {
				try {
					pstmt3.close();
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
	} // reInsertBoard() 끝
		
} // BoardDao 클래스 끝







