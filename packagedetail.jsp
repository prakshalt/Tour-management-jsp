<!DOCTYPE HTML>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<html>
<head>
   <meta name="viewport" content="width=device-width, initial-scale=1">
         <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
         <link rel="stylesheet" type="text/css" href="style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

  <script src="functions.js"></script>

	<title></title>
   <style>
@import url('https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css');
#myBtn {
  display: none; /* Hidden by default */
  position: fixed; /* Fixed/sticky position */
  bottom: 20px; /* Place the button at the bottom of the page */
  right: 30px; /* Place the button 30px from the right */
  z-index: 99; /* Make sure it does not overlap */
  border: none; /* Remove borders */
  outline: none; /* Remove outline */
  background-color: red; /* Set a background color */
  color: white; /* Text color */
  cursor: pointer; /* Add a mouse pointer on hover */
  padding: 15px; /* Some padding */
  border-radius: 10px; /* Rounded corners */
  font-size: 30px; /* Increase font size */
}

#myBtn:hover {
  background-color: #FC0; /* Add a dark-grey background on hover */
}
</style>

</head>
<body>
  <% try{
  String unamefromsession=(String)session.getAttribute("username");
  if(unamefromsession!=null && unamefromsession!="")
  {%>
    <jsp:include page="navbarlogin.html" flush="true" />
 <%
  }
  else{%>
    <jsp:include page="navbar.html" flush="true" />
<%}%>	
  <jsp:include page="loginmodal.html" flush="true" />
  <jsp:include page="bookmodal.html" flush="true" />
  <jsp:include page="logoutmodal.html" flush="true" />
  <jsp:include page="registermodal.html" flush="true" />
  <jsp:include page="loginsuccessmodal.html" flush="true" />
<%  
String pid=(String)session.getAttribute("pid");
out.println(pid);
if(pid!=null && pid!="")
{
	String path="C:/xampp/tomcat/webapps/ROOT/aj_oep/packages/"+pid+".txt";
	//out.println(path);
//	InputStream fis=new FileInputStream(path);
    BufferedReader br=new BufferedReader(new FileReader(path));
   // out.println(br.readLine());
    for (String line = br.readLine(); line != null; line = br.readLine()) {
  //  out.println(line.substring(0,5));
    if(line.substring(0,5).equals("type:"))
    {
    	String temp=line.replace("type:","");
    	out.println("<input type='hidden' id='type' value='"+temp+"'>");
    }
    if(line.substring(0,6).equals("title:"))
    {
    	String temp=line.replace("title:","");
    	out.println("<h2 style='font-size:50px;background-color:#FFCC00; text-align:center;margin:0;'>"+temp+"</h2>");
    }
    if(line.substring(0,6).equals("image:"))
    {
    	String temp=line.replace("image:","");
    	out.println("<img class='d-block w-100' src='"+temp+"' alt='image'>");
    }
    if(line.substring(0,6).equals("price:"))
    {
    	String temp=line.replace("price:",""); 
    	out.println("<h2 style='font-size:50px;background-color:#FFCC00; text-align:center;margin:0;'>"+temp+"</h2>");
  		if(unamefromsession!=null && unamefromsession!="")
  		{ %>
    		<div class='container'>
 			 <div class='row'>
    		<div class='col text-center'>
     		<button type='button' class='btn btn-outline-warning mt-4 mb-4' data-toggle='modal' data-target='#bookModal' id='booknow' style='font-size:40px;'>Book now</button>
    		</div>
  			</div>
			</div>
  		<% }
  		else{ %>
    	<div class='container'>
  		<div class='row'>
    	<div class='col text-center'>
     	<button type='button' class='btn btn-outline-warning mt-4 mb-4' data-toggle='modal' data-target='#bookloginModal' id='bookloginnow' style='font-size:40px;'>Book now</button>
    	</div>
  		</div>
		</div>
		<% }
    }
     if(line.substring(0,9).equals("overview:"))
    {
    	String temp=line.replace("overview:","");
    	%>
    	<div class='container-fluid bg-dark'>
  		<h1 style='color:#FFCC00;'>Overview</h1>
  		<div class='row'>
  			<div class='col text-center'>
     		<p style='font-size: 20px;color:white;'>
     			<%= temp %>
     		</p>
    </div>
    </div>
	</div>

    <%}
    out.println(line.substring(0,11));
   if(line.substring(0,11)==("inclusions:"))
    {
    	String temp=line.replace("inclusions:","");
    	String[] words=temp.split(",");
    	%>
    	<div class='container'>
    		<h1>Inclusions</h1>
    		<div class='row'>
		<% for(String w:words){  
		if(w.equals("taxi")){ %>
			<div class='col text-center'>
     		<span class='fa fa-taxi' style='font-size: 30px;' ></span>
     		<p style='font-size: 30px'>Taxi</p>
    		</div>
		<% }
		}%> 
		</div></div> 
    <%}

    }
}

}catch(Exception e){out.println(e);}
%>
</body>
</html>