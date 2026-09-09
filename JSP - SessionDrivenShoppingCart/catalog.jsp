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
     * USER INFORMATION
     * ==========================================================
     */

    String username = (String) session.getAttribute("username");


    /*
     * ==========================================================
     * SESSION CART
     *
     * The cart belongs only to this user's session.
     * ==========================================================
     */

    java.util.HashMap<String, Integer> cart =
        (java.util.HashMap<String, Integer>) session.getAttribute("cart");

    if (cart == null) {

        cart = new java.util.HashMap<String, Integer>();

        session.setAttribute("cart", cart);
    }


    /*
     * ==========================================================
     * ADD PRODUCT TO CART
     *
     * request.getParameter("add") demonstrates the
     * JSP request implicit object.
     * ==========================================================
     */

    String addProduct = request.getParameter("add");

    if (addProduct != null && !addProduct.trim().isEmpty()) {

        Integer quantity = cart.get(addProduct);

        if (quantity == null) {

            cart.put(addProduct, 1);

        } else {

            cart.put(addProduct, quantity + 1);
        }

        /*
         * Redirect prevents the product from being added again
         * when the browser refreshes the page.
         */
        response.sendRedirect("catalog.jsp");
        return;
    }


    /*
     * ==========================================================
     * CART COUNT
     * ==========================================================
     */

    int cartCount = 0;

    for (Integer quantity : cart.values()) {

        cartCount += quantity;
    }


    /*
     * ==========================================================
     * APPLICATION SCOPE
     *
     * totalSold is shared by the entire application.
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

    <title>ShopEasy - Product Catalog</title>


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
                    #e9eef5
                );

            min-height: 100vh;

            color: #222;
        }


        /*
         * ======================================================
         * HEADER
         * ======================================================
         */

        .header {

            width: 100%;

            background:
                rgba(20, 20, 20, 0.96);

            color: white;

            padding: 16px 5%;

            display: flex;

            justify-content: space-between;

            align-items: center;

            position: sticky;

            top: 0;

            z-index: 100;

            box-shadow:
                0 5px 20px rgba(0,0,0,0.15);
        }


        .logo {

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .logo-icon {

            width: 42px;

            height: 42px;

            background:
                linear-gradient(
                    135deg,
                    #7c3aed,
                    #2563eb
                );

            border-radius: 12px;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 22px;
        }


        .logo-text h1 {

            font-size: 21px;

            margin-bottom: 2px;
        }


        .logo-text span {

            font-size: 11px;

            color: #aaa;

            letter-spacing: 1px;
        }


        .header-right {

            display: flex;

            align-items: center;

            gap: 15px;
        }


        .welcome {

            color: #ddd;

            font-size: 14px;
        }


        .welcome strong {

            color: white;
        }


        /*
         * CART BUTTON
         */

        .cart-button {

            position: relative;

            text-decoration: none;

            color: white;

            background:
                rgba(255,255,255,0.1);

            padding: 10px 15px;

            border-radius: 10px;

            transition: 0.2s;
        }


        .cart-button:hover {

            background:
                rgba(255,255,255,0.2);

            transform: translateY(-2px);
        }


        .cart-count {

            position: absolute;

            top: -7px;

            right: -7px;

            width: 22px;

            height: 22px;

            border-radius: 50%;

            background: #ef4444;

            color: white;

            font-size: 11px;

            display: flex;

            justify-content: center;

            align-items: center;

            font-weight: bold;
        }


        /*
         * LOGOUT
         */

        .logout {

            color: #ffaaaa;

            text-decoration: none;

            font-size: 13px;

            transition: 0.2s;
        }


        .logout:hover {

            color: #ff5555;
        }


        /*
         * ======================================================
         * HERO SECTION
         * ======================================================
         */

        .hero {

            width: 90%;

            max-width: 1250px;

            margin: 35px auto 25px;

            padding: 40px;

            background:
                linear-gradient(
                    135deg,
                    #111827,
                    #1f2937,
                    #312e81
                );

            border-radius: 25px;

            color: white;

            display: flex;

            justify-content: space-between;

            align-items: center;

            overflow: hidden;

            position: relative;

            box-shadow:
                0 20px 40px rgba(0,0,0,0.16);
        }


        .hero::after {

            content: "";

            width: 280px;

            height: 280px;

            border-radius: 50%;

            position: absolute;

            right: -80px;

            top: -100px;

            background:
                rgba(255,255,255,0.08);
        }


        .hero-content {

            position: relative;

            z-index: 2;

            max-width: 650px;
        }


        .hero-content .small-title {

            color: #a5b4fc;

            font-size: 13px;

            letter-spacing: 2px;

            text-transform: uppercase;

            margin-bottom: 10px;
        }


        .hero-content h2 {

            font-size: 38px;

            line-height: 1.15;

            margin-bottom: 12px;
        }


        .hero-content p {

            color: #d1d5db;

            font-size: 15px;

            line-height: 1.6;

        }


        .hero-icon {

            font-size: 90px;

            position: relative;

            z-index: 2;

            animation: floating 3s ease-in-out infinite;
        }


        @keyframes floating {

            0% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-10px);
            }

            100% {
                transform: translateY(0);
            }
        }


        /*
         * ======================================================
         * STORE STATISTICS
         * ======================================================
         */

        .stats {

            width: 90%;

            max-width: 1250px;

            margin: 0 auto 25px;

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 15px;
        }


        .stat-card {

            background: white;

            padding: 20px;

            border-radius: 16px;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 5px 15px rgba(0,0,0,0.05);
        }


        .stat-title {

            font-size: 12px;

            color: #777;

            text-transform: uppercase;

            letter-spacing: 1px;

            margin-bottom: 7px;
        }


        .stat-value {

            font-size: 25px;

            font-weight: bold;

            color: #111827;
        }


        /*
         * ======================================================
         * PRODUCT SECTION
         * ======================================================
         */

        .container {

            width: 90%;

            max-width: 1250px;

            margin: 0 auto 60px;
        }


        .section-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 20px;

            gap: 20px;

            flex-wrap: wrap;
        }


        .section-header h2 {

            font-size: 26px;

            color: #111827;
        }


        .section-header p {

            color: #777;

            font-size: 14px;

            margin-top: 5px;
        }


        /*
         * SEARCH
         */

        .search-box {

            width: 280px;

            position: relative;
        }


        .search-box input {

            width: 100%;

            padding: 12px 15px 12px 40px;

            border: 1px solid #ddd;

            border-radius: 12px;

            outline: none;

            font-size: 13px;

            background: white;

            transition: 0.2s;
        }


        .search-box input:focus {

            border-color: #6366f1;

            box-shadow:
                0 0 0 3px rgba(99,102,241,0.1);
        }


        .search-icon {

            position: absolute;

            left: 14px;

            top: 50%;

            transform: translateY(-50%);

            color: #888;
        }


        /*
         * PRODUCT GRID
         */

        .products {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 22px;
        }


        /*
         * PRODUCT CARD
         */

        .product {

            background: white;

            border-radius: 20px;

            overflow: hidden;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 10px 25px rgba(0,0,0,0.07);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease;

            display: flex;

            flex-direction: column;
        }


        .product:hover {

            transform:
                translateY(-7px);

            box-shadow:
                0 20px 35px rgba(0,0,0,0.12);
        }


        /*
         * IMAGE AREA
         */

        .product-image {

            width: 100%;

            height: 220px;

            overflow: hidden;

            background: #f3f4f6;

            position: relative;
        }


        .product-image img {

            width: 100%;

            height: 100%;

            object-fit: cover;

            transition:
                transform 0.4s ease;
        }


        .product:hover
        .product-image img {

            transform: scale(1.07);
        }


        .badge {

            position: absolute;

            top: 12px;

            left: 12px;

            background:
                rgba(17,24,39,0.9);

            color: white;

            font-size: 10px;

            font-weight: bold;

            padding: 6px 9px;

            border-radius: 20px;

            text-transform: uppercase;

            letter-spacing: 0.5px;
        }


        /*
         * PRODUCT CONTENT
         */

        .product-info {

            padding: 18px;

            display: flex;

            flex-direction: column;

            flex: 1;
        }


        .category {

            color: #6366f1;

            font-size: 11px;

            text-transform: uppercase;

            font-weight: bold;

            letter-spacing: 1px;

            margin-bottom: 7px;
        }


        .product-name {

            font-size: 19px;

            font-weight: bold;

            color: #111827;

            margin-bottom: 7px;
        }


        .description {

            color: #777;

            font-size: 12px;

            line-height: 1.5;

            min-height: 38px;

            margin-bottom: 15px;
        }


        .price-row {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-top: auto;

            margin-bottom: 15px;
        }


        .price {

            font-size: 22px;

            font-weight: bold;

            color: #111827;
        }


        .rating {

            font-size: 12px;

            color: #f59e0b;
        }


        /*
         * ADD TO CART BUTTON
         */

        .add-button {

            width: 100%;

            border: none;

            padding: 12px;

            border-radius: 11px;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            color: white;

            text-decoration: none;

            text-align: center;

            font-size: 13px;

            font-weight: bold;

            transition: 0.2s;

            cursor: pointer;

            display: block;
        }


        .add-button:hover {

            transform: translateY(-2px);

            box-shadow:
                0 7px 15px
                rgba(79,70,229,0.3);
        }


        /*
         * ======================================================
         * FOOTER
         * ======================================================
         */

        .footer {

            background: #111827;

            color: #9ca3af;

            text-align: center;

            padding: 25px;

            font-size: 12px;
        }


        .footer strong {

            color: white;
        }


        /*
         * ======================================================
         * RESPONSIVE DESIGN
         * ======================================================
         */

        @media (max-width: 1100px) {

            .products {

                grid-template-columns:
                    repeat(3, 1fr);
            }
        }


        @media (max-width: 800px) {

            .products {

                grid-template-columns:
                    repeat(2, 1fr);
            }

            .stats {

                grid-template-columns:
                    1fr;
            }

            .hero {

                padding: 30px;

            }

            .hero-content h2 {

                font-size: 29px;
            }

            .hero-icon {

                font-size: 60px;
            }

            .welcome {

                display: none;
            }
        }


        @media (max-width: 550px) {

            .products {

                grid-template-columns:
                    1fr;
            }

            .header {

                padding: 14px 20px;
            }

            .logo-text {

                display: none;
            }

            .hero {

                width: 92%;
            }

            .container,
            .stats {

                width: 92%;
            }

            .hero-icon {

                display: none;
            }

            .search-box {

                width: 100%;
            }

        }

    </style>

