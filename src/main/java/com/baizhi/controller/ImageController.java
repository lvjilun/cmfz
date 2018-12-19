package com.baizhi.controller;


import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.baizhi.util.CreateValidateCode;

@RequestMapping("/img")
@Controller
@Log4j
public class ImageController {
	
	//生成验证码的图片
	@RequestMapping("/createImage")
	public void createImage(HttpSession session,HttpServletResponse response) throws Exception{
		// 调用工具类，生成图片上的随机字符
				CreateValidateCode cvc = new CreateValidateCode();
				String code = cvc.getCode();
				
				// 存 随机字符到  --- session
				session.setAttribute("vcode", code);
				
				// 调用工具类，把生成的随机字符，使用输出流往client输出成图片
				cvc.write( response.getOutputStream());
	}
}
