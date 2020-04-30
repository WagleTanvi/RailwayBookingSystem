/* Written By: Tanvi Wagle tnw39 */
package com.TransitProject.pkg;


public class TrainScheduleObject {
	String transitLine;
	int scheduleNum;
	int trainId;
	String departure;
	String arrival;
	String start;
	String end;
	String travelTime;
	int cost;
	public TrainScheduleObject(String tl, int sN, int id, String d, String a, String s, String e, String tt, int c) {
		transitLine = tl;
		trainId = id;
		scheduleNum = sN;
		//SimpleDateFormat ft = new SimpleDateFormat ("hh:mm:ss");
//		try {
//			departure = ft.parse(d);
//			arrival = ft.parse(a);
//			travelTime = ft.parse(tt);
//		} catch (ParseException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
		departure = d;
		arrival = a;
		travelTime = tt;
		start = s;
		end = e;
		cost = c;
		
	}
	public String toString() {
		return transitLine + "\t" + trainId + "\t" + departure + "\t" + arrival + "\t" + start + "\t" + end + "\t" + travelTime;
	}
	public String getData(String personType) {
		System.out.println("HEYYY");
		String html = "<td style=\"border: 1px solid black;\">" 
				+"<a href='stations.jsp?transit="+transitLine+"&num="+scheduleNum+"'>"+ transitLine + "</a></td>"+
				"<td style=\"border: 1px solid black;\">#" + scheduleNum + "</td>"+
				"<td style=\"border: 1px solid black;\">" + departure + "</td>"+
				"<td style=\"border: 1px solid black;\">" + arrival + "</td>"+
				"<td style=\"border: 1px solid black;\">" + start + "</td>"+
				"<td style=\"border: 1px solid black;\">"+ end + "</td>"+
				"<td style=\"border: 1px solid black;\">" + travelTime + "</td>"+
				"<td style=\"border: 1px solid black;\">" + "$"+ cost + "</td>";
//		if (personType.contentEquals("customer")) {
			html += "<td style=\"border: 1px solid black;\"><a href='?fare="+cost+"&schedule="+scheduleNum+"#popup1'><button> Reserve </button></a>" + "</td>";
//		}	
		System.out.println(html);
		return html;
	}
	public String getBrowseData() {
		String html = "<td style=\"border: 1px solid black;\">"+ transitLine + "</td>"+
				"<td style=\"border: 1px solid black;\">#" + scheduleNum + "</td>"+
				"<td style=\"border: 1px solid black;\">" + start + "</td>"+
				"<td style=\"border: 1px solid black;\">"+ end + "</td>"+
				"<td style=\"border: 1px solid black;\">" + departure + "</td>"+
				"<td style=\"border: 1px solid black;\">" + arrival + "</td>"+
				"<td style=\"border: 1px solid black;\">" + "$"+ cost + "</td>";	
		//System.out.println(html);
		return html;
	}
	public String getAddData() {
		String html = "<td style=\"border: 1px solid black;\">" + trainId + "</td>"+
				"<td style=\"border: 1px solid black;\">" + start + "</td>"+
				"<td style=\"border: 1px solid black;\"><input type='time' id='time_"+trainId+"' name='time_"+trainId+"'></td>";
		return html;
	}
	public String getUpdateData() {
		String html = "<td style=\"border: 1px solid black;\">" + trainId + "</td>"+
				"<td style=\"border: 1px solid black;\">" + start + "</td>"+
				"<td style=\"border: 1px solid black;\"><input type='time' value='"+departure+"' id='time_"+trainId+"' name='time_"+trainId+"'></td>";
		//System.out.println(html);
		return html;
	}
	public int getTrainId() {
		return trainId;
	}
	public String getArrival() {
		return arrival;
	}
}
