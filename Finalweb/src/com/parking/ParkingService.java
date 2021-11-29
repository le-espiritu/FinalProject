package com.parking;

import java.util.ArrayList;

import javax.annotation.Resource;

import com.frame.Dao;
import com.frame.Service;
import com.vo.ParkingVO;

@org.springframework.stereotype.Service("ParkingService")
public class ParkingService implements Service<String, ParkingVO>{

	@Resource(name="ParkingDao")
	Dao<String,ParkingVO> dao;

	@Override
	public void register(ParkingVO v) throws Exception {
		dao.insert(v);
	}

	@Override
	public void remove(String k) throws Exception {
		dao.delete(k);
	}

	@Override
	public void modify(ParkingVO v) throws Exception {
		dao.update(v);
	}

	@Override
	public ParkingVO get(String k) throws Exception {
		return dao.select(k);
	}

	@Override
	public ArrayList<ParkingVO> get() throws Exception {
		return dao.select();
	}

	@Override
	public ParkingVO login(ParkingVO v) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}