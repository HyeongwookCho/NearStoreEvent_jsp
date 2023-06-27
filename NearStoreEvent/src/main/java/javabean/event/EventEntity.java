package javabean.event;

import java.sql.Date;

public class EventEntity {
	private int event_id;
    private int store_id; // 외래키
    private String title;
    private String content;
    private String image_path;
    private Date period_start;
    private Date period_end;
    private String created_at;
    private int user_id; // 외래키
    private String storeLocation;
    
	public int getEvent_id() {
		return event_id;
	}
	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}
	public int getStore_id() {
		return store_id;
	}
	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public Date getPeriod_start() {
		return period_start;
	}
	public void setPeriod_start(java.sql.Date period_start) {
	    this.period_start = period_start;
	}
	public Date getPeriod_end() {
		return period_end;
	}
	public void setPeriod_end(java.sql.Date period_end) {
	    this.period_end = period_end;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getStoreLocation() {
		return storeLocation;
	}
	public void setStoreLocation(String storeLocation) {
		this.storeLocation = storeLocation;
	}
    
    
	
}
