package comment.db;

public class Comment {
	private int comm_num;
	private String m_id;
	private int inf_num;
	private String comm_content;
	private int comm_ref;
	private int comm_lev;
	private int comm_seq;
	private String comm_reg;

	public int getComm_num() {
		return comm_num;
	}

	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public int getInf_num() {
		return inf_num;
	}

	public void setInf_num(int inf_num) {
		this.inf_num = inf_num;
	}

	public String getComm_content() {
		return comm_content;
	}

	public void setComm_content(String comm_content) {
		this.comm_content = comm_content;
	}

	public int getComm_ref() {
		return comm_ref;
	}

	public void setComm_ref(int comm_ref) {
		this.comm_ref = comm_ref;
	}

	public int getComm_lev() {
		return comm_lev;
	}

	public void setComm_lev(int comm_lev) {
		this.comm_lev = comm_lev;
	}

	public int getComm_seq() {
		return comm_seq;
	}

	public void setComm_seq(int comm_seq) {
		this.comm_seq = comm_seq;
	}

	public String getComm_reg() {
		return comm_reg;
	}

	public void setComm_reg(String comm_reg) {
		this.comm_reg = comm_reg;
	}
}
