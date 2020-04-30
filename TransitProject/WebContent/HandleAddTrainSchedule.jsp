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
	Enumeration pL = request.getParameterNames();
	int count = 0;
	while( pL.hasMoreElements() ){
		count++;
		System.out.println(pL.nextElement().toString());
	 } 
	System.out.println(count);
	System.out.println(request.getParameter("line") == null || request.getParameter("train_id") == null || request.getParameter("direction") == null
			|| count <= 0);
	if (request.getParameter("clear") != null && request.getParameter("clear").equals("true")){
		session.removeAttribute("add_train");
		session.removeAttribute("add_dir");
		session.removeAttribute("add_line");
		session.removeAttribute("add");
		session.removeAttribute("add_msg");
		response.sendRedirect("Home.jsp");
	}
	else{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		if (request.getParameter("clear") != null){
			if (session.getAttribute("add") != null){session.removeAttribute("add");}
			if (session.getAttribute("add_train") != null){session.removeAttribute("add_train");}
			if (session.getAttribute("add_line") != null){session.removeAttribute("add_line");}
			if (session.getAttribute("add_dir") != null){session.removeAttribute("add_dir");}
		    response.sendRedirect("addTrainSchedule.jsp");  
		}
		else if (request.getParameter("line") != null && request.getParameter("train") != null && request.getParameter("direction") != null){
			String line = request.getParameter("line").replace("+"," ");
			String dir = request.getParameter("direction");
			out.println(line);
			String statement = "Select r.route_id, r.hop_number, s1.name start, s2.name end from transit_line_route r, transit_line tl, station s1, station s2" 
					+" where r.direction=? and tl.tl_id = r.tl_id and tl.tl_name= ? and s1.station_id = r.start_station_id and s2.station_id = r.end_station_id;";
			PreparedStatement ps = con.prepareStatement(statement);
			ps.setString(1,dir);
			ps.setString(2,line);
		    ResultSet rs = ps.executeQuery();
		    ArrayList<TrainScheduleObject> list = new ArrayList<TrainScheduleObject>();
		    while (rs.next()){
				list.add(new TrainScheduleObject(
						"",
						rs.getInt("route_id"),
						rs.getInt("hop_number"),
						"",
						"",
						rs.getString("start"),
						rs.getString("end"),
						"",
						0
						)); 
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
	 		list.add(new TrainScheduleObject("",0,list.get(list.size()-1).getTrainId()+1, "", "",rs.getString("name") ,"", "", 0));
		    session.setAttribute("add", list);
		    session.setAttribute("add_train", request.getParameter("train").replace("+", " "));
		    session.setAttribute("add_line", request.getParameter("line").replace("+", " "));
		    session.setAttribute("add_dir", request.getParameter("direction"));
			response.sendRedirect("addTrainSchedule.jsp");  
		}
		else if (session.getAttribute("add_train") != null){
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
			    if (value == null || value.equals("")){
			    	session.setAttribute("add_msg", "Input Timings Please!");
				    //response.sendRedirect("addTrainSchedule.jsp"); 
				    success= false;
			    }
			    else {
			    	hops.add(Integer.parseInt(splitArr[1]));
			    	 times.add(time.valueOf(value+":00"));
			    }
			 } 
			if (success == true){
				String statement = "select min(tsm.departure_time) dt, max(tsm.arrival_time) at" 
						+" from train_schedule_assignment ta, train_schedule_timings tsm" 
						+" where ta.train_id = ? and tsm.schedule_num = ta.schedule_num group by tsm.schedule_num;";
				PreparedStatement ps = con.prepareStatement(statement);
				ps.setString(1, session.getAttribute("add_train").toString());
			    ResultSet rs = ps.executeQuery();
			    boolean validate = true;
				while (rs.next()){
					if (times.get(0).compareTo(time.valueOf(rs.getString("dt"))) >= 0 && times.get(0).compareTo(time.valueOf(rs.getString("at"))) <= 0){
						System.out.print("hey");
						validate = false;
						session.setAttribute("add_msg", "This train is already begin used during this time frame. Please choose different times.");
					}
				}
				System.out.println("VALIDATE: "+validate);
				if (validate == true){
					rs = stmt.executeQuery("Select max(schedule_num)+1 num from train_schedule_assignment;");
					rs.next();
					int schedule_num = rs.getInt("num");
					String line = ((String) session.getAttribute("add_line")).replace("+", " ");
					String train = (String) session.getAttribute("add_train");
					out.println(line);
					statement = "Select tl_id from transit_line where tl_name = ?";
					ps = con.prepareStatement(statement);
					ps.setString(1,line);
					rs = ps.executeQuery();
					rs.next();
					String tl_id = rs.getString("tl_id");
					statement = "Insert into train_schedule_assignment (schedule_num, train_id, tl_id) values (?,?,?)";
					ps = con.prepareStatement(statement);
					ps.setInt(1,schedule_num);
					ps.setInt(2, Integer.parseInt(train));
					ps.setString(3, tl_id);
					int result = ps.executeUpdate();
					if (result < 0){
						success = false;
					}
					else {
							for (int x=0; x < times.size()-1; x++){
								statement = "Select route_id from transit_line_route where tl_id = ? and hop_number=?";
							    ps = con.prepareStatement(statement);
								ps.setString(1,tl_id);
								ps.setInt(2, hops.get(x));
								rs = ps.executeQuery();
								rs.next();
								int route_number = rs.getInt("route_id");
								statement = "Insert into train_schedule_timings (schedule_num, route_id, departure_time, arrival_time) values (?,?,?,?)";
								ps = con.prepareStatement(statement);
								ps.setInt(1,schedule_num);
								ps.setInt(2, route_number);
								ps.setTime(3, times.get(x));
								ps.setTime(4, times.get(x+1));
								result = ps.executeUpdate();
								if (result < 0){
									success = false;
								}
							}
					}
					if (success == true){
						/* session.removeAttribute("add");
					    session.removeAttribute("add_train");
					    session.removeAttribute("add_line");
					    session.removeAttribute("add_dir"); */
					    session.setAttribute("add_msg", "Successfully Added!");
					    //response.
					}
				} // end of validate
			} // end of success
			response.sendRedirect("addTrainSchedule.jsp"); 
		} // end of else
		else {
			session.setAttribute("add_msg", "Please input line, train_id and direction.");
			response.sendRedirect("addTrainSchedule.jsp"); 
		}
		db.closeConnection(con);
	}
	%>
</body>
</html>