<html>
<head>
  <title>Ernst-Reuter-Platz Unf&aumllle</title>
 
  <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
   <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  
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
  berlin = new google.maps.LatLng(52.512061800000, 13.321974500000);

  map = new google.maps.Map(document.getElementById('map-canvas'), {
      center: berlin,
      zoom: 15
    });

 <%@ page import = "java.sql.*" %>
  <%
  
 	String MYSQL_USERNAME = System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
    String MYSQL_PASSWORD = System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");
    String MYSQL_DATABASE_HOST = System.getenv("OPENSHIFT_MYSQL_DB_HOST");
    String MYSQL_DATABASE_PORT = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
    String MYSQL_DATABASE_NAME = System.getenv( "OPENSHIFT_APP_NAME");
    String MYSQL_DATABASE_DRIVER = "com.mysql.jdbc.Driver";
    
    
/*     String MYSQL_DATABASE_PORT = "48266";
    String MYSQL_DATABASE_HOST = "52d533b64382ecc670000075-delysid.rhcloud.com";
    String MYSQL_PASSWORD = "TzW6621jyUrG";
    String MYSQL_USERNAME = "adminxzEwuJN";
    String MYSQL_DATABASE_NAME = "ernstunfall";
    String MYSQL_DATABASE_DRIVER = "com.mysql.jdbc.Driver";  */
    
    
    
    
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


function hideRestOfMarkers(markersToDisplay){

	 for(var i = 0; i < markersArray.length; i++){
		markersArray[0].setVisible(false);
	 }
	 markersArray = [];
	 
}

function displayAccident(lat, lon) {
  

      var placeLatlng  = new google.maps.LatLng(lat,lon);
      createMarker(placeLatlng);

 
}

var markersArray = [];

function createMarker(placeLatlng) {

  var marker = new google.maps.Marker({
      position: placeLatlng,
      map: map,
      title: 'Hello World!'
  });
  
  markersArray.push(marker);

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(place.name);
    infowindow.open(map, this);
  });
}


google.maps.event.addDomListener(window, 'load', initialize);
</script>

  <script>


function updateMapAccordingToTimeRange(value){

	 $( "#amount" ).val(value);
	 
	    $.ajax({
            url: "timeRangeRequest.jsp?range="+value,
            success: function(data){
                alert(data)
             }
          });
		
}
  
  $(function() {
    $( "#slider-range-max" ).slider({
      range: "max",
      min: 1,
      max: 8,
      value: 2,
      slide: function( event, ui ) {
	  switch(ui.value)
		{
		case 1:
		  	updateMapAccordingToTimeRange("0:00 - 5:59");
		  	break;
		case 2:
		  	updateMapAccordingToTimeRange("6:00 - 7:59");
		  break;
		case 3:
			updateMapAccordingToTimeRange("8:00 - 10:29");			
		  break;
		case 4:
			 updateMapAccordingToTimeRange("10:30 - 12.59");
		  break;
		case 5:
			updateMapAccordingToTimeRange( "13:00 - 15:29");
		  	break;
		case 6:
			updateMapAccordingToTimeRange("15:30 - 17:59");
		  break;
		case 7:
			updateMapAccordingToTimeRange( "18:00 - 20:29" );
		  break;
		case 8:
			updateMapAccordingToTimeRange( "20:30 - 23:59" );
		  break;
  
		default:
		  break;
		}
		
		
			
	          
      }
    });
    
   $( "#amount" ).val("6:00 - 7:59" );
  });
  
  </script> 



  
  
</head>
<body>
  <h1>Unf&aumllle am Ernst-Reuter-Platz</h1>
  <h3>by Viktor Stoitschev, Jakob und Mandy</h3>
  
<p>
  <label for="amount">Time Range:</label>
  <input type="text" id="amount" style="border:0; color:#f6931f; font-weight:bold;">
</p> 
<div style="width: 200px">
<div id="slider-range-max"></div>
</div>  
    <div id="map-canvas"></div>
    
 
 </body>
 <html>
  
  