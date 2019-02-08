package com.ac.augustProj.vo;

public class Realtime {
	private String eqid;
	private String time;
	private String degree;
	private String title;
	private String lat;
	private String lng;
	private String tag;
	private String url;
	private int moditime;
	private int count;
	private String count_eq;
	private String avg_eq;
	
	
	/* 시간에 따른 진도 별 지진 횟수 */
	private int hour;
	private int deg1;
	private int deg2;
	private int deg3;
	
	public String getCount_eq() {
		return count_eq;
	}
	public String getAvg_eq() {
		return avg_eq;
	}
	public void setCount_eq(String count_eq) {
		this.count_eq = count_eq;
	}
	public void setAvg_eq(String avg_eq) {
		this.avg_eq = avg_eq;
	}
	public int getHour() {
		return hour;
	}
	public int getDeg1() {
		return deg1;
	}
	public int getDeg2() {
		return deg2;
	}
	public int getDeg3() {
		return deg3;
	}
	public void setHour(int hour) {
		this.hour = hour;
	}
	public void setDeg1(int deg1) {
		this.deg1 = deg1;
	}
	public void setDeg2(int deg2) {
		this.deg2 = deg2;
	}
	public void setDeg3(int deg3) {
		this.deg3 = deg3;
	}
	
	public int getModitime() {
		return moditime;
	}
	public int getCount() {
		return count;
	}
	public void setModitime(int moditime) {
		this.moditime = moditime;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getEqid() {
		return eqid;
	}
	public String getTime() {
		return time;
	}
	public String getDegree() {
		return degree;
	}
	public String getTitle() {
		return title;
	}
	public String getLat() {
		return lat;
	}
	public String getTag() {
		return tag;
	}
	public String getUrl() {
		return url;
	}
	public void setEqid(String eqid) {
		this.eqid = eqid;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@Override
	public String toString() {
		return "Realtime [eqid=" + eqid + ", time=" + time + ", degree=" + degree + ", title=" + title + ", lat=" + lat
				+ ", lng=" + lng + ", tag=" + tag + ", url=" + url + "]";
	}
}
