<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
	<table id="tt" class="easyui-datagrid"
		data-options="
		url:'article/queryCategory',
		fitColumns:true,
		singleSelect:true,
		pageSize:5,
		pageNumber:1,
		pageList:[5,10,20],
		rownumbers:true,
		pagination:true,
		fit:true">
		<thead>
			<tr>
				<th data-options="field:'name',width:100,align:'center'">栏目名</th>
				<th data-options="field:'introduce',width:100,align:'center'">简介</th>
				<th data-options="field:'url',width:100,align:'center'">url</th>
			</tr>
		</thead>
	</table>
</body>
</html>