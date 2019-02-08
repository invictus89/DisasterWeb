package com.ac.augustProj.vo;

public class ShelterCount {
	private String area01;
	private int count01;
	public String getArea01() {
		return area01;
	}
	public void setArea01(String area01) {
		this.area01 = area01;
	}
	public int getCount01() {
		return count01;
	}
	public void setCount01(int count01) {
		this.count01 = count01;
	}
	@Override
	public String toString() {
		return "ShelterCount [area01=" + area01 + ", count01=" + count01 + "]";
	}
}
