<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<!-- 실제로 데이터베이스 클래스를 사용할 수 있도록 가져온다.-->
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

<title>건국대학교</title>
</head>
<body>
	<%
	    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
	    if (session.getAttribute("userID") != null) {
	        userID = (String) session.getAttribute("userID");
	    }

	    //매개변수 및 기본세팅을 처리하도록 한다.
	    int noticeID = 0;

	    //매개변수로 넘어온 bbsID가 존재한다면
	    if (request.getParameter("noticeID") != null) {
	        //bbsID를 넣어준다. 정상적으로 bbsID가 넘어왔다면 view 페이지 안에서 이걸 이용하여 bbsID를 담은 다음에 처리할 수 있도록 한다.
	        noticeID = Integer.parseInt(request.getParameter("noticeID"));
	        System.out.println(noticeID);

	    }
	    //bbsID가 0이라면 bbs.jsp에 다시 이동할 수 있게 해준다.
	    if (noticeID == 0) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('유효하지 않은 글입니다')");
	        script.println("location.href = 'notice.jsp'");
	        script.println("</script>");
	    }
	    //유효한 글이라면 해당 글의 구체적인 내용을 가져올 수 있도록 한다. --> 실제로 해당 글의 내용을 보여줄 수 있도록 한다.
	    Notice notice = new NoticeDAO().getNotice(noticeID);
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
				<li><a href="bbs.jsp">과제게시판</a></li>
				<li class="active"><a href="notice.jsp">공지사항</a></li>
			</ul>
			<%
			    // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
			    if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
						
					</ul></li>
			</ul>
			<%
			    // 로그인이 되어있는 사람만 볼수 있는 화면
			    } else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="loginAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
			    }
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<!-- 제목부분 같은 경우는 3개만큼의 열을 차지할 수 있도록 설정해준다. -->
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">공지사항 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%=notice.getNoticeTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
						        .replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=notice.getUserID().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
                    .replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
                        <td>작성일자</td>
                        <td colspan="2"><%=notice.getNoticeDate().substring(0, 11) + notice.getNoticeDate().substring(11, 13) + "시"
                    + notice.getNoticeDate().substring(14, 16) + "분"%></td>
                    </tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;">
							<!-- 특수문자를 제대로 출력하기위해 replaceAll로 특수문자를 구현시켜준다 & 악성스크립트를 방지하기위해 -->
							<%=notice.getNoticeContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
                    .replaceAll("\n", "<br>")%></td>
					</tr>

					<%-- <tr>
                        <td>파일</td>
                        <td colspan="2"><%=bbs.getFileName()%></td>
                    </tr> --%>


				</tbody>
			</table>
			<a href="notice.jsp" class="btn btn-primary">목록</a>
			<%
			    // 해당 글의 작성자가 본인이라면 수정 및 삭제 할 수 있게 해준다.
			    if (userID != null && userID.equals(notice.getUserID())) {
			%>
			<a href="update2.jsp?noticeID=<%=noticeID%>" class="btn btn-primary">수정</a>
			<!-- onclick을 이용해서 삭제버튼을 누르면 한번 더 알림창이 뜨게 해준다. -->
			<a onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="deleteAction2.jsp?noticeID=<%=noticeID%>" class="btn btn-primary">삭제</a>

			<%
			    }
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>