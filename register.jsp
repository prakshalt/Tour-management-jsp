<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/aj_oep"
     user="root"  password="root"/>

<%  
String uname=request.getParameter("username");
String password=request.getParameter("password");  
%>  
<sql:query dataSource="${snapshot}" var="result">
Select email from users where email='<%= uname %>';
</sql:query>
<c:choose>
        <c:when test="${result.rowCount == 0}">
            <sql:update dataSource = "${snapshot}" var = "count">
         INSERT INTO users ( email, password)
		VALUES ('<%= uname %>','<%= password %>');
      </sql:update>
        </c:when>
        <c:otherwise>
            <%out.println("already");%>
        </c:otherwise>
</c:choose>


