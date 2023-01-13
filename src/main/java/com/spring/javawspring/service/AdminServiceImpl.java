package com.spring.javawspring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawspring.dao.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public int setMemberLevelCheck(int idx, int level) {
		return adminDAO.setMemberLevelCheck(idx, level);
	}

	@Override
	public void setMemberDelete(int idx) {
		adminDAO.setMemberDelete(idx);
	}

	@Override
	public int getNewMemberCount() {
		return adminDAO.getNewMemberCount();
	}

	@Override
	public int getNewBoardCount() {
		return adminDAO.getNewBoardCount();
	}
}
