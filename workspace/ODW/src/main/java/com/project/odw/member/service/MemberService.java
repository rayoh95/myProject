package com.project.odw.member.service;

import java.io.OutputStream;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.odw.member.dto.MemberDto;
import com.project.odw.member.dto.SimpleMemberDto;

public interface MemberService {

	public void joinMember(MemberDto memberDto, MultipartHttpServletRequest mul) throws Exception;
	public String overlapped(String memberId) throws Exception;
	public MemberDto loginMember(MemberDto memberDto) throws Exception;
	public MemberDto showOneMember(String memberId) throws Exception;
	public void getProfileImage(OutputStream out, String filePath) throws Exception;
	public boolean updateMember(MemberDto memberDto, MultipartHttpServletRequest mul) throws Exception;
	public void deleteMember(String memberId) throws Exception;
	public List<SimpleMemberDto> showAllMember(String memberId) throws Exception;
	public void keepLogin(String id) throws Exception;
	public MemberDto getAutoLogin(String autoLogin) throws Exception;
	public List<MemberDto> getLikeReceiveList(String id) throws Exception;
	
}
