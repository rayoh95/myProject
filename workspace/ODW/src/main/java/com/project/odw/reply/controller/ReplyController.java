package com.project.odw.reply.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.odw.reply.dto.ReplyDto;
import com.project.odw.reply.service.ReplyService;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public @ResponseBody String write(ReplyDto replyDto, HttpServletRequest request) throws Exception {
		
		String htmlBody = "";
		
		replyService.insertReply(replyDto, request);
		
		htmlBody = "<script>";
		htmlBody += "alert('reply registered successfuly!');";
		htmlBody += "location.href='"+ request.getContextPath()+"/board/info?num=" + replyDto.getbNum() + "'";
		htmlBody += "</script>";
		
		return htmlBody;
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public ModelAndView update(@RequestParam("num") int num) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("reply/rUpdate");
		mv.addObject("replyDto", replyService.getOneReply(num));
		
		return mv;
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public @ResponseBody String update(ReplyDto replyDto, HttpServletRequest request, @RequestParam("num") int num, @RequestParam("bNum") int bNum) throws Exception {
		
		String htmlBody = "";
		replyDto.setbNum(num);
		
		replyService.updateReply(replyDto);
		
		htmlBody = "<script>";
		htmlBody += "alert('updated successfuly!');";
		htmlBody += "location.href='"+ request.getContextPath()+"/board/info?num=" + bNum + "'";
		htmlBody += "</script>";
		
		return htmlBody;
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public @ResponseBody String delete(HttpServletRequest request, @RequestParam("num") int num, @RequestParam("bNum") int bNum) throws Exception {
		
		String htmlBody = "";
		
		replyService.deleteReply(num);
		
		htmlBody = "<script>";
		htmlBody += "alert('deleted successfuly!');";
		htmlBody += "location.href='"+ request.getContextPath()+"/board/info?num=" + bNum + "'";
		htmlBody += "</script>";
		
		return htmlBody;
	}
	
	
}
