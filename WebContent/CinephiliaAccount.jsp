<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client" %>
<%@ page import="com.sun.jersey.api.client.ClientResponse" %>
<%@ page import="com.sun.jersey.api.client.WebResource" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Cinephilia - Account</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
        <link href='https://fonts.googleapis.com/css?family=Jacques Francois Shadow' rel='stylesheet'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="cinephilia.css">
        <script src="cinephilia.js" defer></script>
        <style>
            #login form, #sign-up form, .logged form{
                font-size: 18px;
                margin-left: 15px;
                margin-right: 15px;
                margin-top: 20px;
            }

            #login label::before, #sign-up label::before, .logged label::before{
                margin: 28px 0 0;
                font-size: 14px;
                color: #5a5a5a;
            }

            #login input, #sign-up input, .logged input{
                margin-bottom: 15px;
                width: 100%;
                padding: 10px;
                background: none;
                outline: none;
                border: 0;
                border-bottom: 2px solid rgb(65, 56, 50);
            }

            #login .required, #sign-up .required, .logged .required{
                color: red;
            }

            #login input:focus, #sign-up input:focus, .logged input:focus{
                transition: all 0.3s;
                border-bottom: 2px solid rgb(228, 161, 18);
            }

            #login .form-button, #sign-up .form-button, .logged .form-button{
                float: right;
                padding: 8px 12px;
                margin-top: 20px;
                margin-right: 20px;
                border: 2px solid rgb(65, 56, 50);
                background: 0;
                color: rgb(65, 56, 50);
                cursor: pointer;
                clear: both;
            }

            #login .form-button:hover, #sign-up .form-button:hover, .logged .form-button:hover{
                transition: all 0.3s;
                background: rgb(228, 161, 18);
                border: 2px solid rgb(228, 161, 18);
                color: rgb(235,235,235);
            }

            #vl{
                transform: rotate(90deg);
            }

            @media (max-width:992px) {
                #vl{
                    display: none;
                }
            }

            .top a{
                margin: 20px;
                padding: 10px;
                font-family: 'Jacques Francois Shadow';
                font-size: 30px;
                color: #413832;
                background-color: #f3ebd2;
            }

            .logged{
                margin-top: 30px;
                margin-bottom: 100px;
                width: 50%;
                margin-left: auto;
                margin-right: auto;
            }

            .logged form{
                width: 50%;
            }

            #listings{
                overflow: hidden;
            }

            #listings img {
                width: 100%;
                overflow: hidden;
                border-radius: 2% 2% 0 0;
                
            }


            .listing{
                width: 90%;
                margin-bottom: 20px;
                margin-top: 10px;
                margin-left: auto;
                margin-right: auto;
            }

            .images {
                height: 15em;
                background-size: cover; 
                background-position: center center; 
                background-repeat: no-repeat;
                border-radius: 2% 2% 0 0;
                transition: all 1s ease;
                -moz-transition: all 1s ease;
                -ms-transition: all 1s ease;
                -webkit-transition: all 1s ease;
                -o-transition: all 1s ease;
            }

            .images:hover {
                transform: scale(1.2);
                overflow: hidden;
                border-radius: 2%;
            }

            .text-box {
                width: 100%;
                float: left;
                border: 0.01em solid #dddbdb;
                border-radius: 0 0 2% 2%;
                padding: 1em;
            }

            .logged h2, .logged h3 {
                float: left;
                font-weight: 400;
                font-size: 1em;
                margin: 0.2em auto;
            }

            .item, .price {
                clear: left;
                width: 100%;
                text-align: center;
            }

            .price {
                color: Grey;
            }

            #item-button {
                float: left;
                clear: left;
                width: 100%;
                font-weight: 300;
                font-size: 1em;
                text-align: center;
                margin: 0.2em auto;
                background-color: #f3ebd2;
                border: none;
                cursor: pointer;
            }

            #item-button:hover {
                background-color: #bb8c64;
            }

            @media (min-width:768px) and (max-width:992px){
                .listing{
                width: 80%;
                }
            }

            table{
                margin-top: 20px;
            }

            tbody{
                display: table;
                margin: auto;
                justify-content: center;
                align-items: center;
                width: 70%;
            }

            tr{
                text-align: center;
                border: 1px solid #5a6431;
            }

            th{
                padding: 10px;
                color: #f3ebd2;
                background-color: #413832;
            }

            td{
                padding: 10px;
                background-color: rgb(253, 252, 252);
                border: 1px solid #413832;
            }

            .add, .remove{
            text-decoration: none;
            color: black;
          }

          .add:hover, .remove:hover{
            text-decoration: none;
            color: black;
          }
        </style>
	</head>
	<body>
		
		<%	if (request.getParameter("sign_up_btn") != null){
				String email = request.getParameter("email");
				String username = request.getParameter("username");
				String password = request.getParameter("password"); 
				  
		        Client client = Client.create();
		        WebResource  webResource = client.resource("http://localhost:8080/Cinephilia/rest/CinephiliaServices/Register/"+email+"/"+username+"/"+password);
		        ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
		        
		        if (myresponse.getStatus() != 200) {
		            throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
		        }
		        
				String output = myresponse.getEntity(String.class);
		        
		        if (output.equals("SUCCESS")){
		        	session.setAttribute("user_email", email);
		        	System.out.println("User Registered");
		        	
		        	/*CHECK IF USER IS ADMIN*/
		        	final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
                	final String DB_URL = "jdbc:mysql://localhost/cinephilia?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
                	
                	//Database credentials
                	final String USER = "admin_charis";
                    final String PASS = "msqlPsw4u#2";
                    
                	Connection conn = null;
                	
                	try {
                		//Register JDBC driver
                		Class.forName("com.mysql.cj.jdbc.Driver");
                		//Open a connection
                		System.out.println("Connecting to database(SHOW INFO)...");
                		conn = DriverManager.getConnection(DB_URL, USER, PASS);
                		
                		System.out.println("Checking for data(SHOW INFO)...");
                		PreparedStatement ps = conn.prepareStatement("SELECT * from users WHERE email = ? AND username = ? AND password = ?");
                		ps.setString(1, email);
                		ps.setString(2, username);
                		ps.setString(3, password);
                		
                		ResultSet rs = ps.executeQuery();
                		
                		if (rs.next()){
                			username = rs.getString("username");
                			email = rs.getString("email");
                			password = rs.getString("password");
                			
                			if (username.equals("admin")){
                				response.sendRedirect("CinephiliaAdminHome.jsp");
            				    return;
                			}
                		}
                		
                		ps.close();
                	}catch(SQLException | ClassNotFoundException e) {
                		e.printStackTrace();
                	}
				    
		        }else{
		        	System.out.println("User Already Exists.");
		        }
			}
		%>
		
		<%		if (request.getParameter("sign_in_btn") != null){
				String email = request.getParameter("email");
				String password = request.getParameter("password"); 
				  
		        Client client = Client.create();
		        WebResource  webResource = client.resource("http://localhost:8080/Cinephilia/rest/CinephiliaServices/Login/"+email+"/"+password);
		        ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
		        
		        if (myresponse.getStatus() != 200) {
		            throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
		        }
		        
		        String output = myresponse.getEntity(String.class);
		        
		        String username = "";
		        
		        if (output.equals("SUCCESS")){
		        	session.setAttribute("user_email", email);
		        	System.out.println("Logged In.");
		        	
		        	/*CHECK IF USER IS ADMIN*/
		        	final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
                	final String DB_URL = "jdbc:mysql://localhost/cinephilia?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
                	
                	//Database credentials
                	final String USER = "admin_charis";
                    final String PASS = "msqlPsw4u#2";
                    
                	Connection conn = null;
                	
                	try {
                		//Register JDBC driver
                		Class.forName("com.mysql.cj.jdbc.Driver");
                		//Open a connection
                		System.out.println("Connecting to database(SHOW INFO)...");
                		conn = DriverManager.getConnection(DB_URL, USER, PASS);
                		
                		System.out.println("Checking for data(SHOW INFO)...");
                		PreparedStatement ps = conn.prepareStatement("SELECT * from users WHERE email = ? AND password = ?");
                		ps.setString(1, email);
                		ps.setString(2, password);
                		
                		ResultSet rs = ps.executeQuery();
                		
                		if (rs.next()){
                			username = rs.getString("username");
                			email = rs.getString("email");
                			password = rs.getString("password");
                			
                			if (username.equals("admin")){
                				response.sendRedirect("CinephiliaAdminHome.jsp");
            				    return;
                			}
                		}
                		
                		ps.close();
                	}catch(SQLException | ClassNotFoundException e) {
                		e.printStackTrace();
                	}
		        }else{
		        	System.out.println("Wrong Email or Password.");
		        }
			}
		%>
		
		<% String user_email = (String)session.getAttribute("user_email"); %>
			
		<%	
			if (request.getParameter("changes_btn") != null){
				String username = request.getParameter("username");
				String password = request.getParameter("password"); 
				  
		        Client client = Client.create();
		        WebResource  webResource = client.resource("http://localhost:8080/Cinephilia/rest/CinephiliaServices/ChangeUserInfo/"+user_email+"/"+username+"/"+password);
		        ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
		        
		        if (myresponse.getStatus() != 200) {
		            throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
		        }
		        
				String output = myresponse.getEntity(String.class);
		        
		        if (output.equals("SUCCESS")){
		        	System.out.println("Information Updated");
		        }else{
		        	System.out.println("Information not updated");
		        }
			}
		%>
		
		<%
			if (request.getParameter("add_to_favs_btn") != null){
				String product = request.getParameter("product");
				product = URLEncoder.encode(product, "UTF-8");

		        Client client = Client.create();
		        WebResource  webResource = client.resource("http://localhost:8080/Cinephilia/rest/CinephiliaServices/AddToFavourites/"+user_email+"/"+product);
		        ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
		        
		        if (myresponse.getStatus() != 200) {
		            throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
		        }
		        
				String output = myresponse.getEntity(String.class);
		        
		        if (output.equals("SUCCESS")){
		        	System.out.println("Added To Favourites");
		        }else{
		        	System.out.println("Product not added to Favourites");
		        }
			}
		%>
		
		<%
			if (request.getParameter("remove_from_favs_btn") != null){
				String product = request.getParameter("product");
				product = URLEncoder.encode(product, "UTF-8");
				  
		        Client client = Client.create();
		        WebResource  webResource = client.resource("http://localhost:8080/Cinephilia/rest/CinephiliaServices/RemoveFromFavourites/"+user_email+"/"+product);
		        ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
		        
		        if (myresponse.getStatus() != 200) {
		            throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
		        }
		        
				String output = myresponse.getEntity(String.class);
		        
		        if (output.equals("SUCCESS")){
		        	System.out.println("Removed from Favourites");
		        }else{
		        	System.out.println("Product not removed from Favourites");
		        }
			}
		%>
		
		<%
			if (request.getParameter("add_to_cart_btn") != null){
				String product = request.getParameter("product");
				product = URLEncoder.encode(product, "UTF-8");

		        Client client = Client.create();
		        WebResource  webResource = client.resource("http://localhost:8080/Cinephilia/rest/CinephiliaServices/AddToCart/"+user_email+"/"+product);
		        ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
		        
		        if (myresponse.getStatus() != 200) {
		            throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
		        }
		        
		        String output = myresponse.getEntity(String.class);
		        
		        if (output.equals("SUCCESS")){
		        	System.out.println("Added To Cart");
		        }else{
		        	System.out.println("Product not added to Cart");
		        }
			}
		%>
			
		<% 	if (request.getParameter("logout_btn") != null){
				session.invalidate();
				System.out.println("Logged Out.");
				response.sendRedirect("CinephiliaAccount.jsp");
			    return;
			}
	    %>
	    
	    <header align="center" id="top">
            WELCOME
        </header>
        <div class="navigation">
            <a href="CinephiliaHome.jsp" target="_self" id="middle"><img src="images/film.png" alt="company logo"/></a>
            <nav>
                <div class="icon-bar" onclick="Show()">
                    <i></i>
                    <i></i>
                    <i></i>
                </div>
                <span id="nav-menu">
                    <i class="close" onclick="Hide()"><i class="fa fa-remove" style="font-size:44px;"></i></i>
                    <a href="CinephiliaHome.jsp" target="_self" id="middle">Home</a>
                    <a href="CinephiliaShop.jsp" target="_self">Shop</a>
                    <a class="mobile-nav" href="CinephiliaAccount.jsp" target="_self">Account <i class="fa fa-user"></i></a>
                    <a class="mobile-nav" href="CinephiliaCart.jsp" target="_self">Cart <i class="material-icons">local_mall</i></a>
                    <% if (user_email != null) {%>
                        <form class="mobile-nav"><button class="mobile-nav" type="submit" name="logout_btn">Logout</button></form>
                    <% } %>
                    <span class="right-nav">
                    	<% if (user_email != null) {%>
                    		<form><button type="submit" name="logout_btn">Logout</button></form>
                        <% } %>
                            <a href="CinephiliaAccount.jsp" target="_self">Account <i class="fa fa-user"></i></a>
                        <a href="CinephiliaCart.jsp" target="_self">Cart <i class="fa fa-shopping-bag"></i></a>
                    </span>
                </span>
            </nav>
        </div>
        <div class="container">
        	<% if (user_email != null) {%>
                <div class="top d-flex justify-content-center">
                    <a href="#info">Change your Info</a>
                    <a href="#favourites">Favourites</a>
                </div>
                <section class="logged">
                    <header id="info" style="text-align: center; font-size:26px">Change your personal information</header>
                    <% 
	                  	//JDBC driver and database URL
	                	final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	                	final String DB_URL = "jdbc:mysql://localhost/cinephilia?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	                	
	                	//Database credentials
	                	final String USER = "admin_charis";
	                    final String PASS = "msqlPsw4u#2";
	                    
                    	Connection conn = null;
                    	
                    	String username = "";
                    	String email = "";
                    	String password = "";
                    	
	                	try {
	                		//Register JDBC driver
	                		Class.forName("com.mysql.cj.jdbc.Driver");
	                		//Open a connection
	                		System.out.println("Connecting to database(SHOW INFO)...");
	                		conn = DriverManager.getConnection(DB_URL, USER, PASS);
	                		
	                		System.out.println("Checking for data(SHOW INFO)...");
	                		PreparedStatement ps = conn.prepareStatement("SELECT * from users WHERE email = ?");
	                		ps.setString(1, user_email);
	                		
	                		ResultSet rs = ps.executeQuery();
	                		if (rs.next()){
	                			username = rs.getString("username");
	                			email = rs.getString("email");
	                			password = rs.getString("password");
	                		}
	                		
	                		ps.close();
	                	}catch(SQLException | ClassNotFoundException e) {
	                		e.printStackTrace();
	                	}
                	%>
                    <form method="POST" class="mx-auto"> 
                        <label for="username">Username<span class="required"> *</span></label>
                        <input type="text" id="username" name="username" required="required" value="<% out.print(username); %>">
                        
                        <label for="password">Password<span class="required"> *</span></label>
                        <input type="text" id="password" name="password" required="required" value="<% out.print(password); %>">
                        
                        <button class="form-button" name="changes_btn" type="submit">Save Changes</button>
                        <p><span class="required">*</span>Required field</p>
                    </form>
                </section>
                <section class="logged" id="listings">
                    <header id="favourites" style="text-align: center; font-size:26px">Favourites</header><br>
                    <div class="row" style="clear: both;">
		              <% 
			        	String product_name = "";
			        	String genre = "";
			        	String collection = "";
			        	int price = 0;
			        	String location = "";
			        	int modal_index = 0;
			        	ResultSet rs = null;
			        	PreparedStatement ps = null;
			        	
			        	try {
			        		//Register JDBC driver
			        		Class.forName("com.mysql.cj.jdbc.Driver");
			        		//Open a connection
			        		System.out.println("Connecting to database(ACCOUNT-FAVOURITES)...");
			        		conn = DriverManager.getConnection(DB_URL, USER, PASS);
			        		
			        		System.out.println("Checking for data(ACCOUNT-FAVOURITES)...");
			        		ps = conn.prepareStatement("SELECT * FROM favourites WHERE email = ?");
							ps.setString(1, user_email);
			        		rs = ps.executeQuery();
			        		
			        	}catch(SQLException | ClassNotFoundException e) {
			        		e.printStackTrace();
			        	}
		            %>
		            <%while (rs.next()){
		    			product_name = rs.getString("product_name");
		    			genre = rs.getString("genre");
		    			collection = rs.getString("collection");
		    			price = rs.getInt("price");
		    			location = rs.getString("location");
		    		%>
		                  <div class="col-lg-3 col-md-6 col-sm-12">
		                    <div class="listing">
		                      <img class="images" src="<% out.print(location); %>" alt="<% out.print(product_name); %>"/>
		                      <div class="text-box">
		                        <h2 class="item"><% out.print(product_name); %></h2>
		                        <h3 class="price"><% out.print(price); %>&euro;</h3>
		                        <button type="button" data-toggle="modal" data-target="#myModal<% out.print(modal_index); %>" id="item-button">View Details</button>
		                        <div class="modal fade" id="myModal<% out.print(modal_index); %>" role="dialog">
		                          <div class="modal-dialog modal-dialog-centered">
		                            <div class="modal-content">
		                              <div class="modal-header">
		                                <h2><% out.print(product_name); %></h2>
		                              </div>
		                              <div class="modal-body">
		                                <div class="row">
		                                  <div class="col-md-6 product_img">
		                                    <img class="modal__img" src="<% out.print(location); %>" alt="<% out.print(product_name); %>"/>
		                                  </div>
		                                  <div class="col-md-6 product_content">
		                                    <h6>Genre: <% out.print(genre); %></h6>
		                                    <h6><% out.print(collection); %> Collection</h6>
		                                    <h6><% out.print(price); %>&euro;</h6>
		                                    <% if (user_email != null) {%>
			                                    <form>
			                                    	<input name="product" value="<% out.print(product_name); %>" style="visibility: hidden;"/>
			                                    	<button id="item-button" class="add" name="add_to_cart_btn">Add to Cart</button>
			                                    </form>
		                                    <% } %>
		                                    <% boolean flag = false; %>
		                                    <% if (user_email != null) {
		                                    
			                                    	ResultSet rs_favourites = null;
										        	try {
										        		//Register JDBC driver
										        		Class.forName("com.mysql.cj.jdbc.Driver");
										        		//Open a connection
										        		System.out.println("Connecting to database(FAVOURITE?)...");
										        		conn = DriverManager.getConnection(DB_URL, USER, PASS);
										        		
										        		System.out.println("Checking for data(FAVOURITE?)...");
										        		ps = conn.prepareStatement("SELECT * FROM favourites WHERE email = ? and product_name = ?");
										        		ps.setString(1, user_email);
										        		ps.setString(2, product_name);
										        		
										        		rs_favourites = ps.executeQuery();
										        		
										        		if (rs_favourites.next()) {
										        			flag = true;
										        		}
										        		
										        		
										        	}catch(SQLException | ClassNotFoundException e) {
										        		e.printStackTrace();
										        	}
		                                    	}
								            %>
								            <%  if (flag == true){%>
		                                        <% if (user_email != null) {%>
			                                        <form METHOD="POST">
				                                        <input name="product" value="<% out.print(product_name); %>" style="visibility: hidden;"/>
				                                        <button id="item-button" name="remove_from_favs_btn" class="remove">Remove From Favourites</button>
			                                        </form>
		                                        <% } %>
		                                    <% }else{ %>
		                                        <% if (user_email != null) {%>
			                                        <form  METHOD="POST">
			                                        	<input name="product" value="<% out.print(product_name); %>" style="visibility: hidden;"/>
			                                        	<button id="item-button" name="add_to_favs_btn" class="add">Add To Favourites  <i id="heart" class="fa fa-heart"></i></button>
			                                        </form>
		                                         <% } %>
		                                    <% } %>
		                                  </div>
		                                </div>
		                              </div>
		                            </div>
		                          </div>
		                        </div>
		                      </div>
		                    </div>
		                  </div>
		              <% modal_index++;} ps.close(); %>
		            </div>
                </section>
            <% }else{ %>
                <section id="sign-up">
                    <div class="col-lg-6">
                        <br><br>
                        <h3>Sign Up</h3>
                        <form METHOD="POST"> 
                            <label for="email">Email<span class="required"> *</span></label>
                            <input type="text" id="email" name="email" required="required" placeholder="Enter your email address">
                            
                            <label for="username">Username<span class="required"> *</span></label>
                            <input type="text" id="username" name="username" required="required" placeholder="Enter your username">
                            
                            <label for="password">Password<span class="required"> *</span></label>
                            <input type="text" id="password" name="password" required="required" placeholder="Enter your password">
                            
                            <button class="form-button" name="sign_up_btn" type="submit">Submit</button>
                            <p><span class="required">*</span>Required field</p>
                        </form><br><br><br>
                    </div>
                </section>
                <hr id="vl">
                <section id="login">
                    <div class="col-lg-6">
                        <h2 style="color:#818a91; font-size: small;">Already have an account?</h2>
                        <h3>Sign In</h3>
                        <form METHOD = "POST"> 
                            <label for="email">Email<span class="required"> *</span></label>
                            <input type="text" id="email" name="email" required="required" placeholder="Enter your email address">
                            
                            <label for="password">Password<span class="required"> *</span></label>
                            <input type="text" id="password" name="password" required="required" placeholder="Enter your password">
                            
                            <button class="form-button" name="sign_in_btn" type="submit">Submit</button>
                            <p><span class="required">*</span>Required field</p>
                        </form><br>
                    </div>
                </section>
           <% } %>
        </div>
        <footer>
        	<div class="row">
                <div class="col-lg-4">
                    <h6><b><u>About</b></u></h6>
                    <p>
                        Cinephilia is an online store that sells ecological decorative posters with designs by independent artists, with a cinema theme. There is a constant demand in the market for ideas and ways of decorating our personal and/or work spaces.
                    </p>
                </div>
                <div class="col-lg-4">
                    <h6><b><u>Categories</b></u></h6>
                    <ul class="list-unstyled">
                        <li><a href="#" target="_self">About Cinephilia</a></li>
                        <li><a href="#" target="_self">FAQ's</a></li>
                        <li><a href="#">Shipping & Return Policies</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms & Conditions</a></li>
                    </ul>
                </div>
                <div class="col-lg-4">
                    <h6><b><u>Payment Methods</b></u></h6>
                    <ul class="list-unstyled">
                        <li>
                            <i style="font-size:30px" class="fa fa-cc-mastercard"></i>
                            <i style="font-size:30px" class="fa fa-cc-visa"></i>
                            <i style="font-size:30px" class="fa fa-cc-amex"></i>
                            <i style="font-size:30px" class="fa fa-cc-diners-club"></i>
                            <i style="font-size:30px" class="fa fa-paypal"></i>
                        </li>
                    </ul>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-lg-6"><p class="copyright-text" style="line-height: 90px; text-align: center;">&copy; Cinephilia 2022. All rights reserved.</p></div>
                <div class="col-lg-6">
                    <ul class="social-icons">
                        <li><a class="facebook" href="https://www.facebook.com/ds.unipi.gr" target="_blank"><i class="fa fa-facebook"></i></a></li>
                        <li><a class="instagram" href="https://www.instagram.com/haarrisa/" target="_blank"><i class="fa fa-instagram"></i></a></li>
                        <li><a class="email" href="mailto:harisantoniadi@gmail.com"><i class="material-icons" style="vertical-align: middle;">mail_outline</i></a></li>
                        <li><a class="telephone" href="tel:+30210 4142000"><i class="fa fa-phone" style="vertical-align: middle; font-size:24px;"></i></a></li>
                    </ul>
                </div>
            </div>
        </footer>
	</body>
</html>