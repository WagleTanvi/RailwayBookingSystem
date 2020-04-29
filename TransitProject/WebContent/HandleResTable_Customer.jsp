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
<title>Insert title here</title>
</head>
<body>
<% out.println("<h2>" + session.getAttribute("user") + "'s Reservations</h2>" );%>

<table id = "resvationTable" align = "center" style="width:90%">

  	<tr>
    	<th>Transit Line</th>
    	<th>Train ID</th>
    	<th>Reservation ID </th>
    	<th>Date Reserved</th>
    	<th>Date Bought</th>
    	<th>Class</th>
    	<th>Total Cost</th>
    	<th>Origin</th>
    	<th>Destination</th>
    	<th> Edit </th>
	</tr>

<%

		try{

			//connect to database
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT tsa.tl_id, tsa.train_id, r.rid, r.date_reserved, r.date_ticket,  r.class, r.total_cost, r.origin, r.destination FROM reservations r, train_schedule_assignment tsa WHERE r.schedule_num = tsa.schedule_num AND r.username = '" + session.getAttribute("user") + "' ORDER BY tsa.train_id;";
			//sString v_rid = "";
			//System.out.println(session.getAttribute("user"));

			//to hold all the information from the database
			ArrayList<ResObj> customerTable = new ArrayList<ResObj>();
			//ResObj entry = new ResObj("1", "", 1, "", "", "", "", 1, 2);

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			while(result.next()) {
				//session.setAttribute("v_rid", );
				//System.out.println(v_rid);
				out.print("<tr>");
				out.print("<td>");
				out.print(result.getString("tsa.tl_id"));
				out.print("</td> <td>");
				out.print(result.getString("tsa.train_id"));
				out.print("</td> <td>");
				out.print(result.getString("r.rid"));
				out.print("</td> <td>");
				out.print(result.getString("r.date_reserved"));
				out.print("</td> <td>");
				out.print(result.getString("r.date_ticket"));
				out.print("</td> <td>");
				out.print(result.getString("r.class"));
				out.print("</td> <td>");
				out.print(result.getString("r.total_cost"));
				out.print("</td> <td>");
				out.print(result.getString("r.origin"));
				out.print("</td> <td>");
				out.print(result.getString("r.destination"));
				out.print("</td> <td>");
				%>
					<button>
					<a style="color: black; "href="editRes.jsp">Edit</a>
					</button>
				<%
				out.print("</td></tr>");

			}

			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}


	%>

	</table>

</body>
</html>
