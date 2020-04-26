<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
</style>


<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Reservation Page</title>
</head>

<body>
	<button style = "float: right; top:30px; right: 40px;">
		<a style="color: black; font-size: 20px; "href="logout.jsp">Logout</a>
	</button>
	
	
	<%
	
	if(request != null){
		String name = request.getParameter("username");
		String sch = session.getAttribute("schedule").toString();
		String date = session.getAttribute("date").toString();
		String or = session.getAttribute("origin").toString();
		String dest = session.getAttribute("destination").toString();
		String cla = request.getParameter("class");
		String trip = request.getParameter("trip");
		String dis = request.getParameter("discount");
		String fare = session.getAttribute("fare").toString();
		
		
		/***UNCOMMENT ONCE MERGED WITH NICK 
		//ArrayList<String> transitLineInit = (ArrayList<String>session.getAttribute("transitLinesInit")); 
		//ArrayList<String> scheduleNumsInit = (ArrayList<String>session.getAttribute("transitLinesInit")); 
		//ArrayList<String> startTimesInit = (ArrayList<String>session.getAttribute("transitLinesInit")); 
		
		try{

			String rid = "10"; 
			
			//connect to database 
			ApplicationDB db = new ApplicationDB(); 
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String tst = "SELECT * from train_schedule_timings tst WHERE tst.schedule_num = '" + sch + "'";
			String tsa = SELECT * from train_schedule_assignment tsa WHERE tsa.schedule_num = '" + sch + "'";
			ResultSet r1 = stmt.executeQuery(tst);
			ResultSet r2 = stmt.executeQuery(tsa);
			
			
			String start = r1.getString("departure_time");
			String transitLine = r2.getString("tl_id");
			
			transitLineInit.add(transitLine); 
			scheduleNumsInit.add(sch); 
			startTimesInit.add(startTimesInit); 
			
			session.setAttribute("transitLinesInit", transitLineInit);
			session.setAttribute("scheduleNumsInit", scheduleNumsInit);
			session.setAttribute("startTimesInit", startTimesInit);
			
			
			String insert = "INSERT INTO reservations (username, total_cost, origin, destination, schedule_num, class, date_ticket, date_reserved, booking_fee) 
					+ "VALUES (name, fare, or, dest, sch, class, date, '2020-04-20', 3.5);"; 
			
			
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
			
					
			
			
			
		}
		***/
		
		
	}
	
	String role = "admin"; 
	
	if(session.getAttribute("user") == null) {
		response.sendRedirect("index.jsp");
	
	} else if ((role.equals("customer"))) {
				%>
				<div style="align:center; text-align:center; " >
				<jsp:include page="HandleResTable_Customer.jsp"/>
				
				<%
	} else if ((role.equals("admin"))) {
		%>
		
		<div style="align:center; text-align:center; " >
		<jsp:include page="ResTable_Admin.jsp"/>
		<%
	} else if ((role.equals("customerRep"))) {
		%>
		
		<div style="align:center; text-align:center; " >
		<jsp:include page="ResTable_CustomerRep.jsp"/>
		<%
	}
	
	%> 
		
	</div>

	<div style = "text-align: center; padding-top:30px;">
		<button>
			<a style="color: black; font-size: 20px;"href="index.jsp">Make Another Reservation</a>
		</button>
	</div>

</body>
</html>