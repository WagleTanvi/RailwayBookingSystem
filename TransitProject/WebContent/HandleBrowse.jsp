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
		session.removeAttribute("b_data");
		session.removeAttribute("b_sort");
		session.removeAttribute("b_line");
		session.removeAttribute("b_msg");
		response.sendRedirect("Home.jsp");
	}
	else if (request.getParameter("sort") != null && request.getParameter("b_line") != null){
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	String line = request.getParameter("b_line").replace("+", " ");
	String statement = "Select tl.tl_name, s1.name start, s2.name end, tsm1.departure_time, tsm2.arrival_time, ABS(t2.hop_number - t1.hop_number + 1)*tl.fare fare, tsm1.schedule_num"
			+ " from transit_line_route t1, transit_line_route t2, transit_line tl, station s1, station s2, train_schedule_timings tsm1, train_schedule_timings tsm2"
			+" where  tl.tl_id = t1.tl_id and tl.tl_id = t2.tl_id and s1.station_id = t1.start_station_id and s2.station_id = t2.end_station_id and tsm1.route_id = t1.route_id and tsm2.route_id = t2.route_id and tsm1.schedule_num = tsm2.schedule_num and"
			+" t1.direction = t2.direction and t2.route_id >= t1.route_id and tl.tl_name = ?"
			+" order by "+ request.getParameter("sort")+";";
	PreparedStatement ps = con.prepareStatement(statement);		 
    ps.setString(1,line);
    ResultSet rs = ps.executeQuery();
	out.println(line);
	System.out.println(ps);
	ArrayList<TrainScheduleObject> list = new ArrayList<TrainScheduleObject>();
	while (rs.next()){
		list.add(new TrainScheduleObject(
				rs.getString("tl_name"),
				rs.getInt("schedule_num"),
				0,
				rs.getString("departure_time"),
				rs.getString("arrival_time"),
				rs.getString("start"),
				rs.getString("end"),
				"",
				rs.getInt("fare")
				)); 
		/* out.print(""+rs.getString("tl_name"));
		out.print("\t"+rs.getString("schedule_num"));
		out.print("\t"+rs.getString("departure"));
		out.print("\t "+rs.getString("arrival"));
		out.print("\t "+rs.getString("start"));
		out.print("\t"+rs.getString("end"));
		out.println(rs.getInt("fare"));  */
	} 
	session.setAttribute("b_line", line);
	session.setAttribute("b_data", list);
	session.setAttribute("b_sort", request.getParameter("sort"));
	response.sendRedirect("BrowseTrainSchedule.jsp"); 
	db.closeConnection(con);
	}
	else if (request.getParameter("sort") == null || request.getParameter("b_line") == null){
		session.setAttribute("b_msg", "Please choose a transit line and sort.");
		response.sendRedirect("BrowseTrainSchedule.jsp");
	}
	
	%>
</body>
</html>