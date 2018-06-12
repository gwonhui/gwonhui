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

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

import domain.MyBoard;
import domain.ReportBoard;


public class ReportBoardDao {
	
	private static ReportBoardDao instance = new ReportBoardDao();
	
	private ReportBoardDao() {
		
	}
	
	
	public static ReportBoardDao getInstance() {
		return instance;
	}


	// DB연결 메소드
	private Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	} // getConnection() 끝

	public int getBoardCount() {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			con = getConnection();
			// sql  전체글개수 가져오기  select count(*)
			sql = "select count(*) from reportb";
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
	public List<ReportBoard> getBoards(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		ResultSet rs = null;
		List<ReportBoard> list = new ArrayList<>();
		
		try {
			con = getConnection();
			// sql
			// select * from board order by re_ref desc, re_seq asc
			StringBuilder sb = new StringBuilder();
			sb.append("select * ");
			sb.append("from (select rownum as rnum, a.* ");
			sb.append("        from (select * from reportb order by num desc) a ");
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
				ReportBoard bean = new ReportBoard();
				// rs => 자바빈에 저장
				bean.setContent(rs.getString("content"));
				bean.setFilename(rs.getString("filename"));
				bean.setName(rs.getString("name"));
				bean.setNum(rs.getInt("num"));
				bean.setSubject(rs.getString("subject"));
				bean.setReason(rs.getString("reason"));
			
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
		
	public List<MyBoard> getReportBoards(int startRow, int endRow) {
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
			sb.append("        from (select * from reportb order by re_ref desc, re_seq asc) a ");
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
	} // getReportborads() 끝
	// 전체 글개수 가져오기 메소드
		public int getReportBCount() {
			Connection con = null;
			PreparedStatement pstmt = null;  // select용
			ResultSet rs = null;
			String sql = "";
			int count = 0;
			
			try {
				con = getConnection();
				// sql  전체글개수 가져오기  select count(*)
				sql = "select count(*) from reportb";
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
		} // getReportBCount() 끝
		public void insertReport(ReportBoard bean) {
			 Connection con = null;
			 PreparedStatement pstmt = null;  // select용
			 PreparedStatement pstmt2 = null; // insert용
			 ResultSet rs = null;
			 String sql = "";
			 
			 try {
				con = getConnection();
				// num구하기  글이없을경우 1
				//         글이있을경우 최근글번호(번호가 가장큰값)+1
				sql = "SELECT MAX(num) FROM reportb";
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
				
				// sql insert
				sql = "insert into reportb (num,name,passwd,subject,reason,filename,content,ip) "
						+ "values (?,?,?,?,?,?,?,?)";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.setInt(1, bean.getNum());
				pstmt2.setString(2, bean.getName());
				pstmt2.setString(3, bean.getPasswd());
				pstmt2.setString(4, bean.getSubject());
				pstmt2.setString(5, bean.getReason());
				pstmt2.setString(6, bean.getFilename());
				pstmt2.setString(7, bean.getContent());
				pstmt2.setString(8, bean.getIp());
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
		}//reportBoard() 끝.
		
		public ReportBoard getReport(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;  // select용
			ResultSet rs = null;
			String sql = "";
			ReportBoard bean = null;
			
			try {
				con = getConnection(); //DB연결
				// sql num에 해당하는 글정보 가져오기
				sql = "select * from reportb where num =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				// rs 결과 => 자바빈 객체 저장 
				if(rs.next()) {
					//자바빈 객체생성
					bean = new ReportBoard();
					//자바빈 rs결과 저장
					bean.setContent(rs.getString("content"));
					bean.setFilename(rs.getString("filename"));
					bean.setIp(rs.getString("ip"));
					bean.setName(rs.getString("name"));
					bean.setNum(rs.getInt("num"));
					bean.setSubject(rs.getString("subject"));
					bean.setReason(rs.getString("reason"));
					
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
		
		public void sendEmail(ReportBoard bean) {
			
			long beginTime = System.currentTimeMillis();
			
			// SimpleEmail 객체생성
			SimpleEmail simpleEmail = new SimpleEmail();
			// SMTP 서버 연결설정
			simpleEmail.setHostName("smtp.gmail.com");
			simpleEmail.setSmtpPort(587);
			simpleEmail.setAuthentication("admiadmi2222", "qawsedrf%"); //비밀번호
			
			// SMTP SSL, TLS 설정
			simpleEmail.setSSLOnConnect(true);
			simpleEmail.setStartTLSEnabled(true);		
			
			String rt = "fail";
			try {
				// 보내는사람 설정
				simpleEmail.setFrom("admiadmi2222@gmail.com", bean.getName(), "utf-8");
				// 받는사람 설정
				simpleEmail.addTo("admiadmi2222@gmail.com", "운영진", "utf-8");
				// 받는사람(참조인) 설정
//				simpleEmail.addCc(email, name, charset);
				// 받는사람(숨은참조인) 설정
//				simpleEmail.addBcc(email, name, charset);
				
				// 제목 설정
				simpleEmail.setSubject("신고합니다.");
				// 본문 설정
				simpleEmail.setMsg("신고자 : "+ bean.getName() +  "\n 신고이유 : "+ bean.getReason()+
						"\n 제목 : "+bean.getSubject()+ "\n 내용 : " + bean.getContent());
				// 메일 전송
				rt = simpleEmail.send();
				
			} catch (EmailException e) {
				e.printStackTrace();
			} finally {
				long execTime = System.currentTimeMillis() - beginTime;
				System.out.println("execTime : " + execTime);
				System.out.println("rt : " + rt);
			}
			
		}//sendEmail() 끝
		
		
} // BoardDao 클래스 끝







