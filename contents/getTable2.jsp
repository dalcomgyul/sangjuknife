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
	  ResultSet rs3 = null;
	  ResultSet rs4 = null;
	  
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
	
	
	<%
	  sql = "SELECT A.USER_NAME, A.TOT_GAME, A.WIN_GAME, A.LOSE_GAME, ROUND(A.WIN_GAME/A.TOT_GAME*100) AS WIN_RATE  FROM ( " +
			  "SELECT A.USER_NAME " +
			  ", SUM(CASE WHEN B.GAME_RESULT = 'O' THEN 1 ELSE 0 END) AS WIN_GAME " +
			  ", SUM(CASE WHEN B.GAME_RESULT = 'X' THEN 1 ELSE 0 END) AS LOSE_GAME " +
			  ", SUM(1) AS TOT_GAME " +
			  "FROM user_info A " +
			  "LEFT JOIN game_part B ON A.USER_ID = B.USER_ID " +
			  "LEFT JOIN game_info C ON B.GAME_ID = C.GAME_ID " +
			  "LEFT JOIN champ_list D ON B.CHAMP_ID = D.CHAMP_ID " +
			  "LEFT JOIN version_info E ON SUBSTRING_INDEX(C.GAME_VERSION, '.', 2)  = E.GAME_VERSION " +
			  "WHERE C.GAME_MODE = 'ARAM' " +
			  "AND E.version_info = '" + season + "' " +
			  "GROUP BY A.USER_NAME ) A " +
			  "ORDER BY A.TOT_GAME DESC ";
	  pstmt = conn.prepareStatement(sql);
	  rs = pstmt.executeQuery();

	  
	%>
	
	
	<table border="1">
		<tr style = "background-color: #909be0">
			<th>이름</th>
			<th>총게임</th>
			<th>승</th>
			<th>패</th>
			<th>승률</th>
		</tr>
		<%
		while (rs.next()) {
			int result = rs.getInt("WIN_RATE");
			String result_color = "#ffffff";
		%>
		<tr style = "background-color: <%=result_color%>">
			<td width="200" align = "center" style = "background-color: #909be0"><%=rs.getString("USER_NAME")%></td>
			<td width="100" align = "center"><%=rs.getString("TOT_GAME")%></td>
			<td width="100" align = "center"><%=rs.getString("WIN_GAME")%></td>
			<td width="100" align = "center"><%=rs.getString("LOSE_GAME")%></td>
			<td width="100" align = "center"><%=rs.getString("WIN_RATE")%></td>
		</tr>
		<%
		}
		%>
	</table>
	
	
	<%

	  sql = "SELECT A.USER_NAME, ROW_NUMBER() OVER(ORDER BY A.USER_NAME DESC) AS RNK FROM (SELECT DISTINCT USER_NAME FROM user_list) A ORDER BY A.USER_NAME DESC";
	  pstmt = conn.prepareStatement(sql);
	  rs4 = pstmt.executeQuery();
	  int i = 0;
     while (rs4.next()) {
	  String user_name = rs4.getString("USER_NAME");
	  int user_seq = rs4.getInt("RNK");
	  sql = "SELECT A.USER_NAME " +
			  " 		,CASE WHEN A.CHAMP_TYPE = 'T' THEN '앞라인' " +
			  " 				WHEN A.CHAMP_TYPE = 'P' THEN 'AP' " +
			  " 				WHEN A.CHAMP_TYPE = 'D' THEN '원딜' " +
			  " 				WHEN A.CHAMP_TYPE = 'S' THEN '서폿' " +
			  " 				WHEN A.CHAMP_TYPE = 'X' THEN '암살자' ELSE '미설정'END AS CHAMP_TYPE, A.TOT_GAME, A.WIN_GAME, A.LOSE_GAME, ROUND(A.WIN_GAME/A.TOT_GAME*100) AS WIN_RATE  FROM ( " +
			  " SELECT A.USER_NAME, D.CHAMP_TYPE " +
			  " , SUM(CASE WHEN B.GAME_RESULT = 'O' THEN 1 ELSE 0 END) AS WIN_GAME " +
			  " , SUM(CASE WHEN B.GAME_RESULT = 'X' THEN 1 ELSE 0 END) AS LOSE_GAME " +
			  " , SUM(1) AS TOT_GAME " +
			  " FROM user_info A " +
			  " LEFT JOIN game_part B ON A.USER_ID = B.USER_ID " +
			  " LEFT JOIN game_info C ON B.GAME_ID = C.GAME_ID " +
			  " LEFT JOIN champ_list D ON B.CHAMP_ID = D.CHAMP_ID " +
			  " LEFT JOIN version_info E ON SUBSTRING_INDEX(C.GAME_VERSION, '.', 2)  = E.GAME_VERSION " +
			  " WHERE C.GAME_MODE = 'ARAM' " +
			  " AND E.version_info = '" + season + "' " +
			  " AND A.USER_NAME = '" + user_name + "' " +
			  " GROUP BY A.USER_NAME, D.CHAMP_TYPE ) A " +
			  " ORDER BY A.USER_NAME DESC,A.CHAMP_TYPE";
	  pstmt = conn.prepareStatement(sql);
	  rs3 = pstmt.executeQuery();

	  rs3.last();
	  int rowCount = rs3.getRow(); 
	  rs3.beforeFirst();
	  
		%>
	
	<table border="1">
		<%
		if (i == 0){
		
		%>
		<tr style = "background-color: #909be0">
			<th>이름</th>
			<th>챔프종류</th>
			<th>총게임</th>
			<th>승</th>
			<th>패</th>
			<th>승률</th>
		</tr>
		<%	
		i = i + 1;
		}
		%>
		<%
		String result_color = "#ffffff";
		if(user_seq % 2 == 0){
			result_color = "#ffffff";
		}
		else{
			result_color = "#cccccc";
		}
		int j = 0;
		while (rs3.next()) {
			
		%>
		<tr style = "background-color: <%=result_color%>">
		<%
		if( j == 0){
		 %>
			<td width="200" align = "center" rowspan = '<%=rowCount%>'><%=rs3.getString("USER_NAME")%></td>
			
		<%
		}
		 %>
			<td width="100" align = "center"><%=rs3.getString("CHAMP_TYPE")%></td>
			<td width="100" align = "center"><%=rs3.getString("TOT_GAME")%></td>
			<td width="100" align = "center"><%=rs3.getString("WIN_GAME")%></td>
			<td width="100" align = "center"><%=rs3.getString("LOSE_GAME")%></td>
			<td width="100" align = "center"><%=rs3.getString("WIN_RATE")%></td>
		</tr>
		<%
		j = j + 1;
		}
		%>
	</table>
	
		<%
		}
		%>
    </div>
</body>
</html>
