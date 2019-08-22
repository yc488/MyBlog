package com.yc.blog.util;

public class Utils {
	public static String getContent(String content) {
		return content.replaceAll("<.+?>", "").replaceAll("\\s", "").replaceAll("&.+?", "");
	}
	
	public static String getCode() {
		StringBuffer sb=new StringBuffer();
		
		for(int i=0;i<6;i++) {
			int b=(int)(Math.random()*10);
			sb.append(b);
		}
		return sb.toString();
	}
}
