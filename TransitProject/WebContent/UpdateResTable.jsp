<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try{
		//connect to database 
		ApplicationDB db = new ApplicationDB(); 
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String rid = request.getParameter("v_rid"); 
		String cla = request.getParameter("class");
		String trip = request.getParameter("trip");
		String disc = request.getParameter("discount");
		int fare = 0; 
		int origin = 0; 
		int dest = 0; 
		
		//System.out.println(cla + " " + trip + " " + dis); 
		
		String getFare = "SELECT tl.tl_id, tl.fare, r.origin, r.destination"  
				+ " FROM transit_line tl, reservations r, train_schedule_assignment tsa" 
				+ " WHERE r.schedule_num = tsa.schedule_num AND tl.tl_id = tsa.tl_id AND r.rid = " + rid; 
		
		ResultSet result = stmt.executeQuery(getFare);
		
		while(result.next()){
			fare = result.getInt("tl.fare"); 
			origin = result.getInt("r.origin"); 
			dest = result.getInt("r.destination"); 
			
		}
		
		if(trip.equals("Round")){
			fare = fare *2; 
		} else if (trip.equals("Monthly")){
			fare = fare * 30; 
		} else if (trip.equals("Weekly")) {
			fare = fare * 7; 
		}
		
		if(disc.equals("Senior/Child") || disc.equals("Disabled") ){
			fare = fare/2; 
		} 
		
		if(cla.equals("First") || cla.equals("Buisness") ){
			fare = fare + 5; 
		} 
		
		int totalFare = fare * (dest - origin);
		totalFare += 3.5; 
		
		
		//System.out.println(cla + " " + trip + " " + disc + " " + totalFare);
	
		String update = "UPDATE reservations" 
				+ " SET class = '" + cla + "' , discount = '" + disc + "' , trip = '" + trip + "' , total_cost = " + fare 
				+ " WHERE rid = " + rid; 
				
				
		//System.out.println(update);
		stmt.executeUpdate(update);
		
		db.closeConnection(con); 
	} catch (Exception e) {
		out.print(e);
	}


%>

</body>
</html>