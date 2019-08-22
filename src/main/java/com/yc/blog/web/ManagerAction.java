package com.yc.blog.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ManagerAction {

	@RequestMapping("manage")
	public String manage() {
		return "manage";
	}
	
	@RequestMapping("articleMgr")
	public String articleMgr() {
		return "articleMgr";
	}
	@RequestMapping("articleType")
	public String articleType() {
		return "articleType";
	}
}
