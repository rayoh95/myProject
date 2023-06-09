package com.project.odw.reply.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.project.odw.reply.dto.ReplyDto;

public interface ReplyService {
	
	public void insertReply(ReplyDto replyDto, HttpServletRequest request) throws Exception;
	public List<ReplyDto> getReplyList(int num) throws Exception;
	public ReplyDto getOneReply(int num) throws Exception;
	public void updateReply(ReplyDto replyDto) throws Exception;
	public void deleteReply(int num) throws Exception;

}
