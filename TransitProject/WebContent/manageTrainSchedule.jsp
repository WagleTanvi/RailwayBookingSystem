<!-- Written By: Tanvi Wagle tnw39 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Manage Train Schedule</title>
  </head>
  <style>
    .button {
      font-size: 1em;
      padding: 10px;
      color: black;
      background-color: #06d85f;
      border-radius: 20px;
      text-decoration: none;
      margin-bottom: 20px;
    }
    .button:hover {
      background-color: yellow;
    }
  </style>
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
    <h2 style="text-align: center;">Manage Train Schedule</h2>
    <div style="display: flex; justify-content: center;">
      <table>
        <tr style="margin: 20px;">
          <td>
            <a class="button" href="addTrainSchedule.jsp">Add Train Schedule</a>
          </td>
        </tr>
        <br />
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td>
            <a class="button" href="changeScheduleNumPage.jsp?button=edit"
              >Edit Train Schedule</a
            >
          </td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td>
            <a class="button" href="changeScheduleNumPage.jsp?button=delete"
              >Delete Train Schedule</a
            >
          </td>
        </tr>
      </table>
    </div>
  </body>
</html>
