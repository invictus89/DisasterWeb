package com.ac.augustProj.vo;

import java.sql.Date;

public class Weather_Forecast {
	
	private String loc;
	private Float lat;
	private Float lng;
	private int hour;
	private int log_reg;
	private Float log_reg_ac;
	private int svm;
	private Float svm_ac;
	private int RForest;
	private Float RForest_ac;
	private Date date;
	private int rainMarker;
	
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public Float getLat() {
		return lat;
	}
	public void setLat(Float lat) {
		this.lat = lat;
	}
	public Float getLng() {
		return lng;
	}
	public void setLng(Float lng) {
		this.lng = lng;
	}
	public int getHour() {
		return hour;
	}
	public void setHour(int hour) {
		this.hour = hour;
	}
	public int getLog_reg() {
		return log_reg;
	}
	public void setLog_reg(int log_reg) {
		this.log_reg = log_reg;
	}
	public Float getLog_reg_ac() {
		return log_reg_ac;
	}
	public void setLog_reg_ac(Float log_reg_ac) {
		this.log_reg_ac = log_reg_ac;
	}
	public int getSvm() {
		return svm;
	}
	public void setSvm(int svm) {
		this.svm = svm;
	}
	public Float getSvm_ac() {
		return svm_ac;
	}
	public void setSvm_ac(Float svm_ac) {
		this.svm_ac = svm_ac;
	}
	public int getRForest() {
		return RForest;
	}
	public void setRForest(int rForest) {
		RForest = rForest;
	}
	public Float getRForest_ac() {
		return RForest_ac;
	}
	public void setRForest_ac(Float rForest_ac) {
		RForest_ac = rForest_ac;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getRainMarker() {
		return rainMarker;
	}
	public void setRainMarker(int rainMarker) {
		this.rainMarker = rainMarker;
	}

	
	
	

}
