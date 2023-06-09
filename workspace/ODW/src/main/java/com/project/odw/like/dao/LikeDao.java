package com.project.odw.like.dao;

import java.util.List;

import com.project.odw.like.dto.LikeDto;

public interface LikeDao {

	public void insertLike(LikeDto likeDto) throws Exception;
	public int likeChk(LikeDto likeDto) throws Exception;
	public List<LikeDto> selectReceive(String id) throws Exception;
}
