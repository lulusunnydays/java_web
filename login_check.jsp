<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@page import = "java.sql.*"%>
<html>
<head>chapter5</head>
<body>
<%!
	public static final String DBDRIVER = "com.mysql.jdbc.Driver";
	//public static final String DBDRIVER = "org.git.mm.jdbc.Driver";
	public static final String DBURL = "jdbc:mysql://localhost:3306/mldn";
	public static final String DBUSER ="root";
	public static final String DBPASS = "123";
%>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean flag = false;
	String name = null;
%>
<%
	try{
	Class.forName(DBDRIVER); //加载驱动程序
	conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS); //取得数据库连接
	String sql = "SELECT name,userid FROM user WHERE userid=? AND password=?"; 
	pstmt = conn.prepareStatement(sql); //实例化数据库操作对象
	pstmt.setString(1,request.getParameter("id")); //设置查询所需要的内容
	pstmt.setString(2, request.getParameter("password")); //设置查询所需要的内容
	rs = pstmt.executeQuery(); //执行查询
	if(rs.next()){
		name =  rs.getString(1);
		flag =  true;
	}
}catch(Exception e){
	System.out.print(e);
}
finally{
	try{
		rs.close(); //关闭操作会跑出异常 catch
		pstmt.close(); //关闭查询对象
		conn.close(); //关闭数据库连接
	}catch (Exception e){
		
	}
}
%>
<%
	if(flag){
%>
	<jsp:forward page="login_success.jsp">
		<jsp:param value="<%=name%>" name="uname"/>
	</jsp:forward>
<%
	}else{
%>	
	
	<jsp:forward page="login_failure.jsp"></jsp:forward>
<%
	}
%>
</body>
</html>