<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-2.1.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/js/easyui/themes/icon.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	$(function() {
		$.get("article/getCategory",function(data){
			for(var i=0;i<data.data.length;i++){
				$("#catagoryid").append("<option value='" + data.data[i].id + "'>" + data.data[i].name + "</option>"); 
			}
			$("#catagoryid").combobox({});
		});
	})
	
	function doSearch(){
		$('#tt').datagrid('load',{
			title:$('#title').val(),
			author:$('#author').val(),
			categoryid:$('#catagoryid').val()
		});
	}
	
	
	
	function openEdit() {
		$('#ff').form('clear');
		myeditor.setData('');
		getCategorys();
		$("#image").attr("src","images/uploadimg.jpg");
		$("#dlg").dialog('open');
		
	}
	function closeEdit() {	
		$("#dlg").dialog('close');
	}
	
	function save() {
		$('#ff').form('submit', {
		    url:'article/save',
		    onSubmit: function(param){
				//扩展参数
				param.agreecnt="0";
				param.commcnt="0";
				param.readcnt="0";
				param.categoryid=$('.dialogCatagoryid').val();
		    },
		    success:function(data){  //不是json对象，而是json字符串
		    	data=JSON.parse(data);
				if(data.code==1){
					$.messager.show({
						title:'系统提示',
						msg:data.msg,
						timeout:5000,
						showType:'slide'
					});
					$('#tt').datagrid('reload');
					closeEdit();
				}else{
					for(var i=0;i<data.data.length;i++){
						if(data.data[i].field=="title"){
							$("#titlemsg").css("color","red");
							$("#titlemsg").text(data.data[i].defaultMessage);
						}
						if(data.data[i].field=="author"){
							$("#authormsg").css("color","red");
							$("#authormsg").text(data.data[i].defaultMessage);
						}
						if(data.data[i].field=="categoryid"){
							$("#categoryidmsg").css("color","red");
							$("#categoryidmsg").text(data.data[i].defaultMessage);
						}
					}
				}
		    }
		});
	}
	
	function fmtbnt(value,row,index) {
		//var json = JSON.stringify(row);
		return '<input type="button" value="修改" onclick=\'update('+index+')\' />';
	}
	
	function getCategorys() {
		$(".dialogCatagoryid").empty();
		$.get("article/getCategory",function(data){
			for(var i=0;i<data.data.length;i++){
				$(".dialogCatagoryid").append("<option value='" + data.data[i].id + "'>" + data.data[i].name + "</option>"); 
			}
			$(".dialogCatagoryid").combobox({});
		});
	}
	
	function update(index) {
		var row=$('#tt').datagrid('getRows')[index];
		
		if(row.titleimgs){
			$("#image").attr("src",row.titleimgs);
		}else{
			$("#image").attr("src","images/uploadimg.jpg");			
		}
		
		$('#ff').form('load',row);
		myeditor.setData(row.content);
		
		getCategorys();
		$(".dialogCatagoryid").combobox({
			onLoadSuccess:function(){
			$('.dialogCatagoryid').combobox('select',row.categoryid);
			}
		});
		$("#dlg").dialog('open');
		
	}
	
	function upload() {
		$.ajax({
	        url: "article/upload",
	        type: 'POST',
	        cache: false,
	        data: new FormData($('#ff')[0]),
	        processData: false,
	        contentType: false,
	        dataType:"json",
	        success : function(data) {
	            if (data.code == 1) {
	                $("#image").attr("src", data.data);
	                $("#titleimgs").val(data.data);
	                $.messager.show({
						title:'系统提示',
						msg:data.msg,
						timeout:5000,
						showType:'slide'
					});
	            }else if(data.code==-1){
	            	$.messager.show({
						title:'系统提示',
						msg:data.msg,
						timeout:5000,
						showType:'slide'
					});
	            } else {
	            	$.messager.alert('系统提示',data.msg,'error');
	            }
	        }
	    });
	}
	
	function fmtimgs(value,row,index) {
		if(value){
			return "<img src='"+value+"' width='150px' height='100px'>";
		}else{
			return "<img src='images/noimage.jpg' width='150px' height='100px'>";
		}
		
	}
