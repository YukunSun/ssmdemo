<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>keyreset</title>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<script type="text/javascript" language="javascript">
	function valicationCheck() {
		var original = $("#original").val();
		var pwd = $("#pwd").val();
		var confirmPwd = $("#confirm_pwd").val();
		if (original == "" || pwd == "" || confirmPwd == "") {
			alert("请把信息填写完整!");
			return false;
		}
		if (pwd.length < 6) {
			$("#test").html("<p>请输入不少于6位密码！</p>");
			return false;
		}
		if (pwd != confirmPwd) {
			$("#test").html("<p>需要与第一次输入的密码相同！</p>");
			return false;
		}
		return true;
	}
</script>

</head>
<body>
	<h5>密码修改：</h5>
	${registerTip}
	<div id="test" align="center">
		<p>按要求重置密码:</p>
	</div>
	<form id="signupForm"
		action="${pageContext.request.contextPath}/user/keyreset.action"
		method="post" onsubmit="return valicationCheck();">
		<table border="1" align="center">
			<tr>
				<td>原密码:</td>
				<td><input id="original" type="text" name="original"
					placeholder="请输入姓名" /></td>
			</tr>
			<tr>
				<td>密码：</td>
				<td><input id="pwd" type="password" name="pwd"
					placeholder="不少于6位" /></td>
			</tr>
			<tr>
				<td>确认密码：</td>
				<td><input id="confirm_pwd" type="password" name="pwd"
					placeholder="与上面密码相同" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交">
					<input type="reset" value="重置"></td>
			</tr>
		</table>
	</form>
</body>
</html>