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
<title>Insert title here</title>
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
		if (request.getParameter("schedule") != null){
			session.setAttribute("schedule", request.getParameter("schedule"));
		}
		if (session.getAttribute("update") == null){
			response.sendRedirect("HandleUpdateTrainSchedule.jsp?schedule="+request.getParameter("schedule"));
		}
	%>
	<button style="background-color: green; position:absolute; top:20px; left: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="HandleUpdateTrainSchedule.jsp?clear=true">Home</a></button>
	<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
	<h2 style="text-align:center"> Update Train Schedule</h2>
	<p style="text-align:center"> Selected train schedule: <%= session.getAttribute("schedule") %></p>
    <div style="display: flex; justify-content:center;" >
    <% if (session.getAttribute("update") != null){ %>
    <form method="get" action="HandleUpdateTrainSchedule.jsp">
	    <table style="border: 1px solid black; border-collapse: collapse; flex-wrap: wrap; align-content:center;" >
			<tr> 
				<th style="border: 1px solid black;"> Stop Number </th>
				<th style="border: 1px solid black;"> Station </th>
				<th style="border: 1px solid black;"> Time </th>
			</tr>
				<% for (TrainScheduleObject t: (ArrayList<TrainScheduleObject>)session.getAttribute("update")){
					%>
					<tr>
					<%= t.getUpdateData()%>
					</tr>
					<% 
				}%>
		</table>
		<br>
		<br>
		<input style="display: flex; justify-content:center;" type="submit" value="Update Schedule" />
	</form>
	<%} %>
	</div>
	<% if (session.getAttribute("update_msg") != null) {  %>
		<% if (session.getAttribute("update_msg").equals("Successfully Updated!")) {
			session.removeAttribute("update");
			session.removeAttribute("schedule_nums");
		    session.removeAttribute("changeType");
		    session.removeAttribute("schedule");
		    session.removeAttribute("change_line");
		%>
		<div id="popup1" class="overlay">
			<div class="popup">
				<p><%= session.getAttribute("update_msg")%></p>
				<% session.removeAttribute("update_msg");%>
				<div class="content">
					<button><a href="manageTrainSchedule.jsp"> Go Back to Manage Train Schedule</a></button>
				</div>
			</div>
		</div>
		<%} %>
	<%} %> 
</body>
</html>