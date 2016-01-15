<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>login</title>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<script type="text/javascript">
	function valicationCheck() {
		if ($("#checkUserName").val() == "" || $("#checkPwd").val() == "") {
			alert('用户名和密码不能为空！');
			return false;
		}
		return true;
	}
	$(function() { //生成验证码         
		$('#kaptchaImage')
				.click(
						function() {
							$(this).hide().attr(
									'src',
									'/user/captcha-image?'
											+ Math.floor(Math.random() * 100))
									.fadeIn();
						});
	});

	window.onbeforeunload = function() {
		//关闭窗口时自动退出  
		if (event.clientX > 360 && event.clientY < 0 || event.altKey) {
			alert(parent.document.location);
		}
	};

	function changeCode() { //刷新
		$('#kaptchaImage').hide().attr('src',
				'/user/captcha-image?' + Math.floor(Math.random() * 100))
				.fadeIn();
		event.cancelBubble = true;
	}
</script>
</head>
<body>
	<h4>登录：</h4>
	<form id="myForm"
		action="${pageContext.request.contextPath}/user/login.action"
		method="post" onSubmit="return valicationCheck();">
		<table border="1" align="center">
			<tr>
				<td>姓名：</td>
				<td><input type="text" name="userName" id="checkUserName"
					placeholder="请输入姓名" msg="<font color=red>*</font>账号不能为空" /></td>
			</tr>
			<tr>
				<td>密码：</td>
				<td><input type="password" name="pwd" id="checkPwd"
					placeholder="请输入密码" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交">
					<input type="button" value="注册"
					onclick="window.location.href='${pageContext.request.contextPath}/view/register.jsp'" /></td>
			</tr>
		</table>
	</form>
	<div class="form-group">
		<label>验证码 </label> <input name="j_code" type="text" id="kaptcha"
			maxlength="4" class="form-control" /> <br /> <img
			src="/user/captcha-image" id="kaptchaImage"
			style="margin-bottom: -3px" /> <a href="#" onclick="changeCode()">看不清?换一张</a>
	</div>
</body>


</html>