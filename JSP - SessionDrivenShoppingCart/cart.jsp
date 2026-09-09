```jsp
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    /*
     * ==========================================================
     * AUTHENTICATION CHECK
     * ==========================================================
     */

    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");

    if (loggedIn == null || !loggedIn) {
%>

        <jsp:forward page="login.jsp" />

<%
        return;
    }


    /*
     * ==========================================================
     * GET USER'S SESSION CART
     *
     * IMPORTANT:
     * catalog.jsp creates the cart as:
     *
     * HashMap<String, Integer>
     *
     * Therefore cart.jsp MUST use HashMap too.
     * ==========================================================
     */

    java.util.HashMap<String, Integer> cart =
        (java.util.HashMap<String, Integer>)
        session.getAttribute("cart");


    /*
     * If cart doesn't exist, create one.
     */

    if (cart == null) {

        cart = new java.util.HashMap<String, Integer>();

        session.setAttribute("cart", cart);
    }


    /*
     * ==========================================================
     * HANDLE CART ACTIONS
     * ==========================================================
     */

    String action = request.getParameter("action");

    String product = request.getParameter("product");


    /*
     * REMOVE PRODUCT
     */

    if ("remove".equals(action) && product != null) {

        cart.remove(product);

        response.sendRedirect("cart.jsp");

        return;
    }


    /*
     * INCREASE QUANTITY
     */

    if ("increase".equals(action) && product != null) {

        Integer quantity = cart.get(product);

        if (quantity != null) {

            cart.put(product, quantity + 1);
        }

        response.sendRedirect("cart.jsp");

        return;
    }


    /*
     * DECREASE QUANTITY
     */

    if ("decrease".equals(action) && product != null) {

        Integer quantity = cart.get(product);

        if (quantity != null) {

            if (quantity > 1) {

                cart.put(product, quantity - 1);

            } else {

                cart.remove(product);
            }
        }

        response.sendRedirect("cart.jsp");

        return;
    }


    /*
     * ==========================================================
     * CALCULATE TOTAL ITEMS
     * ==========================================================
     */

    int totalItems = 0;

    for (Integer quantity : cart.values()) {

        totalItems += quantity;
    }


    /*
     * ==========================================================
     * USER INFORMATION
     * ==========================================================
     */

    String username =
        (String) session.getAttribute("username");


    /*
     * ==========================================================
     * APPLICATION-WIDE SOLD COUNT
     * ==========================================================
     */

    Integer totalSold =
        (Integer) application.getAttribute("totalSold");

    if (totalSold == null) {

        totalSold = 0;

        application.setAttribute("totalSold", 0);
    }

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Your Shopping Cart</title>


    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        body {

            font-family:
                Arial,
                Helvetica,
                sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #f5f7fa,
                    #e8ecf3
                );

            min-height: 100vh;

            color: #222;
        }


        /*
         * HEADER
         */

        .header {

            background: #111827;

            color: white;

            padding: 18px 6%;

            display: flex;

            align-items: center;

            justify-content: space-between;
        }


        .logo {

            font-size: 21px;

            font-weight: bold;
        }


        .user {

            font-size: 14px;

            color: #d1d5db;
        }


        /*
         * MAIN
         */

        .container {

            width: 90%;

            max-width: 1100px;

            margin: 40px auto;
        }


        .page-title {

            margin-bottom: 25px;
        }


        .page-title h1 {

            font-size: 32px;

            margin-bottom: 8px;
        }


        .page-title p {

            color: #777;

            font-size: 14px;
        }


        /*
         * CART BOX
         */

        .cart-box {

            background: white;

            border-radius: 20px;

            overflow: hidden;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 10px 30px
                rgba(0,0,0,0.08);
        }


        /*
         * EMPTY CART
         */

        .empty-cart {

            padding: 70px 30px;

            text-align: center;
        }


        .empty-cart .icon {

            font-size: 65px;

            margin-bottom: 20px;
        }


        .empty-cart h2 {

            margin-bottom: 10px;
        }


        .empty-cart p {

            color: #777;

            margin-bottom: 25px;
        }


        /*
         * CART TABLE
         */

        table {

            width: 100%;

            border-collapse: collapse;
        }


        th {

            background: #111827;

            color: white;

            padding: 16px;

            font-size: 13px;

            text-align: left;
        }


        td {

            padding: 18px 16px;

            border-bottom:
                1px solid #eee;

            font-size: 14px;
        }


        tr:last-child td {

            border-bottom: none;
        }


        /*
         * PRODUCT NAME
         */

        .product-name {

            font-weight: bold;

            font-size: 16px;
        }


        .product-category {

            font-size: 11px;

            color: #777;

            margin-top: 4px;
        }


        /*
         * QUANTITY CONTROLS
         */

        .quantity {

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .quantity a {

            width: 30px;

            height: 30px;

            border-radius: 8px;

            display: flex;

            justify-content: center;

            align-items: center;

            text-decoration: none;

            color: white;

            font-weight: bold;
        }


        .increase {

            background: #16a34a;
        }


        .decrease {

            background: #f59e0b;
        }


        .quantity-number {

            min-width: 25px;

            text-align: center;

            font-weight: bold;
        }


        /*
         * REMOVE
         */

        .remove {

            display: inline-block;

            padding: 8px 12px;

            background: #fee2e2;

            color: #dc2626;

            border-radius: 8px;

            text-decoration: none;

            font-size: 12px;

            font-weight: bold;
        }


        .remove:hover {

            background: #fecaca;
        }


        /*
         * TOTAL
         */

        .total-row {

            background: #f9fafb;
        }


        .total-row td {

            font-size: 17px;

            font-weight: bold;

            padding: 20px 16px;
        }


        .total-number {

            color: #4f46e5;

            font-size: 22px;
        }


        /*
         * BUTTONS
         */

        .actions {

            padding: 25px;

            display: flex;

            justify-content: space-between;

            gap: 15px;

            flex-wrap: wrap;
        }


        .button {

            display: inline-block;

            padding: 12px 20px;

            border-radius: 10px;

            text-decoration: none;

            font-size: 13px;

            font-weight: bold;

            transition: 0.2s;
        }


        .continue {

            background: #e5e7eb;

            color: #111827;
        }


        .continue:hover {

            background: #d1d5db;
        }


        .checkout {

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            color: white;

            box-shadow:
                0 7px 15px
                rgba(79,70,229,0.2);
        }


        .checkout:hover {

            transform: translateY(-2px);
        }


        /*
         * STORE INFO
         */

        .store-info {

            margin-top: 25px;

            background:
                #fff7ed;

            border: 1px solid #fed7aa;

            padding: 18px;

            border-radius: 14px;

            color: #9a3412;

            font-size: 13px;
        }


        /*
         * RESPONSIVE
         */

        @media (max-width: 700px) {

            .container {

                width: 94%;
            }


            table {

                font-size: 12px;
            }


            th,
            td {

                padding: 12px 8px;
            }


            .page-title h1 {

                font-size: 25px;
            }


            .quantity {

                gap: 5px;
            }


            .quantity a {

                width: 27px;

                height: 27px;
            }

        }

    </style>

</head>


<body>


<!-- ==========================================================
     HEADER
     ========================================================== -->

<div class="header">

    <div class="logo">

        🛒 ShopEasy

    </div>


    <div class="user">

        Welcome,
        <strong><%= username %></strong>

    </div>

</div>



<!-- ==========================================================
     MAIN
     ========================================================== -->

<div class="container">


    <div class="page-title">

        <h1>
            Your Shopping Cart
        </h1>

        <p>
            Review your selected products before checkout.
        </p>

    </div>



    <div class="cart-box">


<%
    /*
     * ========================================================
     * EMPTY CART
     * ========================================================
     */

    if (cart.isEmpty()) {
%>

        <div class="empty-cart">

            <div class="icon">
                🛒
            </div>

            <h2>
                Your cart is empty
            </h2>

            <p>
                You haven't added any products yet.
            </p>

            <a
                href="catalog.jsp"
                class="button checkout">

                Browse Products

            </a>

        </div>

<%
    } else {
%>


        <!-- ==================================================
             CART TABLE
             ================================================== -->

        <table>

            <tr>

                <th>
                    Product
                </th>

                <th>
                    Quantity
                </th>

                <th>
                    Actions
                </th>

            </tr>


<%
        /*
         * Loop through HashMap
         */

        for (
            java.util.Map.Entry<String, Integer> entry
            : cart.entrySet()
        ) {

            String productName =
                entry.getKey();

            Integer quantity =
                entry.getValue();
%>


            <tr>


                <td>

                    <div class="product-name">

                        <%= productName %>

                    </div>


                    <div class="product-category">

                        Selected Product

                    </div>

                </td>


                <td>

                    <div class="quantity">


                        <a
                            class="decrease"
                            href="cart.jsp?action=decrease&product=<%= java.net.URLEncoder.encode(productName, "UTF-8") %>">

                            −

                        </a>


                        <span class="quantity-number">

                            <%= quantity %>

                        </span>


                        <a
                            class="increase"
                            href="cart.jsp?action=increase&product=<%= java.net.URLEncoder.encode(productName, "UTF-8") %>">

                            +

                        </a>


                    </div>

                </td>


                <td>

                    <a
                        class="remove"
                        href="cart.jsp?action=remove&product=<%= java.net.URLEncoder.encode(productName, "UTF-8") %>">

                        Remove

                    </a>

                </td>


            </tr>


<%
        }
%>


            <!-- TOTAL -->

            <tr class="total-row">

                <td>

                    Total Items

                </td>


                <td>

                    <span class="total-number">

                        <%= totalItems %>

                    </span>

                </td>


                <td>

                    item(s)

                </td>

            </tr>


        </table>



        <!-- ==================================================
             BUTTONS
             ================================================== -->

        <div class="actions">


            <a
                href="catalog.jsp"
                class="button continue">

                ← Continue Shopping

            </a>


            <a
                href="checkout.jsp"
                class="button checkout">

                Proceed to Checkout →

            </a>


        </div>


<%
    }
%>


    </div>



    <!-- ======================================================
         APPLICATION SCOPE INFORMATION
         ====================================================== -->

    <div class="store-info">

        <strong>
            Store-wide Sales:
        </strong>

        <%= totalSold %>

        item(s) have been sold across all active
        user sessions.

    </div>


</div>

</body>

</html>
```
