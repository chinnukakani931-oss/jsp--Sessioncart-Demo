<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>

    .footer {
        margin-block-start: 60px;
        background: #111827;
        color: white;
        padding: 40px 5% 20px;
    }

    .footer-container {
        max-inline-size: 1280px;
        margin: auto;
        display: grid;
        grid-template-columns: 2fr 1fr 1fr;
        gap: 40px;
    }

    .footer-brand h2 {
        margin: 0 0 12px;
        font-size: 24px;
        font-weight: bold;
    }

    .footer-brand p {
        color: #9ca3af;
        line-height: 1.6;
        max-inline-size: 450px;
    }

    .footer-section h3 {
        margin: 0 0 15px;
        font-size: 17px;
    }

    .footer-section a {
        display: block;
        color: #9ca3af;
        text-decoration: none;
        margin-block-end: 10px;
    }

    .footer-section a:hover {
        color: white;
    }

    .footer-bottom {
        max-inline-size: 1280px;
        margin: 35px auto 0;
        padding-block-start: 20px;
        border-block-start: 1px solid #374151;
        text-align: center;
        color: #9ca3af;
        font-size: 14px;
    }

    .footer-highlight {
        color: #60a5fa;
        font-weight: bold;
    }


    @media (max-inline-size: 768px) {

        .footer-container {
            grid-template-columns: 1fr;
            text-align: center;
        }

        .footer-brand p {
            margin-inline-start: auto;
            margin-inline-end: auto;
        }

    }

</style>


<footer class="footer">


    <div class="footer-container">


        <!-- STORE -->

        <div class="footer-brand">

            <h2>

                &#128717; My Online Store

            </h2>


            <p>

                Your simple and secure online
                shopping destination. Browse products,
                add them to your cart, and complete
                your purchase easily.

            </p>

        </div>


        <!-- QUICK LINKS -->

        <div class="footer-section">

            <h3>

                Quick Links

            </h3>


            <a href="catalog.jsp">

                Product Catalog

            </a>


            <a href="cart.jsp">

                Shopping Cart

            </a>


            <a href="checkout.jsp">

                Checkout

            </a>

        </div>


        <!-- ACCOUNT -->

        <div class="footer-section">

            <h3>

                Account

            </h3>


            <a href="catalog.jsp">

                Continue Shopping

            </a>


            <a href="logout.jsp">

                Logout

            </a>

        </div>


    </div>


    <!-- FOOTER BOTTOM -->

    <div class="footer-bottom">

        <p>

            &copy; 2026

            <span class="footer-highlight">

                My Online Store

            </span>

            | Session-Driven Shopping Cart

        </p>


        <p>

            JSP Assignment |
            Session &amp; Application Scope

        </p>

    </div>


</footer>