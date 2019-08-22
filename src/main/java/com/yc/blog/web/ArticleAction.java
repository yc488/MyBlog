package com.yc.blog.web;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.Page;
import com.yc.blog.bean.Article;
import com.yc.blog.bean.Category;
import com.yc.blog.bean.Comment;
import com.yc.blog.bean.User;
import com.yc.blog.biz.ArticleBiz;
import com.yc.blog.biz.CategoryBiz;
import com.yc.blog.biz.CommentBiz;
import com.yc.blog.vo.EasyUIPage;
import com.yc.blog.vo.Result;

@RestController
@RequestMapping("article")
public class ArticleAction {

	@Resource
	private CategoryBiz cb;
	
	@Resource
	private ArticleBiz ab;
	
	@Resource
	private CommentBiz cmmb;
	
	@RequestMapping("queryAll")
	public EasyUIPage queryAll(Integer page,Integer rows,String title,String author,@RequestParam(name="categoryid",defaultValue="0")int categoryid) {
		Page<Article> p = ab.findArticleByPage(categoryid,page,rows,title,author);
		return new EasyUIPage(p.getTotal(), p.getResult());
	} 
	
	@RequestMapping("getCategory")
	public Result getCategory() {
		List<Category> data = cb.findAll();
		return new Result(1, "栏目", data);
	} 
	
	@RequestMapping("queryCategory")
	public EasyUIPage queryCategory(Integer page,Integer rows) {
		Page<Category> p = cb.findAll(page,rows);
		return new EasyUIPage(p.getTotal(), p.getResult());
	} 
	
	@PostMapping("save")
	public Result save(@Valid Article article,Errors error) {
		if(error.hasErrors()) {
			return new Result(Result.FAIL, "博客保存失败",error.getAllErrors());
		}else {
			ab.save(article);
			return new Result(Result.SUCCESS, "博客保存成功");
		}
		
	}
	
	@RequestMapping("upload")
	public Result upload(@RequestParam("file") MultipartFile file) {
		if(file.getSize()==0) {
			return new Result(Result.CANCEL,"取消上传");
		}
		String filename = UUID.randomUUID()+file.getOriginalFilename();
		try {
			file.transferTo(new File("F:/images/upload/"+filename));
			return new Result(Result.SUCCESS,"文件上传成功","/upload/"+filename);
		}  catch (Exception e) {
			return new Result(Result.FAIL,"文件上传失败");
		}
	}
	
	@RequestMapping("pageComment")
	public Result firstPage(Integer articleId,@RequestParam(defaultValue="0") Integer commpage,
			@RequestParam(defaultValue="10") Integer commsize) {
		List<Comment> list = cmmb.firstPage(articleId, commpage, commsize);
		return new Result(1, "", list);
	}
	
	@RequestMapping("commentArticle/{articleid}/{commcnt}")
	public Result commentArticle(@PathVariable("articleid") Integer articleid, 
			@PathVariable("commcnt") Integer commcnt,String commentContent,
			@SessionAttribute("loginUser") User user) {
		Comment c=new Comment();
		c.setArticleid(articleid);
		c.setCreateby(user.getId());
		c.setContent(commentContent);
		cmmb.commentArticle(c);
		
		long commTotal=cmmb.getCommTotal(articleid);
		long totalPage=commTotal%10==0?commTotal/10:(commTotal/10)+1;
		
		Article a=new Article();
		a.setCommcnt(++commcnt);
		a.setId(articleid);
		ab.addCommCnt(a);
		
		return new Result(1,"评论成功!",totalPage);
	}
}
