<!-- Written By: Tanvi Wagle tnw39 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Schedule</title>
</head>
<style>

.overlay {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.7);
 /*  transition: opacity 500ms;
  visibility: hidden;
  opacity: 0; */
}
.popup {
  margin: 70px auto;
  padding: 20px;
  background: #fff;
  border-radius: 5px;
  width: 30%;
  position: relative;
  transition: all 5s ease-in-out;
  text-align: center;
}

.popup h2 {
  margin-top: 0;
  color: #333;
  font-family: Tahoma, Arial, sans-serif;
}
.popup .content {
  max-height: 30%;
  overflow: auto;
}

@media screen and (max-width: 700px){
  .popup{
    width: 70%;
  }
}
</style>
<body>
	<%  
		if (request.getParameter("button") != null){
			session.setAttribute("changeType", request.getParameter("button"));
		}
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * from transit_line;");
		ArrayList<String> lines = new ArrayList<String> ();
		while (rs.next()){
			lines.add(rs.getString("tl_name"));
		}
		db.closeConnection(con);
	%>
	<button style="background-color: green; position:absolute; top:20px; left: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="HandleChangeTrainSchedule.jsp?clear=true">Home</a></button>
	<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
	<h2 style="text-align:center"> Modify Train Schedule</h2>
	<div style="display: flex; justify-content:center;" >
	<form method="get" action="HandleChangeTrainSchedule.jsp">
		<select name="line" id ="line" <% if (session.getAttribute("schedule_nums") != null){ %> disabled <%} %>> 
				<%if (session.getAttribute("schedule_nums") == null){ %>
					<option  disabled selected>Select Transit Line</option>
				<% } %>
	        <%  for (String s : lines){  
	        	String s_temp = s.replace(" ", "+");
	        	if (session.getAttribute("schedule_nums") != null 
	        			&& session.getAttribute("change_line").equals(s)){
	        %>
	            <option value=<%= s_temp %>  selected><%= s %></option>
	        <%
	        		} else{
	        %>
	        	<option value=<%= s_temp %>><%= s %></option>
	        <% }} %>
	    </select> 
	    <input type="submit" value="Select" />
	   <button onClick ="HandleChangeTrainSchedule.jsp" name= "clear" id="clear">Clear</button> 
    </form>
    </div>
    
    <div style="display: flex; justify-content:center;" >
    <% if (session.getAttribute("schedule_nums") != null){ %>
    <table style="border: 1px solid black; border-collapse: collapse; flex-wrap: wrap; align-content:center;" >
		<tr> 
			<th style="border: 1px solid black;"> Schedule Num </th>
			<th style="border: 1px solid black;">   </th>
		</tr>
			<% for (Integer t: (ArrayList<Integer>)session.getAttribute("schedule_nums")){
				%>
				<tr>
					<td style="border: 1px solid black;"><%= t %></td>
					<% if (session.getAttribute("changeType").equals("delete")){ %>
						<td style="border: 1px solid black;"><button><a href="HandleChangeTrainSchedule.jsp?schedule=<%=t%>">Delete</a></button></td>
					<% } else { %>
						<td style="border: 1px solid black;"><button><a href="updateTrainSchedule.jsp?schedule=<%=t%>">Update</a></button></td>
					<%} %>
				</tr>
				<% 
			}%>
	</table>
	<%} %>
	</div>
	
	<% if (session.getAttribute("change_msg") != null && !session.getAttribute("change_msg").equals("Please input transit line.")) {  %>
		<% if (session.getAttribute("change_msg").equals("Successfully Deleted!")) {
			 session.removeAttribute("schedule_nums");
			 session.removeAttribute("changeType");
			 session.removeAttribute("change_line");
		%>
		<div id="popup1" class="overlay">
			<div class="popup">
				<p><%= session.getAttribute("change_msg")%></p>
				<% session.removeAttribute("change_msg");%>
				<div class="content">
					<button><a href="manageTrainSchedule.jsp"> Go Back to Manage Train Schedule</a></button>
				</div>
			</div>
		</div>
		<%} %>
	<%} %>
	<% if (session.getAttribute("change_msg") != null && session.getAttribute("change_msg").equals("Please input transit line.")) {  %>
		<div id="popup1" class="overlay">
			<div class="popup">
				<p><%= session.getAttribute("change_msg")%></p>
				<% session.removeAttribute("change_msg");%>
				<div class="content">
					<button><a href=""> Close</a></button>
				</div>
			</div>
		</div>
	<%} %>  
</body>
</html>