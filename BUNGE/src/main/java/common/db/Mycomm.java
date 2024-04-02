package common.db;

import comment.db.Comment;
import info.db.Board;

public class Mycomm {
	private Board board = new Board(); //내가 쓴 글 
	private Comment comment = new Comment(); //내가 쓴 댓글
	
	public Mycomm() {
		
	}
	public Mycomm(Board board, Comment comment) {
		super();
		this.board=board;
		this.comment=comment;
	}

	public Board getBoard() {
		return board;
	}

	public void setBoard(Board board) {
		this.board = board;
	}

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}
}
