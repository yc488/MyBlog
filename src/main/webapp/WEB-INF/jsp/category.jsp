<%@page import="com.yc.blog.util.Utils"%>
<%@page import="com.yc.blog.bean.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="zh-CN">
<%@ include file="common/links.jsp"%>

<body class="user-select">
	<%@ include file="common/header.jsp"%>

	<section class="container">
		<div class="content-wrap">
			<div class="content">
				<div class="title">
					<h3>后端程序</h3>
				</div>

				<c:forEach items="${ categoryArticles}" var="article">
					<article class="excerpt excerpt-1">
						<a class="focus" href="seeArticle?id=${article.id }" title=""><img
							class="thumb"
							data-original="${article.titleimgs==null?'images/excerpt.jpg':article.titleimgs }"
							src="images/articleloading.gif" alt=""></a>
						<header>
							<a class="cat" href="category?categoryId=${article.category.id }">${article.category.name}<i></i></a>
							<h2>
								<a href="seeArticle?id=${article.id }" title="">${article.title}</a>
							</h2>
						</header>
						<p class="meta">
							<time class="time">
								<i class="glyphicon glyphicon-time"></i> ${article.createtime}
							</time>
							<span class="views"><i
								class="glyphicon glyphicon-eye-open"></i> 共${article.readcnt}人围观</span>
							<a class="comment" href="seeArticle?id=${article.id }#comment"><i
								class="glyphicon glyphicon-comment"></i> ${article.commcnt}个不明物体</a>
						</p>
						<%
							Article a = (Article) pageContext.getAttribute("article");
						%>
						<p class="note"><%=Utils.getContent(a.getContent()).substring(0, 100)%>...
						</p>
					</article>
				</c:forEach>


				<nav class="pagination" style="display: none;">
					<ul>
						<li class="prev-page"></li>
						<li class="active"><span>1</span></li>
						<li><a href="?page=3">3</a></li>
						<li class="next-page"><a href="?categoryId=${param.categoryId }&page=${page}">下一页</a></li>
						<li><span>共 3页</span></li>
					</ul>
				</nav>
			</div>
		</div>
		


			<!--右键菜单列表-->
			<%@ include file="common/footer.jsp"%>
</body>
</html>