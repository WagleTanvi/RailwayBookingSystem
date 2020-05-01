<!-- Written By: Vancha Verma vv199 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<head>
<title>Edit Reservations </title>
</head>
<body>
<a style="color: black; text-decoration: none; font-size: 20px;"href="Home.jsp"><button style="background-color: green; position:absolute; top:2%; left: 4%; border-radius: 10px;">Home</button></a>
<a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp"><button style="background-color: red; position:absolute; top:2%; right: 4%; border-radius: 10px;">Logout</button></a>

<h1 style="text-align:center; top:50px;"> Edit Reservation</h1>
	<div style="align:center; text-align:center; " >

	<%
	if(session.getAttribute("user") == null) {
		response.sendRedirect("index.jsp");
	}
		String rid = request.getParameter("v_val");
		String change = "";
		//session.setAttribute("changed", change);

		//String rid = request.getParameter("val");
		try{
		//connect to database
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String og = "SELECT tsa.tl_id, r.* from reservations r, train_schedule_assignment tsa WHERE r.rid = " + rid + " AND r.schedule_num = tsa.schedule_num";
		System.out.println(og);
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(og);

		ResObj entry = new ResObj();
		String sch_num = "";

		while(result.next()) {
			entry.setRid(result.getString("r.rid"));
			entry.setTransit(result.getString("tsa.tl_id"));
			entry.setResDate(result.getString("r.date_reserved"));
			entry.setBought(result.getString("r.date_ticket"));
			entry.setClass(result.getString("r.class"));
			entry.setCost("$"+ result.getString("r.total_cost"));
			if(result.getString("r.discount").equals("Normal")){
				entry.setDisc("None");
			} else {
				entry.setDisc(result.getString("r.discount"));
			}
			if(result.getString("r.trip").equals("One")){
				entry.setTrip("One-Way");
			} else {
				entry.setTrip(result.getString("r.trip"));
			}

			entry.setDest(result.getString("r.destination"));
			entry.setOrigin(result.getString("r.origin"));
			sch_num = result.getString("r.schedule_num");
		}
		//System.out.println(entry.getDest());
		//System.out.println(entry.getOrigin());

		String getSt = "SELECT distinct s.name, s.station_id"
				+ " FROM transit_line_route tlr, station s"
				+ " WHERE tlr.tl_id = '" + entry.getTransit() + "' AND tlr.start_station_id = s.station_id";
		System.out.println(getSt);
		result = stmt.executeQuery(getSt);
		ArrayList<String> stOr = new ArrayList<String>();
		ArrayList<String> st_idOr = new ArrayList<String>();

		while(result.next()){
			stOr.add(result.getString("s.name"));
			st_idOr.add(result.getString("s.station_id"));
		}

		getSt = "SELECT distinct s.name, s.station_id"
				+ " FROM transit_line_route tlr, station s"
				+ " WHERE tlr.tl_id = '" + entry.getTransit() + "' AND tlr.end_station_id = s.station_id";

		System.out.println(getSt);
		result = stmt.executeQuery(getSt);
		ArrayList<String> stDes = new ArrayList<String>();
		ArrayList<String> st_idDes = new ArrayList<String>();

		while(result.next()){
			stDes.add(result.getString("s.name"));
			st_idDes.add(result.getString("s.station_id"));
		}
		//System.out.println(entry.getDisc());

		%>

			<form action = "editRes.jsp?v_val=<%=entry.getRid()%>" method= "post">
			<p><b>Change Origin: </b>
			<select id="origin" name="origin">
			<% for(int i = 0; i < stOr.size(); i++){
				if(entry.getOrigin().equals(st_idOr.get(i))){ %>
  					<option id=<%=st_idOr.get(i)%> name="origin" value=<%=st_idOr.get(i)%> selected ><%out.print(stOr.get(i));%></option>
				<% } else { %>
					<option id=<%=st_idOr.get(i)%> name="origin" value=<%=st_idOr.get(i)%>><%out.print(stOr.get(i));%></option>
				<%}
			}%>
			</select> &nbsp;&nbsp;

			<b>Change Destination: </b>
			<select id="dest" name="dest">
			<% for(int i = 0; i < stDes.size(); i++){
				if(entry.getDest().equals(st_idDes.get(i))){ %>
  					<option id="<%=st_idDes.get(i)%>" name="dest" value=<%=st_idDes.get(i)%> selected ><%out.print(stDes.get(i));%></option>
				<% } else { %>
					<option id=<%=st_idDes.get(i)%> name="dest" value=<%=st_idDes.get(i)%>><%out.print(stDes.get(i));%></option>
				<%}
			}%>
			</select>
			<input type="submit" name = "station_change" value = "Find New Times">

			</p>
			</form>


			<%
			session.setAttribute("v_org", entry.getOrigin());
			session.setAttribute("v_dest", entry.getDest());

			if((request.getParameter("origin") != null) && (request.getParameter("dest") != null)){
				session.setAttribute("v_org", request.getParameter("origin"));
				session.setAttribute("v_dest", request.getParameter("dest"));
			}
				String getTimes = "select distinct tst.arrival_time, tst.schedule_num"
								+ " from train_schedule_timings tst, train_schedule_assignment tsa, transit_line_route tlr"
								+ " where tsa.schedule_num = tst.schedule_num AND tsa.tl_id = '" + entry.getTransit()  + "' AND tst.route_id = tlr.route_id AND tlr.start_station_id = " + session.getAttribute("v_org");

				//where tsa.schedule_num = tst.schedule_num AND tsa.tl_id = 'PB' AND tst.route_id = tlr.route_id AND tlr.start_station_id = 18;

				System.out.println(getTimes);
				result = stmt.executeQuery(getTimes);
				ArrayList<String> times = new ArrayList<String>();
				ArrayList<String> schNum = new ArrayList<String>();
				while(result.next()){
					times.add(result.getString("tst.arrival_time"));
					schNum.add(result.getString("tst.schedule_num"));
				}
			%>



			<form action = "resPage.jsp?v_rid=<%=rid%>" method= "post">

			<p><b>Change Departure Time: </b>
			<select id="schNum" name="schNum">

			<% for(int i = 0; i < times.size(); i++){
			if(sch_num.equals(schNum.get(i))){ %>
  					<option id=<%=schNum.get(i)%> name="schNum" value=<%=schNum.get(i)%> selected ><%out.print(times.get(i));%></option>
				<% } else { %>
					<option id=<%=schNum.get(i)%> name="schNum" value=<%=schNum.get(i)%>><%out.print(times.get(i));%></option>
				<%}
			} %>
			</select></p>


			<p><b>Change Ticket Type: </b></p>

			<%if(entry.getTrip().equals("One-Way")){ %>
			<input type="radio" id="one" name="trip" value="One" checked/>
				<label for="one">One-Way</label>
			<input type="radio" id="two" name="trip" value="Round">
				<label for="two">Round-Trip</label>
			<input type="radio" id="weekly" name="trip" value="Weekly">
				<label for="weekly">Weekly</label>
			<input type="radio" id="monthly" name="trip" value="Monthly">
				<label for="monthly">Monthly</label>

			<% }  else if(entry.getTrip().equals("Round")) { %>
			<input type="radio" id="one" name="trip" value="One"/>
			<label for="one">One-Way</label>
			<input type="radio" id="two" name="trip" value="Round" checked/>
			<label for="two">Round-Trip</label>
			<input type="radio" id="weekly" name="trip" value="Weekly">
			<label for="weekly">Weekly</label>
			<input type="radio" id="monthly" name="trip" value="Monthly">
			<label for="monthly">Monthly</label>

			<% }  else if(entry.getTrip().equals("Weekly")) { %>
			<input type="radio" id="one" name="trip" value="One">
			<label for="one">One-Way</label>
			<input type="radio" id="two" name="trip" value="Round">
			<label for="two">Round-Trip</label>
			<input type="radio" id="weekly" name="trip" value="Weekly"  checked/>
			<label for="weekly">Weekly</label>
			<input type="radio" id="monthly" name="trip" value="Monthly">
			<label for="monthly">Monthly</l.abel>

			<% }  else if(entry.getTrip().equals("Monthly")) { %>
			<input type="radio" id="one" name="trip" value="One">
			<label for="one">One-Way</label>
			<input type="radio" id="two" name="trip" value="Round">
			<label for="two">Round-Trip</label>
			<input type="radio" id="weekly" name="trip" value="Weekly">
			<label for="weekly">Weekly</label>
			<input type="radio" id="monthly" name="trip" value="Monthly" checked/>
			<label for="monthly">Monthly</label>
			<% } %>



			<p><b>Change Discount:</b></p>

			<%if(entry.getDisc().equals("None")){ %>
			<input type="radio" id="normal" name="discount" value="Normal" checked>
			<label for="discount">None</label>
			<input type="radio" id="senior/child" name="discount" value="Senior/Child">
			<label for="senior">Senior/Child</label>
			<input type="radio" id="disabled" name="discount" value="Disabled">
			<label for="disabled">Disabled</label>

			<% }else if(entry.getDisc().equals("Senior/Child")){ %>
			<input type="radio" id="normal" name="discount" value="Normal">
			<label for="discount">None</label>
			<input type="radio" id="senior/child" name="discount" value="Senior/Child" checked>
			<label for="senior">Senior/Child</label>
			<input type="radio" id="disabled" name="discount" value="Disabled">
			<label for="disabled">Disabled</label>

			<% }else if(entry.getDisc().equals("Disabled")){ %>
			<input type="radio" id="normal" name="discount" value="Normal">
			<label for="discount">None</label>
			<input type="radio" id="senior/child" name="discount" value="Senior/Child" >
			<label for="senior">Senior/Child</label>
			<input type="radio" id="disabled" name="discount" value="Disabled" checked>
			<label for="disabled">Disabled</label> <br>

			<% } %>

			<p><b>Change Class:</b></p>
			<%if(entry.getClas().equals("Business")){ %>
			<input type="radio" id="Economy" name="class" value="Economy">
			<label for="Economy">Economy</label>
			<input type="radio" id="Business" name="class" value="Business" checked>
			<label for="business">Business</label>
			<input type="radio" id="First" name="class" value="First">
			<label for="First">First</label>

			<% }else if(entry.getClas().equals("First")){ %>
			<input type="radio" id="Economy" name="class" value="Economy">
			<label for="Economy">Economy</label>
			<input type="radio" id="Business" name="class" value="Business">
			<label for="business">Business</label>
			<input type="radio" id="First" name="class" value="First" checked>
			<label for="First">First</label>

			<% }else if(entry.getClas().equals("Economy")){ %>
			<input type="radio" id="Economy" name="class" value="Economy" checked >
			<label for="Economy">Economy</label>
			<input type="radio" id="Business" name="class" value="Business">
			<label for="business">Business</label>
			<input type="radio" id="First" name="class" value="First">
			<label for="First">First</label>

			<% } %>

			<br><br>

			<input type="submit" name = "res_change" value = "Update">

			<a style="color: black; text-decoration: none;" href="resPage.jsp?v_val=cancel?">
			<button a style="color: black;">Cancel</button></a>

			<p><a style="color: black; text-decoration: none;" href = "resPage.jsp?v_rid=<%=rid%>">
			<button style = "color: white; background-color: red;" name = "res_change" value = "delete">Delete Reservation</button>
			</a></p>
			</form>

			<%

		db.closeConnection(con);
	} catch (Exception e) {
		out.print(e);
	}


	%>
</div>
</body>
</html>
