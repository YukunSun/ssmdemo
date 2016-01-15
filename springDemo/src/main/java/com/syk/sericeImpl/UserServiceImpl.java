package com.syk.sericeImpl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.syk.mapper.UserMapper;
import com.syk.model.User;
import com.syk.model.UserQueryByPage;
import com.syk.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper mapper;

	public void add(User user) {
		mapper.add(user);
	}

	public User login(String userName) {
		User user = mapper.login(userName);
		return user;
	}

	public List<User> sel(HashMap<String, Integer> offsetLimit) {
		List<User> lists = mapper.sel(offsetLimit);
		return lists;
	}

	public int countAll() {
		int count = mapper.countAll();
		return count;
	}

	public User selByName(String userName) {
		User user = mapper.selByName(userName);
		return user;
	}

	public List<User> ifSel(User user, HashMap<String, Integer> offsetLimit) {
		UserQueryByPage userQueryByPage=new UserQueryByPage();
		userQueryByPage.setName("%"+user.getName()+"%");
		userQueryByPage.setAge(user.getAge());
		userQueryByPage.setSex(user.getSex());
		userQueryByPage.setCome_time(user.getCome_time());
		userQueryByPage.setAddress("%"+user.getAddress()+"%");
		
		userQueryByPage.setLimit(offsetLimit.get("limit"));
		userQueryByPage.setOffset(offsetLimit.get("offset"));
		
		List<User> lists = mapper.ifSel(userQueryByPage);
		return lists;
	}

	public int countIfSel(User user) {
		User user1=new User();
		user1.setName("%"+user.getName()+"%");
		user1.setAge(user.getAge());
		user1.setSex(user.getSex());
		user1.setCome_time(user.getCome_time());
		user1.setAddress("%"+user.getAddress()+"%");
		
		int count =mapper.countIfSel(user);
		return count;
	}

}
