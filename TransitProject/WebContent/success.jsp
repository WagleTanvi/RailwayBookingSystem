<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <button
      style="
        background-color: green;
        position: absolute;
        top: 20px;
        left: 30px;
        border-radius: 10px;
      "
    >
      <a
        style="color: black; text-decoration: none; font-size: 20px;"
        href="Home.jsp"
        >Home</a
      >
    </button>
    <button
      style="
        background-color: red;
        position: absolute;
        top: 20px;
        right: 30px;
        border-radius: 10px;
      "
    >
      <a
        style="color: black; text-decoration: none; font-size: 20px;"
        href="logout.jsp"
        >Logout</a
      >
    </button>
    <% if (session.getAttribute("type").equals("register")){ %>
    <h1>
      Welcome <%out.println("<span style="color: blue;"
        >"+session.getAttribute("user")+"</span
      >.");%> Successfully Registered and logged in!
    </h1>
    <% } else if (session.getAttribute("type").equals("login")){ %>
    <h1>
      Welcome back <%out.println("<span style="color: blue;"
        >"+session.getAttribute("user")+"</span
      >.");%> Successfully Logged In!
    </h1>
    <% } %>
  </body>
</html>
