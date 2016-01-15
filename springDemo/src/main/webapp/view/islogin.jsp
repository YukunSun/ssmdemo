<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>logining</title>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<script language="javascript" type="text/javascript" src="../js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" language="javascript">
	function valicationCheck() {
		var age = $("#age").val();
		reg = /^[-+]?\d+$/;
		if (!reg.test(age) || age<0||age>120) {
			if (age == ""){
				$("#conditionalQuery").attr("action","${pageContext.request.contextPath}/user/ifselect.action		");
				$("#conditionalQuery").submit();
				}
			$("#test").html("<p>年龄需要为合法数字或不填写 ！</p>");
			return false;
		}
		$("#conditionalQuery").attr("action","${pageContext.request.contextPath}/user/ifselect.action		");
		$("#conditionalQuery").submit();
		return true;
	}

	function selectByPage(page){
		$("#cp").val(page);
		$("#conditionalQuery").attr("action","${pageContext.request.contextPath}/user/ifselect.action");
		$("#conditionalQuery").submit();
	}
	
</script>
</head>
<body>
	<h5>登录情况：</h5>
	${isFail}
	<a href="${pageContext.request.contextPath}/user/logout.action">退出登录</a>
	<a href="${pageContext.request.contextPath}/user/keyreset.action">修改密码</a>
	<div id="test" align="center">
		<p>输入下列条件进行模糊查询：</p>
	</div>
	<form id="conditionalQuery"  method="post" >
		<input type="hidden" id="cp" name="page">
		<table border="1" align="center">
			<tr>
				<td>姓名:</td>
				<td><input id="userName" type="text" name="userName"
					placeholder="输入姓名（模糊查询）" value="${user.name}" }/></td>
			</tr>
			<tr>
				<td>年龄：</td>
				<td><input id="age" type="text" name="age" placeholder="合法数字" <c:if test="${user.age==-1}">value=""</c:if> /> </td>
				
				
			</tr>
			<tr>
				<td>性别：</td>
				<td align="center">
				<select id="sex" name="sex">
					<option value="">不限</option>
					<option value="男" <c:if test="${user.sex=='男'}">selected="selected"</c:if>>男</option>
					<option value="女" <c:if test="${user.sex=='女'}">selected="selected"</c:if>>女</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>住址：</td>
				<td><input id="address" type="text" name="address"
					placeholder="输入住址（模糊查询）" value="${user.address}"/></td>
			</tr>
			<tr>
				<td>注册时间：</td>
				<td><input type="text" name="cometime" id="cometime" placeholder="注册时间	"
					onclick="WdatePicker()" value="<fmt:formatDate value="${user.come_time}" pattern="yyyy-MM-dd"/>"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" onclick="valicationCheck()" value="提交">
					<input type="reset" value="重置"></td>
			</tr>
		</table>
	</form>
	
	<h5>在这里分页显示数据:</h5>
	<table border="1" align="center">
		<tr>
			<td>ID</td>
			<td>姓名</td>
			<td>年龄</td>
			<td>性别</td>
			<td>地址</td>
			<td>注册时间</td>
		</tr>
		<c:forEach items="${allUsers}" var="item">
			<tr>
				<td>${item.sid }</td>
				<td>${item.name}</td>
				<td>${item.age}</td>
				<td>${item.sex }</td>
				<td>${item.address}</td>
				<td><fmt:formatDate value="${item.come_time}" pattern="yyyy-MM-dd"/></td>
			</tr>
		</c:forEach>
	</table>
	
	<div id="pageControl" align="center">
		<!-- 上一页 按钮 -->
		<c:choose>
			<c:when test="${page != 1}">
				<a href="javascript:void(0)" onclick="selectByPage('${page-1}')"><input type="button"
					name="lastPage" value="上一页" /></a>
			</c:when>
			<c:otherwise>
				<input type="button" disabled="true" name="lastPage" value="上一页" />
				<!-- 为了要那个灰掉的button -->
			</c:otherwise>
		</c:choose>
		<!-- 页数列表 -->
		<c:forEach items="${pageArr}" var="item">
			<c:choose>
				<c:when test="${item == page}">
					<a href="javascript:void(0)" onclick="selectByPage('${item}')" class="currentPage">${item}</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:void(0)" onclick="selectByPage('${item}')">${item}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<!-- 下一页 按钮 -->
		<c:choose>
			<c:when test="${page != totalPage}">
				<a href="javascript:void(0)" onclick="selectByPage('${page+1}')"> <input type="button"
					name="nextPage" value="下一页" />
				</a>
			</c:when>
			<c:otherwise>
				<input type="button" disabled=true name="nextPage" value="下一页" />
				<!-- 为了要那个灰掉的button -->
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>