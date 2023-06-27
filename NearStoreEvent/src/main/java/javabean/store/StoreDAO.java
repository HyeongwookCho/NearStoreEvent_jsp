package javabean.store;

import java.sql.*; 
import java.util.*; 
import javax.sql.*;

import javabean.user.UserEntity;

import javax.naming.*;

public class StoreDAO {
	// 데이터베이스 연결 관련 객체 선언
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private DataSource ds = null;

	// JDBC 드라이버 로딩
	public StoreDAO() {
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
	//가게 정보 전체 조회
	public ArrayList<StoreEntity> getStoreList(){
		connect();
		ArrayList<StoreEntity> list = new ArrayList<StoreEntity>();
		
		String SQL = "select * from store";
		
		try {
			pstmt = con.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				StoreEntity str = new StoreEntity();
				str.setStore_id(rs.getInt("store_id"));
				str.setName(rs.getString("name"));
				str.setNumber(rs.getString("number"));
				str.setLocation(rs.getString("location"));
				str.setCategory(rs.getString("category"));
				str.setReg_num(rs.getString("reg_num"));
				str.setCreated_at(rs.getString("created_at"));
				list.add(str);
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return list;
	}
	
	//특정 가게 정보 조회
		public StoreEntity getStore(int store_id) {
			connect();
			String SQL = "select * from store where store_id = ?";
			StoreEntity str = new StoreEntity();
			
			try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setInt(1, store_id);
				ResultSet rs = pstmt.executeQuery();			
				rs.next();
				str.setStore_id(rs.getInt("store_id"));
				str.setName(rs.getString("name"));
				str.setNumber(rs.getString("number"));
				str.setLocation(rs.getString("location"));
				str.setCategory(rs.getString("category"));
				str.setReg_num(rs.getString("reg_num"));
				str.setCreated_at(rs.getString("created_at"));
				rs.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}
			return str;
		}
		
		// 가게 정보 삽입 ( 가게 등록 )
		public boolean insertDB(StoreEntity store) {
			boolean success = false;
			connect();
			String sql = "INSERT INTO store (user_id, name, number, location, category, reg_num) VALUES (?, ?, ?, ?, ?, ?)";
			try {
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, store.getUser_id());
		        pstmt.setString(2, store.getName());
		        pstmt.setString(3, store.getNumber());
		        pstmt.setString(4, store.getLocation());
		        pstmt.setString(5, store.getCategory());
		        pstmt.setString(6, store.getReg_num());
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
		
		
		// 가게 정보 수정
		public boolean updateDB(StoreEntity store) {
			boolean success = false; 
			connect();		
			String sql ="update store set name =?, number = ?, location=?, category=?, reg_num=? where user_id=?";	
			try {
				pstmt = con.prepareStatement(sql);
				// 수정할 게시물의 정보를 SQL 쿼리에 삽입
				pstmt.setString(1, store.getName());
				pstmt.setString(2, store.getNumber());
				pstmt.setString(3, store.getLocation());
				pstmt.setString(4, store.getCategory());
				pstmt.setString(5, store.getReg_num());
				pstmt.setInt(6, store.getUser_id());
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
		public boolean deleteDB(int store_id) {
		    boolean success = false;
		    connect();

		    // event 테이블에서 해당 store_id를 참조하는 행을 삭제
		    try {
		        String deleteEvent = "DELETE FROM event WHERE store_id = ?";
		        pstmt = con.prepareStatement(deleteEvent);
		        pstmt.setInt(1, store_id);
		        pstmt.executeUpdate();
		    } catch (SQLException e) {
		        e.printStackTrace();
		        return success;
		    }

		    // store 테이블에서 store_id를 삭제
		    try {
		        String deleteStore = "DELETE FROM store WHERE store_id = ?";
		        pstmt = con.prepareStatement(deleteStore);
		        pstmt.setInt(1, store_id);
		        pstmt.executeUpdate();
		        success = true;
		    } catch (SQLException e) {
		        e.printStackTrace();
		        return success;
		    } finally {
		        disconnect();
		    }
		    return success;
		}

		public boolean storeExists(int user_id) {
			connect();
		    ResultSet rs = null;

		    try {
		        String sql = "SELECT * FROM store WHERE user_id = ?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setInt(1, user_id);
		        rs = pstmt.executeQuery();

		        if(rs.next()) {
		            return true;
		        }

		    } catch(Exception e) {
		        e.printStackTrace();
		    } finally {
		    	disconnect();
		    }

		    return false;
		}
		
		public int getStoreId(int user_id) {
			int store_id = -1;
			ResultSet rs = null;
			 
		    try {
		    	connect();
		        pstmt = con.prepareStatement("SELECT store_id FROM store WHERE user_id = ?");
		        pstmt.setInt(1, user_id);
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		        	store_id = rs.getInt("store_id");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        disconnect();
		    }

		    return store_id;
		}
		
		public String getStoreLocation(int user_id) {
			String location = "";
			ResultSet rs = null;
			 
		    try {
		    	connect();
		        pstmt = con.prepareStatement("SELECT location FROM store WHERE user_id = ?");
		        pstmt.setInt(1, user_id);
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		        	location = rs.getString("location");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        disconnect();
		    }

		    return location;
		}
		
		//admin 페이지에서 특정 유저에 대한 가게 정보 조회
		public StoreEntity AdmingetStore(int user_id) {
			connect();
			String SQL = "select * from store where user_id = ?";
			StoreEntity str = new StoreEntity();
			
			try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setInt(1, user_id);
				ResultSet rs = pstmt.executeQuery();			
				rs.next();
				str.setStore_id(rs.getInt("store_id"));
				str.setName(rs.getString("name"));
				str.setNumber(rs.getString("number"));
				str.setLocation(rs.getString("location"));
				str.setCategory(rs.getString("category"));
				str.setReg_num(rs.getString("reg_num"));
				str.setCreated_at(rs.getString("created_at"));
				rs.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
				disconnect();
			}
			return str;
		}
}
