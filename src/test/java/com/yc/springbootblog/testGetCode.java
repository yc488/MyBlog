package com.yc.springbootblog;

import java.util.List;

import org.junit.Test;

import com.github.pagehelper.Page;
import com.yc.blog.bean.Article;
import com.yc.blog.bean.Category;
import com.yc.blog.biz.ArticleBiz;
import com.yc.blog.biz.CategoryBiz;
import com.yc.blog.util.Utils;

public class testGetCode {
	private static ArticleBiz ab=new ArticleBiz();
	
	@Test
	public void test(String[] args) {
		Page<Article> list = ab.findHotArticleByPage(0,5);
		System.out.println(list);
	}
}
