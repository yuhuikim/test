<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<!-- 내비게이션 바 -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">건국대학교</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">메인</a></li>
				<li><a href="bbs.jsp">과제게시판</a></li>
				<li class="active"><a href="notice.jsp">공지사항</a></li>
			</ul>
			<!-- 로그인 전 화면 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>

					</ul></li>
			</ul>
			<!--  로그인 후 화면 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
		</div>
	</nav>
	<!-- 글 작성 양식 -->
	<div class="container">
		<div class="row">
			<form method="post" action="noticeAction.jsp">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="noticeTitle" maxlength="50"></td>
						</tr>
						<tr>
							<!-- 장문의 글을 위해서  -->
							<td><textarea class="form-control" placeholder="글 내용"
									name="noticeContent" maxlength="4096" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>

			<!-- 	<form action="fileAction.jsp" method="post" enctype="multipart/form-data">
				<input type="file" name="file1" accept="image/*" /><br>
				<input type="submit" class="btn btn-primary pull-left" value="파일업로드">

			</form> -->
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>