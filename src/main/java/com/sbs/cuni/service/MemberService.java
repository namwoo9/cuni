package com.sbs.cuni.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.sbs.cuni.dto.Member;

public interface MemberService {

	public Map<String, Object> login(Map<String, Object> param, HttpServletRequest request);

	public Member getOne(long id);

	public Map<String, Object> update(Map<String, Object> args);

	public Map<String, Object> doubleCheck(Map<String, Object> param);

	public Map<String, Object> searchId(Map<String, Object> param);

	public Map<String, Object> searchPw(Map<String, Object> param);

	public Map<String, Object> updateAuthStatus(Map<String, Object> param);

	public Map<String, Object> updateDelStatus(Map<String, Object> param);

	public boolean isMasterMember(long loginedMemberId);

	Map<String, Object> login(Map<String, Object> param);

	public int userIdCheck(String loginId);

	public int userNameCheck(String name);

	
}