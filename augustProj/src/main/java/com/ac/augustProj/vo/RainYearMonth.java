package com.ac.augustProj.vo;

public class RainYearMonth {

	private String date;
	private String rainfall;
	private String code;
	private String code_name;
	private String shiname;
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getRainfall() {
		return rainfall;
	}
	public void setRainfall(String rainfall) {
		this.rainfall = rainfall;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public String getShiname() {
		return shiname;
	}
	public void setShiname(String shiname) {
		this.shiname = shiname;
	}
	
	@Override
	public String toString() {
		return "RainYearMonth [date=" + date + ", rainfall=" + rainfall + ", code=" + code + ", code_name=" + code_name
				+ ", shiname=" + shiname + "]";
	}
	
	
}
