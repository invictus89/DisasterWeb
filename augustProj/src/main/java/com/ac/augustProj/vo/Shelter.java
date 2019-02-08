package com.ac.augustProj.vo;

public class Shelter {
	private int number;
	private String name;
	private String address;
	private String firstadd;
	private String secondadd;
	private double area;
	private double lng;
	private double lat;
	private boolean InOutShelter;
	
	
	public boolean isInOutShelter() {
		return InOutShelter;
	}
	public void setInOutShelter(boolean inOutShelter) {
		InOutShelter = inOutShelter;
	}
	public String getFirstadd() {
		return firstadd;
	}
	public String getSecondadd() {
		return secondadd;
	}
	
	public void setFirstadd(String firstadd) {
		this.firstadd = firstadd;
	}
	public void setSecondadd(String secondadd) {
		this.secondadd = secondadd;
	}
	
	public int getNumber() {
		return number;
	}
	public String getName() {
		return name;
	}
	public String getAddress() {
		return address;
	}
	public String getFirstAdd() {
		return firstadd;
	}
	public String getSecondAdd() {
		return secondadd;
	}
	public double getArea() {
		return area;
	}
	public double getLng() {
		return lng;
	}
	public double getLat() {
		return lat;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setFirstAdd(String firstadd) {
		this.firstadd = firstadd;
	}
	public void setSecondAdd(String secondadd) {
		this.secondadd = secondadd;
	}
	public void setArea(double area) {
		this.area = area;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	
	
}
