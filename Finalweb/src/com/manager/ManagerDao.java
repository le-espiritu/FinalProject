package com.manager;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.frame.Dao;
import com.mapper.ManagerMapper;
import com.vo.ManagerVO;

@Repository("ManagerDao")
public class ManagerDao implements Dao<String, ManagerVO>{
	@Autowired
	ManagerMapper mm;

	@Override
	public void insert(ManagerVO v) throws Exception {
		mm.insert(v);
	}

	@Override
	public void delete(String k) throws Exception {
		mm.delete(k);
	}

	@Override
	public void update(ManagerVO v) throws Exception {
		mm.update(v);
	}

	@Override
	public ManagerVO select(String k) throws Exception {
		return mm.select(k);
	}

	@Override
	public ArrayList<ManagerVO> select() throws Exception {
		return mm.selectall();
	}

	@Override
	public ManagerVO login(ManagerVO v) {
		return mm.login(v);
	}
	
	
}