</head>


<body>


<!-- ==========================================================
     HEADER
     ========================================================== -->

<header class="header">


    <div class="logo">

        <div class="logo-icon">
            🛒
        </div>


        <div class="logo-text">

            <h1>ShopEasy</h1>

            <span>
                SESSION-DRIVEN STORE
            </span>

        </div>

    </div>


    <div class="header-right">


        <div class="welcome">

            Welcome,
            <strong>
                <%= username %>
            </strong>

        </div>


        <a
            class="cart-button"
            href="cart.jsp">

            🛒 Cart

            <span class="cart-count">

                <%= cartCount %>

            </span>

        </a>


        <a
            class="logout"
            href="logout.jsp">

            Logout

        </a>

    </div>

</header>



<!-- ==========================================================
     HERO
     ========================================================== -->

<section class="hero">


    <div class="hero-content">

        <div class="small-title">

            Welcome to ShopEasy

        </div>


        <h2>

            Everything you need,
            in one place.

        </h2>


        <p>

            Browse our latest collection,
            add your favourite products to
            your session-based shopping cart
            and checkout when you're ready.

        </p>

    </div>


    <div class="hero-icon">

        🛍️

    </div>

</section>



<!-- ==========================================================
     STORE STATISTICS
     ========================================================== -->

<section class="stats">


    <div class="stat-card">

        <div class="stat-title">

            Available Products

        </div>

        <div class="stat-value">

            8+

        </div>

    </div>


    <div class="stat-card">

        <div class="stat-title">

            Your Cart

        </div>

        <div class="stat-value">

            <%= cartCount %>
            Item(s)

        </div>

    </div>


    <div class="stat-card">

        <div class="stat-title">

            Store-wide Items Sold

        </div>

        <div class="stat-value">

            <%= totalSold %>

        </div>

    </div>


