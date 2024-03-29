package com.yc.blog.bean;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value = {"handler"})
public class Comment {
	
	private User commUser;
	
	@Override
	public String toString() {
		return "Comment [commUser=" + commUser + ", id=" + id + ", articleid=" + articleid + ", content=" + content
				+ ", createby=" + createby + ", createtime=" + createtime + "]";
	}

	public User getCommUser() {
		return commUser;
	}

	public void setCommUser(User commUser) {
		this.commUser = commUser;
	}

	/**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column comment.id
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    private Integer id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column comment.articleId
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    private Integer articleid;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column comment.content
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    private String content;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column comment.createBy
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    private Integer createby;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column comment.createTime
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    private Timestamp createtime;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column comment.id
     *
     * @return the value of comment.id
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column comment.id
     *
     * @param id the value for comment.id
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column comment.articleId
     *
     * @return the value of comment.articleId
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public Integer getArticleid() {
        return articleid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column comment.articleId
     *
     * @param articleid the value for comment.articleId
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public void setArticleid(Integer articleid) {
        this.articleid = articleid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column comment.content
     *
     * @return the value of comment.content
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public String getContent() {
        return content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column comment.content
     *
     * @param content the value for comment.content
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column comment.createBy
     *
     * @return the value of comment.createBy
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public Integer getCreateby() {
        return createby;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column comment.createBy
     *
     * @param createby the value for comment.createBy
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public void setCreateby(Integer createby) {
        this.createby = createby;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column comment.createTime
     *
     * @return the value of comment.createTime
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public Timestamp getCreatetime() {
        return createtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column comment.createTime
     *
     * @param createtime the value for comment.createTime
     *
     * @mbg.generated Fri May 31 21:30:34 CST 2019
     */
    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }
}