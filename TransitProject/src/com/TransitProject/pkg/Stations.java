package com.TransitProject.pkg;

public class Stations {
	String name;
	String state;
	String city;
	
	public Stations(String n, String s, String c) {
		name = n;
		state = s;
		city = c;
	}
	public String getRow(boolean target) {
		if (target) {
			return "<td style=\"border: 1px solid black;\"><b>"+name+"</b></td>" + 
					"<td style=\"border: 1px solid black;\"><b>"+state+"</b></td>" + 
					"<td style=\"border: 1px solid black;\"><b>"+city+"</b></td>";
		}
		return "<td style=\"border: 1px solid black;\">"+name+"</td>" + 
				"<td style=\"border: 1px solid black;\">"+state+"</td>" + 
				"<td style=\"border: 1px solid black;\">"+city+"</td>";
	}
	public String getName() {
		return name;
	}
}
