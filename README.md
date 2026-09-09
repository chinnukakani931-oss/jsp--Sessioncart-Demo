jsp-session-shopping-cart
A Java JSP-based session-driven shopping cart application demonstrating authentication, session management, product selection, cart operations, and checkout.

JSP Session-Driven Shopping Cart 🛒
A simple and interactive shopping cart web application developed using Java Server Pages (JSP). This project demonstrates user authentication, HTTP session management, product selection, shopping cart operations, and checkout functionality.

📌 Project Overview
The application provides a basic e-commerce workflow where users can log in, browse products, add products to a shopping cart, view their cart, and complete a checkout process.

This project was developed for learning and demonstrating fundamental Java JSP web application concepts.

✨ Features
🔐 User login authentication
👤 Session-based user management
🛍️ Product catalog
➕ Add products to cart
🛒 Session-based shopping cart
🔢 Dynamic cart item count
💳 Checkout functionality
✅ Purchase confirmation
🚪 Logout functionality
🧩 Reusable JSP header and footer
📱 Responsive user interface
🛠️ Technologies Used
Java
JSP (JavaServer Pages)
HTML5
CSS3
JavaScript
Tailwind CSS
HTTP Session
Apache Tomcat
📂 Project Structure
jsp-session-shopping-cart/
│
├── index.jsp
├── login.jsp
├── catalog.jsp
├── cart.jsp
├── checkout.jsp
├── logout.jsp
├── header.jsp
├── footer.jsp

🔑 Demo Login
The current application uses demonstration credentials:

Username: student
Password: 1234
⚠️ These credentials are intended only for demonstration and educational purposes.

🔄 Application Flow
Login
  ↓
Authentication
  ↓
Product Catalog
  ↓
Add Products
  ↓
Shopping Cart
  ↓
Checkout
  ↓
Purchase Confirmation
  ↓
Logout
🧠 Concepts Demonstrated
This project demonstrates the following JSP concepts:

JSP pages
JSP scriptlets
HTTP sessions
Session attributes
Application scope
Request parameters
JSP includes
Page navigation
Basic authentication
Dynamic HTML generation
Shopping cart management
▶️ How to Run
Requirements
Before running the project, install:

Java JDK
Apache Tomcat
A Java-compatible IDE such as Eclipse or IntelliJ IDEA
A modern web browser
Run the Application
Install and configure Apache Tomcat.
Deploy the project to the Tomcat webapps directory.
Start the Tomcat server.
Open the application in your browser.
Example:

http://localhost:8080/SessionDrivenShoppingCart/
🔒 Security Note
This project is intended for educational purposes.

The current version uses demonstration credentials and does not implement production-level authentication.

A production version should use:

Database-backed authentication
Password hashing
Input validation
Secure session management
HTTPS
CSRF protection
Proper authorization
🚀 Future Improvements
Planned improvements for a more advanced version include:

MySQL/MariaDB database integration
JDBC integration
User registration
Secure password hashing
Product database
Product search
Product categories
Quantity management
Order history
User profiles
Admin dashboard
Inventory management
MVC architecture
Servlet-based controllers
DAO layer
Commands used to run project
Step 1: Install Requirements

Install:

Java JDK 26 Apache Tomcat 11 Git Step 2: Open PowerShell

Open PowerShell and set the Java path:

$env:JAVA_HOME = "C:\Program Files\Java\jdk-26.0.2"

Check Java:

java -version Step 3: Set Tomcat Path $env:CATALINA_HOME = "C:\Program Files\Apache Software Foundation\Tomcat 11.0" Step 4: Go to Tomcat cd "$env:CATALINA_HOME\bin" Step 5: Start Tomcat .\startup.bat Step 6: Open the Application

Open your browser and visit:

http://localhost:8080/JSP - SessionDrivenShoppingCart/ Login Credentials Username: admin Password: 1234

Stop Tomcat

To stop the server:

cd "$env:CATALINA_HOME\bin" .\shutdown.bat.

🎯 Learning Objective
The main objective of this project is to understand how JSP and HTTP sessions can be used to create an interactive Java web application with a basic e-commerce workflow.

Author: Rajesh Kakani
Devloped by Rajesh Kakani

Java | JSP | Web Development | AI-Assisted Development

📄 License
This project is intended for educational and portfolio purposes.
