package com.spring.javawspring.service;

public interface AdminService {

	public int setMemberLevelCheck(int idx, int level);

	public void setMemberDelete(int idx);

	public int getNewMemberCount();

	public int getNewBoardCount();

}
