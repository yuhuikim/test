<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.Notice"%>
<%@ page import="notice.NoticeDAO"%>
<!DOCTYPE html>
<html>
<head>
<!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

<link rel="stylesheet" href="css/bootstrap.css">
<!-- 참조  -->
<link rel="stylesheet" href="css/custom.css">
<!-- 참조  -->

<!-- <script>
    function doSubmit() {
        Frm.encoding = "application/x-www-form-urlencoded";
        Frm.action = "updateAction.jsp";
        Frm.submit();
    }
</script> -->


<title>건국대학교</title>
</head>
<body>
	<%
	    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
	    if (session.getAttribute("userID") != null) {
	        userID = (String) session.getAttribute("userID");
	    }
	    if (userID == null) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('로그인을 하세요')");
	        script.println("location.href = 'login.jsp'");
	        script.println("</script>");
	    }
	    int noticeID = 0;
	    if (request.getParameter("noticeID") != null) {
	        noticeID = Integer.parseInt(request.getParameter("noticeID"));
	    }
	    if (noticeID == 0) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('유효하지 않은 글입니다')");
	        script.println("location.href = 'notice.jsp'");
	        script.println("</script>");
	    }
	    //현재 넘어온 bbsID값을 갖고 해당 글을 가지고 온 다음에 실제로 이 글을 작성한 사람이 맞는지 확인해준다.
	    Notice notice = new NoticeDAO().getNotice(noticeID);

	    if (!userID.equals(notice.getUserID())) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('권한이 없습니다')");
	        script.println("location.href = 'notice.jsp'");
	        script.println("</script>");
	    }
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<!-- 홈페이지의 로고 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expand="false">
				<span class="icon-bar"></span>
				<!-- 줄였을때 옆에 짝대기 -->
				<span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">건국대학교</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li class="active"><a href="notice.jsp">공지사항</a></li>
			</ul>
			<%--        <%
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            // 로그인이 되어있는 사람만 볼수 있는 화면
                } else {
            %> 
--%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="loginAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%--             
            <%
                }
            %> 
--%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction2.jsp?noticeID=<%=noticeID%>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">공지사항
								글 수정 양식</th>

						</tr>
					</thead>
					<tbody>
						<tr>
						<%-- 	value="<%=notice.getNoticeTitle()%> --%>
							<!--자기가 수정하기 전의 내용을 보여줄 수 있도록 한다. -->
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="noticeTitle" maxlength="50"
								value="<%=notice.getNoticeTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="noticeContent" maxlength="4096" style="height: 350px"><%=notice.getNoticeContent()%></textarea></td>
						</tr>

						<!-- 	<tr>
							<td><input type="file" name="file1"
								accept="image/*" />
							</td>
						</tr> -->
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
