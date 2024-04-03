package common.db;

public class Mypage {

private Member member =new Member();

public Mypage() {
}

public Mypage(Member member) {
	this.member = member;
}

public Member getMember() {
	return member;
}

public void setMember(Member member) {
	this.member = member;
	}

}
