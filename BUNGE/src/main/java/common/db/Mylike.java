package common.db;

import comment.db.Comment;
import info.db.Board;
import infoboardlike.db.InfoLike;

public class Mylike {
	private Board board =new Board();
	private Comment comment = new Comment();
	private InfoLike infoLike = new InfoLike();
	

	public Mylike() {
		
	}
	public Mylike(Board board, InfoLike infoLike, Comment comment) {
		super();
		this.board = board;
		this.infoLike = infoLike;
		this.setComment(comment);
	}
	public Board getBoard() {
		return board;
	}
	public void setBoard(Board board) {
		this.board = board;
	}
	public InfoLike getInfoLike() {
		return infoLike;
	}
	public void setInfoLike(InfoLike infoLike) {
		this.infoLike = infoLike;
	}
	public Comment getComment() {
		return comment;
	}
	public void setComment(Comment comment) {
		this.comment = comment;
	}

	
}

