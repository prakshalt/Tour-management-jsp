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
Select userid,password from users where email='<%= uname %>';
</sql:query>
<c:choose>
        <c:when test="${result.rowCount == 0}">
            <%out.println("no user");%>
          </c:when>
        <c:otherwise>
            <c:forEach var="row" items="${result.rows}">
            <c:set var="q_uid" value ="${row.userid}" />
            <c:set var="q_pwd" value ="${row.password}" />
            <% 
            int id=(Integer)pageContext.getAttribute("q_uid");
            String pwd=(String)pageContext.getAttribute("q_pwd");
            if(pwd.equals(password))
            {
                session.setAttribute("username",uname);
                  session.setAttribute("userid",id);
            }
            else{
                out.println("false");
             }
               %>
            </c:forEach>
            </c:otherwise>
</c:choose>


