<!-- Written By: Vancha Verma vv199 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import= "java.time.format.DateTimeFormatter, java.time.LocalDateTime"%>
<%@ page import = "java.text.DateFormat, java.text.SimpleDateFormat, java.util.Date, java.util.Calendar"   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String username = (String) session.getAttribute("username");
	String sch_num = (String) session.getAttribute("schedule");
	String date_ticket = (String) session.getAttribute("date"); //the day its reserved for
	String or = (String) session.getAttribute("origin");
	String dest = (String) session.getAttribute("destination");
	String cls = (String) session.getAttribute("class");
	String trip = (String) session.getAttribute("trip");
	String discount = (String) session.getAttribute("discount");
	String f = (String) session.getAttribute("r_fare");
	System.out.println(username + " " + sch_num + " " + date_ticket +  " " + or + " " + dest + " " + cls + " " + trip + " " + discount + " " + f);

	try{

			//connect to database
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();

			Date date = Calendar.getInstance().getTime();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		    Date dateobj = new Date();
		    System.out.println(df.format(dateobj));

			int total_cost = 0;
			int fare = Integer.parseInt(f);
			int origin = 0;
			int destination = 0;
			String date_reserved = df.format(dateobj);

			String getStation = "SELECT s.name, s.station_id FROM station s"
							+ " WHERE s.name = '" + or + "' OR s.name = '" + dest + "';";
			//System.out.println(getStation);
			ResultSet result = stmt.executeQuery(getStation);

			while(result.next()){
				if(result.getString("name").equals(or)){
					origin = result.getInt("station_id");
				} else if(result.getString("name").equals(dest)){
					destination = result.getInt("station_id");
				}
			}

			out.print("here");

			if(trip.equals("Round")){
				fare = fare *2;
			} else if (trip.equals("Monthly")){
				fare = fare * 30;
			} else if (trip.equals("Weekly")) {
				fare = fare * 7;
			}

			if(discount.equals("Senior/Child") || discount.equals("Disabled") ){
				fare = fare/2;
			}

			if(cls.equals("First") || cls.equals("Buisness") ){
				fare = fare + 5;
			}

			total_cost = fare * (destination - origin);
			total_cost += 3.5;

			String insert = "INSERT INTO reservations "
					+ "(username, total_cost, origin, destination, schedule_num, class, date_ticket, date_reserved, booking_fee, discount, trip)"
					+ " VALUES ( '" + username + "' , "
					+ total_cost + ", "
					+ origin + " , "
					+ destination + " , "
					+ sch_num + " , '"
					+ cls + "', '"
					+ date_ticket + "', '"
					+ date_reserved + "', "
					+ 3.5 + ", '"
					+ discount + "', '"
					+ trip + "');";

			System.out.println(insert);
			stmt.executeUpdate(insert);

			int schedule_num = Integer.parseInt(sch_num);
			ArrayList<String> transitLine = new ArrayList<String>();
			ArrayList<Integer> scheduleNums = new ArrayList<Integer>();
			ArrayList<String> startTimes = new ArrayList<String>();

			String tst = "SELECT * from train_schedule_timings tst WHERE tst.schedule_num = '" + sch_num + "'";
			String tsa = "SELECT * from train_schedule_assignment tsa WHERE tsa.schedule_num = '" + sch_num + "'";
			ResultSet r1 = stmt.executeQuery(tst);
			String start = "";
			String tLine = "";

			while(r1.next()){
				start = r1.getString("arrival_time");
			}
			ResultSet r2 = stmt.executeQuery(tsa);

			while(r1.next()){
				tLine = r2.getString("tl_name");
			}

			if(!(scheduleNums.contains(schedule_num)) && startTimes.contains(start)){
				transitLine.add(tLine);
				scheduleNums.add(schedule_num);
				startTimes.add(start);
				session.setAttribute("transitLinesInit", transitLine);
				session.setAttribute("scheduleNumsInit", scheduleNums);
				session.setAttribute("startTimesInit", startTimes);

			}


			session.removeAttribute("username");
			session.removeAttribute("schedule");
			session.removeAttribute("date"); //the day its reserved for
			session.removeAttribute("origin");
			session.removeAttribute("destination");
			session.removeAttribute("class");
			session.removeAttribute("trip");
			session.removeAttribute("discount");
			session.removeAttribute("r_fare");

			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}



%>

</body>
</html>