</script>
</head>
<body>

	<div id="tb" style="padding:3px">
		<div>
			<span>标题</span>
			<input id="title" class="easyui-textbox" style="width:100px" placeholder="输入博客标题">
			<span>作者:</span>
			<input id="author" class="easyui-textbox" style="width:100px" placeholder="输入作者" >
			<span>栏目:</span>
			<select id="catagoryid" style="width:150px">
				<option value="" >请选择栏目</option>
			</select>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">搜索</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openEdit()">添加</a>
		</div>
	</div>
	<table id="tt" class="easyui-datagrid"
		data-options="
		url:'article/queryAll',
		fitColumns:true,
		singleSelect:true,
		pageSize:5,
		pageNumber:1,
		pageList:[5,10,20],
		rownumbers:false,
		pagination:true,
		fit:true,
		toolbar:'#tb'">
		<thead>
			<tr>
				<th data-options="field:'title',width:100,align:'center'">标题</th>
				<th data-options="field:'author',width:50,align:'center'">作者</th>
				<th data-options="field:'categoryname',width:50,align:'center',formatter:function(val,row){
					if(row.category==null){
						return '空';
					}else{
						return row.category.name;
					}
				}">栏目</th>
				<th data-options="field:'createtime',width:100,align:'center',formatter:function(value,row,index){  
			            var createtime = new Date(value);  
			            return createtime.toLocaleString();  
			    }">发表时间</th>
			    <th data-options="field:'titleimgs',width:100,align:'center',formatter:fmtimgs">图片</th>
				<th data-options="field:'commcnt',width:50,align:'center'">评论量</th>
				<th data-options="field:'agreecnt',width:50,align:'center'">获赞量</th>
				<th data-options="field:'readcnt',width:50,align:'center'">阅读量</th>
				<th data-options="field:'id',width:50,align:'center',formatter:fmtbnt">操作</th>
			</tr>
		</thead>
	</table>
	
	<div id="dlg" class="easyui-dialog" title="添加博客" style="width:60%;height:100%;padding:10px"
			data-options="
				iconCls: 'icon-save',
				buttons: [{
					text:'Ok',
					iconCls:'icon-ok',
					handler:function(){
						save();
					}
				},{
					text:'Cancel',
					handler:function(){
						closeEdit();
					}
				}],
				closed:true,
				modal:true
			">
		<form id="ff" method="post">
			<input type="hidden" id="id" name="id">
			<input class="easyui-textbox" name="title" id="title" style="width:300px;" data-options="
				label:'标题',
			"/><font id="titlemsg"></font><br>
			<input class="easyui-textbox" name="author" id="author" style="width:300px" data-options="
				label:'作者',
			"/><font id="authormsg"></font><br>
			
			<img alt="点击上传图片" src="images/uploadimg.jpg" height="100px" onclick="file.click()" id="image"
				style="display: inline-block;border: 1px solid #666;float: right;margin: -50px 100px;">
			<input type="hidden" name="titleimgs" id="titleimgs">
			<input type="file" name="file" style="display: none;" id="file" onchange="upload()">
			<br/>
			<!-- 栏目选择 -->
			<label class="textbox-label textbox-label-before" for="_easyui_textbox_input4" style="text-align: left; height: 30px; line-height: 30px;">栏目</label>
			<select class="dialogCatagoryid" style="width:200px">
				<option value="0" >请选择栏目</option>
			</select><font id="categoryidmsg"></font>
			<br/>
			
			
			<label class="textbox-label textbox-label-before" for="_easyui_textbox_input4" style="text-align: left; height: 30px; line-height: 30px;">内容</label>
			<textarea name="content" id="content"></textarea>
			<script type="text/javascript">
				var myeditor=CKEDITOR.replace('content', {
				      height: 300,
				      width: 720,
				    });
			</script>
		</form>
	</div>
</body>
</html>