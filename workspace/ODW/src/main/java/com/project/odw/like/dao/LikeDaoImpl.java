package com.project.odw.like.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.odw.like.dto.LikeDto;

@Repository
public class LikeDaoImpl implements LikeDao {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public void insertLike(LikeDto likeDto) throws Exception {
		sqlSession.insert("mapper.like.insertLike", likeDto);
	}

	@Override
	public int likeChk(LikeDto likeDto) throws Exception {
		return sqlSession.selectOne("mapper.like.likeChk", likeDto);
	}

	@Override
	public List<LikeDto> selectReceive(String id) throws Exception {
		return sqlSession.selectList("mapper.like.selectReceive", id);
	}

}
