<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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

        .posts {
            border: 1px solid black;
            height: 160px;
            margin: 10px 0px 10px 0px;
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

    <div class="alert">

    </div>
    <div class="posts">
        <h2>Sample Post 1</h2>
    </div>
    <div class="posts">
        <h2>Sample Post 2</h2>
    </div>
    <div class="posts">
        <h2>Sample Post 3</h2>
    </div>
    <button id="askQuestion">Ask a question</button>
</body>

</html>