
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

    <nav class = "navbar">
      <ul class = "navbar__menu">
        <li><a href="/contents/getTable.jsp?value=변준옥">변준옥</a></li>
        <li><a href="/contents/getTable.jsp?value=손한결">손한결</a></li>
        <li><a href="/contents/getTable.jsp?value=송시욱">송시욱</a></li>
        <li><a href="/contents/getTable.jsp?value=신찬울">신찬울</a></li>
        <li><a href="/contents/getTable.jsp?value=이상주">이상주</a></li>
        <li><a href="/contents/getTable.jsp?value=장세홍">장세홍</a></li>
        <li><a href="/contents/getTable.jsp?value=김지환">김지환</a></li>
        <li><a href="/contents/getTable2.jsp?value=total">종합</a></li>
      </ul>
    </nav>
    