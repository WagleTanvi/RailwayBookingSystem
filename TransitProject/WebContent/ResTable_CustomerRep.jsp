<!-- Written By: Vancha Verma vv199 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservations </title>
</head>
<body>
<h1 style="text-align:center; top:50px;"> User Reservations</h1>

<p> Please note that the 'Date Reserved' for Monthly and Weekly tickets refer to date the pass becomes active </p>


<%

	if((session.getAttribute("user") == null) || (session.getAttribute("role") == null))  {
		response.sendRedirect("index.jsp");
	}

		try{

			//connect to database
			//out.println("here");
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			//out.println("here");
			String trainID = "SELECT t.train_id from train t;";

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(trainID);  %>
			<form action = "resPage.jsp" method= "post">

			<select name="trainID" id="trainID" value="">
			<option value="" selected>All Trains</option>

			<%
			while(result.next()) {
			%>

  			<option value=<%=result.getString("t.train_id")%> ><%out.print(result.getString("t.train_id"));%> </option>

			<%
			}


			%>

			</select>

			<INPUT TYPE="submit" VALUE="Filter"/>
			</form>
			<p></p>
			<%
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
		%>

<table id = "resvationTable" align = "center" style="width:90%">

  	<tr>
  		<th>User</th>
  		<th>Transit Line</th>
    	<th>Train ID</th>
    	<th>Origin</th>
    	<th>Destination</th>
    	<th>Date Reserved</th>
    	<th>Departure Time </th>
    	<th>Cost</th>
    	<th>Class</th>
    	<th>Ticket Type</th>
    	<th>Discount</th>
    	<th>Date Bought</th>
    	<th>Edit</th>
	</tr>

<%

		try{

			//connect to database
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();

			String str = "SELECT tsa.tl_id, tst.arrival_time, tsa.train_id, r.*"
					+ " FROM reservations r, train_schedule_assignment tsa, train_schedule_timings tst, transit_line_route tlr"
					+ " WHERE r.schedule_num = tsa.schedule_num AND r.origin = tlr.start_station_id AND tlr.route_id = tst.route_id AND r.schedule_num = tst.schedule_num";
			//sString v_rid = "";
			//System.out.println(session.getAttribute("user"));
			if(request.getParameter("trainID") != null) {
				if(!(request.getParameter("trainID").equals(""))){
					str = str + " AND tsa.train_id = '" + request.getParameter("trainID") +"'";
				}
			}
			str = str + " ORDER BY r.username, tsa.train_id;";

			//System.out.println(str);

			//to hold all the information from the database
			ArrayList<ResObj> customerTable = new ArrayList<ResObj>();

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			while(result.next()) {
				ResObj entry = new ResObj();
				entry.setUser(result.getString("r.username"));
				entry.setTransit(result.getString("tsa.tl_id"));
				entry.setTrain(result.getString("tsa.train_id"));
				entry.setRid(result.getString("r.rid"));
				entry.setBought(result.getString("r.date_reserved"));
				entry.setResDate(result.getString("r.date_ticket"));
				entry.setClass(result.getString("r.class"));
				entry.setCost("$"+ result.getString("r.total_cost"));
				entry.setTime(result.getString("tst.arrival_time"));
				entry.setDisc(result.getString("r.discount"));
				if(result.getString("r.discount").equals("Normal")){
					entry.setDisc("None");
				}
				if(result.getString("r.trip").equals("One")){
					entry.setTrip("One-Way");
				} else {
					entry.setTrip(result.getString("r.trip"));
				}

				entry.setDest(result.getString("r.destination"));
				entry.setOrigin(result.getString("r.origin"));

				customerTable.add(entry);
			}


			for(int i = 0; i < customerTable.size(); i++){
				String getS = "SELECT s.name, s.station_id FROM station s WHERE s.station_id = "
				+ customerTable.get(i).getOrigin() + " OR s.station_id = " + customerTable.get(i).getDest();
				ResultSet origin = stmt.executeQuery(getS);
				while(origin.next()) {
					if((origin.getString("station_id").equals(customerTable.get(i).getOrigin()))){
						customerTable.get(i).setOrigin(origin.getString("name"));
					}

					if((origin.getString("station_id").equals(customerTable.get(i).getDest()))){
						customerTable.get(i).setDest(origin.getString("name"));
					}

				}
			}

			db.closeConnection(con); //close database

			for(int i = 0; i < customerTable.size(); i++){
				out.print("<tr>");
				out.print(customerTable.get(i).printTable_Rep());
				out.print("<td>");
				%>
				<button>
					<a style="color: black; "href= "editRes.jsp?v_val=<%=customerTable.get(i).getRid()%>" >Edit</a>
				</button>

				<%
				out.print("</td></tr>");
			}
		} catch (Exception e) {
			out.print(e);
		}


	%>

	</table>

</body>
</html>
