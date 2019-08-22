<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<aside class="sidebar">
			<div class="fixed">
				<div class="widget widget-tabs">
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#notice"
							aria-controls="notice" role="tab" data-toggle="tab">网站公告</a></li>
						<li role="presentation"><a href="#centre"
							aria-controls="centre" role="tab" data-toggle="tab">会员中心</a></li>
						<li role="presentation"><a href="#contact"
							aria-controls="contact" role="tab" data-toggle="tab">联系站长</a></li>
					</ul>
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane notice active" id="notice">
							<ul>
								<li><time datetime="2016-01-04">01-04</time> <a href=""
									target="_blank">欢迎访问异清轩博客</a></li>
								<li><time datetime="2016-01-04">01-04</time> <a
									target="_blank" href="">在这里可以看到前端技术，后端程序，网站内容管理系统等文章，还有我的程序人生！</a></li>
								<li><time datetime="2016-01-04">01-04</time> <a
									target="_blank" href="">在这个小工具中最多可以调用五条</a></li>
							</ul>
						</div>
						<div role="tabpanel" class="tab-pane centre" id="centre">
							
							
								<c:if test="${loginUser!=null }">
									<h4>欢迎你,${loginUser.cnName }</h4>
									<p>
										<a data-toggle="modal" data-target="#updataPwd"
											class="btn btn-primary">修改密码</a> 
										<a class="btn btn-default" onclick="loginOut()">退出</a>
									</p>
								</c:if>
								<c:if test="${loginUser==null }">
									<h4>需要登录才能进入会员中心</h4>
									<p>
										<a data-toggle="modal" data-target="#loginModal"
											class="btn btn-primary">立即登录</a> 
										<a data-toggle="modal" data-target="#regModal"
											class="btn btn-default">现在注册</a>
									</p>
								</c:if>
	
						</div>
						<div role="tabpanel" class="tab-pane contact" id="contact">
							<h2>
								Email:<br /> <a href="mailto:yc488@qq.com"
									data-toggle="tooltip" data-placement="bottom"
									title="yc488@qq.com">yc488@qq.com</a>
							</h2>
						</div>
					</div>
				</div>
				<div class="widget widget_search">
					<form class="navbar-form" action="/Search" method="post">
						<div class="input-group">
							<input type="text" name="keyword" class="form-control" size="35"
								placeholder="请输入关键字" maxlength="15" autocomplete="off">
							<span class="input-group-btn">
								<button class="btn btn-default btn-search" name="search"
									type="submit">搜索</button>
							</span>
						</div>
					</form>
				</div>
			</div>
			<div class="widget widget_sentence">
				<h3>每日一句</h3>
				<div class="widget-sentence-content">
					<h4 id="time" ></h4>
					
					<p>
						Do not let what you cannot do interfere with what you can do.<br />
						别让你不能做的事妨碍到你能做的事。（John Wooden）
					</p>
				</div>
			</div>
<!--修改密码模态框-->
	<div class="modal fade user-select" id="updataPwd" tabindex="-1" 
		role="dialog" aria-labelledby="loginModalLabel">
		<div class="modal-dialog" role="document" style="width: 400px;" >
			<div class="modal-content">
				<form>
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="loginModalLabel">登录</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="loginModalUserNmae">新密码</label> <input type="password"
								class="form-control" name="newpassword" id="newpassword"
								placeholder="请输入新密码"
								required="required" >
						</div>
						<div class="form-group">
							<label for="loginModalUserPwd">确认密码</label> <input type="password"
								class="form-control" name="newrepassword" id="newrepassword" placeholder="再次输入密码"
								required="required" >
						</div>
						<div class="form-group">
							<label for="loginModalUserPwd">验证码</label> 
							<input type="text"
								class="form-control" name="recode" id="recode" placeholder="输入验证码"
								required="required" >
							<input type="button" value="免费获取验证码" onclick="getUpdateCode(this)" class="btn btn-primary"/> 
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="cancle">取消</button>
						<button type="button" onclick="updatePwd()" class="btn btn-primary">修改</button>
					</div>
				</form>
			</div>
		</div>
	</div>
<!--登录注册模态框-->
	<div class="modal fade user-select" id="loginModal" tabindex="-1"
		role="dialog" aria-labelledby="loginModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form>
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="loginModalLabel">登录</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="loginModalUserNmae">用户名</label> <input type="text"
								class="form-control" name="cnName" id="cnName"
								placeholder="请输入用户名"
								required="required">
						</div>
						<div class="form-group">
							<label for="loginModalUserPwd">密码</label> <input type="password"
								class="form-control" name="password" id="password" placeholder="请输入密码"
								required="required">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="cancle">取消</button>
						<button type="button" onclick="login()" class="btn btn-primary">登录</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
