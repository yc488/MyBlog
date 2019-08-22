package com.yc.blog.web;

import com.yc.blog.bean.Article;
import com.yc.blog.bean.User;
import com.yc.blog.biz.*;
import com.yc.blog.util.Utils;
import com.yc.blog.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

import javax.annotation.Resource;
import java.util.Date;

@Controller
@SessionAttributes(value= {"loginUser"})
public class IndexAction {

	private String code=null;
	
	@Resource
	CategoryBiz cb;
	
	@Resource
	ArticleBiz ab;
	
	@Resource
	CommentBiz cmmb;
	
	@Resource
	UserBiz ub;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Value("${mail.fromMail.addr}")
	private String from;
	
	@ModelAttribute
	public void initHeaderData(Model model) {
		model.addAttribute("categorys", cb.findAll());
	}
	
	
	@RequestMapping(path= {"index","/"})
	public String index(Model model,@RequestParam(defaultValue="1") Integer page,
			@RequestParam(defaultValue="5") Integer size) {		
		Article todayRecommend = ab.findTodayRecommend();
		todayRecommend.setContent(Utils.getContent(todayRecommend.getContent()).substring(0, 150));
		model.addAttribute("todayRecommend", todayRecommend);
		model.addAttribute("newArticles", ab.findArticleByPage(0,page,size,null,null));
		model.addAttribute("hotArticles", ab.findHotArticleByPage(0,5));
		model.addAttribute("page", ++page);
		System.out.println(todayRecommend);
		return "index";
	}
	
	@RequestMapping("category")
	public String category(Model model,@RequestParam(defaultValue="1") Integer page,
			@RequestParam(defaultValue="5") Integer size,Integer categoryId) {
		model.addAttribute("categoryArticles", ab.findArticleByPage(categoryId,page, size,null,null));
		model.addAttribute("hotArticles", ab.findHotArticleByPage(0,5));
		model.addAttribute("page", ++page);
		return "category";
	}
	
	@RequestMapping("seeArticle")
	public String seeArticle(Model model,Article article,@RequestParam(defaultValue="0") Integer commpage,
			@RequestParam(defaultValue="10") Integer commsize) {
		article = ab.findArticleById(article.getId(),commpage,commsize);
		Integer readcnt = article.getReadcnt();
		article.setReadcnt(++readcnt);
		ab.updataReadcnt(article);
		model.addAttribute("article",article );
		
		if(article.getLabel()!=null && !article.getLabel().trim().isEmpty()) {
			String[] split = article.getLabel().split(",");
			model.addAttribute("recommends", ab.findArticleByLabel(split,1,8));
		}else {
			model.addAttribute("recommends", ab.findArticleByPage(0, 1, 8, null, null));
		}
		
		model.addAttribute("hotArticles", ab.findHotArticleByPage(0,5));
		
		long commTotal=cmmb.getCommTotal(article.getId());
		if(commTotal==0) {
			model.addAttribute("commTotalPage",1);
		}else {
			long totalPage=commTotal%commsize==0?commTotal/commsize:(commTotal/commsize)+1;
			model.addAttribute("commTotalPage",totalPage);
		}
		
		return "article";
	}
	
	@RequestMapping("tags")
	public String tags() {
		return "tags";
	}
	
	@RequestMapping("readers")
	public String readers() {
		return "readers";
	}
	
	@RequestMapping("links")
	public String links() {
		return "links";
	}
	
	public boolean sendEmail(String to,String subject,String content) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(from);
		message.setTo(to);
		message.setSubject(subject);
		message.setText(content);
		message.setSentDate(new Date());
		try {
			mailSender.send(message);
			return true;
		} catch (MailException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	@PostMapping("getUpdateCode")
	@ResponseBody
	public Result getUpdateCode(@SessionAttribute("loginUser")User user) {
		code=Utils.getCode();
		String content="如果不是本人操作，请忽略本条邮件，避免发声账号安全，请不要将验证码发送给他人，博客修改密码验证码为："+code;
		sendEmail(user.getAddress(),"博客系统邮件", content);
		return new Result(1, "验证码已发送到邮箱,请查收");
	}
	@PostMapping("getRegCode")
	@ResponseBody
	public Result getRegCode(String to) {
		if(to==null || to.trim().isEmpty()) {
			return new Result(0, "验证码发送失败");
		}else {
			code=Utils.getCode();
			String content="如果不是本人操作，请忽略本条邮件，避免发声账号安全，请不要将验证码发送给他人，博客修改密码验证码为："+code;
			boolean sorf = sendEmail(to,"博客系统邮件", content);
			if(sorf) {
				return new Result(1, "验证码已发送到"+to+"的邮箱,请查收");
			}else {
				return new Result(0, "请填写正确的邮箱");
			}
			
		}
		
	}
	
	
	@PostMapping("indexLogin")
	@ResponseBody
	public Result indexLogin(User user, Model model) {
		try {
			User loginUser = ub.login(user);
			model.addAttribute("loginUser", loginUser);
			return new Result(1, "登录成功",loginUser);
		} catch (BizException e) {
			e.printStackTrace();
			return new Result(0, e.getMessage());
		}
	}

	
	@PostMapping("clearCode")
	@ResponseBody
	public Result clearCode() {
		code=null;
		return new Result(1, "验证码已失效");
	}
	
	@PostMapping("loginOut")
	@ResponseBody
	public Result loginOut(SessionStatus sessionStatus) {
		sessionStatus.setComplete();
		return new Result(1, "退出成功");
	}
	
	@PostMapping("updatePwd")
	@ResponseBody
	public Result updatePwd(@SessionAttribute("loginUser")User user,
			String newpassword,String recode,String newrepassword,SessionStatus sessionStatus) {
		try {
			ub.updataPwd(user,code,recode,newpassword,newrepassword);
			sessionStatus.setComplete();
			code=null;
			return new Result(1, "修改成功,请重新登录");
		} catch (BizException e) {
			e.printStackTrace();
			return new Result(0, e.getMessage());
		}
	}
	
	@PostMapping("reg")
	@ResponseBody
	public Result reg(User user,String recode,String regrepassword) {
		try {
			ub.reg(user,code,recode,regrepassword);
			code=null;
			return new Result(1, "注册成功");
		} catch (BizException e) {
			e.printStackTrace();
			return new Result(0, e.getMessage());
		}
	}
}
