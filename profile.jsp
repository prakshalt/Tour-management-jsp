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
th{
	font-size: 25px;
}
</style>

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
    <jsp:forward page="index.jsp" />
<% } %>
   <jsp:include page="loginmodal.html" flush="true" />
  <jsp:include page="logoutmodal.html" flush="true" />
  <jsp:include page="registermodal.html" flush="true" />
  <jsp:include page="loginsuccessmodal.html" flush="true" />
  <h2 style="background-color:#FC0;font-size:40px;margin:0;text-align:center;">My tours</h2>
  <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/aj_oep"
     user="root"  password="root"/>

<sql:query dataSource="${snapshot}" var="result">
SELECT  bookings.bid,bookings.mnumber, bookings.address,bookinginfo.name,bookinginfo.gender,bookinginfo.bdate,packages.title FROM bookings INNER JOIN bookinginfo ON bookings.bid=bookinginfo.bid INNER JOIN packages ON bookings.packageid=packages.packageid WHERE bookings.userid=<%= unamefromsession%>;
</sql:query>
<table class='table table-striped'>
    <thead class='thead-dark'>
    <th scope='col'>Booking ID</th>
    <th scope='col'>Name</th>
    <th scope='col'>Gender</th>
    <th scope='col'>Birthdate</th>
    <th scope='col'>Mobile number</th>
    <th scope='col'>Address</th>
    <th scope='col'>Tour</th>
    </thead>
    <tbody>
<c:forEach var="row" items="${result.rows}">
 <tr>
  <td>
    ${row.bid}
  </td>
  <td>
    ${row.name}
  </td>
  <td>
    ${row.gender}
  </td>
  <td>
    ${row.bdate}
  </td>
  <td>
    ${row.mnumber}
  </td>
  <td>
    ${row.address}
  </td>
  <td>
    ${row.title}
  </td>
</tr>
</c:forEach>
</tbody>
</table>
</body>
</html>