<!--注册模态框-->
	<div class="modal fade user-select" id="regModal" tabindex="-1"
		role="dialog" aria-labelledby="loginModalLabel">
		<div class="modal-dialog" role="document" style="width: 400px;">
			<div class="modal-content">
				<form action="indexReg" method="post">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">注册</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>用户名</label> <input type="text"
								class="form-control" id="regcnName"
								placeholder="请输入用户名"
								required="required">
						</div>
						<div class="form-group">
							<label >密码</label> <input type="password" id="regpassword" 
								class="form-control" placeholder="请输入密码"
								required="required">
						</div>
						<div class="form-group">
							<label >确认密码</label> <input type="password" id="regrepassword" 
								class="form-control" placeholder="请输入密码"
								required="required">
						</div>
						<div class="form-group">
							<label >邮箱</label> <input type="email" id="address"
								class="form-control" placeholder="请输入邮箱"
								required="required">
						</div>
						<div class="form-group">
							<label for="loginModalUserPwd">验证码</label> 
							<input type="text"
								class="form-control" id="regRecode" placeholder="输入验证码"
								required="required" >
							<input type="button" value="免费获取验证码" onclick="getRegCode(this)" class="btn btn-primary"/> 
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" onclick="reg()" class="btn btn-primary">注册</button>
					</div>
				</form>
			</div>
		</div>
	</div>

<div class="widget widget_hot">
	<h3>热门文章</h3>
	<c:forEach items="${hotArticles }" var="hotArticle">
		<li><a href="seeArticle?id=${hotArticle.id }"><span
				class="thumbnail"><img class="thumb"
					data-original="${hotArticle.titleimgs==null?'images/excerpt.jpg':hotArticle.titleimgs }"
					src="images/articleloading.gif" alt=""></span><span class="text">${hotArticle.title}</span><span
				class="muted"><i class="glyphicon glyphicon-time"> </i>${hotArticle.createtime}
			</span><span class="muted"> <i class="glyphicon glyphicon-eye-open"></i>
					${hotArticle.readcnt }
			</span></a></li>
	</c:forEach>
</div>
</aside>
</section>
<footer class="footer">
	<div class="container">
		<p>
			&copy; 2016 <a href="">ylsat.com</a> &nbsp; <a
				href="http://www.miitbeian.gov.cn/" target="_blank" rel="nofollow">豫ICP备20151109-1</a>
			&nbsp; <a href="sitemap.xml" target="_blank" class="sitemap">网站地图</a>
		</p>
	</div>
	<div id="gotop">
		<a class="gotop"></a>
	</div>
</footer>
<!--微信二维码模态框-->
<div class="modal fade user-select" id="WeChat" tabindex="-1"
	role="dialog" aria-labelledby="WeChatModalLabel">
	<div class="modal-dialog" role="document"
		style="margin-top: 120px; max-width: 280px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="WeChatModalLabel"
					style="cursor: default;">微信扫一扫</h4>
			</div>
			<div class="modal-body" style="text-align: center">
				<img src="images/weixin.jpg" alt="" style="cursor: pointer" />
			</div>
		</div>
	</div>
</div>
<!--该功能正在日以继夜的开发中-->
<div class="modal fade user-select" id="areDeveloping" tabindex="-1"
	role="dialog" aria-labelledby="areDevelopingModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="areDevelopingModalLabel"
					style="cursor: default;">该功能正在日以继夜的开发中…</h4>
			</div>
			<div class="modal-body">
				<img src="images/baoman/baoman_01.gif" alt="深思熟虑" />
				<p
					style="padding: 15px 15px 15px 100px; position: absolute; top: 15px; cursor: default;">很抱歉，程序猿正在日以继夜的开发此功能，本程序将会在以后的版本中持续完善！</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">朕已阅</button>
			</div>
		</div>
	</div>
</div>
<!-- 
右键菜单列表
<div id="rightClickMenu">
	<ul class="list-group rightClickMenuList">
		<li class="list-group-item disabled">欢迎访问异清轩博客</li>
		<li class="list-group-item"><span>IP：</span>172.16.10.129</li>
		<li class="list-group-item"><span>地址：</span>河南省郑州市</li>
		<li class="list-group-item"><span>系统：</span>Windows10</li>
		<li class="list-group-item"><span>浏览器：</span>Chrome47</li>
	</ul>
</div> -->

<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.ias.js"></script>
<script src="js/scripts.js"></script>


