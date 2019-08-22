package com.yc.blog.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yc.blog.bean.Category;
import com.yc.blog.dao.CategoryMapper;

@Service
public class CategoryBiz {

	@Resource
	private CategoryMapper cm;
	
	public List<Category> findAll(){
		List<Category> list = cm.selectByExample(null);
		return list;
	}
	
	public Page<Category> findAll(int page, int rows){
		Page<Category> p = PageHelper.startPage(page, rows);
		cm.selectByExample(null);
		return p;
	}
}
