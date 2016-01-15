package com.syk.controller;

import java.awt.image.BufferedImage;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.syk.model.User;
import com.syk.service.UserService;
import com.syk.util.MD5Utils;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private Producer captchaProducer = null;

	@RequestMapping("/add")
	public ModelAndView register(HttpServletRequest request) {
		User user = new User();
		String userName = request.getParameter("userName");
		user.setName(userName);
		String pwd = request.getParameter("pwd");

		MD5Utils md5 = new MD5Utils(pwd);
		user.setPassword(md5.getResult());

		Integer age = Integer.parseInt(request.getParameter("age"));
		user.setAge(age);
		user.setSex(request.getParameter("sex"));
		user.setAddress(request.getParameter("address"));

		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = format.format(new Date());
		try {
			date = format.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		user.setCome_time(date);

		ModelAndView mav = new ModelAndView("welcome");

		if (userService.selByName(userName) != null) {
			mav.addObject("result", "用户已存在，请直接登录！");
		} else {
			userService.add(user);
			mav.addObject("result", "注册成功！");
		}

		return mav;
	}

	@RequestMapping("/login")
	public ModelAndView login(String userName, String pwd, HttpServletRequest request) {
		MD5Utils md5 = new MD5Utils(pwd);
		String encoded = md5.getResult();
		ModelAndView mav = new ModelAndView("islogin");
		if (userService.login(userName) != null) {
			String tmpwd = userService.login(userName).getPassword();
			if (tmpwd.equals(encoded)) {
				mav.addObject("isFail", "登录成功！");
				HttpSession session = request.getSession();
				Hashtable<String, String> userInfo = new Hashtable<String, String>();
				userInfo.put("userName", userName);
				userInfo.put("password", encoded);
				session.setAttribute("userInfo", userInfo);
			} else {
				mav.setViewName("welcome");
				mav.addObject("result", "密码错误，请重新输入！");
			}
		} else {
			mav.setViewName("register");
			mav.addObject("registerTip", "用户不存在，请先注册！");
		}

		return mav;
	}

	@RequestMapping("/ifselect")
	public ModelAndView ifSelect(HttpServletRequest request, Date cometime) {
		int page = ((request.getParameter("page")) == "") ? 1 : Integer.parseInt(request.getParameter("page"));
		String userName = request.getParameter("userName");
		Integer age;
		if ("".equals(request.getParameter("age"))) {
			age = -1;
		} else {
			age = Integer.parseInt(request.getParameter("age"));
		}
		String sex = request.getParameter("sex");
		String address = request.getParameter("address");

		User user = new User();
		user.setName(userName);
		user.setAge(age);
		user.setSex(sex);
		user.setAddress(address);
		user.setCome_time(cometime);
		HashMap<String, Integer> offsetLimit = new HashMap<String, Integer>();
		int limit = 3;
		int offset = (page - 1) * limit;// (page-1)*limit
		offsetLimit.put("offset", offset);
		offsetLimit.put("limit", limit);
		List<User> allUsers = userService.ifSel(user, offsetLimit);

		int total = userService.countIfSel(user);// all
		int totalPage = total / limit;
		if (total % limit != 0) {
			totalPage += 1;
		}
		Vector<Integer> pageArr = new Vector<Integer>();
		int start = 1;
		if (page >= 10) {
			start = page / 10 * 10;
		}
		int num = start;
		while (!(num > totalPage || num > start + 10)) {
			pageArr.add(new Integer(num));
			++num;
		}

		ModelAndView mav = new ModelAndView("islogin");
		mav.addObject("allUsers", allUsers);

		mav.addObject("page", page);
		mav.addObject("totalPage", totalPage);
		mav.addObject("pageArr", pageArr);
		mav.addObject("user", user);
		return mav;
	}

	@RequestMapping("logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "login";
	}

	// @RequestMapping("keyreset")
	// public ModelAndView keyReset(HttpServletRequest request) {
	// String original = request.getParameter("original");
	// String pwd = request.getParameter("pwd");
	//
	// // 修改失败提示
	// ModelAndView mav = new ModelAndView();
	// mav.setViewName("");
	// return mav;
	// }

	@RequestMapping(value = "captcha-image")
	public ModelAndView getKaptchaImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String code = (String) session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
		System.out.println("验证码: " + code);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("image/jpeg");

		String capText = captchaProducer.createText();
		session.setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);

		BufferedImage bi = captchaProducer.createImage(capText);
		ServletOutputStream out = response.getOutputStream();
		ImageIO.write(bi, "jpg", out);
		try {
			out.flush();
		} finally {
			out.close();
		}
		return null;
	}

	
	
	
	// 注册时间属性编辑器
	@InitBinder
	public void initBinder(ServletRequestDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		CustomDateEditor cde = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(Date.class, cde);
	}
}
