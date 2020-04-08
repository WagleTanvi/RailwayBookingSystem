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

        .posts {
            border: 1px solid black;
            height: 160px;
            margin: 10px 0px 10px 0px;
        }
        
        .alert {
        	border: 1px solid black;
            height: 100px;
            margin: 10px 0px 10px 0px;
            background-color: red;
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
    
    <script>
    </script>
</head>

<body>
	<%
		//session.setAttribute("user", "testUsername"); // the username will be stored in the session
		//session.setAttribute("isUser", true); //!IMPORTANT: Currently assuming that all users logging in are users only.
		
		//isUser is referring to HandleLoginDetails.jsp.
		//session.setAttribute is made there. It is used to determine weather the current person logged in is a user or not
		if((Boolean)(session.getAttribute("isUser"))) {
			%>
  				<button>Hello User!</button>
			<%
		} else {
			%>
				<button>Hello Admin!</button>
			<%
		}
	%>
    <h3>Messaging</h3>
    <input id="questionQuery" type="text" placeholder="Search for a question here!"></input>

    <div class="alert">
    	<h2>__TRANSIT LINE__ DELAYED __MINS__</h2>
    </div>
    <form method="get">
    	<div class="posts">
        	<h2>Sample Post 1</h2>
        	<div>
        		<h2 type="radio">Admin: Answer Question</h2>
        	</div>
    	</div>
    	<div class="posts">
        	<h2>Sample Post 2</h2>
        	<div>
        		<h2 type="radio">Admin: Answer Question</h2>
        	</div>
    	</div>
    	<div class="posts">
        	<h2>Sample Post 3</h2>
        	<div>
        		<h2 type="radio">Admin: Answer Question</h2>
        	</div>
    	</div>
    	<button id="askQuestion">Ask a question</button>
    </form>
    
    
</body>

</html>