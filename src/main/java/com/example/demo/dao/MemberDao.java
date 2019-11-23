package com.example.demo.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.Member;

@Mapper
public interface MemberDao {
	public int getLoginIdDupCount(String loginId);

	public void join(Map<String, Object> param);

	public Member getOne(long loginedMemberId);

	public Member getMatchedOne(String loginId, String loginPw);
}