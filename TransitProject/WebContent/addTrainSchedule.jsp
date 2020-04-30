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
<title>Add Train Schedule</title>
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
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	
	/* Get stations for the Origin and Destination Dropdown */
	ResultSet rs = stmt.executeQuery("SELECT * from transit_line;");
	ArrayList<String> lines = new ArrayList<String> ();
	while (rs.next()){
		lines.add(rs.getString("tl_name"));
	}
	rs = stmt.executeQuery("SELECT * from train;");
	ArrayList<String> trains = new ArrayList<String> ();
	while (rs.next()){
		trains.add(rs.getString("train_id"));
	}
	db.closeConnection(con);
	%>
	<button style="background-color: green; position:absolute; top:20px; left: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="HandleAddTrainSchedule.jsp?clear=true">Home</a></button>
	<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
	<h2 style="text-align:center"> Add Train Schedule</h2>
	<div style="display: flex; justify-content:center;" >
	<form method="get" action="HandleAddTrainSchedule.jsp">
		<select name="line" id ="line" <% if (session.getAttribute("add") != null){ %> disabled <%} %>> 
				<%if (session.getAttribute("add") == null){ %>
					<option  disabled selected>Select Transit Line</option>
				<% } %>
	        <%  for (String s : lines){  
	        	String s_temp = s.replace(" ", "+");
	        	if (session.getAttribute("add") != null && session.getAttribute("add_line").equals(s)){
	        %>
	            <option value=<%= s_temp %>  selected><%= s %></option>
	        <%
	        		} else{
	        %>
	        	<option value=<%= s_temp %>><%= s %></option>
	        <% }} %>
	    </select> 
	    <select name="train" id ="train" <% if (session.getAttribute("add") != null){ %> disabled <%} %>> 
			<%if (session.getAttribute("add") == null){ %>
					<option  disabled selected>Select Train</option>
			<% } %>
	        <%  for (String s : trains){ 
	        	String s_temp = s.replace(" ", "+");
	        	if (session.getAttribute("add") != null && session.getAttribute("add_train").equals(s)){
   	        %>
   	            <option value=<%= s_temp %>  selected><%= s %></option>
   	        <%
   	        		} else{
   	        %>
   	        	<option value=<%= s_temp %>><%= s %></option>
   	        <% }} %>
	    </select> 
	     <select name="direction" id ="direction" <% if (session.getAttribute("add") != null){ %> disabled <%} %>> 
			<%if (session.getAttribute("add") == null){ %>
					<option  disabled selected>Select Direction</option>
				<% } %>
	        <%if (session.getAttribute("add") != null && session.getAttribute("add_dir").equals("up")){ %>
	        	<option value="up" selected >up</option>
	        	<option value="down">down</option>
	        <%} else if (session.getAttribute("add") != null && session.getAttribute("add_dir").equals("down")){ %>
	        	<option value="up" >up</option>
	        	<option value="down" selected>down</option>
	        <%} else {%>
	        	<option value="up" >up</option>
	        	<option value="down">down</option>
	        <% } %>
	    </select> 
	    <input type="submit" value="Select" />
	   <button onClick ="HandleAddTrainSchedule.jsp" name= "clear" id="clear">Clear</button> 
    </form>
    </div>
    <br>
    <br>
    <div style="display: flex; justify-content:center;" >
    <% if (session.getAttribute("add") != null){ %>
    <form method="get" action="HandleAddTrainSchedule.jsp">
    <table style="border: 1px solid black; border-collapse: collapse; flex-wrap: wrap; align-content:center;" >
		<tr> 
			<th style="border: 1px solid black;"> Stop Number </th>
			<th style="border: 1px solid black;"> Station </th>
			<th style="border: 1px solid black;"> Time </th>
		</tr>
			<% for (TrainScheduleObject t: (ArrayList<TrainScheduleObject>)session.getAttribute("add")){
				%>
				<tr>
				<%= t.getAddData()%>
				</tr>
				<% 
			}%>
	</table>
	<br>
	<br>
	<input style="display: flex; justify-content:center;" type="submit" value="Add Schedule" />
	</form>
	<%} %>
	</div>
	<% if (session.getAttribute("add_msg") != null) {  %>
		<% if (session.getAttribute("add_msg").equals("Successfully Added!")) {
			session.removeAttribute("add");
		    session.removeAttribute("add_train");
		    session.removeAttribute("add_line");
		    session.removeAttribute("add_dir");
		%>
		<div id="popup1" class="overlay">
			<div class="popup">
				<p><%= session.getAttribute("add_msg")%></p>
				<% session.removeAttribute("add_msg");%>
				<div class="content">
					<button><a href="manageTrainSchedule.jsp"> Go Back to Manage Train Schedule</a></button>
				</div>
			</div>
		</div>
		<%} else { %>
		<div id="popup1" class="overlay">
			<div class="popup">
				<p><%= session.getAttribute("add_msg")%></p>
				<% session.removeAttribute("add_msg");%>
				<div class="content">
					<button><a href=""> close </a></button>
				</div>
			</div>
		</div>
		<%} %>	
	<%} %>
</body>
</html>