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
<a style="color: black; text-decoration: none; font-size: 20px;"href="Home.jsp"><button style="background-color: green; position:absolute; top:2%; left: 4%; border-radius: 10px;">Home</button></a>
<a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp"><button style="background-color: red; position:absolute; top:2%; right: 4%; border-radius: 10px;">Logout</button></a>
		
	
	<%
	String role = (String)session.getAttribute("role");
	String rid = ""; 
		
		try{
			//connect to database 
			ApplicationDB db = new ApplicationDB(); 
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			if(request.getParameter("res_change") != null){
				System.out.println("RES CHANGE"); 
		
				
				if((request.getParameter("res_change")).equals("delete") && (request.getParameter("v_rid") != null)){
					rid = request.getParameter("v_rid"); 
					String remove = "delete from reservations where rid = " + rid; 
					stmt.executeUpdate(remove); 
					
				} else if((request.getParameter("res_change")).equals("Update")){
					rid = request.getParameter("v_rid"); 
					%>
					<jsp:include page="UpdateResTable.jsp"/>
					<% 
					//stmt.executeUpdate(remove);
					
					System.out.println("Updated " + rid); 
					
				} 
			}
			
			//System.out.println("Username: " + session.getAttribute("schedule")); 
			
				
				if(session.getAttribute("username") != null){
					out.print("here"); 
					rid = request.getParameter("v_rid");
					//System.out.print("\n SUBMIT \n "); 
					
					%>
					<jsp:include page="AddReservation.jsp"/>
					<% 
				}
				db.closeConnection(con);
			} catch (Exception e) {
				out.print(e);
			}
			
			
			/***if(request.getParameter("username") != null){
				String name = request.getParameter("username");
				String sch = session.getAttribute("schedule").toString();
				String date = session.getAttribute("date").toString();
				String or = session.getAttribute("origin").toString();
				String dest = session.getAttribute("destination").toString();
				String cla = request.getParameter("class");
				String trip = request.getParameter("trip");
				String dis = request.getParameter("discount");
				String fare = session.getAttribute("fare").toString();
				
				/****
				ArrayList<String> transitLineInit = ArrayList<String>(); 
				ArrayList<String> scheduleNumsInit = ArrayList<String>(); 
				ArrayList<String> startTimesInit = ArrayList<String>(); 
				****/
			
				/****
			String tst = "SELECT * from train_schedule_timings tst WHERE tst.schedule_num = '" + sch + "'";
			String tsa = "SELECT * from train_schedule_assignment tsa WHERE tsa.schedule_num = '" + sch + "'";
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
			
			
			
			String insert = "INSERT INTO reservations (username, total_cost, origin, destination, schedule_num, class, date_ticket, date_reserved, booking_fee)"+
					"VALUES (name, fare, or, dest, sch, class, date, '2020-04-20', 3.5);";
			}
			***/
			
	
	if(session.getAttribute("user") == null) {
		response.sendRedirect("index.jsp");
	
	} else if ((role.equals("customer"))) {
		%>
		<div style="align:center; text-align:center; " >
		<jsp:include page="ResTable_Customer.jsp"/>
				
		<%
	} else if ((role.equals("administrator"))) {
		%>
		
		<div style="align:center; text-align:center; " >
		<jsp:include page="ResTable_Admin.jsp"/>
		<%
	} else if ((role.equals("customer_service_rep"))) {
		%>
		
		<div style="align:center; text-align:center; " >
		<jsp:include page="ResTable_CustomerRep.jsp"/></div></div>
		<%
	}
	
	%> 
		
	</div>

	<div style = "text-align: center; padding-top:30px;">
		<button>
			<a style="color: black; font-size: 20px;"href="TrainSchedule.jsp">Make Another Reservation</a>
		</button>
	</div>

</body>
</html>