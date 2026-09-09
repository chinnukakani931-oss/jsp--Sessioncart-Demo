<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");

    if (loggedIn == null || !loggedIn) {
%>
        <jsp:forward page="login.jsp" />
<%
        return;
    }

    java.util.HashMap<String, Integer> cart =
        (java.util.HashMap<String, Integer>) session.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
%>
        <jsp:forward page="cart.jsp" />
<%
        return;
    }

    int purchasedItems = 0;

    for (Integer quantity : cart.values()) {
        purchasedItems += quantity;
    }

    /*
     * application is shared by every user session.
     *
     * Synchronization prevents two users checking out
     * at exactly the same time from overwriting the value.
     */
    synchronized (application) {

        Integer totalSold =
            (Integer) application.getAttribute("totalSold");

        if (totalSold == null) {
            totalSold = 0;
        }

        totalSold = totalSold + purchasedItems;

        application.setAttribute("totalSold", totalSold);
    }

    // Save order information in the request
    request.setAttribute("purchasedItems", purchasedItems);

    // Clear this user's cart after successful purchase
    cart.clear();

    String username =
        (String) session.getAttribute("username");

    Integer totalSold =
        (Integer) application.getAttribute("totalSold");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Checkout</title>

    <style>

        body {
            font-family: Arial;
            background: #f5f5f5;
        }

        .checkout-box {
            width: 600px;
            margin: 80px auto;
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 0 15px #ccc;
        }

        .success {
            color: green;
            font-size: 50px;
        }

        .button {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .store {
            background: #fff3cd;
            padding: 15px;
            margin-top: 20px;
        }

    </style>

</head>

<body>

<div class="checkout-box">

    <div class="success">✅</div>

    <h1>Order Successful!</h1>

    <p>
        Thank you, <b><%= username %></b>.
    </p>

    <p>
        Items purchased:
        <b><%= request.getAttribute("purchasedItems") %></b>
    </p>

    <div class="store">

        <b>Store-wide Statistics</b>

        <p>
            Total items sold by all users:
            <strong><%= totalSold %></strong>
        </p>

    </div>

    <a class="button" href="catalog.jsp">
        Continue Shopping
    </a>

</div>

</body>

</html>