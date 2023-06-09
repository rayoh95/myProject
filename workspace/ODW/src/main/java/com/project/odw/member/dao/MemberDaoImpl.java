package com.project.odw.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.odw.member.dto.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public void insertMember(MemberDto memberDto) throws Exception {
		sqlSession.insert("mapper.member.joinMember", memberDto);
	}

	@Override
	public MemberDto overlapped(String memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.duplicatedMemberCheck", memberId);
	}

	@Override
	public MemberDto login(MemberDto memberDto) throws Exception {
		return sqlSession.selectOne("mapper.member.loginMember", memberDto);
	}

	@Override
	public MemberDto selectOneMember(String memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.showOneMember", memberId);
	}

	@Override
	public void updateMember(MemberDto memberDto) throws Exception {
		sqlSession.update("mapper.member.updateMember", memberDto);
	}

	@Override
	public void deleteMember(String memberId) throws Exception {
		sqlSession.delete("mapper.member.deleteMember", memberId);
	}

	@Override
	public List<MemberDto> selectAllMember(String memberGender) throws Exception {
		return sqlSession.selectList("mapper.member.showAllMember", memberGender);
	}

	@Override
	public void keepLogin(String id) throws Exception {
		sqlSession.update("mapper.member.keepLogin", id);
	}

	@Override
	public MemberDto getAutoLogin(String autoLogin) throws Exception {
		return sqlSession.selectOne("mapper.member.getAutoLogin", autoLogin);
	}

}
