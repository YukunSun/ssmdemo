package com.syk.mapper;

import java.util.HashMap;
import java.util.List;

import com.syk.model.User;
import com.syk.model.UserQueryByPage;

public interface UserMapper {
	void add(User user);
	User login(String name);
	List<User> sel(HashMap<String, Integer> offsetLimit);
	int countAll();
	int countIfSel(User user);
	User selByName(String name);
	List<User> ifSel(UserQueryByPage userQueryByPage);
}
