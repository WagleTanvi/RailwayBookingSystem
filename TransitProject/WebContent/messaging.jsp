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
		//FOR THIS PAGE TO WORK, MAKE SURE TO LOG IN FIRST AT index.jsp.
		//session.setAttribute("isUser", false); //UNCOMMENT THIS FOR ADMIN VIEW.
		System.out.println("Role of current viewer: " + session.getAttribute("role"));
	%>
    <h3>Messaging</h3>
    <input id="questionQuery" type="text" placeholder="Search for a question here!"></input>

    <div class="alert">
    	<h2>__TRANSIT LINE__ DELAYED __MINS__</h2>
    </div>
    <div class="posts">
       	<h2>Sample Post 1</h2>
       	<p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et
            dolore magna aliqua. Orci ac auctor augue mauris augue neque gravida in fermentum. Faucibus interdum posuere
            lorem ipsum dolor sit. Mi tempus imperdiet nulla malesuada pellentesque elit eget. Cras semper auctor neque
            vitae. Ipsum consequat nisl vel pretium. In nulla posuere sollicitudin aliquam. Enim praesent elementum
            facilisis leo vel fringilla est. Fringilla est ullamcorper eget nulla facilisi etiam. Nisl pretium fusce id
            velit ut tortor pretium. Tristique nulla aliquet enim tortor at auctor. Est placerat in egestas erat
            imperdiet sed.
        </p>
       	<%
			//isUser is referring to HandleLoginDetails.jsp.
			//session.setAttribute is made there. It is used to determine weather the current person logged in is a user or not
			if(session.getAttribute("role").equals("administrator") || session.getAttribute("role").equals("customer_service_rep")) {
				%>
					<button>Troubleshoot/Solve (Admin Only)</button>
				<%
			}
		%>
    </div>
    <div class="posts">
       	<h2>Sample Post 2</h2>
       	<p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et
            dolore magna aliqua. Orci ac auctor augue mauris augue neque gravida in fermentum. Faucibus interdum posuere
            lorem ipsum dolor sit. Mi tempus imperdiet nulla malesuada pellentesque elit eget. Cras semper auctor neque
            vitae. Ipsum consequat nisl vel pretium. In nulla posuere sollicitudin aliquam. Enim praesent elementum
            facilisis leo vel fringilla est. Fringilla est ullamcorper eget nulla facilisi etiam. Nisl pretium fusce id
            velit ut tortor pretium. Tristique nulla aliquet enim tortor at auctor. Est placerat in egestas erat
            imperdiet sed.
        </p>
       	<%
			if(session.getAttribute("role").equals("administrator") || session.getAttribute("role").equals("customer_service_rep")) {
				%>
					<button>Troubleshoot/Solve (Admin Only)</button>
				<%
			}
		%>
    </div>
    <div class="posts">
       	<h2>Sample Post 3</h2>
       	<p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et
            dolore magna aliqua. Orci ac auctor augue mauris augue neque gravida in fermentum. Faucibus interdum posuere
            lorem ipsum dolor sit. Mi tempus imperdiet nulla malesuada pellentesque elit eget. Cras semper auctor neque
            vitae. Ipsum consequat nisl vel pretium. In nulla posuere sollicitudin aliquam. Enim praesent elementum
            facilisis leo vel fringilla est. Fringilla est ullamcorper eget nulla facilisi etiam. Nisl pretium fusce id
            velit ut tortor pretium. Tristique nulla aliquet enim tortor at auctor. Est placerat in egestas erat
            imperdiet sed.
        </p>
       	<%
			if(session.getAttribute("role").equals("administrator") || session.getAttribute("role").equals("customer_service_rep")) {
				%>
					<button>Troubleshoot/Solve (Admin Only)</button>
				<%
			}
		%>
    </div>
    <button id="askQuestion">Ask a question</button>
    
    
</body>

</html>