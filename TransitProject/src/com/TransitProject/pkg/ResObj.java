package com.TransitProject.pkg;


public class ResObj {
	String origin; 
	String destination;
	String currClass; 
	
	public ResObj(String o, String d, String c) {
		origin = o; 
		destination = d; 
		currClass = c; 
	}
	
	public String getOrigin() {
		 return origin; 
	}
	
	public String getDest() {
		 return destination; 
	}
	
	public String getcurrClass() {
		 return currClass; 
	}
	
	
}