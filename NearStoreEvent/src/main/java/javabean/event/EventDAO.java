package javabean.event;

import java.sql.*; 
import java.util.*; 
import javax.sql.*;

import javabean.store.StoreEntity;

import javax.naming.*; 

public class EventDAO {
	// 데이터베이스 연결 관련 객체 선언
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private DataSource ds = null;
	
	// JDBC 드라이버 로딩
	public EventDAO() {
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
	
	//이벤트 정보 전체 조회
	public ArrayList<EventEntity> getEventList(){
		connect();
		ArrayList<EventEntity> list = new ArrayList<EventEntity>();
		
		String SQL = "SELECT e.*, s.location FROM event e INNER JOIN store s ON e.store_id = s.store_id";
		
		try {
			pstmt = con.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventEntity ev = new EventEntity();
				ev.setEvent_id(rs.getInt("event_id"));
				ev.setStore_id(rs.getInt("store_id"));
				ev.setTitle(rs.getString("title"));
				ev.setContent(rs.getString("content"));
				ev.setImage_path(rs.getString("image_path"));
				ev.setPeriod_start(rs.getDate("period_start"));
				ev.setPeriod_end(rs.getDate("period_end"));
				ev.setCreated_at(rs.getString("created_at"));
				ev.setStoreLocation(rs.getString("location"));
				list.add(ev);
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return list;
	}
	
	//특정 이벤트 정보 조회
	public EventEntity getEvent(int event_id) {
		connect();
		String SQL = "select * from event where event_id = ?";
		EventEntity ev = new EventEntity();
		
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, event_id);
			ResultSet rs = pstmt.executeQuery();			
			rs.next();
			ev.setUser_id(rs.getInt("user_id"));
			ev.setEvent_id(rs.getInt("event_id"));
			ev.setStore_id(rs.getInt("store_id"));
			ev.setTitle(rs.getString("title"));
			ev.setContent(rs.getString("content"));
			ev.setImage_path(rs.getString("image_path"));
			ev.setPeriod_start(rs.getDate("period_start"));
			ev.setPeriod_end(rs.getDate("period_end"));
			ev.setCreated_at(rs.getString("created_at"));
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally {
			disconnect();
		}
		return ev;
	}
	
	// 이벤트 정보 삽입 ( 이벤트 등록 )
	public boolean insertDB(EventEntity event) {
	    boolean success = false;
	    connect();
	    String sql = "INSERT INTO event (user_id, store_id, title, content, image_path, period_start, period_end) VALUES (?, ?, ?, ?, ?, ?, ?)";
	    try {
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, event.getUser_id());
	        pstmt.setInt(2, event.getStore_id());
	        pstmt.setString(3, event.getTitle());
	        pstmt.setString(4, event.getContent());
	        pstmt.setString(5, event.getImage_path());
	        pstmt.setDate(6, event.getPeriod_start());
	        pstmt.setDate(7, event.getPeriod_end());
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
	
	// 이벤트 중복 확인 (한 가게 당 하나의 이벤트)
	public boolean eventExists(int store_id) {
		boolean success = false;
		connect();
	    ResultSet rs = null;

	    try {
	        String sql = "SELECT * FROM event WHERE store_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, store_id);
	        rs = pstmt.executeQuery();
	        success = true;
	        if(rs.next()) {
	            return success;
	        }

	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	    	disconnect();
	    }

	    return success;
	}
	
	
	public int getEventId(int user_id) {
		int event_id = -1;
		ResultSet rs = null;
		 
	    try {
	    	connect();
	        pstmt = con.prepareStatement("SELECT event_id FROM event WHERE user_id = ?");
	        pstmt.setInt(1, user_id);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	        	event_id = rs.getInt("event_id");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        disconnect();
	    }

	    return event_id;
	}
	
	//이벤트 정보 삭제
	public boolean deleteDB(int event_id) {
		boolean success = false; 
		connect();		
		String sql ="delete from event where event_id=?";
		try {
			pstmt = con.prepareStatement(sql);
			// 삭제할 유저 정보의 인조키인 user_id를 SQL 쿼리에 삽입
			pstmt.setInt(1, event_id);
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
	
	// 이벤트 정보 수정
	public boolean updateDB(EventEntity event) {
		boolean success = false; 
		connect();		
		String sql ="update event set title =?, content = ?, image_path=?, period_start=?, period_end=? where event_id=?";	
		try {
			pstmt = con.prepareStatement(sql);
			// 수정할 게시물의 정보를 SQL 쿼리에 삽입
			pstmt.setString(1, event.getTitle());
	        pstmt.setString(2, event.getContent());
	        pstmt.setString(3, event.getImage_path());
	        pstmt.setDate(4, event.getPeriod_start());
	        pstmt.setDate(5, event.getPeriod_end());
	        pstmt.setInt(6, event.getEvent_id());
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
	//image path 가져오기
	public String getImage_path(int user_id) {
		String image_path="";
		ResultSet rs = null;
		 
	    try {
	    	connect();
	        pstmt = con.prepareStatement("SELECT image_path FROM event WHERE user_id = ?");
	        pstmt.setInt(1, user_id);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	        	image_path = rs.getString("image_path");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        disconnect();
	    }

	    return image_path;
	}
	// 이벤트를 진행하는 가게의 위치 정보 가져오기
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
	
	// 카테고리를 기준으로 이벤트 목록 조회하기
	public ArrayList<EventEntity> getEventListByCategory(String category) {
	    connect();
	    ArrayList<EventEntity> list = new ArrayList<EventEntity>();

	    String SQL = "SELECT e.*,s.location FROM event e INNER JOIN store s ON e.store_id = s.store_id WHERE s.category = ?";

	    try {
	        pstmt = con.prepareStatement(SQL);
	        pstmt.setString(1, category);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            EventEntity event = new EventEntity();
	            event.setEvent_id(rs.getInt("event_id"));
	            event.setStore_id(rs.getInt("store_id"));
	            event.setTitle(rs.getString("title"));
	            event.setContent(rs.getString("content"));
	            event.setImage_path(rs.getString("image_path"));
	            event.setPeriod_start(rs.getDate("period_start"));
	            event.setPeriod_end(rs.getDate("period_end"));
	            event.setCreated_at(rs.getString("created_at"));
	            event.setUser_id(rs.getInt("user_id"));
	            event.setStoreLocation(rs.getString("location"));
	            list.add(event);
	        }
	        rs.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        disconnect();
	    }
	    return list;
	}

	// 검색어를 사용하여 이벤트 목록 조회하기
	public ArrayList<EventEntity> searchEventList(String search) {
	    connect();
	    ArrayList<EventEntity> list = new ArrayList<EventEntity>();
	    String keyword = "%" + search + "%";

	    String SQL = "SELECT e.*,s.location FROM event e INNER JOIN store s ON e.store_id = s.store_id WHERE e.title LIKE ? OR e.content LIKE ?";

	    try {
	        pstmt = con.prepareStatement(SQL);
	        pstmt.setString(1, keyword);
	        pstmt.setString(2, keyword);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            EventEntity event = new EventEntity();
	            // 이벤트 필드 값 설정
	            event.setEvent_id(rs.getInt("event_id"));
	            event.setStore_id(rs.getInt("store_id"));
	            event.setTitle(rs.getString("title"));
	            event.setContent(rs.getString("content"));
	            event.setImage_path(rs.getString("image_path"));
	            event.setPeriod_start(rs.getDate("period_start"));
	            event.setPeriod_end(rs.getDate("period_end"));
	            event.setCreated_at(rs.getString("created_at"));
	            event.setUser_id(rs.getInt("user_id"));
	            event.setStoreLocation(rs.getString("location"));
	            list.add(event);
	        }
	        rs.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        disconnect();
	    }
	    return list;
	}

	// 지난 이벤트 삭제
	public void deleteExpiredEvents() {
	    connect();
	    String sql = "DELETE FROM event WHERE period_end < CURDATE()";
	    try {
	        pstmt = con.prepareStatement(sql);
	        pstmt.executeUpdate();
	    } catch(SQLException e) {
	        e.printStackTrace();
	    } finally {
	        disconnect();
	    }
	}
	
	//특정 이벤트 정보 조회
	public EventEntity AdmingetEvent(int user_id) {
		connect();
		String SQL = "select * from event where user_id = ?";
		EventEntity ev = new EventEntity();
		
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, user_id);
			ResultSet rs = pstmt.executeQuery();			
			rs.next();
			ev.setUser_id(rs.getInt("user_id"));
			ev.setEvent_id(rs.getInt("event_id"));
			ev.setStore_id(rs.getInt("store_id"));
			ev.setTitle(rs.getString("title"));
			ev.setContent(rs.getString("content"));
			ev.setImage_path(rs.getString("image_path"));
			ev.setPeriod_start(rs.getDate("period_start"));
			ev.setPeriod_end(rs.getDate("period_end"));
			ev.setCreated_at(rs.getString("created_at"));
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally {
			disconnect();
		}
		return ev;
	}

}
