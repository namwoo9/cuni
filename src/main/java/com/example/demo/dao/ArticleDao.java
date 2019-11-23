package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.Article;

@Mapper
public interface ArticleDao {
	List<Article> getList();

	long add(Map<String, Object> param);

	int getTotalCount();

	Article getOne(long id);

	void modify(Map<String, Object> param);

	void hitUp(long id);

	void getId(long id);
}
