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
		<title>Cinephilia - Admin Products</title>
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
            header {
                text-align: center;
                background-color: #946c34;
                font-size: 40px;
            }

            #listings{
                overflow: hidden;
            }

            #listings img {
                width: 100%;
                overflow: hidden;
                border-radius: 2% 2% 0 0;
                
            }

            .col-lg-3, .col-md-6, .col-sm-12{
                margin-bottom: 20px;
                margin-top: 10px;
            }

            .listing{
                width: 90%;
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

            .text-box {
                width: 100%;
                float: left;
                border: 0.01em solid #dddbdb;
                border-radius: 0 0 2% 2%;
                padding: 1em;
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

            @media (max-width: 767px){
                .listing{
                width: 50%;
                }
            }

            .navigation > a{
                display: block;
                height: 60px;
                line-height: 60px;
                padding: 0 10px;
                color: #f3ebd2;
                font-size: 20px;
            }

            section{
                margin-bottom: 100px;
            }

            section > h3{
                text-align: center;
            }

            form{
                font-size: 18px;
                margin-left: 15px;
                margin-right: 15px;
                margin-top: 20px;
            }

            label::before{
                margin: 28px 0 0;
                font-size: 14px;
                color: #5a5a5a;
            }

            input{
                margin-bottom: 15px;
                width: 100%;
                padding: 10px;
                background: none;
                outline: none;
                border: 0;
                border-bottom: 2px solid rgb(65, 56, 50);
            }

            .required{
                color: red;
            }

            input:focus{
                transition: all 0.3s;
                border-bottom: 2px solid rgb(228, 161, 18);
            }

            .form-button{
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

            .form-button:hover{
                transition: all 0.3s;
                background: rgb(228, 161, 18);
                border: 2px solid rgb(228, 161, 18);
                color: rgb(235,235,235);
            }
        </style>
	</head>
	<body>
		<%
			if (request.getParameter("add_product_btn") != null){
					String product_name = request.getParameter("product_name");
					product_name = URLEncoder.encode(product_name, "UTF-8");
					String genre = request.getParameter("genre");
					String collection = request.getParameter("collection");
					String price = request.getParameter("price");
					String location = request.getParameter("url");
					location = location.replace("/", "+");
	
			        Client client = Client.create();
			        WebResource  webResource = client.resource("http://localhost:8080/Cinephilia/rest/CinephiliaServices/AddProduct/"+product_name+"/"+genre+"/"+collection+"/"+price+"/"+location);
			        ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
			        
			        if (myresponse.getStatus() != 200) {
			            throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
			        }
			        
					String output = myresponse.getEntity(String.class);
			        
			        if (output.equals("SUCCESS")){
			        	System.out.println("Product Added.");
			        }
				}
		%>
		<%
			if (request.getParameter("update_product_btn") != null){
					String product_name = request.getParameter("product_name");
					String new_product_name = request.getParameter("new_product_name");
					product_name = URLEncoder.encode(product_name, "UTF-8");
					new_product_name = URLEncoder.encode(new_product_name, "UTF-8");
					String genre = request.getParameter("genre");
					String collection = request.getParameter("collection");
					String price = request.getParameter("price");
					String location = request.getParameter("url");
					location = location.replace("/", "+");
	
			        Client client = Client.create();
			        WebResource  webResource = client.resource("http://localhost:8080/Cinephilia/rest/CinephiliaServices/UpdateProduct/"+product_name+"/"+new_product_name+"/"+genre+"/"+collection+"/"+price+"/"+location);
			        ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
			        
			        if (myresponse.getStatus() != 200) {
			            throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
			        }
			        
					String output = myresponse.getEntity(String.class);
			        
			        if (output.equals("SUCCESS")){
			        	System.out.println("Product Updated.");
			        }
				}
		%>
		<%
			if (request.getParameter("delete_product_btn") != null){
					String product_name = request.getParameter("product_name");
					product_name = URLEncoder.encode(product_name, "UTF-8");
	
			        Client client = Client.create();
			        WebResource  webResource = client.resource("http://localhost:8080/Cinephilia/rest/CinephiliaServices/DeleteProduct/"+product_name);
			        ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
			        
			        if (myresponse.getStatus() != 200) {
			            throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
			        }
			        
					String output = myresponse.getEntity(String.class);
			        
			        if (output.equals("SUCCESS")){
			        	System.out.println("Product Deleted.");
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
		<header>
            Cinephilia Admin Products Page
        </header>
        <div class="navigation d-flex justify-content-center">
            <a href="CinephiliaAdminHome.jsp" target="_self">Home</a>
            <a href="CinephiliaAdminUsers.jsp" target="_self">Users</a>
            <a href="CinephiliaAdminProducts.jsp" target="_self">Products</a>
            <div class="d-flex justify-content-center"><form METHOD="POST"><button class="btn btn-primary" name="logout_btn" role="button" type="submit">Logout</button></form></div>
        </div>
        <div class="container">
            <div class="row">
                <section id="listings">
            <div class="row" style="clear: both;">
              <% 
	          	//JDBC driver and database URL
	        	final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	        	final String DB_URL = "jdbc:mysql://localhost/cinephilia?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	        	
	        	//Database credentials
	        	final String USER = "admin_charis";
	            final String PASS = "msqlPsw4u#2";
	            
	        	Connection conn = null;
	        	
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
	        		System.out.println("Connecting to database(SHOP)...");
	        		conn = DriverManager.getConnection(DB_URL, USER, PASS);
	        		
	        		System.out.println("Checking for data(SHOP)...");
	        		ps = conn.prepareStatement("SELECT * FROM products");
	        		
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
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
              <% modal_index++;} ps.close();%>
            </div>
          </section>
            </div>
            <hr>
            <div class="row">
                <section class="col-lg-4">
                    <h3>Add a new product</h3>
                    <form method="POST"> 
                        <label for="product_name">Product Name<span class="required"> *</span></label>
                        <input type="text" id="product_name" name="product_name" required="required" placeholder="Enter product name">
                        
                        <label for="genre">Genre<span class="required"> *</span></label>
                        <input type="text" id="genre" name="genre" required="required" placeholder="Enter genre">
                        
                        <label for="collection">Collection<span class="required"> *</span></label>
                        <input type="text" id="collection" name="collection" required="required" placeholder="Enter collection type">

                        <label for="price">Price<span class="required"> *</span></label>
                        <input type="text" id="price" name="price" required="required" placeholder="Enter item's price">

                        <label for="url">Image Location<span class="required"> *</span></label>
                        <input type="text" id="url" name="url" required="required" placeholder="Enter image's url">
                        
                        <button class="form-button" type="submit" name="add_product_btn">Submit</button>
                        <p><span class="required">*</span>Required field</p>
                    </form>
                </section>
                <section class="col-lg-4">
                    <h3>Update a product</h3>
                    <form method="POST"> 
                        <label for="product_name">Product Name<span class="required"> *</span></label>
                        <input type="text" id="product_name" name="product_name" required="required" placeholder="Enter product name">

                        <label for="new_product_name">Product name<span class="required"> *</span></label>
                        <input type="text" id="new_product_name" name="new_product_name" required="required" placeholder="Enter new product name">
                        
                        <label for="genre">Genre<span class="required"> *</span></label>
                        <input type="text" id="genre" name="genre" required="required" placeholder="Enter new genre">
                        
                        <label for="collection">Collection<span class="required"> *</span></label>
                        <input type="text" id="collection" required="required" name="collection" placeholder="Enter new collection type">

                        <label for="price">Price<span class="required"> *</span></label>
                        <input type="text" id="price" required="required" name="price" placeholder="Enter new item price">

                        <label for="url">Image Location<span class="required"> *</span></label>
                        <input type="text" id="url" required="required" name="url" placeholder="Enter new image url">
                        
                        <button class="form-button" type="submit" name="update_product_btn">Submit</button>
                        <p><span class="required">*</span>Required field</p>
                    </form>
                </section>
                <section class="col-lg-4">
                    <h3>Delete a product</h3>
                    <form method="POST"> 
                        <label for="product_name">Product Name<span class="required"> *</span></label>
                        <input type="text" id="product_name" name="product_name" placeholder="Enter product name">                    
                        <button class="form-button" type="submit" name="delete_product_btn">Submit</button>
                        <p><span class="required">*</span>Required field</p>
                    </form>
                </section>
            </div>
        </div>
        <footer>
            <div class="row">
                <div class="col-lg-6">
                    <h6><b><u>About</b></u></h6>
                    <p>
                        Cinephilia is an online store that sells ecological decorative posters with designs by independent artists, with a cinema theme. There is a constant demand in the market for ideas and ways of decorating our personal and/or work spaces.
                    </p>
                </div>
                <div class="col-lg-6">
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