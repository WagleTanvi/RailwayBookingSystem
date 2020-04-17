<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Messaging</title>
    <style>
        h3 {
            font-size: 40px;
            text-align: center;
            margin: 15px 0px 15px 0px;
        }

        body {
            margin: 10px 30px 30px 30px;
            border: 1px solid black;
            padding: 0% 2% 1% 2%;
            background-color: #F6F4F3;
            font-family: Arial, Helvetica, sans-serif;
        }

        button {
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }

        div {
            padding: 10px 15px 10px 15px;
        }
        
        span {
        	color: #AC80A0;
        }

        .posts {
            border: 1px solid black;
            height: 160px;
            margin: 10px 0px 10px 0px;
        }

        .alert {
            border: 1px solid black;
            height: 100px;
            margin: 10px 0px 10px 0px;
            background-color: #F03A47;
        }

        .posts h2 {
            margin: 0px 0px 0px 0px;
        }

        .posts button {
            position: absolute;
            right: 8%;
            font-size: 14px;
            width: 14%;
            margin-bottom: 40%;
            background-color: #183059;
            float: right;
            margin: 0 auto;
            display: block;
        }

        .posts p {
            float: left;
            width: 65%;
            margin: 0.5% 0px 0.5% 0px;
        }

        #forumPost {
            width: 80%;
            height: 80%;
            background-color: black;
            position: absolute;
            left: 10%;
            top: 10%;
            display: none;
        }

        #forumPost input {
            left: 5%;
            position: absolute;
            top: 5%;
            font-size: 25px;
        }

        #forumPost textarea {
            position: absolute;
            left: 5%;
            top: 15%;
            width: 90%;
            height: 70%;
            font-size: 20px;
        }

        #forumPost button {
            position: absolute;
            background-color: #008CBA;
            width: 20%;
            bottom: 3%;
            left: 40%;
        }

        #questionQuery {
            width: 355px;
            height: 30px;
            font-size: 30px;
        }

        #askQuestion {
            background-color: #008CBA;
            margin: auto;
            margin-left: 40%;
            width: 20%;
        }
    </style>
</head>

<body>
    <h3>Messaging</h3>
    <input id="questionQuery" type="text" placeholder="Search for a question here!"></input>
    
    <form action = messaging.jsp method="POST">
    	<div id="forumPost">
    		<input name="subject" id="questionQuery" type="text" placeholder="Subject"></input>
    		<textarea name="content" placeholder="What's wrong?"></textarea>
	        <button onClick="postToDB()">Post Question</button>
	    </div>
    </form>


    <div class="alert">
    	<h2>__TRANSIT LINE__ DELAYED __MINS__</h2>
    </div>
    
    <%
		//FOR THIS PAGE TO WORK, MAKE SURE TO LOG IN FIRST AT index.jsp
		System.out.println("Role of current viewer: " + session.getAttribute("role"));
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String msgQuery = "SELECT * FROM messaging";
		
		ResultSet rs = stmt.executeQuery(msgQuery);
		
		System.out.println("Getting number of posts...");
		int count = 0;
		String postView = "";
		while(rs.next()) {
			System.out.println(rs.getInt("mid"));
			
			if(session.getAttribute("role").equals("administrator") || session.getAttribute("role").equals("customer_service_rep")) {
				postView += "<div class=\"posts\">" + 
										"<h2>" + rs.getString("subject") + " - " + "<span>" + rs.getString("user") + "</span>" + "&emsp;ticketID: " + rs.getInt("mid") + "</h2>" + 
										"<p>" + rs.getString("content") + "</p>" +
										"<button>Troubleshoot/Solve (Admin Only)</button>" + 
				  				  "</div>";
			} else {
				postView += "<div class=\"posts\">" + 
										"<h2>" + rs.getString("subject") + " - " + "<span>" + rs.getString("user") + "</span>" + "</h2>" + 
										"<p>" + rs.getString("content") + "</p>" +
								  "</div>";
			}
		}
		
		if(postView.length() == 0) {
			out.println("<h3>No posts.</h3>");
		} else {
			out.println(postView);
		}
		
	%>

    <button id="askQuestion" onClick="questionPost()">Ask a question</button>
    <script>
    	function questionPost() {
    		document.getElementById("forumPost").style.display = "block";
    	}
    	
    	//In admin view, each forum post will have the mid in the 
    	function postToDB() {
    		<%
	        	System.out.println("postToDB");
	        	String subject = request.getParameter("subject");
	    	    String content = request.getParameter("content");
	    	    if(subject != null && content != null) {
	    	   		System.out.println("subject: " + subject);
	    		    System.out.println("content: " + content);
	    	    }
    		%>
    	}
    </script>
</body>

</html>