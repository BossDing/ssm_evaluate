<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Colleage" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Colleage colleage = (Colleage)request.getAttribute("colleage");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改学院信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">学院信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="colleageEditForm" id="colleageEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="colleage_colleageNumber_edit" class="col-md-3 text-right">学院编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="colleage_colleageNumber_edit" name="colleage.colleageNumber" class="form-control" placeholder="请输入学院编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="colleage_colleageName_edit" class="col-md-3 text-right">学院名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="colleage_colleageName_edit" name="colleage.colleageName" class="form-control" placeholder="请输入学院名称">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxColleageModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#colleageEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改学院信息界面并初始化数据*/
function colleageEdit(colleageNumber) {
	$.ajax({
		url :  basePath + "Colleage/" + colleageNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (colleage, response, status) {
			if (colleage) {
				$("#colleage_colleageNumber_edit").val(colleage.colleageNumber);
				$("#colleage_colleageName_edit").val(colleage.colleageName);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交学院信息信息表单给服务器端修改*/
function ajaxColleageModify() {
	$.ajax({
		url :  basePath + "Colleage/" + $("#colleage_colleageNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#colleageEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#colleageQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    colleageEdit("<%=request.getParameter("colleageNumber")%>");
 })
 </script> 
</body>
</html>

