package com.project.odw.member.controller;

import java.io.OutputStream;
import java.time.LocalDate;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.odw.like.service.LikeService;
import com.project.odw.member.dto.MemberDto;
import com.project.odw.member.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private LikeService likeService;
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public ModelAndView join() {
		return new ModelAndView("member/join");
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public @ResponseBody String join(MemberDto memberDto, HttpServletRequest request, MultipartHttpServletRequest mul) throws Exception {
				
		memberService.joinMember(memberDto, mul);
		
		String htmlBody = "<script>";
		htmlBody += "alert('Signed in successfuly.');";
		htmlBody += "location.href='"+ request.getContextPath()+"/member/login'";
		htmlBody += "</script>";
		
		return htmlBody;
	}
	
	@RequestMapping(value="/overlapped", method=RequestMethod.POST)
	public ResponseEntity<Object> overlapper(@RequestParam("id") String id) throws Exception {
		return new ResponseEntity<Object>(memberService.overlapped(id), HttpStatus.OK);
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		
		if (session.getAttribute("loginUser") != null) {
			return new ModelAndView("redirect:myPage");
		}
		else {
			return new ModelAndView("member/login");
		}
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public @ResponseBody String login(MemberDto memberDto, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="auto_login", required=false) String autoLogin) throws Exception {
		
		String htmlBody = "";
	
		if (memberService.loginMember(memberDto) != null) {
		
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", memberDto.getMemberId());
			
			if(autoLogin != null) {
				int time = 60*60*24*90;		// 90일
				Cookie cook = new Cookie("loginCookie", memberDto.getMemberId());
				cook.setPath("/");
				cook.setMaxAge(time);
				response.addCookie(cook);
				memberService.keepLogin(memberDto.getMemberId());
			}
				
			htmlBody += "<script>";
			htmlBody += "location.href='"+ request.getContextPath()+"/member/myPage'";				
			htmlBody += "</script>";
		}
		else {
			htmlBody += "<script>";
			htmlBody += "alert('check your password.');";
			htmlBody += "history.back(-1);";
			htmlBody += "</script>";
		}
		
		return htmlBody;
	}
	
	@RequestMapping(value="/myPage", method=RequestMethod.GET)
	public ModelAndView myPage(Model model, HttpServletRequest request) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		LocalDate now = LocalDate.now();
		
		int year = now.getYear();
		
		mv.addObject("memberDto", memberService.showOneMember((String)session.getAttribute("loginUser")));
		mv.addObject("year", year);
		mv.setViewName("member/myPage");
				
		return mv;
	}
	
	@RequestMapping(value="/info", method=RequestMethod.GET)
	public ModelAndView myPage(HttpServletRequest request, @RequestParam("memberId") String memberId) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		LocalDate now = LocalDate.now();
		
		int year = now.getYear();
		
		mv.addObject("memberDto", memberService.showOneMember(memberId));
		mv.addObject("send", likeService.likeChk((String)session.getAttribute("loginUser"), memberId));
		mv.addObject("year", year);
		mv.setViewName("member/info");
		
		return mv;
	}
	
	@RequestMapping(value="/profile", method=RequestMethod.GET)
	public void profile(@RequestParam("fileName") String fileName , HttpServletResponse response) throws Exception {
	
		OutputStream out = response.getOutputStream();
		String filePath = "/Users/oseunghwan/Desktop/Spring_project/workspace/ODW/src/main/webapp/WEB-INF/views/member/profile_images/" + fileName;

		memberService.getProfileImage(out, filePath);
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public ModelAndView update(HttpServletRequest request) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		
		mv.addObject("memberDto", memberService.showOneMember((String)session.getAttribute("loginUser")));
		
		return mv;
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public @ResponseBody String update(MemberDto memberDto, HttpServletRequest request, MultipartHttpServletRequest mul) throws Exception {
		
		String htmlBody = "";
		
		if (memberService.updateMember(memberDto, mul)) {
			htmlBody = "<script>";
			htmlBody += "alert('updated successfuly.');";
			htmlBody += "location.href='"+ request.getContextPath()+"/member/myPage'";
			htmlBody += "</script>";
		} 
		else {
			htmlBody = "<script>";
			htmlBody += "alert('check your password.');";
			htmlBody += "history.back(-1);";
			htmlBody += "</script>";
		}
		
		return htmlBody;
	}
	
	@RequestMapping(value="/receiveList", method=RequestMethod.GET)
	public ModelAndView receiveList(HttpServletRequest request) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		
		mv.setViewName("like/rList");
		mv.addObject("likeReceiveList", memberService.getLikeReceiveList((String)session.getAttribute("loginUser")));
		
		return mv;
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, @CookieValue(value="loginCookie", required=false)Cookie cook) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		if(cook != null) {
			cook.setMaxAge(0);
			cook.setPath("/");
			response.addCookie(cook);
		}
		
		return new ModelAndView("redirect:/member/login");
	}
	
	@RequestMapping(value="/delete" , method=RequestMethod.GET)
	public @ResponseBody String delete(HttpServletRequest request) throws Exception {
		
		String htmlBody = "";
		
		HttpSession session = request.getSession();
		memberService.deleteMember((String)session.getAttribute("loginUser"));
		session.invalidate();
		
		htmlBody += "<script>";
		htmlBody += "alert('Your account has been deleted successfully!');";
		htmlBody += "location.href='"+ request.getContextPath()+"/member/login'";
		htmlBody += "</script>";
		
		return htmlBody;
		
	}
	
}
