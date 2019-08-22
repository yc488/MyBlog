package com.yc.blog.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yc.blog.bean.User;
import com.yc.blog.bean.UserExample;
import com.yc.blog.dao.UserMapper;

@Service
public class UserBiz {

	@Resource
	UserMapper um;
	
	/**
	 * 登录
	 * @param user
	 * @return
	 * @throws BizException
	 */
	public User login(User user) throws BizException {
		if(user.getCnName()==null || user.getCnName().trim().isEmpty()) {
			throw new BizException("用户名或密码不能为空,登陆失败");
		}
		
		UserExample example = new UserExample();
		example.createCriteria().andCnNameEqualTo(user.getCnName()).andPasswordEqualTo(user.getPassword());
		List<User> list = um.selectByExample(example);
		if(list.size()==0) {
			throw new BizException("用户名或密码错误,登陆失败");
		}
			
		return list.get(0);
	}

	/**
	 * 更新密码
	 * @param user
	 * @param newpassword
	 * @param newrepassword
	 * @param recode 
	 * @param code 
	 * @throws BizException
	 */
	public void updataPwd(User user, String code, String recode, String newpassword, String newrepassword) throws BizException {
		System.out.println(code);
		System.out.println(recode);
		if(code==null) {
			throw new BizException("请先获取验证码");
		}
		if(!code.equals(recode)) {
			throw new BizException("验证码错误");
		}
		if(!newpassword.equals(newrepassword)) {
			throw new BizException("两次密码不一致,修改失败");
		}
		user.setPassword(newpassword);
		um.updateByPrimaryKeySelective(user);
		
	}

	/**
	 * 注册用户
	 * @param user
	 * @param code
	 * @param recode
	 * @param regrepassword 
	 * @throws BizException 
	 */
	public void reg(User user, String code, String recode, String regrepassword) throws BizException {
		if(user.getAddress()==null || user.getCnName()==null || user.getPassword()==null
			|| user.getAddress().trim().isEmpty() || user.getCnName().trim().isEmpty() ||
			user.getPassword().trim().isEmpty()) {
			throw new BizException("用户名、密码或邮箱不能为空");
		}
		if(code==null || code.trim().isEmpty()) {
			throw new BizException("请先获取验证码");
		}
		if(recode==null || recode.trim().isEmpty()) {
			throw new BizException("验证码不能为空");
		}
		if(!code.equals(recode)) {
			throw new BizException("验证码错误");
		}
		if(!regrepassword.equals(user.getPassword())) {
			throw new BizException("两次密码不一致,注册失败");
		}
		
		um.insertSelective(user);
	}
}
