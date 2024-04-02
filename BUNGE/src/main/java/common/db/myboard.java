package common.db;

import comment.db.Comment;
import info.db.Board;
import infoboardlike.db.InfoLike;

public class myboard {
	private Member Member = new Member();
	private Board Board = new Board(); //내가 쓴 글 
	private InfoLike InfoLike = new InfoLike();//내가 쓴 글 좋아요
	private Comment Comment = new Comment(); //내가 쓴 댓글
	
	public myboard() {
		
	}
	
	public myboard(Board Board, InfoLike InfoLike, Comment Comment) {
		super();
		this.Board = Board;
		this.InfoLike = InfoLike;
		this.Comment= Comment;
	}
	
	public Member getMember() {
		return Member;
	}
	public void setMember(Member member) {
		Member = member;
	}
	public Board getBoard() {
		return Board;
	}
	public void setBoard(Board board) {
		Board = board;
	}
	public InfoLike getInfoLike() {
		return InfoLike;
	}
	public void setInfoLike(InfoLike infoLike) {
		InfoLike = infoLike;
	}
	public Comment getComment() {
		return Comment;
	}
	public void setComment(Comment comment) {
		Comment = comment;
	}
}
