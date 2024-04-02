package common.db;

import comment.db.Comment;
import info.db.Board;
import infoboardlike.db.InfoLike;

public class Myboard {
	private Board board = new Board(); //내가 쓴 글 
	private InfoLike infoLike = new InfoLike();//내가 쓴 글 좋아요
	private Comment comment = new Comment(); //내가 쓴 댓글
	
public Myboard() {
		
	}

	public Myboard(Board board, InfoLike infoLike, Comment comment) {
		super();
		this.board = board;
		this.infoLike = infoLike;
		this.comment= comment;
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

	public Board getBoard() {
		return board;
	}

	public void setBoard(Board board) {
		this.board = board;
	}
	
}
