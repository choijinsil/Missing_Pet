package beans.missing.vo;

import java.util.Date;

public class WitnessVO {

	private int wit_no;
	private String missing_pic;
	private Date find_date;
	private String wit_place;
	private String wit_comment;
	private String id;
	private int missing_no;

	public WitnessVO() {
		// TODO Auto-generated constructor stub
	}

	public WitnessVO(String missing_pic, Date find_date, String wit_place, String wit_comment, String id,
			int missing_no) {
		super();
		this.missing_pic = missing_pic;
		this.find_date = find_date;
		this.wit_place = wit_place;
		this.wit_comment = wit_comment;
		this.id = id;
		this.missing_no = missing_no;
	}

	public int getWit_no() {
		return wit_no;
	}

	public void setWit_no(int wit_no) {
		this.wit_no = wit_no;
	}

	public String getMissing_pic() {
		return missing_pic;
	}

	public void setMissing_pic(String missing_pic) {
		this.missing_pic = missing_pic;
	}

	public Date getFind_date() {
		return find_date;
	}

	public void setFind_date(Date find_date) {
		this.find_date = find_date;
	}

	public String getWit_place() {
		return wit_place;
	}

	public void setWit_place(String wit_place) {
		this.wit_place = wit_place;
	}

	public String getWit_comment() {
		return wit_comment;
	}

	public void setWit_comment(String wit_comment) {
		this.wit_comment =wit_comment;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getMissing_no() {
		return missing_no;
	}

	public void setMissing_no(int missing_no) {
		this.missing_no = missing_no;
	}

	@Override
	public String toString() {
		return "WitnessVO [wit_no=" + wit_no + ", missing_pic=" + missing_pic + ", find_date=" + find_date
				+ ", wit_place=" + wit_place + ", wit_comment=" + wit_comment + ", id=" + id + ", missing_no=" + missing_no
				+ "]";
	}

}
