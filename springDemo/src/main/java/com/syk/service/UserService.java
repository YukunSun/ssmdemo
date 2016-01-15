package com.syk.service;

import java.util.HashMap;
import java.util.List;

import com.syk.model.User;

public interface UserService {
	//注册
	void add(User user);
	//登录
	User login(String userName);
	//查询
	List<User> sel(HashMap<String,Integer> offsetLimit);
	int countAll();
	int countIfSel(User user);
	User selByName(String userName);
	//条件查询
	List<User> ifSel(User user, HashMap<String, Integer> offsetLimit);
}
