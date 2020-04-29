<!-- Written By: Tanvi Wagle tnw39 and Boning Ding bnd28 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
     		try{
     			ApplicationDB db = new ApplicationDB();	
	    		Connection con = db.getConnection();
	    		Statement stmt = con.createStatement();
	    		String username = request.getParameter("username");
	    		String password = request.getParameter("password");
	    		if (username == "" || password == "" || username == null || password == null ){
	    			out.println("<h1 style='color:red'> Username/Password cannot be empty </h1> <a href='index.jsp'>Click here to try again</a>");
	    		}
	    		else if (session.getAttribute("type").equals("register")){
    	    		
    	    		String statement = "INSERT INTO users (username,password)"+ "VALUES (?,?)";
    	    		PreparedStatement ps = con.prepareStatement(statement);
    	    		ps.setString(1, username);
    	    		ps.setString(2, password);		
    	    		int x = ps.executeUpdate();
    	    		if (x == 1){
    	    			session.setAttribute("user", username);
    	    			response.sendRedirect("editPerson.jsp");

    	    		}
     			}
     			else if (session.getAttribute("type").equals("login")){
     				
     				//CODE STARTING HERE BY bnd28
     				ResultSet rs = stmt.executeQuery("select * from users where username='" + username + "' and password='" + password + "'");

     				if (rs.next()) {
     					System.out.println("Username: " + rs.getString("username"));
     					System.out.println("User's Role: " + rs.getString("role"));
     					
     					//storing information into session
     			        session.setAttribute("user", rs.getString("username"));
     			        session.setAttribute("role", rs.getString("role"));
     			        
     			        //needed for messaging.jsp delayed/early arrival functionality - written by bnd28
     			        ArrayList<String> transitLines = new ArrayList<String>();
     			        ArrayList<Integer> scheduleNums = new ArrayList<Integer>();
     			        ArrayList<String> startTimes = new ArrayList<String>();
     			        //arrivalTimeAfter compare in parallel
     			        ResultSet res = stmt.executeQuery("SELECT t.schedule_num, t.arrival_time, tl.tl_name FROM `train_schedule_timings` t, `reservations` r, `transit_line` tl, `train_schedule_assignment` tsa WHERE tsa.schedule_num = t.schedule_num AND tsa.tl_id = tl.tl_id AND t.schedule_num = r.schedule_num AND r.username='" + session.getAttribute("user") + "' ORDER BY t.arrival_time");
     			        while(res.next()) {
     			        	if(!(scheduleNums.contains(res.getInt("t.schedule_num")) && startTimes.contains(res.getString("t.arrival_time")))) {
     			        		System.out.println("transitLine: " + res.getString("tl.tl_name"));
         			        	transitLines.add(res.getString("tl.tl_name"));
         			        	
         			        	System.out.println("scheduleNum: " + res.getInt("t.schedule_num"));
         			        	scheduleNums.add(res.getInt("t.schedule_num"));
         			        	
         			        	System.out.println("startTimes: " + res.getString("t.arrival_time"));
         			        	startTimes.add(res.getString("t.arrival_time"));
     			        	}
     			        	
     			        }
     			      	
     			        session.setAttribute("transitLinesInit", transitLines);
     			        session.setAttribute("scheduleNumsInit", scheduleNums);
     			        session.setAttribute("startTimesInit", startTimes);
     			        
     			        response.sendRedirect("Home.jsp");
     			        
     			        //CODE ENDING HERE BY bnd28
     			    } else {
     			        out.println("<h1> Oops! Invalid username or password. </h1> <br> <a href='index.jsp'>Click here to try again</a>");
     			    }

     			}
     			
     			db.closeConnection(con);
	     	} catch (SQLException e) {
				if (e.getSQLState().startsWith("23")){
					session.invalidate();
					out.println("<h1 style='color:red'> Sorry. This username is already been taken! Try another one. </h1> <a href='index.jsp'>Click here to try again</a>");
				}
			}
			catch (Exception e) {
				out.print(e);
			}
     %>
</body>
</html>
