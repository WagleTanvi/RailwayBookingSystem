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
<title>Update Train Schedule</title>
</head>
<body>
	<%
	if (request.getParameter("clear") != null && request.getParameter("clear").equals("true")){
		session.removeAttribute("changeType");
		session.removeAttribute("schedule_nums");
		session.removeAttribute("change_line");
		session.removeAttribute("schedule");
		session.removeAttribute("update");
		session.removeAttribute("update_msg");
		response.sendRedirect("Home.jsp");
	}
	else{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();

		if (request.getParameter("schedule") != null){
			String line = (String) session.getAttribute("change_line");
			int schedule = Integer.parseInt(request.getParameter("schedule"));
			out.println(line);
			String statement = "Select r.route_id,r.direction, r.hop_number, s1.name start, s2.name end, tsm.departure_time, tsm.arrival_time, tsm.departure_time, tsm.schedule_num from transit_line_route r, transit_line tl, station s1, station s2, train_schedule_assignment ta, train_schedule_timings tsm"
					+" where tl.tl_id = r.tl_id and tl.tl_name=? and s1.station_id = r.start_station_id and s2.station_id = r.end_station_id and  ta.schedule_num = ? and ta.schedule_num = tsm.schedule_num and tsm.route_id = r.route_id;";
			PreparedStatement ps = con.prepareStatement(statement);
			ps.setString(1,line);
			ps.setInt(2, schedule);
		    ResultSet rs = ps.executeQuery();
		    ArrayList<TrainScheduleObject> list = new ArrayList<TrainScheduleObject>();
		    String dir = "";
		    while (rs.next()){
				list.add(new TrainScheduleObject(
						"",
						rs.getInt("route_id"),
						rs.getInt("hop_number"),
						rs.getString("departure_time"),
						rs.getString("arrival_time"),
						rs.getString("start"),
						rs.getString("end"),
						"",
						0
						)); 
				dir = rs.getString("direction");
			}
		    statement = "Select s.name from transit_line_route r, station s where r.end_station_id = s.station_id and r.route_id = ("
		    			+" Select max(r.route_id)"
		    			+" from transit_line_route r, transit_line tl, station s"
		    			+" where s.station_id = r.end_station_id and direction = ? and tl.tl_id = r.tl_id and tl.tl_name= ? );";
	 		ps = con.prepareStatement(statement);
	 		ps.setString(1,dir);
	 		ps.setString(2,line);
	 		rs = ps.executeQuery();
	 		rs.next();
	 		list.add(new TrainScheduleObject("",0,list.get(list.size()-1).getTrainId()+1, list.get(list.size()-1).getArrival(), "",rs.getString("name") ,"", "", 0));
		    session.setAttribute("update", list);
			response.sendRedirect("updateTrainSchedule.jsp");  
		}
		else{
			boolean success = true;
			Enumeration parameterList = request.getParameterNames();
			ArrayList<Integer> hops = new ArrayList<Integer>();
			ArrayList<java.sql.Time> times = new ArrayList<java.sql.Time>();
			java.sql.Time time = new java.sql.Time(123456789999l); 
			while( parameterList.hasMoreElements() )
			  {
				String param = parameterList.nextElement().toString();
				String[] splitArr = param.toString().split("_");
			    String value = request.getParameter(param);
			    /* if (value == null || value.equals("")){
			    	session.setAttribute("update_msg", "Input Timings Please!");
				    //response.sendRedirect("addTrainSchedule.jsp"); 
				    success= false;
			    }
			    else { */
			    	hops.add(Integer.parseInt(splitArr[1]));
			    	if (!value.substring(value.length()-3,value.length()).equals(":00")){
			    		value +=":00";
			    	}
			    	times.add(time.valueOf(value));
			    /* } */
			 } 
		   if (success == true){
				int schedule_num = Integer.parseInt((String)session.getAttribute("schedule"));
				String line = ((String) session.getAttribute("change_line")).replace("+", " ");
				out.println(line);
				String statement = "Select tl_id from transit_line where tl_name = ?";
				PreparedStatement ps = con.prepareStatement(statement);
				ps.setString(1,line);
				ResultSet rs = ps.executeQuery();
				rs.next();
				String tl_id = rs.getString("tl_id");
				for (int x=0; x < times.size()-1; x++){
					statement = "Select route_id from transit_line_route where tl_id = ? and hop_number=?";
				    ps = con.prepareStatement(statement);
					ps.setString(1,tl_id);
					ps.setInt(2, hops.get(x));
					rs = ps.executeQuery();
					rs.next();
					int route_number = rs.getInt("route_id");
					statement = "Update train_schedule_timings set schedule_num=?, route_id=?, departure_time=?, arrival_time=? where schedule_num=? and route_id=?";
					ps = con.prepareStatement(statement);
					ps.setInt(1,schedule_num);
					ps.setInt(2, route_number);
					ps.setTime(3, times.get(x));
					ps.setTime(4, times.get(x+1));
					ps.setInt(5,schedule_num);
					ps.setInt(6, route_number);
					int result = ps.executeUpdate();
					if (result < 0){
						success = false;
					}
				}
				if (success == true){
				    session.setAttribute("update_msg", "Successfully Updated!");
				}
			} // end of success
			response.sendRedirect("updateTrainSchedule.jsp");   
		} // end of else
		db.closeConnection(con);
	}
	%>
</body>
</html>