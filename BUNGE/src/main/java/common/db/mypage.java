package common.db;

import info.db.Board;

public class mypage {

	private Member m = new Member();
	private Memberimg mimg = new Memberimg();
	private Board board = new Board();
	
	public Board getBoard() {
		return board;
	}
	public void setBoard(Board board) {
		this.board = board;
	}
	public Member getM() {
		return m;
	}
	public void setM(Member m) {
		this.m = m;
	}
	public Memberimg getMimg() {
		return mimg;
	}
	public void setMimg(Memberimg mimg) {
		this.mimg = mimg;
	}

	
	
	
}
