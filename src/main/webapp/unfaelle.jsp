<html>
<head>
  <title>Ernst-Reuter-Platz Unf&aumllle</title>
  <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
  <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  <script src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>

  <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
  <meta charset="utf-8">
  <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
    </style>

    <script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"></script>
	<script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('visualization', '1', {packages: ['linechart']});
    </script>
    <script type="text/javascript">
    var visualization;
var map;
var service;
var infowindow;
var berlin;
function initialize() {
  berlin = new google.maps.LatLng(52.539614, 13.403106);

  map = new google.maps.Map(document.getElementById('map-canvas'), {
      center: berlin,
      zoom: 12
    });

 <%@ page import = "java.sql.*" %>
  <%
  
	String MYSQL_USERNAME = System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
    String MYSQL_PASSWORD = System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
    String MYSQL_DATABASE_HOST = System.getenv("OPENSHIFT_MYSQL_DB_HOST");
    String MYSQL_DATABASE_PORT = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
    String MYSQL_DATABASE_NAME = System.getenv( "OPENSHIFT_APP_NAME");
    String MYSQL_DATABASE_DRIVER = "com.mysql.jdbc.Driver";
	Connection conn = null;
	
	
	    try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException cnfe) {
                cnfe.getMessage();
            }
	 String url = "";
  
                url = "jdbc:mysql://" + MYSQL_DATABASE_HOST + ":" + MYSQL_DATABASE_PORT + "/" + MYSQL_DATABASE_NAME;
                conn = DriverManager.getConnection(url, MYSQL_USERNAME, MYSQL_PASSWORD);
	Statement stmt = conn.createStatement();
	
      String sqlStr = "SELECT * FROM unfaelle";
 
      // for debugging
      System.out.println("Query statement is " + sqlStr);
      			

			
			ResultSet rset = stmt.executeQuery(sqlStr);

	      while (rset.next()) {
        Double latitude = rset.getDouble("GPS_Lat");
		Double longitude = rset.getDouble("GPS_Long");
		
		out.println("displayAccident(" + String.valueOf(latitude) + ", " + String.valueOf(longitude) + ");");
		}
	  
	  
	  
	  
	  rset.close();
      stmt.close();
      conn.close();
	  
  %>
  
	  
 
}


function displayAccident(lat, lon) {
  

      var place = new google.maps.LatLng(lat,lon);
      createMarker(place);

 
}

function createMarker(place) {
  var placeLoc = place.geometry.location;
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(place.name);
    infowindow.open(map, this);
  });
}


google.maps.event.addDomListener(window, 'load', initialize);


    </script>
 
  
  
</head>
<body>
  <h1>Unf&aumllle am Ernst-Reuter-Platz</h1>
  <h3>by Viktor Stoitschev, Jakob und Mandy</h3>

 
  
    <div id="map-canvas"></div>
    <div id="results">
      <h2>Results</h2>
      <ul id="places"></ul>
      <button id="more">More results</button>
    </div>
	<form action="unfaelle.jsp">
  <div>
    <input type="hidden">
    <input type="submit">
  </div>
   
 
 
 </body>
 <html>
  
  