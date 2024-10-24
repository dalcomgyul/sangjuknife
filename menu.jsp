
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
:root {
  --text-color: #f0f4f5;
  --background-color: #263343;
  --accent-color: orange;
  --icons-color: rgb(152, 187, 201);
  --bodybackground-color: lightgray;
}

body { 
  margin: 0;
  background-color: var(--bodybackground-color);
  font-family: 'STIX Two Math';
}

a {
  text-decoration: none;
  color: var(--text-color);
}

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: var(--background-color);
  padding: 8px 12px;
  font-family: 'STIX Two Math';
}

.navbar__logo i {
  color: var(--accent-color);
  padding-left: 0;
}

.navbar__menu {
  list-style: none;
  display: flex;
  margin: 0;
  padding-left: 0;
}

.navbar__menu li {
  padding: 8px 30px;
}

.navbar__icons {
  list-style: none;
  display: flex;
  color: var(--icons-color);
  margin: 0;
  padding-left: 0;
}

.navbar__icons li {
  padding: 8px 12px;
  margin: 0;
}
.navbar__menu li:hover {
  background-color: var(--accent-color);
  border-radius: 3px;
}

</style>

<html lang="ko">
	<%
	  String driver2 = "org.mariadb.jdbc.Driver";
	  String url2 = "jdbc:mariadb://114.108.153.29:3306/mysql";
	  //String url = "jdbc:mariadb://172.16.30.73/mysql";
	  String user2 = "root";
	  String password2 = "1234";

	  Connection conn2 = null;
	  PreparedStatement pstmt2 = null;
	  ResultSet rsx = null;
	  
	  Class.forName(driver2);
	  conn2 = DriverManager.getConnection(url2, user2, password2);

	  String sql2 = "SELECT A.USER_NAME, ROW_NUMBER() OVER(ORDER BY A.USER_NAME DESC) AS RNK FROM (SELECT DISTINCT USER_NAME FROM user_list) A ORDER BY A.USER_NAME DESC";
	  pstmt2 = conn2.prepareStatement(sql2);
	  rsx = pstmt2.executeQuery();
	  %>
	  
    <nav class = "navbar">
      <ul class = "navbar__menu">
	  <%
		while (rsx.next()) {
	   %>
	        <li><a href="/contents/getTable.jsp?value=<%=rsx.getString("USER_NAME")%>"><%=rsx.getString("USER_NAME")%></a></li>
    <%
		}
	%>
	
        <li><a href="/contents/getTable2.jsp?value=total">종합</a></li>
      </ul>
    </nav>
    
</html>