package com.project.odw.reply.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.odw.reply.dto.ReplyDto;

@Repository
public class ReplyDaoImpl implements ReplyDao {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public void insert(ReplyDto replyDto) throws Exception {
		sqlSession.insert("mapper.reply.insertReply", replyDto);
	}

	@Override
	public List<ReplyDto> selectAll(int num) throws Exception {
		return sqlSession.selectList("mapper.reply.getReplyList", num);
	}

	@Override
	public ReplyDto selectOne(int num) throws Exception {
		return sqlSession.selectOne("mapper.reply.getOneReply", num);
	}

	@Override
	public void updateReply(ReplyDto replyDto) throws Exception {
		sqlSession.update("mapper.reply.updateReply", replyDto);
	}

	@Override
	public void deleteReply(int num) throws Exception {
		sqlSession.delete("mapper.reply.deleteReply", num);
	}

}
