package com.example.demo.service;

import java.util.List;
import java.util.Map;

import com.example.demo.dto.Article;

public interface ArticleService {
	List<Article> getList();

	public long add(Map<String, Object> param);

	int getTotalCount();

	Article getOne(long id);

	void modify(Map<String, Object> param);

	void hitUp(long id);

	void getId(long id);
}
