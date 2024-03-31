package common.db;

import java.sql.Date;

public class Memberimg {
	private int pof_num;
	private String m_id;
	private String pof_savename;
	private String pof_filename;
	
	public int getPof_num() {
		return pof_num;
	}
	public void setPof_num(int pof_num) {
		this.pof_num = pof_num;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getPof_savename() {
		return pof_savename;
	}
	public void setPof_savename(String pof_savename) {
		this.pof_savename = pof_savename;
	}
	public String getPof_filename() {
		return pof_filename;
	}
	public void setPof_filename(String pof_filename) {
		this.pof_filename = pof_filename;
	}
}
