package common.db;

import comment.db.Comment;
import info.db.Board;
import infoboardlike.db.InfoLike;
import net.trade.db.Trade;

public class mypage {

	private Member m = new Member();
	private Board bo = new Board(); //내가 쓴 글 
	private InfoLike like = new InfoLike();//내가 쓴 글 좋아요
	private Comment comm = new Comment(); //내가 쓴 댓글
	private Trade td = new Trade(); // 거래게시판
	
	
	public mypage() {
		
	}
	
	public Member getM() {
		return m;
	}

	public void setM(Member m) {
		this.m = m;
	}

	public Board getBo() {
		return bo;
	}

	public void setBo(Board bo) {
		this.bo = bo;
	}

	public InfoLike getLike() {
		return like;
	}

	public void setLike(InfoLike like) {
		this.like = like;
	}
	
	public Comment getComm() {
		return comm;
	}

	public void setComm(Comment comm) {
		this.comm = comm;
	}

	public Trade getTd() {
		return td;
	}

	public void setTd(Trade td) {
		this.td = td;
	}
	
	
}
