package com.project.odw.reply.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.odw.reply.dao.ReplyDao;
import com.project.odw.reply.dto.ReplyDto;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyDao replyDao;

	@Override
	public void insertReply(ReplyDto replyDto, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		replyDto.setWriter((String)session.getAttribute("loginUser"));
		
		replyDao.insert(replyDto);
	}

	@Override
	public List<ReplyDto> getReplyList(int num) throws Exception {
		return replyDao.selectAll(num);
	}

	@Override
	public ReplyDto getOneReply(int num) throws Exception {
		return replyDao.selectOne(num);
	}

	@Override
	public void updateReply(ReplyDto replyDto) throws Exception {
		replyDao.updateReply(replyDto);
	}

	@Override
	public void deleteReply(int num) throws Exception {
		replyDao.deleteReply(num);
	}

}
