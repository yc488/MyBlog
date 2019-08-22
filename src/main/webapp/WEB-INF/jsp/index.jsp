<%@page import="com.yc.blog.bean.Article"%>
<%@page import="com.yc.blog.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!doctype html>
<html lang="zh-CN">

<%@ include file="common/links.jsp"%>

<body class="user-select">
	<%@ include file="common/header.jsp"%>

	<section class="container">
		<div class="content-wrap">
			<div class="content">
				<div class="jumbotron">
					<h1>欢迎访问异清轩博客</h1>
					<p>在这里可以看到前端技术，后端程序，网站内容管理系统等文章，还有我的程序人生！</p>
				</div>
				<div id="focusslide" class="carousel slide" data-ride="carousel" >
					<ol class="carousel-indicators">
						<li data-target="#focusslide" data-slide-to="0" class="active"></li>
						<li data-target="#focusslide" data-slide-to="1"></li>
						<li data-target="#focusslide" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<a href="" target="_blank"><img
								src="images/banner/banner_01.jpg" alt="" class="img-responsive"></a>
							<!--<div class="carousel-caption"> </div>-->
						</div>
						<div class="item">
							<a href="" target="_blank"><img
								src="images/banner/banner_02.jpg" alt="" class="img-responsive"></a>
							<!--<div class="carousel-caption"> </div>-->
						</div>
						<div class="item">
							<a href="" target="_blank"><img
								src="images/banner/banner_03.jpg" alt="" class="img-responsive"></a>
							<!--<div class="carousel-caption"> </div>-->
						</div>
					</div>
					<a class="left carousel-control" href="#focusslide" role="button"
						data-slide="prev" rel="nofollow"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">上一个</span>
					</a> <a class="right carousel-control" href="#focusslide" role="button"
						data-slide="next" rel="nofollow"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">下一个</span>
					</a>
				</div>
				<article class="excerpt-minic excerpt-minic-index">
					<h2>
						<span class="red">【今日推荐】</span><a href="seeArticle?id=${todayRecommend.id }">${todayRecommend.title }</a>
					</h2>
					<p class="note">${todayRecommend.content}...</p>
				</article>
				<div class="title">
					<h3>最新发布</h3>
				</div>
				<c:forEach items="${newArticles}" var="article">
					<article class="excerpt excerpt-1">
						<a class="focus" href="seeArticle?id=${article.id }" title=""><img
							class="thumb" data-original="${article.titleimgs==null?'images/excerpt.jpg':article.titleimgs }"
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
							<span class="views"><i class="glyphicon glyphicon-eye-open"></i>
								共${article.readcnt}人围观</span> <a class="comment" href="seeArticle?id=${article.id }#comment"><i
								class="glyphicon glyphicon-comment"></i> ${article.commcnt}个不明物体</a>
						</p>
						<% Article a=(Article)pageContext.getAttribute("article"); %>
						<p class="note"><%=Utils.getContent(a.getContent()).substring(0, 100) %>...</p>
					</article>
				</c:forEach>
				
					
				<!-- 滚动翻页 -->
				<nav class="pagination" style="display: none;">
					<ul>
						<li class="prev-page"></li>
						<li class="active"><span>1</span></li>
						<li><a href="?page=3">3</a></li>
						<li class="next-page"><a href="?page=${page}">下一页</a></li>
						<li><span>共 3页</span></li>
					</ul>
				</nav>
			</div>
		</div>
		

	<%@ include file="common/footer.jsp"%>
</body>
</html>