/*** Written By: Vancha Verma vv199 ***/
package com.TransitProject.pkg;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.util.ArrayList;


public class ResObj {
	String transit;
	String train;
	String rid;
	String resDate;
	String bought;
	String cla;
	String cost;
	String origin;
	//int originNum
	String dest;
	String trip;
	String discount;
	String time;
	String username;
	
	String someDummy;
	public ResObj(){
	}

	public void setTransit(String t) {
		transit = t;
	}
	public void setTrain(String tr) {
		train = tr;
	}
	public void setRid(String r) {
		rid = r;
	}
	public void setResDate(String re) {
		resDate = re;
	}
	public void setBought(String b) {
		bought = b;
	}
	public void setClass(String c) {
		cla = c;
	}
	public void setOrigin(String o) {
		origin = o;
	}
	public void setDest(String d) {
		dest = d;
	}
	public void setTrip(String t) {
		trip = t;
	}
	public void setDisc(String d) {
		discount = d;
	}
	public void setCost(String c) {
		cost = c;
	}
	public void setTime(String t) {
		time = t;
	}
	public void setUser(String u) {
		username = u;
	}


	public String getRid() {
		return rid;
	}

	public String getOrigin() {
		return origin;
	}

	public String getDest() {
		return dest;
	}

	public String getClas() {
		return cla;
	}

	public String printTable() {
		String html =
				"<td style=\"border: 1px solid black;\">" + transit + "</td>"+
				"<td style=\"border: 1px solid black;\">" + train + "</td>"+
				"<td style=\"border: 1px solid black;\">" + origin + "</td>" +
				"<td style=\"border: 1px solid black;\">" + dest + "</td>" +
				"<td style=\"border: 1px solid black;\">" + resDate + "</td>"+
				"<td style=\"border: 1px solid black;\">"+ time + "</td>"+
				"<td style=\"border: 1px solid black;\">" + cost + "</td>" +
				"<td style=\"border: 1px solid black;\">" + cla + "</td>" +
				"<td style=\"border: 1px solid black;\">"+ trip + "</td>"+
				"<td style=\"border: 1px solid black;\">" + discount + "</td>"+
				"<td style=\"border: 1px solid black;\">"+ bought + "</td>";
		//System.out.println(html);
		return html;

	}

	public String printTable_Rep() {
		String html =
				"<td style=\"border: 1px solid black;\">" + username + "</td>"+
				"<td style=\"border: 1px solid black;\">" + transit + "</td>"+
				"<td style=\"border: 1px solid black;\">" + train + "</td>"+
				"<td style=\"border: 1px solid black;\">" + origin + "</td>" +
				"<td style=\"border: 1px solid black;\">" + dest + "</td>" +
				"<td style=\"border: 1px solid black;\">" + resDate + "</td>"+
				"<td style=\"border: 1px solid black;\">"+ time + "</td>"+
				"<td style=\"border: 1px solid black;\">" + cost + "</td>" +
				"<td style=\"border: 1px solid black;\">" + cla + "</td>" +
				"<td style=\"border: 1px solid black;\">"+ trip + "</td>"+
				"<td style=\"border: 1px solid black;\">" + discount + "</td>"+
				"<td style=\"border: 1px solid black;\">"+ bought + "</td>";
		//System.out.println(html);
		return html;

	}


}
