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
        
        .closeBtn {
			position: absolute;
			right: 5%;
			color: red;
			cursor: pointer;
			float: right;
        }

        .posts h2 {
            margin: 0px 0px 0px 0px;
        }

        .posts p {
            float: left;
            width: 45%;
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
    <%
    	//if user did not log in yet, redirect to index.jsp
    	if(session.getAttribute("role") == null) {
    		response.sendRedirect("index.jsp");
    	} else if (!(session.getAttribute("role").equals("customer"))) {
    		%>
    			<style>
    				#ticketQuery {
	    				width: 355px;
					    height: 30px;
					    font-size: 30px;
					    position: absolute;
					    top: 6%;
					    left: 5%;
    				}
    				#forumAnswer {
	    				width: 80%;
	            		height: 80%;
	            		background-color: black;
			            position: absolute;
			            left: 10%;
			            top: 10%;
			            display: none;
			            z-index: 99;
		            }
		            
		            #forumAnswer textarea {
			            position: absolute;
			            left: 5%;
			            top: 15%;
			            width: 90%;
			            height: 70%;
			            font-size: 20px;
        			}
        			
        			#forumAnswer button {
			            position: absolute;
			            background-color: #008CBA;
			            width: 20%;
			            bottom: 3%;
			            left: 40%;
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
    			</style>
    		
    		<%
    	}
    
    	//Catching for empty subject/content on forum post
		if(session.getAttribute("badPost") != null) {
			if(session.getAttribute("badPost").equals("Yes")) {
				%>
					<script>
						alert("Error. Please fill in both subject and content!");
					</script>
				<%
				//resetting badPost
				session.setAttribute("badPost", "No");
			}
		}
    	
		System.out.println("Role of current viewer: " + session.getAttribute("role"));
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
    
    %>
</head>

<body>
    <h3>Messaging</h3>
    
    <!-- TODO: need to work on search functionality  -->
    <form action = "messaging.jsp" method="POST">
    	<input name="search" id="questionQuery" type="text" onkeypress="searchEvent(e)" placeholder="Search for a question here!"></input>
    </form>
    
	<%
    	if ((session.getAttribute("role").equals("customer"))) {
    %>
		    <form action = messaging.jsp method="POST">
		    	<div id="forumPost">
		    		<div class="closeBtn" onClick="closeBox()"><h3>&#10006;</h3></div>
		    		<input name="subject" id="questionQuery" type="text" placeholder="Subject"></input>
		    		<textarea name="content" placeholder="What's wrong?"></textarea>
			        <button onClick="postToDB()">Post Question</button>
			    </div>
		    </form>
	<%
		}else if (!(session.getAttribute("role").equals("customer"))) {
    %>
    		<form action = messaging.jsp method="POST">
    			<div id="forumAnswer">
    				<div class="closeBtn" onClick="closeBox()">
    					<h3>&#10006;</h3>
    				</div>
    				<input name="ticketId" id="ticketQuery" type="text" placeholder="TicketID"></input>
    				<textarea name="answer" placeholder="Troubleshoot problem"></textarea>
	        		<button onClick="answerDB()">Post Answer</button>
	    		</div>
    		</form>
    
    <%
		}
    %>
    <!-- admin/customer service answers -->
    


    <div class="alert">
    	<h2>__TRANSIT LINE__ DELAYED __MINS__</h2>
    </div>
    
    <%	
		String msgQuery = "SELECT * FROM messaging ORDER BY mid DESC";
		
		ResultSet rs = stmt.executeQuery(msgQuery);
		
		int count = 0;
		String postView = "";
		while(rs.next()) {
			if(session.getAttribute("role").equals("administrator") || session.getAttribute("role").equals("customer_service_rep")) {
				postView += "<div class=\"posts\">" + 
										"<h2>" + rs.getString("subject") + " - " + "<span>" + rs.getString("user") + "</span>" + "&emsp;ticketID: <span>" + rs.getInt("mid") + "</h2>" + 
										"<p>" + rs.getString("content") + "</p>" +
										"<div class='answer'>" + 
											"" + //have to add "answer" section here. TODO: finish admin answering portion tomorrow if you can.
										"</div>" + 
				  				  "</div>";
			} else {
				postView += "<div class=\"posts\">" + 
										"<h2>" + rs.getString("subject") + " - " + "<span>" + rs.getString("user") + "</span>" + "</h2>" + 
										"<p>" + rs.getString("content") + "</p>" +
								  "</div>";
			}
			count++;
		}
		
		if(postView.length() == 0) {
			out.println("<h3>No posts.</h3>");
		} else {
			out.println(postView);
		}
		
		if(session.getAttribute("role").equals("customer")) {
			%> 
				<button id="askQuestion" onClick="questionPost()">Ask a question</button>
			<%
		} else 
			%>
				<button id="askQuestion" onClick='answerPost()'>Troubleshoot/Solve</button>
			<%
	%>
    <script>
    	
    	function closeBox() {
    		var answer = document.getElementById("forumAnswer");
    		var question = document.getElementById("forumPost");
    		if(answer == null) {
    			question.style.display = "none";
    		} else {
    			answer.style.display = "none";
    		}
    		
    	}
    	function searchEvent(e) {
    		
    	}
    	function questionPost() {
    		document.getElementById("forumPost").style.display = "block";
    	}
    	function answerPost() {
    		document.getElementById("forumAnswer").style.display = "block"
    	}
    	
    	//In admin view, each forum post will have the mid in the 
    	function postToDB() {
    		<%
    			String user = (String)session.getAttribute("user");
	        	String subject = request.getParameter("subject");
	    	    String content = request.getParameter("content");
	    	    if(subject != null && content != null) {
	    	   		System.out.println("subject: " + subject);
	    		    System.out.println("content: " + content);
	    		    String query = "INSERT INTO messaging (user, subject, content) VALUES (?, ?, ?)";
	    		    
	    		    System.out.println("query: " + query);
	    		    if(subject.length() == 0 || content.length() == 0) {
	    		    	System.out.println("bad post");
	    		    	session.setAttribute("badPost", "Yes");
	    		    	response.sendRedirect("messaging.jsp");
	    		    } else {
	    		    	System.out.println("good post");
	    		    	session.setAttribute("badPost", "No");
	    		    	PreparedStatement ps = con.prepareStatement(query);
		    		    ps.setString(1, user);
		    		    ps.setString(2, subject);
		    		    ps.setString(3, content);
	    		    	
		    		    if (ps.executeUpdate() != 1) {
		    		    	System.out.println("some error. Probably never going to happen but keeping it here just in case.");
		    		    }
		    		    response.sendRedirect("messaging.jsp");
	    		    }
	    	    }
    		%>
    	}
    	
    	function answerDB() {
    		<%
	        	String ticketId = request.getParameter("tickerId");
	    	    String answer = request.getParameter("answer");
    		%>
    	}
    </script>
</body>

</html>