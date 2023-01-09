package com.spring.javawspring.service;

import java.util.ArrayList;

import com.spring.javawspring.vo.GuestVO;

public interface StudyService {

	String[] getCityStringArr(String dodo);

	ArrayList<String> getCityArrayListArr(String dodo);

	GuestVO getGuestMid(String mid);

	ArrayList<GuestVO> getGuestNames(String mid);

	ArrayList<GuestVO> getGuestCategory(String mid, String category);

}
