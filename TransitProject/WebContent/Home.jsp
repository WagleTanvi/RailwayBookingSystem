<!-- Written By: Zaid Meer zsm7 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
<h1> Home </h1>
<% 
session.setAttribute("filterRole", "all");
String browseLink = "BrowseTrainSchedule.jsp";
String scheduleLink = "TrainSchedule.jsp";
String manageLink = "manageTrainSchedule.jsp";
String resLink = "resPage.jsp";
String mesLink = "messaging.jsp";
String saleLink = "salesReport.jsp";
String userLink = "People.jsp";
%>

<% if(session.getAttribute("role").equals("customer_service_rep")){ %>
<input type = "button" value = "Browse All Train Schedules" onClick = "javascript:window.location='<%=browseLink%>';">
<input type = "button" value = "Reserve/View Train Schedules" onClick = "javascript:window.location='<%=scheduleLink%>';">
<input type = "button" value = "Manage Train Schedule" onClick = "javascript:window.location='<%=manageLink%>';">
<input type = "button" value = "View Reservations" onClick = "javascript:window.location='<%=resLink %>';">
<input type = "button" value = "View Messages" onClick = "javascript:window.location='<%=mesLink%>';">
<% }   
else if(session.getAttribute("role").equals("customer")){ %>
<input type = "button" value = "Browse All Train Schedules" onClick = "javascript:window.location='<%=browseLink%>';">
<input type = "button" value = "Reserve/View Train Schedules" onClick = "javascript:window.location='<%=scheduleLink %>';">
<input type = "button" value = "View Reservations" onClick = "javascript:window.location='<%=resLink %>';">
<input type = "button" value = "View Messages" onClick = "javascript:window.location='<%=mesLink%>';">

<% } 
else if(session.getAttribute("role").equals("administrator")){ %>
<input type = "button" value = "View Users" onClick = "javascript:window.location='<%=userLink%>';">
<input type = "button" value = "Browse All Train Schedules" onClick = "javascript:window.location='<%=browseLink%>';">
<input type = "button" value = "Reserve/View Train Schedules" onClick = "javascript:window.location='<%=scheduleLink%>';">
<input type = "button" value = "Manage Train Schedule" onClick = "javascript:window.location='<%=manageLink%>';">
<input type = "button" value = "View Sales Reports" onClick = "javascript:window.location='<%=saleLink%>';">
<input type = "button" value = "View Reservations" onClick = "javascript:window.location='<%=resLink%>';">
<input type = "button" value = "View Messages" onClick = "javascript:window.location='<%=mesLink%>';">
<% } %>

</body>
</html>
