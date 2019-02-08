package com.ac.augustProj.vo;

public class EarthquakeCount {
	private String area02;
	private int count02;
	public String getArea02() {
		return area02;
	}
	public void setArea02(String area02) {
		this.area02 = area02;
	}
	public int getCount02() {
		return count02;
	}
	public void setCount02(int count02) {
		this.count02 = count02;
	}
	@Override
	public String toString() {
		return "EarthquakeCount [area02=" + area02 + ", count02=" + count02 + "]";
	}
	
	
}
