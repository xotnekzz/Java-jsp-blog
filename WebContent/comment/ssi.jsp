<%@page import="nation.web.comment_reply.Comment_replyVO"%>
<%@page import="nation.web.comment_reply.Comment_replyProc"%>
<%@page import="java.util.ArrayList"%>
<%@page import="nation.web.comment.*"%>
<%@page import="nation.web.comment.*"%>
<%@ page import="org.json.simple.*" %>
<%
request.setCharacterEncoding("UTF-8");
CommentProc commentProc = new CommentProc();

Comment_replyProc comment_replyProc = new Comment_replyProc();
Comment_replyVO comment_replyVO = new Comment_replyVO();

ArrayList<CommentVO> list = null;
CommentVO commentVO = new CommentVO();



%> 