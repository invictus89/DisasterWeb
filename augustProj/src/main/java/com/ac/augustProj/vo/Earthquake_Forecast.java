package com.ac.augustProj.vo;

import java.sql.Date;

public class Earthquake_Forecast {
	
	private String loc;
	private Float month_dist;
	private Float day_dist;
	private Float lat_op;
	private Float lng_op;
	private String op_name;
	private Date date;
	
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public Float getMonth_dist() {
		return month_dist;
	}
	public void setMonth_dist(Float month_dist) {
		this.month_dist = month_dist;
	}
	public Float getDay_dist() {
		return day_dist;
	}
	public void setDay_dist(Float day_dist) {
		this.day_dist = day_dist;
	}
	public Float getLat_op() {
		return lat_op;
	}
	public void setLat_op(Float lat_op) {
		this.lat_op = lat_op;
	}
	public Float getLng_op() {
		return lng_op;
	}
	public void setLng_op(Float lng_op) {
		this.lng_op = lng_op;
	}
	public String getOp_name() {
		return op_name;
	}
	public void setOp_name(String op_name) {
		this.op_name = op_name;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	

}
