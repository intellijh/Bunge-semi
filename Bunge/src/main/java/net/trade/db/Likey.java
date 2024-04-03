package net.trade.db;

public class Likey {
	private String Userid;
	private int Tradeid;
	private String LikeStatus;
	
	public Likey() {}

	public String getUserid() {
		return Userid;
	}

	public void setUserid(String userid) {
		Userid = userid;
	}

	public int getTradeid() {
		return Tradeid;
	}

	public void setTradeid(int tradeid) {
		Tradeid = tradeid;
	}

	public String getLikeStatus() {
		return LikeStatus;
	}

	public void setLikeStatus(String likeStatus) {
		LikeStatus = likeStatus;
	}
	
}
