<!-- 실제로 글쓰기를 눌러서 만들어주는 Action페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바스크립트 문장사용 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 건너오는 모든 파일을 UTF-8로 -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>건국대학교</title>
</head>
<body>
	<%
		String userID = null;
		// 로그인 된 사람은 회원가입페이지에 들어갈수 없다
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
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} else {

			//빈칸이거나 null값이 하나라도 있는 경우에 입력이 안된 사항이 있다고 사용자가 다시 입력할 수 있게 해준다.
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
					|| request.getParameter("bbsTitle").equals("")
					|| request.getParameter("bbsContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				//정상적으로 입력이 되었다면 성공적으로 글을 수정할 수 있도록 만들어주면 되는 것임 
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"),
						request.getParameter("bbsContent"));
				if (result == -1) { // 오류 : 글수정에 실패했을 경우
					PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣을 수 있도록.
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else { // 글수정에 성공했을 경우
					PrintWriter script = response.getWriter();
					script.println("<script>");
					//게시판 메인 화면으로 이동 시켜줄 수 있도록 하면된다.
					script.println("location.href= 'bbs.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>