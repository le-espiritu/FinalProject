package com.frame;

import java.util.ArrayList;

import com.vo.CarVO;
import com.vo.ParkingVO;

public interface Dao<K,V> {
	public void insert(V v) throws Exception;
	public void delete(K k) throws Exception;
	public void update(V v) throws Exception;
	public V select(K k) throws Exception;
	public V login(V v);
	public ArrayList<V> select() throws Exception;
	public ArrayList<V> getstate(K k);
	
	public ArrayList<V> getstateBy_p_id();
	
}
