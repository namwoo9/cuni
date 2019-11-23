package com.example.demo.service;

import java.util.Map;

import com.example.demo.dto.Member;

public interface MemberService {

	Map<String, Object> checkLoginIdDup(String string);

	Map<String, Object> join(Map<String, Object> param);

	Member getOne(long loginedMemberId);

	Member getMatchedOne(String string, String string2);

}
