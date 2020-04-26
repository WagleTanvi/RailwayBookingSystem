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
<%		try{
			
			//connect to database 
			ApplicationDB db = new ApplicationDB(); 
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String users = "SELECT distinct r.username from reservations r;"; 
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(users); %>
			<form action = "resPage.jsp" method= "post">
			<select name="username" id="username">
			<option value="" selected>All users</option>
			
			<%
			while(result.next()) {	
			%>
  			<option value=<%=result.getString("r.username")%> ><%out.print(result.getString("r.username"));%> </option>
			
			<%
			}
			%>
			</select>
			
			<%
			String lineName = "SELECT tl.tl_id from transit_line tl;"; 
			result = stmt.executeQuery(lineName); %>
			
			<select name="transitLine" id="transitLine">
			<option value="" selected>All Transit Lines</option>
			<%
			while(result.next()) {	
			%>
  			
  			<option value=<%=result.getString("tl.tl_id")%> ><%out.print(result.getString("tl.tl_id"));%> </option>
			
			<%
			}
			%>
			</select>
		
			<%
			String trainID = "SELECT t.train_id from train t;"; 
			result = stmt.executeQuery(trainID); %>
			
			<select name="trainID" id="trainID">
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
			<%

			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
		%>

<table id = "resvationTable" align = "center" style="width:90%">
  
  	<tr>
  		
    	<th>UserName </th>
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
			String str = "SELECT tsa.tl_id, tsa.train_id, r.rid, r.username, r.date_reserved, r.date_ticket,  r.class, r.total_cost, r.origin, r.destination FROM reservations r, train_schedule_assignment tsa WHERE r.schedule_num = tsa.schedule_num";
			
			if(request.getParameter("username") != null){
				if(!(request.getParameter("username").equals(""))){
					str = str + " AND r.username = '" + request.getParameter("username") +"'";  
				}
			}
			
			if(request.getParameter("username") != null){
				if(!(request.getParameter("transitLine").equals(""))){
					str = str + " AND tsa.tl_id = '" + request.getParameter("transitLine") +"'";  
				}
			}
			
			if(request.getParameter("username") != null){
				if(!(request.getParameter("trainID").equals(""))){
					str = str + " AND tsa.train_id = '" + request.getParameter("trainID") +"'";  
				}
			}
			
			str = str + " ORDER BY r.username, tsa.train_id;"; 

			//out.print(str); 
			//sString v_rid = ""; 
			//System.out.println(session.getAttribute("user")); 
			
			//to hold all the information from the database 
			//ArrayList<ResObj> customerTable = new ArrayList<ResObj>(); 
			//ResObj entry = new ResObj("1", "", 1, "", "", "", "", 1, 2); 
			
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			

			while(result.next()) {	
				//session.setAttribute("v_rid", ); 
				//System.out.println(v_rid); 	
			
				out.print("<tr>"); 
				out.print("<td>");
				out.print(result.getString("r.username")); 
				out.print("</td> <td>"); 
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
				out.print("</td><td>");
				%> 
					<a href="editRes.jsp?rid=${entry.getName()}" >Edit</a>
					
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