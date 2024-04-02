package common.db;

import info.db.Board;
import infomark.db.InfoMark;

public class Mymark {
	private Board board =new Board();
	private InfoMark infomark = new InfoMark();

	public Mymark() {
		
	}
	public Mymark(Board board, InfoMark infomark) {
		super();
		this.board = board;
		this.infomark = infomark;
	}
	public Board getBoard() {
		return board;
	}
	public void setBoard(Board board) {
		this.board = board;
	}
	public InfoMark getInfomark() {
		return infomark;
	}
	public void setInfomark(InfoMark infomark) {
		this.infomark = infomark;
	}
	
	
}

