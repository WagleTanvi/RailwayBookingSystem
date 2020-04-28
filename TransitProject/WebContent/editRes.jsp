<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>

<title>Edit Reservations </title>
</head>
<body>
<div style="align:center; text-align:center; " >
<h1 style="text-align:center; top:50px;"> Edit Reservation</h1>
<%		try{

			String rid = "10"; 
			
			//connect to database 
			ApplicationDB db = new ApplicationDB(); 
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String original = "SELECT * from reservations r WHERE r.rid = '" + rid + "'"; 
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(original);
			//ArrayList<ResObj> res = new ArrayList<ResObj>();
			out.print(result.getString("origin")); 
			out.print(result.getString("destination")); 
			out.print(result.getString("class")); 
			
			ResObj temp = new ResObj(result.getString("origin"), result.getString("destination"), result.getString("class")); 
			out.print("here");
			//res.add(temp); 	
%>
			<form action = "editRes.jsp" method= "post">
			<select name="class" id="Class">
			<option value=<%=(temp.getcurrClass())%> selected><%out.print(temp.getcurrClass());%></option>
  			<option value="First"> First</option>
			<option value="Business"> Business</option>
			<option value="Economy"> Economy</option>
			</select>
			
			<%
			String stations = "SELECT * from stations;"; 
			result = stmt.executeQuery(stations); %>
			
			<select name="transitLine" id="transitLine">
			<option value="" selected>All Transit Lines</option>
			<%
			while(result.next()) {	
			%>
  			
  			<option value=<%=result.getString("tl.tl_id")%> ><%out.print(result.getString("tl.tl_id"));%> </option>
			
			<%
			}
			%>
			</select>
		
			<%
			String trainID = "SELECT t.train_id from train t;"; 
			result = stmt.executeQuery(trainID); %>
			
			<select name="trainID" id="trainID">
			<option value="" selected>All Trains</option>
			<%
			while(result.next()) {	
			%>
  			
  			<option value=<%=result.getString("t.train_id")%> ><%out.print(result.getString("t.train_id"));%> </option>
			
			<%
			}
			
			
			%>
			
			</select>
		
			<INPUT TYPE="submit" VALUE="Filter"/>
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