</section>



<!-- ==========================================================
     PRODUCT CATALOG
     ========================================================== -->

<main class="container">


    <div class="section-header">


        <div>

            <h2>
                Featured Products
            </h2>

            <p>
                Choose your favourite products and add them to your cart.
            </p>

        </div>


        <div class="search-box">

            <span class="search-icon">
                🔍
            </span>

            <input
                type="text"
                id="searchInput"
                placeholder="Search products..."
                onkeyup="searchProducts()">

        </div>

    </div>



    <div
        class="products"
        id="productGrid">


        <!-- ==================================================
             LAPTOP
             ================================================== -->

        <div
            class="product"
            data-name="Laptop">


            <div class="product-image">

                <img
                    src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=800&q=80"
                    alt="Laptop">

                <span class="badge">
                    Popular
                </span>

            </div>


            <div class="product-info">

                <div class="category">
                    Electronics
                </div>


                <div class="product-name">
                    Premium Laptop
                </div>


                <div class="description">
                    Powerful laptop for students,
                    developers and professionals.
                </div>


                <div class="price-row">

                    <div class="price">
                        ₹55,000
                    </div>

                    <div class="rating">
                        ★ 4.8
                    </div>

                </div>


                <a
                    href="catalog.jsp?add=Laptop"
                    class="add-button">

                    🛒 Add to Cart

                </a>

            </div>

        </div>



        <!-- ==================================================
             SMARTPHONE
             ================================================== -->

        <div
            class="product"
            data-name="Smartphone">


            <div class="product-image">

                <img
                    src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=800&q=80"
                    alt="Smartphone">

                <span class="badge">
                    New
                </span>

            </div>


            <div class="product-info">

                <div class="category">
                    Electronics
                </div>


                <div class="product-name">
                    Smart Phone
                </div>


                <div class="description">
                    Modern smartphone with a beautiful
                    display and powerful performance.
                </div>


                <div class="price-row">

                    <div class="price">
                        ₹25,000
                    </div>

                    <div class="rating">
                        ★ 4.7
                    </div>

                </div>


                <a
                    href="catalog.jsp?add=Smartphone"
                    class="add-button">

                    🛒 Add to Cart

                </a>

            </div>

        </div>



        <!-- ==================================================
             HEADPHONES
             ================================================== -->

        <div
            class="product"
            data-name="Headphones">


            <div class="product-image">

                <img
                    src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80"
                    alt="Headphones">

                <span class="badge">
                    Bestseller
                </span>

            </div>


            <div class="product-info">

                <div class="category">
                    Audio
                </div>


                <div class="product-name">
                    Wireless Headphones
                </div>


                <div class="description">
                    Comfortable wireless headphones
                    with immersive sound.
                </div>


                <div class="price-row">

                    <div class="price">
                        ₹2,500
                    </div>

                    <div class="rating">
                        ★ 4.9
                    </div>

                </div>


                <a
                    href="catalog.jsp?add=Headphones"
                    class="add-button">

                    🛒 Add to Cart

                </a>

            </div>

        </div>



        <!-- ==================================================
             KEYBOARD
             ================================================== -->

        <div
            class="product"
            data-name="Keyboard">


            <div class="product-image">

                <img
                    src="https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=800&q=80"
                    alt="Keyboard">

            </div>


            <div class="product-info">

                <div class="category">
                    Computer
                </div>


                <div class="product-name">
                    Mechanical Keyboard
                </div>


                <div class="description">
                    Responsive mechanical keyboard
                    designed for gaming and work.
                </div>


                <div class="price-row">

                    <div class="price">
                        ₹1,800
                    </div>

                    <div class="rating">
                        ★ 4.6
                    </div>

                </div>


                <a
                    href="catalog.jsp?add=Keyboard"
                    class="add-button">

                    🛒 Add to Cart

                </a>

            </div>

        </div>



        <!-- ==================================================
             WATCH
             ================================================== -->

        <div
            class="product"
            data-name="Smart Watch">


            <div class="product-image">

                <img
                    src="https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=800&q=80"
                    alt="Smart Watch">

                <span class="badge">
                    Trending
                </span>

            </div>


            <div class="product-info">

                <div class="category">
                    Wearables
                </div>


                <div class="product-name">
                    Smart Watch
                </div>


                <div class="description">
                    Track your activities, notifications
                    and everyday health goals.
                </div>


                <div class="price-row">

                    <div class="price">
                        ₹4,500
                    </div>

                    <div class="rating">
                        ★ 4.5
                    </div>

                </div>


                <a
                    href="catalog.jsp?add=Smart Watch"
                    class="add-button">

                    🛒 Add to Cart

                </a>

            </div>

        </div>



        <!-- ==================================================
             CAMERA
             ================================================== -->

        <div
            class="product"
            data-name="Camera">


            <div class="product-image">

                <img
                    src="https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=800&q=80"
                    alt="Camera">

            </div>


            <div class="product-info">

                <div class="category">
                    Photography
                </div>


                <div class="product-name">
                    Digital Camera
                </div>


                <div class="description">
                    Capture high-quality photos
                    and memorable moments.
                </div>


                <div class="price-row">

                    <div class="price">
                        ₹42,000
                    </div>

                    <div class="rating">
                        ★ 4.7
                    </div>

                </div>


                <a
                    href="catalog.jsp?add=Camera"
                    class="add-button">

                    🛒 Add to Cart

                </a>

            </div>

        </div>



        <!-- ==================================================
             SNEAKERS
             ================================================== -->

        <div
            class="product"
            data-name="Sneakers">


            <div class="product-image">

                <img
                    src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80"
                    alt="Sneakers">

                <span class="badge">
                    Popular
                </span>

            </div>


            <div class="product-info">

                <div class="category">
                    Fashion
                </div>


                <div class="product-name">
                    Premium Sneakers
                </div>


                <div class="description">
                    Stylish and comfortable sneakers
                    for everyday use.
                </div>


                <div class="price-row">

                    <div class="price">
                        ₹3,200
                    </div>

                    <div class="rating">
                        ★ 4.6
                    </div>

                </div>


                <a
                    href="catalog.jsp?add=Sneakers"
                    class="add-button">

                    🛒 Add to Cart

                </a>

            </div>

        </div>



        <!-- ==================================================
             BACKPACK
             ================================================== -->

        <div
            class="product"
            data-name="Backpack">


            <div class="product-image">

                <img
                    src="https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=80"
                    alt="Backpack">

            </div>


            <div class="product-info">

                <div class="category">
                    Accessories
                </div>


                <div class="product-name">
                    Travel Backpack
                </div>


                <div class="description">
                    Spacious and durable backpack
                    for travel, college and work.
                </div>


                <div class="price-row">

                    <div class="price">
                        ₹2,200
                    </div>

                    <div class="rating">
                        ★ 4.7
                    </div>

                </div>


                <a
                    href="catalog.jsp?add=Backpack"
                    class="add-button">

                    🛒 Add to Cart

                </a>

            </div>

        </div>


    </div>

</main>



<!-- ==========================================================
     FOOTER
     ========================================================== -->

<footer class="footer">

    Session-Driven Shopping Cart

    <br><br>

    <strong>
        JSP • Session • Request • Application • jsp:forward
    </strong>

</footer>



<!-- ==========================================================
     SEARCH SCRIPT
     ========================================================== -->

<script>

    function searchProducts() {

        const input =
            document.getElementById("searchInput");

        const searchValue =
            input.value.toLowerCase();

        const products =
            document.querySelectorAll(".product");


        products.forEach(function(product) {

            const productName =
                product
                .getAttribute("data-name")
                .toLowerCase();


            if (productName.includes(searchValue)) {

                product.style.display = "flex";

            } else {

                product.style.display = "none";

            }

        });

    }

</script>


</body>

</html>
```
