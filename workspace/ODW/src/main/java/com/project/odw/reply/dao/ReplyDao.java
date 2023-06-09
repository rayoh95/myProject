package com.project.odw.reply.dao;

import java.util.List;

import com.project.odw.reply.dto.ReplyDto;

public interface ReplyDao {
	
	public void insert(ReplyDto replyDto) throws Exception;
	public List<ReplyDto> selectAll(int num) throws Exception;
	public ReplyDto selectOne(int num) throws Exception;
	public void updateReply(ReplyDto replyDto) throws Exception;
	public void deleteReply(int num) throws Exception;

}
