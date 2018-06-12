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

import domain.My_Member;

public class My_MemberDao {
	// DB연결 메소드
	private static My_MemberDao instance = new My_MemberDao();
	
	private My_MemberDao() {
		
	}
	
	
	public static My_MemberDao getInstance() {
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
	
	public void insertMember(My_Member bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			// 드라이버 로딩. DB연결
			con = getConnection();
			sql = "INSERT INTO my_member (id,passwd,name,reg_date,gender,email,address,tel,mtel) VALUES (?,?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPasswd());
			pstmt.setString(3, bean.getName());
			pstmt.setTimestamp(4, bean.getReg_date());
			pstmt.setString(5, bean.getGender());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getAddress());
			pstmt.setString(8, bean.getTel());
			pstmt.setString(9, bean.getMtel());
			// 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
	} // insertMember() 끝
	
	// 로그인 사용자 체크 메소드
	public int userCheck(String id, String passwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int check = -1;
		// 아이디 불일치: -1
		// 아이디 일치, 패스워드 불일치: 0
		// 아이디 패스워드 모두 일치: 1
		
		sql = "select passwd from my_member where id=?";
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 실행
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				// 아이디 있음
				if (passwd.equals(rs.getString("passwd"))) {
					check = 1;
				} else {
					check = 0;
				}
			} else {
				check = -1;
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
		return check;
	} // userCheck()의 끝
	
	
	public My_Member getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		My_Member bean = null;
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select * from my_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 실행
			rs = pstmt.executeQuery();
			// rs => 변수저장
			if (rs.next()) {
				bean = new My_Member();
				bean.setId(rs.getString("id"));
				bean.setPasswd(rs.getString("passwd"));
				bean.setName(rs.getString("name"));
				bean.setReg_date(rs.getTimestamp("reg_date"));
				bean.setAge(rs.getInt("age"));
				bean.setGender(rs.getString("gender"));
				bean.setEmail(rs.getString("email"));
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
		return bean;
	} // getMember()의 끝
	
	
	public int updateMember(My_Member bean) {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		PreparedStatement pstmt2 = null; // update용
		ResultSet rs = null;
		String sql = "";
		int check = 0;
		
		try {
			con = getConnection();
			
			sql = "select passwd from my_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			// 실행
			rs = pstmt.executeQuery();
			// rs 데이터 있으면 아이디 있음
			//              패스워드비교 맞으면 update  main.jsp이동
			//                        틀리면 "패스워드틀림" 뒤로이동
			if (rs.next()) {
				// 아이디 있음
				if (bean.getPasswd().equals(rs.getString("passwd"))) {
					// update   main.jsp이동
					sql = "update my_member set name=?, age=?, gender=?, email=? where id=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, bean.getName());
					pstmt2.setInt(2, bean.getAge());
					pstmt2.setString(3, bean.getGender());
					pstmt2.setString(4, bean.getEmail());
					pstmt2.setString(5, bean.getId());
					// 실행
					pstmt2.executeUpdate();
					
					check = 1; // 패스워드 일치해서 수정성공
				} else {
					check = 0; // 패스워드 불일치
				}
			}
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
		return check;
	} // updateMember()의 끝
	
	
	public int deleteMember(String id, String passwd) {
		Connection con = null;
		PreparedStatement pstmt = null;  // select용
		PreparedStatement pstmt2 = null; // delete용
		ResultSet rs = null;
		String sql = "";
		int check = 0;
		
		try {
			con = this.getConnection();
			
			sql = "select passwd from my_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 실행
			rs = pstmt.executeQuery();
			// rs 데이터 있으면 아이디 있음
			//              패스워드비교 맞으면 update  main.jsp이동
			//                        틀리면 "패스워드틀림" 뒤로이동
			if (rs.next()) {
				// 아이디 있음
				if (passwd.equals(rs.getString("passwd"))) {
					// delete
					sql = "delete from my_member where id=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, id);
					// 실행
					pstmt2.executeUpdate();
					
					check = 1; // 패스워드 일치. 삭제성공.
				} else {
					check = 0; // 패스워드 불일치
				}
			}
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
		return check;
	} // deleteMember()의 끝
	
	public void deleteMembers(String[] ids) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = this.getConnection();
			
			sql = "delete from my_member where id=?";
			pstmt = con.prepareStatement(sql);
			for (int i=0; i<ids.length; i++) {
				pstmt.setString(1, ids[i]);
				pstmt.addBatch();
				pstmt.clearParameters();
			}
			pstmt.executeBatch();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
	} // deleteMember()의 끝
	
	public List<My_Member> getMembers() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<My_Member> list = new ArrayList<>();
		
		try {
			con = getConnection();
			
			sql = "select * from my_member order by reg_date desc";
			pstmt = con.prepareStatement(sql);
			// 실행
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				My_Member bean = new My_Member();
				bean.setId(rs.getString("id"));
				bean.setPasswd(rs.getString("passwd"));
				bean.setName(rs.getString("name"));
				bean.setReg_date(rs.getTimestamp("reg_date"));
				bean.setAge(rs.getInt("age"));
				bean.setGender(rs.getString("gender"));
				bean.setEmail(rs.getString("email"));
				
				list.add(bean); // 리스트에 추가
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
	} // getMembers()의 끝
	
	public int idCheck(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		int rowCount = 0;
		
		try {
			con =getConnection();
			//select id에 해당하는 데이터가져오기.
			sql = "select count(*) from my_member where id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rowCount = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
		return rowCount;
	}//idCheck()끝
	
	public int countFemale() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		int female= 0;
		try {
			con = getConnection();
			sql = "select count(*) from my_member where gender = '여'" ;
					
			pstmt = con.prepareStatement(sql);
			rs =pstmt.executeQuery();  //0 
			if(rs.next()) {
				female = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
		return female;
	}//countFemale의끝
	public int countMale() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		int male =0;
		try {
			con = getConnection();
			sql = "select count(*) from my_member where gender = '남'";
					
			pstmt = con.prepareStatement(sql);
			rs =pstmt.executeQuery();  //0 
			if(rs.next()) {
				male = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
		return male;
	}//countMale의끝
	
	
	public int getListCount(String search) {
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
	} // getListCount() 끝
	
} // MyMemberDao 클래스 끝

