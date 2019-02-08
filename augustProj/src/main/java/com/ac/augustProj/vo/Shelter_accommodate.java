package com.ac.augustProj.vo;

public class Shelter_accommodate {
private String localName;
private int accommodate;

public String getLocalName() {
	return localName;
}
public void setLocalName(String localName) {
	this.localName = localName;
}
public int getAccommodate() {
	return accommodate;
}
public void setAccommodate(int accommodate) {
	this.accommodate = accommodate;
}
@Override
public String toString() {
	return "Shelter_accommodate [localName=" + localName + ", accommodate=" + accommodate + "]";
}



}
