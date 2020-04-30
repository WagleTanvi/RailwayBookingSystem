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
<body>
	<%
	if (request.getParameter("clear") != null && request.getParameter("clear").equals("true")){
		session.removeAttribute("changeType");
		session.removeAttribute("schedule_nums");
		session.removeAttribute("change_line");
		session.removeAttribute("change_msg");
		response.sendRedirect("Home.jsp");
	}
	else{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		if (request.getParameter("clear") != null){
			if (session.getAttribute("schedule_nums") != null){session.removeAttribute("schedule_nums");}
			if (session.getAttribute("change_line") != null){session.removeAttribute("change_line");}
		    response.sendRedirect("changeScheduleNumPage.jsp");  
		}
		else if (request.getParameter("line") != null){
			String line = request.getParameter("line").replace("+"," ");
			String statement = "Select ts.schedule_num from transit_line tl, train_schedule_assignment ts"
				+" where tl.tl_id = ts.tl_id and tl.tl_name = ?";
			PreparedStatement ps = con.prepareStatement(statement);
			ps.setString(1,line);
		    ResultSet rs = ps.executeQuery();
		    ArrayList<Integer> list = new ArrayList<Integer>();
		    while (rs.next()){
		    	list.add(rs.getInt("schedule_num"));
		    }
		    session.setAttribute("schedule_nums", list);
		    session.setAttribute("change_line", line);
		    response.sendRedirect("changeScheduleNumPage.jsp");
		}
		else if (request.getParameter("schedule") != null){
			int sched_num = Integer.parseInt(request.getParameter("schedule"));
			String statement = "Delete from train_schedule_assignment where schedule_num = ?;";
			PreparedStatement ps = con.prepareStatement(statement);
			ps.setInt(1,sched_num);
		    int rs = ps.executeUpdate();
		    if (rs >= 0){
		    	session.setAttribute("change_msg", "Successfully Deleted!");
		    	response.sendRedirect("changeScheduleNumPage.jsp");
		    }
		}
		else if (request.getParameter("line") == null){
			session.setAttribute("change_msg", "Please input transit line.");
	    	response.sendRedirect("changeScheduleNumPage.jsp");
		}
		db.closeConnection(con);
	}
	%>

</body>
</html>