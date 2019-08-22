package com.yc.blog.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yc.blog.bean.Article;
import com.yc.blog.bean.ArticleExample;
import com.yc.blog.bean.ArticleExample.Criteria;
import com.yc.blog.bean.Comment;
import com.yc.blog.dao.ArticleMapper;

@Service
public class ArticleBiz {

	@Resource
	private ArticleMapper am;
	
	@Resource
	private CommentBiz cmmb;
	
	/**
	 * 查询首页的今日推荐
	 * @return
	 */
	public Article findTodayRecommend() {
		ArticleExample example=new ArticleExample();
		//设置排序
		example.setOrderByClause("id desc");
		PageHelper.startPage(1, 1);
		
		List<Article> list = am.selectByExampleWithBLOBs(example);
		return list.isEmpty()?null:list.get(0);
	}
	
	/**
	 * 分页查询博客
	 * @param categoryId
	 * @param page
	 * @param size
	 * @param title
	 * @param author
	 * @return
	 */
	public Page<Article> findArticleByPage(int categoryId,int page,int size,String title,String author) {
		ArticleExample example=new ArticleExample();
		Criteria criteria = example.createCriteria();
		if(categoryId>0) {
			criteria.andCategoryidEqualTo(categoryId);
		}
		if(title!=null && !title.trim().isEmpty()) {
			criteria.andTitleLike("%"+title+"%");
		}
		if(author!=null && !author.trim().isEmpty()) {
			criteria.andAuthorLike("%"+author+"%");
		}
		//设置排序
		example.setOrderByClause("id desc");
		Page<Article> p = PageHelper.startPage(page, size);
		am.selectByExampleWithBLOBs(example);
		return p;
	}

	/**
	 * 按id查询博客以及评论
	 * @param articleId
	 * @param page
	 * @param size
	 * @return
	 */
	public Article findArticleById(int articleId,int page,int size) {
		Article article = am.selectByPrimaryKey(articleId);
		
		List<Comment> list = cmmb.firstPage(articleId, page, size);
		
		article.setComment(list);
		return article;
	}
	
	

	/**
	 * 后台添加博客
	 * @param article
	 */
	public void save(Article article) {
		if(article.getId()==null) {
			am.insertSelective(article);
		}else {
			am.updateByPrimaryKeySelective(article);
		}
		
		
	}

	/**
	 * 按标签模糊查询前八条相关推荐
	 * @param split[0]
	 * @param i
	 * @param j
	 * @return
	 */
	public Page<Article> findArticleByLabel(String[] split, int i, int j) {
		
		ArticleExample example=new ArticleExample();
		example.setOrderByClause("id desc");
		
		if(split.length==1) {
			example.createCriteria().andLabelLike("%"+split[0]+"%");
		}
		if(split.length>1){
			example.createCriteria().andLabelLike("%"+split[0]+"%");
			for (int k = 1; k < split.length; k++) {
				Criteria criteria = example.createCriteria();
				criteria.andLabelLike("%"+split[k]+"%");
				example.or(criteria);
			}
		}
		
		Page<Article> p=PageHelper.startPage(i, j);
		am.selectByExampleWithBLOBs(example);
		return p;
	}

	/**
	 * 查看博客增加阅读量
	 * @param article 
	 */
	public void updataReadcnt(Article article) {
		am.updateByPrimaryKeySelective(article);
	}

	/**
	 * 热门博客
	 * @param page
	 * @param size
	 * @return
	 */
	public Page<Article> findHotArticleByPage(Integer page, Integer size) {
		ArticleExample example=new ArticleExample();
		example.setOrderByClause("readCnt desc");
		Page<Article> p = PageHelper.startPage(page, size);
		am.selectByExampleWithBLOBs(example);
		return p;
	}

	public void addCommCnt(Article a) {
		am.updateByPrimaryKeySelective(a);
	}

	
	
	
}
