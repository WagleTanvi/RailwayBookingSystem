<!-- Written By: Vancha Verma vv199 -->
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
	<title>Reservations</title>
</head>

<body>
<a style="color: black; text-decoration: none; font-size: 20px;"href="Home.jsp"><button style="background-color: green; font-size: 20px; position:absolute; top:2%; left: 4%; border-radius: 10px;">Home</button></a>
<a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp"><button style="background-color: red; font-size: 20px; position:absolute; top:2%; right: 4%; border-radius: 10px;">Logout</button></a>
	<%

	if((session.getAttribute("user") == null) || (session.getAttribute("role") == null))  {
		response.sendRedirect("index.jsp");
	}

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

					//System.out.println("Updated " + rid);

				}
			}

		//System.out.println("Add res: " + session.getAttribute("schedule"));


			if(session.getAttribute("schedule") != null){
					//out.print("here");
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

		//System.out.println(role + " " + (String)session.getAttribute("role"));

	if ((role.equals("customer"))) {
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
		<a style="color: black; font-size: 20px; "href="TrainSchedule.jsp">
		<button style = "font-size: 20px;"> Make Another Reservation </button>
		</a>

		<p></p> <p></p> <p></p> <p></p>
	</div>

</body>
</html>
