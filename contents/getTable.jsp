<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../styles.css">
  
  <title>상주와 함께하는 칼바람</title>
    <%@include file="/menu.jsp" %>
</head>
<body>
    <div class="content">
            
    
	<%
	  String driver = "org.mariadb.jdbc.Driver";
	  String url = "jdbc:mariadb://114.108.153.29:3306/mysql";
	  //String url = "jdbc:mariadb://172.16.30.73/mysql";
	  String user = "root";
	  String password = "1234";


	  String id = request.getParameter("value");
	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;
	  ResultSet rs2 = null;
	  
	  Class.forName(driver);
	  conn = DriverManager.getConnection(url, user, password);

 	  String sql = "SELECT MAX(version_info) AS VERSION_INFO  FROM version_info";
	  pstmt = conn.prepareStatement(sql);
	  String season = "2024시즌 스플릿 2";
	  rs2 = pstmt.executeQuery();
		while (rs2.next()) {
			season = rs2.getString("VERSION_INFO");
		}
	%>
	
	<%-- 
        <select name="season"  onchange="handleOnChange()">
		<%
		while (rs2.next()) {
		%>
          <option value= <%=rs2.getString("VERSION_INFO")%>><%=rs2.getString("VERSION_INFO")%></option>
		<%
		}
		%>
        </select> --%>
	

	
	<%
	  sql = "SELECT A.CHAMP_NAME, A.TOT_GAME, A.WIN_GAME, A.LOSE_GAME, ROUND(A.WIN_GAME/A.TOT_GAME*100) AS WIN_RATE  FROM (" +
			  " SELECT D.CHAMP_NAME" +
			  " , SUM(CASE WHEN B.GAME_RESULT = 'O' THEN 1 ELSE 0 END) AS WIN_GAME" +
			  " , SUM(CASE WHEN B.GAME_RESULT = 'X' THEN 1 ELSE 0 END) AS LOSE_GAME" +
			  " , SUM(1) AS TOT_GAME" +
			  " FROM user_info A" +
			  " LEFT JOIN game_part B ON A.USER_ID = B.USER_ID" +
			  " LEFT JOIN game_info C ON B.GAME_ID = C.GAME_ID" +
			  " LEFT JOIN champ_list D ON B.CHAMP_ID = D.CHAMP_ID" +
			  " LEFT JOIN version_info E ON SUBSTRING_INDEX(C.GAME_VERSION, '.', 2)  = E.GAME_VERSION" +
			  " WHERE C.GAME_MODE = 'ARAM' " +
			  " AND A.USER_NAME = '" + id + "'" +
			  " AND E.version_info = '" + season + "' " +
			  " GROUP BY D.CHAMP_NAME ) A " +
			  " ORDER BY A.TOT_GAME DESC, A.CHAMP_NAME ";
	  pstmt = conn.prepareStatement(sql);
	  rs = pstmt.executeQuery();
	  
	%>
	
	
	<table border="1">
		<tr style = "background-color: #909be0">
			<th>챔피언</th>
			<th>총게임</th>
			<th>승</th>
			<th>패</th>
			<th>승률</th>
		</tr>
		<%
		while (rs.next()) {
			int result = rs.getInt("WIN_RATE");
			String result_color = "#ffffff";
			if(result == 0){
				result_color = "#666666";
			}
			else if(result > 0 && result <= 20){
				result_color = "#CCCCCC";
			}
			else if(result > 20 && result <= 40){
				result_color = "#999900";
			}
			else if(result > 40 && result < 50){
				result_color = "#CCCC00";
			}
			else if(result >= 50 && result <= 60){
				result_color = "#CCCCFF";
			}
			else if(result > 60 && result <= 75){
				result_color = "#99FF99";
			}
			else if(result > 75 && result <= 85){
				result_color = "#00FF00";
			}
			else if(result > 85 && result <= 100){
				result_color = "#00FFFF";
			}
		%>
		<tr style = "background-color: <%=result_color%>">
			<td width="200" align = "center"><%=rs.getString("CHAMP_NAME")%></td>
			<td width="100" align = "center"><%=rs.getString("TOT_GAME")%></td>
			<td width="100" align = "center"><%=rs.getString("WIN_GAME")%></td>
			<td width="100" align = "center"><%=rs.getString("LOSE_GAME")%></td>
			<td width="100" align = "center"><%=rs.getString("WIN_RATE")%></td>
		</tr>
		<%
		}
		%>
	</table>
    </div>
</body>
</html>
