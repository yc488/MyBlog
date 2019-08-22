<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="zh-CN">
<%@ include file="common/links.jsp"%>

<body class="user-select single">
	<%@ include file="common/header.jsp"%>
	<section class="container">
		<div class="content-wrap">
			<div class="content">
				<header class="article-header">
					<h1 class="article-title">
						<a href="seeArticle?id=${article.id }">${article.title }</a>
						<font style="display: none;" id="articleId">${article.id }</font>
					</h1>
					<div class="article-meta">
						<span class="item article-meta-time"> <time class="time"
								data-toggle="tooltip" data-placement="bottom">
								<i class="glyphicon glyphicon-time"></i> ${article.createtime.toLocaleString() }
							</time>
						</span> <span class="item article-meta-source" data-toggle="tooltip"
							data-placement="bottom" ><i
							class="glyphicon glyphicon-globe"></i> 第一PHP社区</span> <span
							class="item article-meta-category" data-toggle="tooltip"
							data-placement="bottom" ><i
							class="glyphicon glyphicon-list"></i> <a
							href="category?categoryId=${article.category.id }" title="">${article.category.name }</a></span>
						<span class="item article-meta-views" data-toggle="tooltip"
							data-placement="bottom" ><i
							class="glyphicon glyphicon-eye-open"></i> 共${article.readcnt }人围观</span>
						<span class="item article-meta-comment" data-toggle="tooltip" data-placement="bottom">
							<i class="glyphicon glyphicon-comment"></i> <front id="commcnt">${article.commcnt }</front>个不明物体</span>
					</div>
				</header>
				<article class="article-content">
					<p>
						<img
							data-original="${article.titleimgs==null?'images/excerpt.jpg':article.titleimgs }"
							src="images/banner/banner_03.jpg" alt="" />
					</p>
					${article.content }
					<p class="article-copyright hidden-xs">
						未经允许不得转载：<a href="index">异清轩博客</a> » <a
							href="seeArticle?id=${article.id }">${article.title }</a>
					</p>
				</article>
				<div class="article-tags">
					标签：<a href="" rel="tag">${article.label }</a>
				</div>
				<div class="relates">
					<div class="title">
						<h3>相关推荐</h3>
					</div>
					<ul>
						<c:forEach items="${recommends }" var="recommend">
							<li><a href="seeArticle?id=${recommend.id }">${recommend.title }</a></li>
						</c:forEach>
					</ul>
				</div>
				<div class="title" id="comment">
					<h3>
						评论 <small>抢沙发</small>
					</h3>
				</div>
				<div id="respond">
				<c:if test="${loginUser==null }">
			        <div class="comment-signarea">
			          <h3 class="text-muted">评论前必须登录！</h3>
			          <p> <a data-toggle="modal" data-target="#loginModal"
									class="btn btn-primary">立即登录</a> &nbsp; <a href="javascript:;" class="btn btn-default register" rel="nofollow">注册</a> </p>
			          <h3 class="text-muted">当前文章禁止评论</h3>
			        </div>

				</c:if>
				<c:if test="${loginUser!=null }">
					
					<form action="" method="post" id="comment-form">
						<div class="comment">
							<div class="comment-title">
								<img class="avatar" src="images/icon/icon.png" alt="" />
							</div>
							<div class="comment-box">
								<textarea placeholder="您的评论可以一针见血" name="comment"
									id="comment-textarea" cols="100%" rows="3" tabindex="1"></textarea>
								<div class="comment-ctrl">
									<span class="emotion"><img src="images/face/5.png"
										width="20" height="20" alt="" />表情</span>
									<div class="comment-prompt">
										<i class="fa fa-spin fa-circle-o-notch"></i> <span
											class="comment-prompt-text"></span>
									</div>
									<input type="hidden" value="1" class="articleid" />
									<button type="button" name="comment-submit" id="comment-submit"
										tabindex="5" >评论</button>
								</div>
							</div>
						</div>
					</form>				
					
				</c:if>
				</div>
				<div id="postcomments">
					<ol class="commentlist" id="commentlist">
						<c:forEach items="${article.comment }" var="comment">		
							<li class="comment-content"><span class="comment-f">#${comment.id
									}</span>
								<div class="comment-avatar">
									<img class="avatar" src="images/icon/icon.png" alt="" />
								</div>
								<div class="comment-main">
									<p>
										来自用户<span class="address">${comment.commUser.cnName }</span>的评论
										<span class="time">(${comment.createtime.toLocaleString() })</span><br />${comment.content }</p>
								</div></li>	
						</c:forEach>
					</ol>
						<div class="quotes">
							<a onclick="firstPage()" id="firstPage">首页</a>
							<a onclick="lastPage()">上一页</a>
							<span id="page" class="disabled">1</span> / <span id="totalPage" class="disabled">${commTotalPage}</span>
							<a onclick="nextPage()">下一页</a>
							<a onclick="finalPage()">尾页</a>
						</div>
					</div>	
				
			</div>
		</div>
		
	<%@ include file="common/footer.jsp"%>

	<script src="js/jquery.qqFace.js"></script>
	<script type="text/javascript">
		$(function() {
			$('.emotion').qqFace({
				id : 'facebox',
				assign : 'comment-textarea',
				path : '/images/arclist/' //表情存放的路径
			});
		});
	</script>
</body>
</html>