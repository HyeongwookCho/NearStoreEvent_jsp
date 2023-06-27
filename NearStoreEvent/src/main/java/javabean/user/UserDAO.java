package javabean.user;

import java.sql.*; 
import java.util.*; 
import javax.sql.*;

import javax.naming.*; 

public class UserDAO {
	// 데이터베이스 연결 관련 객체 선언
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private DataSource ds = null;

	// JDBC 드라이버 로딩
	public UserDAO() {
		try {
			InitialContext ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	
	// 데이터베이스 연결
	public void connect() {
		try {
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 데이터베이스 연결 해제
	public void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	//유저정보 전체 조회
	public ArrayList<UserEntity> getUserList(){
		connect();
		ArrayList<UserEntity> list = new ArrayList<UserEntity>();
		
		String SQL = "select * from user";
		
		try {
			pstmt = con.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				UserEntity usr = new UserEntity();
				usr.setUser_id(rs.getInt("user_id"));
				usr.setId(rs.getString("id"));
				usr.setPassword(rs.getString("password"));
				usr.setName(rs.getString("name"));
				usr.setNickname(rs.getString("Nickname"));
				usr.setEmail(rs.getString("email"));
				usr.setCreated_at(rs.getString("created_at"));
				list.add(usr);
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return list;
	}
	
	//특정 유저 정보 조회
	public UserEntity getUser(int user_id) {
		connect();
		String SQL = "select * from user where user_id = ?";
		UserEntity usr = new UserEntity();
		
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, user_id);
			ResultSet rs = pstmt.executeQuery();			
			rs.next();
			usr.setUser_id(rs.getInt("user_id"));
			usr.setId(rs.getString("id"));
			usr.setPassword(rs.getString("password"));
			usr.setName(rs.getString("name"));
			usr.setNickname(rs.getString("nickname"));
			usr.setEmail(rs.getString("email"));
			usr.setCreated_at(rs.getString("created_at"));
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally {
			disconnect();
		}
		return usr;
	}
	
	
	// 유저 정보 삽입 ( 회원 가입 )
	public boolean insertDB(UserEntity user) {
		boolean success = false;
		connect();
		String sql = "INSERT INTO user (id, password, name, nickname, email) VALUES (?, ?, ?, ?, ?)";
		
		try {
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getNickname());
			pstmt.setString(5, user.getEmail());
			pstmt.executeUpdate();
			success = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		}
		finally {
			disconnect();
		}
		return success;
	}
	
	public int getUserId(String id) {
		int user_id = -1;
		ResultSet rs = null;
		 
	    try {
	    	connect();
	        pstmt = con.prepareStatement("SELECT user_id FROM user WHERE id = ?");
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            user_id = rs.getInt("user_id");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        disconnect();
	    }

	    return user_id;
	}
	
	//user의 id 중복 확인 
	public boolean isIdExists(String id) {
        connect();
        ResultSet rs = null;
        boolean isIdExists = false;

        try {
            String sql = "SELECT COUNT(*) FROM user WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
			
            if (rs.next()) {
                int count = rs.getInt(1);
                if(count > 0) {
                    isIdExists = true ;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
            if (con != null) try { con.close(); } catch (SQLException ex) {}
        }
        return isIdExists;
    }
	
	
	// 유저 정보 수정
		public boolean updateDB(UserEntity user) {
			boolean success = false; 
			connect();		
			String sql ="update user set id =?, password = ?, name=?, nickname=?, email=? where user_id=?";	
			try {
				pstmt = con.prepareStatement(sql);
				// 수정할 게시물의 정보를 SQL 쿼리에 삽입
				pstmt.setString(1, user.getId());
				pstmt.setString(2, user.getPassword());
				pstmt.setString(3, user.getName());
				pstmt.setString(4, user.getNickname());
				pstmt.setString(5, user.getEmail());
				pstmt.setInt(6, user.getUser_id());
				int rowUdt = pstmt.executeUpdate();
				//System.out.println(rowUdt);
				if (rowUdt == 1) success = true;
			} catch (SQLException e) {
				e.printStackTrace();
				return success;
			}
			finally {
				disconnect();
			}
			return success;
		}
	
	
	//user 정보 삭제
	public boolean deleteDB(int user_id) {
		boolean success = false; 
		connect();		
		String sql ="delete from user where user_id=?";
		try {
			pstmt = con.prepareStatement(sql);
			// 삭제할 유저 정보의 인조키인 user_id를 SQL 쿼리에 삽입
			pstmt.setInt(1, user_id);
			pstmt.executeUpdate();
			success = true;
		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		}
		finally {
			disconnect();
		}
		return success;
	}
	
	
	//Login 정보 확인
	public boolean isRightUser(UserEntity usr) {
		boolean success = false;
		connect();
		String sql = "select id from user where id = ? and password = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usr.getId());
			pstmt.setString(2, usr.getPassword());
			ResultSet rs = pstmt.executeQuery();
	        
	        while (rs.next()) { // 결과셋에 데이터가 있다면 success를 true로 변경
	            success = true;
	        }
		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		}
		finally {
			disconnect();
		}
		return success;
	}
	
	
	
}
