package com.project.odw.member.dto;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class SimpleMemberDto {
	
	private String profileImage;
    private String memberId;
    private String memberHeight;
    private Date joinDate;
    private boolean sentLike;

    public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberHeight() {
		return memberHeight;
	}
	public void setMemberHeight(String memberHeight) {
		this.memberHeight = memberHeight;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date date) {
		this.joinDate = date;
	}
	public boolean isSentLike() {
		return sentLike;
	}
	public void setSentLike(boolean sentLike) {
		this.sentLike = sentLike;
	}
}
