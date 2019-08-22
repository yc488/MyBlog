package com.yc.blog.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.yc.blog.bean.Comment;
import com.yc.blog.bean.CommentExample;
import com.yc.blog.dao.CommentMapper;

@Service
public class CommentBiz {

	@Resource
	private CommentMapper cmm;
	
	public List<Comment> firstPage(int articleId,int page,int size) {
		
		CommentExample example = new CommentExample();		
		example.setOrderByClause("id desc");
		example.createCriteria().andArticleidEqualTo(articleId);		
		PageHelper.startPage(page, size);
		List<Comment> list = cmm.selectByExample(example);
		
		return list;
	}
	
	/**
	 * 查询评论总记录数
	 * @param integer 
	 * @return
	 */
	public long getCommTotal(Integer articleid) {
		CommentExample example = new CommentExample();
		example.createCriteria().andArticleidEqualTo(articleid);
		long total = cmm.countByExample(example);
		return total==0?0:total;
	}

	public void commentArticle(Comment c) {
		cmm.insertSelective(c);		
	}


}
