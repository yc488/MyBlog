function time() {
		var str;
		var date1=new Date();
		var y=date1.getFullYear();  //获取年
		var m=date1.getMonth()+1;  //获取月
		var d=date1.getDate();  //获取天
		var h=date1.getHours(); //小时
		var mi=date1.getMinutes(); //分钟
		var s=date1.getSeconds(); //秒钟
		if(mi<10){
			mi="0"+mi;
		}
		if(s<10){
			s="0"+s;
		}
		if(h<10){
			h="0"+h;
		}
		$("#time").text(y+"年"+m+"月"+d+"日  "+h+":"+mi+":"+s);
		
	}
	setInterval(time,1000);
//获取注册验证码
	function getRegCode(bnt) {
		$.post("getRegCode",{
			to:$('#address').val()
		},function(data){
			if(data.code==1){
				getSuccessMsg(data.msg);
				setTimeout(function () {
					$.post("clearCode",function(data){
						getFailMsg(data.msg);
					})
				}, 60000);
			}else{
				getFailMsg(data.msg);
			}
		});
		getTime(bnt);
	}

	//用户注册
	function reg() {
		$.post("reg",{
			cnName:$('#regcnName').val(),
			password:$('#regpassword').val(),
			regrepassword:$('#regrepassword').val(),
			address:$('#address').val(),
			recode:$('#regRecode').val()
		},function(data){
			if(data.code==1){
				getSuccessMsg(data.msg);
				setTimeout(function () {
					location.reload();
				}, 500);
			}else{
				getFailMsg(data.msg);
			}
		});
	}
	
	//用户更新密码
	function updatePwd() {
		$.post("updatePwd",{
			newpassword:$('#newpassword').val(),
			newrepassword:$('#newrepassword').val(),
			recode:$('#recode').val()
		},function(data){
			if(data.code==1){
				getSuccessMsg(data.msg);
				setTimeout(function () {
					location.reload();
				}, 500);
			}else{
				getFailMsg(data.msg);
			}
		});
	}

	var time=60;
	//验证码过期倒数时间
	function getTime(bnt) {
		
		if(time==0){
			bnt.removeAttribute("disabled"); 
			bnt.value="免费获取验证码"; 
			time = 60;
		}else{
			bnt.setAttribute("disabled", true); 
			bnt.value="重新发送(" + time + ")";
			time--;
			setTimeout(function() { 
				getTime(bnt) 
			},1000); 
		}
		
	}
	//获得更新密码的验证码
	function getUpdateCode(bnt) {
		$.post("getUpdateCode",function(data){
			if(data.code==1){
				getSuccessMsg(data.msg);
				setTimeout(function () {
					$.post("clearCode",function(data){
						getFailMsg(data.msg);
					})
				}, 60000);
			}else{
				getFailMsg("邮件发送失败");
			}
		});
		getTime(bnt);
	}
	
	
	//用户退出
	function loginOut() {
		$.post("loginOut",function(data){
			if(data.code==1){
				getSuccessMsg(data.msg);
				setTimeout(function () {
					location.reload();
				}, 500);
			}
		})
	}

	//用户登录
	function login() {
		$.post("indexLogin",{
			cnName:$('#cnName').val(),
			password:$('#password').val()
			},function(data){
				if(data.code==0){
					getFailMsg(data.msg);
				}else if(data.code==1){
					getSuccessMsg(data.msg)
					setTimeout(function () {
						location.reload();
					}, 500);					
				}
			})
	}
	
	//登录信息提示框
	function getSuccessMsg(msg) {
		$.message({
	        message:msg,
	        type:'success',
	        duration:'3000'
	    });
	}
	function getInfoMsg(msg) {
		$.message({
	        message:msg,
	        type:'info',
	        duration:'3000'
	    });
	}
	function getFailMsg(msg) {
		$.message({
	        message:msg,
	        type:'error',
	        duration:'3000'
	    });
	}
	
//评论分页
	function firstPage() {
		$.post("article/pageComment",{
			articleId:$('#articleId').text()
		},function(data){
			if(data.code==1){
				showData(data);
				$('#page').text('1');
			}
			
		});
	}
	
	function lastPage() {
		if($('#page').text()==1){
			getInfoMsg("已经是第一页了，别在翻了")
			return ;
		}else{
			var page=$('#page').text();
			$.post("article/pageComment",{
				articleId:$('#articleId').text(),
				commpage:--page
			},function(data){
				if(data.code==1){
					showData(data);
					$('#page').text(page);
				}
				
			});
		}
		
	}
	
	function nextPage() {
		if($('#page').text()==$('#totalPage').text()){
			getInfoMsg("已经是最后一页了，别在翻了")
			return ;
		}else{
			var page=$('#page').text()
			$.post("article/pageComment",{
				articleId:$('#articleId').text(),
				commpage:++page
			},function(data){
				if(data.code==1){
					showData(data);
					$('#page').text(page);
				}
				
			});
		}
		
	}
	
	function finalPage() {
		$.post("article/pageComment",{
			articleId:$('#articleId').text(),
			commpage:$('#totalPage').text()
		},function(data){
			if(data.code==1){
				showData(data);
				$('#page').text($('#totalPage').text());
			}
			
		});
	}
	
	function showData(data) {
		$("html,body").animate({scrollTop:$("#comment").offset().top}, 500);
		$('#commentlist').empty();
		for(var i=0;i<data.data.length;i++){
			var createtime=new Date(data.data[i].createtime).toLocaleString();
			$('#commentlist').append(
					'<li class="comment-content"><span class="comment-f">#'+data.data[i].id+'</span>'
				+'<div class="comment-avatar">'
					+'<img class="avatar" src="images/icon/icon.png" alt="" />'
				+'</div>'
				+'<div class="comment-main">'
					+'<p>来自用户<span class="address">'+data.data[i].commUser.cnName+'</span>的评论'
						+'<span class="time">('+createtime+')</span><br />'+data.data[i].content+'</p>'
				+'</div></li>'		
			);
		}
		
	}
	