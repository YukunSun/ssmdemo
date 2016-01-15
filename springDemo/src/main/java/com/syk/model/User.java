package com.syk.model;

import java.util.Date;

public class User {
	private int sid;
	private String name;
	private String password;
	private int age;
	private String sex;
	private String address;
	private Date come_time;
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getCome_time() {
		return come_time;
	}
	public void setCome_time(Date come_time) {
		this.come_time = come_time;
	}
	@Override
	public String toString() {
		return "User [sid=" + sid + ", name=" + name + ", password=" + password + ", age=" + age + ", sex=" + sex
				+ ", address=" + address + ", come_time=" + come_time + "]";
	}
	
}
