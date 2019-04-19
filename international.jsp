<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 

<html>
<head>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="functions.js"></script>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
     <link rel="stylesheet" type="text/css" href="style.css">
 <meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
@import url('https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css');
</style>

	<title>Tours</title>
</head>
<body>
 <%
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
  <jsp:include page="logoutmodal.html" flush="true" />
  <jsp:include page="registermodal.html" flush="true" />
  <jsp:include page="loginsuccessmodal.html" flush="true" />
  <h1>International Tour Packages</h1>
  <script type="text/javascript">
    //console.log('in');
    var element=document.getElementById('intlink');
    element.classList.add("active");
    var element2=document.getElementById('serviceslink');
    element2.classList.add("active");
  </script>
<% int count = 0; %> 
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/aj_oep"
     user="root"  password="root"/>

<sql:query dataSource="${snapshot}" var="result">
Select title,smalldesc,price,image,packageid from packages where type='int';
</sql:query>
<c:forEach var="row" items="${result.rows}">
<%  if(count%3==0){ %>
           <div class='row'>
<% } %>
 <div class='col-md-4'>
               <div class='card'>
    <img class='card-img-top' src="<c:out value='${row.image}'/>" alt='Card image cap'>
    <div class='card-body'>
      <h5 class='card-title'><c:out value='${row.title}'/></h5>
      <p class='card-text'><c:out value='${row.smalldesc}'/></p>
      <p class='card-text'><small class='text-muted'>Starting with <c:out value='${row.price}'/></small></p>
       <button type='button' class='btn btn-outline-warning mt-4 mb-4' id="<c:out value='${row.packageid}'/>" onClick='setpackage(this.id)' >View details</button>
    </div>
  </div>
  </div>
<% count++;
if(count%3==0){ %>
</div>
<% } %>
</c:forEach><jsp:include page="footer.html" flush="true" />
</body>
</html>

