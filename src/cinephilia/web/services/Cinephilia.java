package cinephilia.web.services;

import java.sql.*;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

@Path("CinephiliaServices")
public class Cinephilia {
	
	//JDBC driver and database URL
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/cinephilia?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "admin_charis";
    static final String PASS = "msqlPsw4u#2";
	
	@GET
	@Path("/Register/{email}/{username}/{password}")
	@Produces("text/plain")
	public String register(@PathParam("email") String email, @PathParam("username") String username, @PathParam("password") String password)
	{
		Connection conn = null;
		String output = "FAIL";
		
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(Resgister)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
    		ps1.setString(1, email);
    		
    		ResultSet rs1 = ps1.executeQuery();
    		
    		if (!rs1.next()) {
    			System.out.println("Inserting data(Register)...");
    			PreparedStatement ps2 = conn.prepareStatement("INSERT INTO users (email, username, password) VALUES (?, ?, ?)");
	    		ps2.setString(1, email);
	    		ps2.setString(2, username);
	    		ps2.setString(3, password);
	    		ps2.executeUpdate();
	    		System.out.println("Data inserted successfully(Register)");
	    		output = "SUCCESS";
	    		ps2.close();
    		}
    		ps1.close();
    		
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/Login/{email}/{password}")
	@Produces("text/plain")
	public String login(@PathParam("email") String email, @PathParam("password") String password)
	{
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(Login)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		System.out.println("Checking for data(Login)...");
    		PreparedStatement ps = conn.prepareStatement("SELECT * from users WHERE email = ? and password = ?");
    		ps.setString(1, email);
    		ps.setString(2, password);
    		
    		ResultSet rs = ps.executeQuery();
    		
    		if (rs.next()) {
    			System.out.println("Data selected successfully(Login)");
    			output = "SUCCESS";
    		}
    		ps.close();
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}

	@GET
	@Path("/ChangeUserInfo/{user_email}/{username}/{password}")
	@Produces("text/plain")
	public String change_user_info(@PathParam("user_email") String email, @PathParam("username") String username, @PathParam("password") String password)
	{
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(CHANGE INFO)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		PreparedStatement ps = conn.prepareStatement("UPDATE users set email = ?, username = ?, password = ? WHERE email = ?");
    		ps.setString(1, email);
    		ps.setString(2, username);
    		ps.setString(3, password);
    		ps.setString(4, email);
    		ps.executeUpdate();
    		
    		output = "SUCCESS";
    		
    		ps.close();
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/Search/{search_input}")
	@Produces("text/plain")
	public String search(@PathParam("search_input") String search_input)
	{

		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(SEARCH)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE product_name = ? or genre = ? or collection = ?");
    		ps.setString(1, search_input);
    		ps.setString(2, search_input);
    		ps.setString(3, search_input);
    		
    		ps.executeQuery();
    		
    		if (ps != null) {
    			output = "SUCCESS";
    		}
    		
    		ps.close();
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/AddToFavourites/{user_email}/{product}/")
	@Produces("text/plain")
	public String add_to_favourites(@PathParam("user_email") String email, @PathParam("product") String product)
	{
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(FAVOURITES-ADD)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		product = product.replace("+", " ");
    		PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM products WHERE product_name = ?");
    		ps1.setString(1, product);
    		
    		ResultSet rs1 = ps1.executeQuery();
    		
    		String genre = "";
    		String collection = "";
    		String location = "";
    		int price = 0;
    		
    		if (rs1.next()){
    			genre = rs1.getString("genre");
    			collection = rs1.getString("collection");
    			location = rs1.getString("location");
    			price = rs1.getInt("price");
    		}
    		
    		PreparedStatement ps2 = conn.prepareStatement("INSERT INTO favourites (email, product_name, genre, collection, price, location) VALUES (?, ?, ?, ?, ?, ?)");
    		ps2.setString(1, email);
    		ps2.setString(2, product);
    		ps2.setString(3, genre);
    		ps2.setString(4, collection);
    		ps2.setInt(5, price);
    		ps2.setString(6, location);
    		
    		ps2.executeUpdate();
    		
    		output = "SUCCESS";
    		
    		ps1.close();
    		ps1.close();
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/RemoveFromFavourites/{user_email}/{product}")
	@Produces("text/plain")
	public String remove_from_favourites(@PathParam("product") String product, @PathParam("user_email") String email)
	{
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(FAVOURITES-REMOVE)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		product = product.replace("+", " ");
    		PreparedStatement ps = conn.prepareStatement("DELETE FROM favourites WHERE email = ? and product_name = ?");
    		ps.setString(1, email);
    		ps.setString(2, product);
    		
    		ps.executeUpdate();
    		
    		output = "SUCCESS";
    		
    		ps.close();
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/AddToCart/{user_email}/{product}")
	@Produces("text/plain")
	public String add_to_cart(@PathParam("user_email") String email, @PathParam("product") String product)
	{
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(CART-ADD)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		product = product.replace("+", " ");
    		PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM products WHERE product_name = ?");
    		ps1.setString(1, product);
    		
    		ResultSet rs1 = ps1.executeQuery();
    		
    		String genre = "";
    		String collection = "";
    		String location = "";
    		int price = 0;
    		
    		if (rs1.next()){
    			genre = rs1.getString("genre");
    			collection = rs1.getString("collection");
    			location = rs1.getString("location");
    			price = rs1.getInt("price");
    			
    			PreparedStatement ps2 = conn.prepareStatement("INSERT INTO cart (email, product_name, genre, collection, price, location) VALUES (?, ?, ?, ?, ?, ?)");
	    		ps2.setString(1, email);
	    		ps2.setString(2, product);
	    		ps2.setString(3, genre);
	    		ps2.setString(4, collection);
	    		ps2.setInt(5, price);
	    		ps2.setString(6, location);
	    		
	    		ps2.executeUpdate();
	    		
	    		output = "SUCCESS";
	    		
	    		ps1.close();
	    		ps2.close();
    		}
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/RemoveFromCart/{user_email}/{product}")
	@Produces("text/plain")
	public String remove_from_cart(@PathParam("user_email") String email, @PathParam("product") String product)
	{
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(CART-REMOVE)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		product = product.replace("+", " ");
    		PreparedStatement ps = conn.prepareStatement("DELETE FROM cart WHERE email = ? and product_name = ?");
    		ps.setString(1, email);
    		ps.setString(2, product);
    		
    		ps.executeUpdate();
    		
    		output = "SUCCESS";
    		
    		ps.close();
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/Checkout/{user_email}/{order_number}")
	@Produces("text/plain")
	public String checkout(@PathParam("user_email") String email, @PathParam("order_number") int order_number)
	{
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(CHECKOUT)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		PreparedStatement ps1 = conn.prepareStatement("INSERT INTO orders (email, order_number) VALUES (?, ?)");
    		ps1.setString(1, email);
    		ps1.setInt(2,  order_number);
    		
    		ps1.executeUpdate();
    		ps1.close();
    		
    		PreparedStatement ps2 = conn.prepareStatement("DELETE FROM cart WHERE email = ?");
    		ps2.setString(1, email);
    		ps2.executeUpdate();
    		
    		output = "SUCCESS";
    		
    		ps2.close();
    		
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/DeleteAccount/{email}")
	@Produces("text/plain")
	public String delete_account(@PathParam("email") String email)
	{
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(DelectAccount)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		PreparedStatement ps;
    		
    		ps = conn.prepareStatement("DELETE FROM users WHERE email = ?");
    		ps.setString(1, email);
    		ps.executeUpdate();
    		System.out.println("Deleted from users.");
    		
    		ps = conn.prepareStatement("DELETE FROM cart WHERE email = ?");
    		ps.setString(1, email);
    		ps.executeUpdate();
    		System.out.println("Deleted from cart.");
    		
    		ps = conn.prepareStatement("DELETE FROM favourites WHERE email = ?");
    		ps.setString(1, email);
    		ps.executeUpdate();
    		System.out.println("Deleted from favourites.");
    		
    		ps = conn.prepareStatement("DELETE FROM orders WHERE email = ?");
    		ps.setString(1, email);
    		ps.executeUpdate();
    		System.out.println("Deleted from orders.");
    		
    		output = "SUCCESS";
    		
    		ps.close();
    		
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/AddProduct/{product_name}/{genre}/{collection}/{price}/{location}")
	@Produces("text/plain")
	public String add_product(@PathParam("product_name") String product_name, @PathParam("genre") String genre, @PathParam("collection") String collection, @PathParam("price") String price, @PathParam("location") String location)
	{
		product_name = product_name.replace("+", " ");
		location = location.replace("+", "/");
		int price_int = Integer.parseInt(price);
		String output = "FAIL";
		Connection conn = null;
		int counter = 0;
		
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(CART-REMOVE)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM products");
    		
    		ResultSet rs1 = ps1.executeQuery();
	        	
             while (rs1.next()){
            	counter = counter + 1;
            }
    		
    		
    		PreparedStatement ps = conn.prepareStatement("INSERT INTO products (product_name, genre, collection, price, location, id) VALUES (?, ?, ?, ?, ?, ?)");
    		ps.setString(1, product_name);
    		ps.setString(2, genre);
    		ps.setString(3, collection);
    		ps.setInt(4, price_int);
    		ps.setString(5, location);
    		ps.setInt(6, counter+1);
    		ps.executeUpdate();
    		
    		output = "SUCCESS";
    		
    		ps.close();
    		
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/UpdateProduct/{product_name}/{new_product_name}/{genre}/{collection}/{price}/{location}")
	@Produces("text/plain")
	public String update_product(@PathParam("product_name") String product_name, @PathParam("new_product_name") String new_product_name, @PathParam("genre") String genre, @PathParam("collection") String collection, @PathParam("price") String price, @PathParam("location") String location)
	{
		product_name = product_name.replace("+", " ");
		new_product_name = new_product_name.replace("+", " ");
		location = location.replace("+", "/");
		int price_int = Integer.parseInt(price);
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(CART-REMOVE)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		PreparedStatement ps;
    		
    		ps = conn.prepareStatement("UPDATE products SET product_name = ?, genre = ?, collection = ?, price = ?, location = ? WHERE product_name = ?");
    		ps.setString(1, new_product_name);
    		ps.setString(2, genre);
    		ps.setString(3, collection);
    		ps.setInt(4, price_int);
    		ps.setString(5, location);
    		ps.setString(6, product_name);
    		ps.executeUpdate();
    		
    		output = "SUCCESS";
    		
    		ps.close();
    		
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/DeleteProduct/{product_name}")
	@Produces("text/plain")
	public String delete_product(@PathParam("product_name") String product_name)
	{
		
		product_name = product_name.replace("+", " ");
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(CART-REMOVE)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		PreparedStatement ps;
    		
    		ps = conn.prepareStatement("DELETE FROM products WHERE product_name = ?");
    		ps.setString(1, product_name);
    		ps.executeUpdate();
    		ps.close();
    		
    		ps = conn.prepareStatement("DELETE FROM cart WHERE product_name = ?");
    		ps.setString(1, product_name);
    		ps.executeUpdate();
    		ps.close();
    		
    		ps = conn.prepareStatement("DELETE FROM favourites WHERE product_name = ?");
    		ps.setString(1, product_name);
    		ps.executeUpdate();
    		ps.close();
    		
    		output = "SUCCESS";
    		
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
	
	@GET
	@Path("/UpdateUser/{email}/{username}")
	@Produces("text/plain")
	public String update_user_info(@PathParam("email") String email, @PathParam("username") String username)
	{
		String output = "FAIL";
		Connection conn = null;
    	try {
    		//Register JDBC driver
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		//Open a connection
    		System.out.println("Connecting to database(CART-REMOVE)...");
    		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    		
    		PreparedStatement ps;
    		
    		ps = conn.prepareStatement("UPDATE users SET username = ? WHERE email = ?");
    		ps.setString(1, username);
    		ps.setString(2, email);
    		ps.executeUpdate();
    		
    		output = "SUCCESS";
    		
    		ps.close();
    		
    	}catch(SQLException | ClassNotFoundException e) {
    		e.printStackTrace();
    	}
    	return output;
	}
}


