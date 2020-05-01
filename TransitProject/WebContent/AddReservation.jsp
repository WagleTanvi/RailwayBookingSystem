<!-- Written By: Vancha Verma vv199 and BONING DING bnd28 -->
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
	if((session.getAttribute("user") == null) || (session.getAttribute("role") == null))  {
		response.sendRedirect("index.jsp");
	}

	String username = (String) session.getAttribute("user");
	if(session.getAttribute("username") != null){
		username = (String) session.getAttribute("username");
	}


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

			//double total_cost = 0;
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

			//out.print("here");

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

			double totalFare = fare * Math.abs((destination - origin));
			System.out.println(totalFare);
			totalFare += 3.5;

			String insert = "INSERT INTO reservations "
					+ "(username, total_cost, origin, destination, schedule_num, class, date_ticket, date_reserved, booking_fee, discount, trip)"
					+ " VALUES ( '" + username + "' , "
					+ totalFare + ", "
					+ origin + " , "
					+ destination + " , "
					+ sch_num + " , '"
					+ cls + "', '"
					+ date_ticket + "', '"
					+ date_reserved + "', "
					+ 3.5 + ", '"
					+ discount + "', '"
					+ trip + "');";

			//System.out.println(insert);
			stmt.executeUpdate(insert);

			//CODE STARTING HERE BY bnd28 AND vv199
			int schedule_num = Integer.parseInt(sch_num);
			@SuppressWarnings("unchecked")
			ArrayList<String> transitLinesInit = (ArrayList<String>)session.getAttribute("transitLinesInit");
			@SuppressWarnings("unchecked")
			ArrayList<Integer> scheduleNumsInit = (ArrayList<Integer>)session.getAttribute("scheduleNumsInit");
			@SuppressWarnings("unchecked")
			ArrayList<String> startTimesInit = (ArrayList<String>)session.getAttribute("startTimesInit");

			String tst = "SELECT * from train_schedule_timings tst WHERE tst.schedule_num = " + sch_num + "ORDER BY arrival_time";
			String tsa = "SELECT tl.tl_name from transit_line tl, train_schedule_assignment tsa where tsa.schedule_num = " + sch_num + " AND tsa.tl_id = tl.tl_id;";

			String start = "";
			String tLine = "";

			if(!(scheduleNumsInit.contains(schedule_num)) && startTimesInit.contains(start)){
				ResultSet r1 = stmt.executeQuery(tst);
				ResultSet r2 = stmt.executeQuery(tsa);
				String tl_name = "";
				while(r2.next()){
					tl_name = r2.getString("tl_name");
				}

				while(r1.next()){
					startTimesInit.add(r1.getString("arrival_time"));
					scheduleNumsInit.add(schedule_num);
					transitLinesInit.add(tl_name);
				}

				transitLinesInit.add(tLine);
				scheduleNumsInit.add(schedule_num);
				startTimesInit.add(start);

			}

			session.setAttribute("transitLinesInit", transitLinesInit);
			session.setAttribute("scheduleNumsInit", scheduleNumsInit);
			session.setAttribute("startTimesInit", startTimesInit);

			//CODE ENDING HERE BY bnd28 AND vv199

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
