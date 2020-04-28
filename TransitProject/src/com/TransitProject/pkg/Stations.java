/* Written By: Tanvi Wagle tnw39 */
package com.TransitProject.pkg;

public class Stations {
	String name;
	String end;
	String state;
	String city;
	String Estate;
	String Ecity;
	String depart;
	String arrival;
	
	public Stations(String n, String s, String c, String d, String a, String e, String eState, String ecity) {
		name = n;
		state = s;
		city = c;
		depart = d;
		arrival = a;
		end = e;
		Estate = eState;
		Ecity = ecity;
	}
	public String getRow(boolean target) {
		if (target) {
			return "<td style=\"border: 1px solid black;\"><b>"+name+"</b></td>" + 
					"<td style=\"border: 1px solid black;\"><b>"+state+"</b></td>" + 
					"<td style=\"border: 1px solid black;\"><b>"+city+"</b></td>" + 
					"<td style=\"border: 1px solid black;\"><b>"+depart+"</b></td>"; 
					
		}
		return "<td style=\"border: 1px solid black;\">"+name+"</td>" + 
				"<td style=\"border: 1px solid black;\">"+state+"</td>" + 
				"<td style=\"border: 1px solid black;\">"+city+"</td>" + 
				"<td style=\"border: 1px solid black;\">"+depart+"</td>";
	}
	public String getName() {
		return name;
	}
	public String getEnd() {
		return end;
	}
	public String getState() {
		return state;
	}
	public String getCity() {
		return city;
	}
	public String getEState() {
		return Estate;
	}
	public String getECity() {
		return Ecity;
	}
	public String getDepart() {
		return depart;
	}
	public String getArrival() {
		return arrival;
	}
}
