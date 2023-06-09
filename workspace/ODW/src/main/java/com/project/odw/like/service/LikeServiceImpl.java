package com.project.odw.like.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.odw.like.dao.LikeDao;
import com.project.odw.like.dto.LikeDto;

@Service
public class LikeServiceImpl implements LikeService {
	
	@Autowired
	private LikeDao likeDao;

	@Override
	public void likeSend(String likeSend, String likeReceive) throws Exception {
		
		LikeDto likeDto = new LikeDto();
		
		likeDto.setLikeSend(likeSend);
		likeDto.setLikeReceive(likeReceive);
		
		likeDao.insertLike(likeDto);
	}

	@Override
	public String likeChk(String likeSend, String likeReceive) throws Exception {
		
		String send = "false";
		LikeDto likeDto = new LikeDto();
		
		likeDto.setLikeSend(likeSend);
		likeDto.setLikeReceive(likeReceive);
		
		if(likeDao.likeChk(likeDto) == 1) {
			send = "true";
			return send;
		}
			
		return send;
	}

	@Override
	public List<LikeDto> getLikeReceiveList(String id) throws Exception {
		return likeDao.selectReceive(id);
	}

}
