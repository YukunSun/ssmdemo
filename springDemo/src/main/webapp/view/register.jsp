<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>register</title>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<script type="text/javascript" language="javascript">
	function valicationCheck() {
		var userName = $("#userName").val();
		var pwd = $("#pwd").val();
		var confirmPwd = $("#confirm_pwd").val();
		var age = $("#age").val();
		var sex = $('input:radio[name=sex]:checked').val();
		var address = $("#address").val();
		if (userName == "" || pwd == "" || confirmPwd == "" || age == ""
				|| sex ==undefined || address == "") {
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
		if (address.length < 6) {
			$("#test").html("<p>请把地址写详细！</p>");
			return false;
		}
		reg = /^[-+]?\d+$/;
		if (!reg.test(age) || age<0||age>120) {
			$("#test").html("<p>请输入合法的年龄 ！</p>");
			return false;
		}
		return true;
	}
</script>

</head>
<body>
	<h5>注册：</h5>
	${registerTip}
	<div id="test" align="center">
		<p>按要求填写注册信息:</p>
	</div>
	<form id="signupForm"
		action="${pageContext.request.contextPath}/user/add.action"
		method="post" onsubmit="return valicationCheck();">
		<table border="1" align="center">
			<tr>
				<td>姓名:</td>
				<td><input id="userName" type="text" name="userName"
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
				<td>年龄：</td>
				<td><input id="age" type="text" name="age" placeholder="合法数字" /></td>
			</tr>
			<tr>
				<td>性别：</td>
				<td align="center"><input id="sex" type="radio" name="sex"
					value="男" />男 <input id="sex" type="radio" name="sex" value="女" />女
				</td>
			</tr>
			<tr>
				<td>地址：</td>
				<td><input id="address" type="text" name="address"
					placeholder="不少于6个字符" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交">
					<input type="reset" value="重置"></td>
			</tr>
		</table>
	</form>
</body>
</html>