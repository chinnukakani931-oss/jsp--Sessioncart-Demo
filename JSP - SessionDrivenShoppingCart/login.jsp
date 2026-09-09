<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String error = "";

    if (username != null && password != null) {

        if (username.equals("admin") && password.equals("1234")) {

            // Store login status in session
            session.setAttribute("loggedIn", true);
            session.setAttribute("username", username);

            // Create cart for this user
            if (session.getAttribute("cart") == null) {
                session.setAttribute(
                    "cart",
                    new java.util.HashMap<String, Integer>()
                );
            }

%>

            <jsp:forward page="catalog.jsp" />

<%
        } else {

            error = "Invalid username or password!";

        }
    }
%>


<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Login - Shopping Cart</title>


    <style>

        /* From Uiverse.io by JohnnyCSilva */

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;

            display: flex;
            justify-content: center;
            align-items: center;

            background: #f1f1f1;

            font-family: Arial, Helvetica, sans-serif;
        }


        /* ORIGINAL CARD DESIGN */

        .card {
            width: 195px;
            height: 285px;

            background: #313131;

            border-radius: 20px;

            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;

            color: white;

            transition: 0.2s ease-in-out;

            position: relative;

            overflow: hidden;
        }


        /* ORIGINAL SVG */

        .img {
            width: 100%;
            height: 100%;

            position: absolute;

            transition: 0.2s ease-in-out;

            z-index: 1;

            padding: 35px;
        }


        /* ORIGINAL TEXTBOX */

        .textBox {
            opacity: 0;

            width: 100%;

            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;

            gap: 10px;

            transition: 0.2s ease-in-out;

            z-index: 2;

            padding: 18px;
        }


        .textBox > .text {
            font-weight: bold;
        }


        .textBox > .head {
            font-size: 20px;
        }


        .textBox > span {
            font-size: 12px;

            color: lightgrey;
        }


        /* LOGIN INPUTS */

        .login-form {
            width: 100%;

            display: flex;
            flex-direction: column;

            gap: 7px;
        }


        .login-form input {
            width: 100%;

            height: 32px;

            padding: 0 9px;

            border: none;

            outline: none;

            border-radius: 6px;

            background: #f1f1f1;

            color: #222;

            font-size: 11px;
        }


        .login-form input::placeholder {
            color: #888;
        }


        /* LOGIN BUTTON */

        .login-button {
            width: 100%;

            height: 32px;

            border: none;

            border-radius: 6px;

            background: white;

            color: #313131;

            font-size: 11px;

            font-weight: bold;

            cursor: pointer;

            transition: 0.2s ease-in-out;
        }


        .login-button:hover {
            background: #dcdcdc;
        }


        /* ERROR */

        .error {
            width: 100%;

            text-align: center;

            color: #ff6b6b;

            font-size: 10px;

            font-weight: bold;
        }


        /* DEMO LOGIN */

        .demo {
            font-size: 9px;

            color: #aaa;

            text-align: center;

            line-height: 1.4;
        }


        .demo b {
            color: white;
        }


        /* ORIGINAL HOVER EFFECT */

        .card:hover > .textBox {
            opacity: 1;
        }


        .card:hover > .img {
            height: 65%;

            filter: blur(7px);

            animation: anim 3s infinite;
        }


        @keyframes anim {

            0% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-20px);
            }

            100% {
                transform: translateY(0);
            }

        }


        .card:hover {
            transform: scale(1.04) rotate(-1deg);
        }

    </style>

</head>


<body>


<!-- ORIGINAL UIVERSE CARD -->

<div class="card">


    <!-- ORIGINAL ETHEREUM SVG -->

    <svg
        class="img"
        xmlns="http://www.w3.org/2000/svg"
        xml:space="preserve"
        width="100%"
        height="100%"
        version="1.1"
        shape-rendering="geometricPrecision"
        text-rendering="geometricPrecision"
        image-rendering="optimizeQuality"
        fill-rule="evenodd"
        clip-rule="evenodd"
        viewBox="0 0 784.37 1277.39"
        xmlns:xlink="http://www.w3.org/1999/xlink">

        <g id="Layer_x0020_1">

            <metadata
                id="CorelCorpID_0Corel-Layer">
            </metadata>

            <g id="_1421394342400">

                <g>

                    <polygon
                        fill="#343434"
                        fill-rule="nonzero"
                        points="392.07,0 383.5,29.11 383.5,873.74 392.07,882.29 784.13,650.54">
                    </polygon>

                    <polygon
                        fill="#8C8C8C"
                        fill-rule="nonzero"
                        points="392.07,0 -0,650.54 392.07,882.29 392.07,472.33">
                    </polygon>

                    <polygon
                        fill="#3C3C3B"
                        fill-rule="nonzero"
                        points="392.07,956.52 387.24,962.41 387.24,1263.28 392.07,1277.38 784.37,724.89">
                    </polygon>

                    <polygon
                        fill="#8C8C8C"
                        fill-rule="nonzero"
                        points="392.07,1277.38 392.07,956.52 -0,724.89">
                    </polygon>

                    <polygon
                        fill="#141414"
                        fill-rule="nonzero"
                        points="392.07,882.29 784.13,650.54 392.07,472.33">
                    </polygon>

                    <polygon
                        fill="#393939"
                        fill-rule="nonzero"
                        points="0,650.54 392.07,882.29 392.07,472.33">
                    </polygon>

                </g>

            </g>

        </g>

    </svg>


    <!-- LOGIN CONTENT INSIDE ORIGINAL TEXTBOX -->

    <div class="textBox">


        <p class="text head">
            Login
        </p>


        <span>
            Shopping Cart
        </span>


        <form
            class="login-form"
            method="post"
            action="login.jsp">


            <input
                type="text"
                name="username"
                placeholder="Username"
                required>


            <input
                type="password"
                name="password"
                placeholder="Password"
                required>


            <button
                type="submit"
                class="login-button">

                LOGIN

            </button>


        </form>


        <% if (!error.equals("")) { %>

            <div class="error">

                <%= error %>

            </div>

        <% } %>


        <div class="demo">

            Demo:<br>

            <b>admin</b> /
            <b>1234</b>

        </div>


    </div>


</div>


</body>

</html>
