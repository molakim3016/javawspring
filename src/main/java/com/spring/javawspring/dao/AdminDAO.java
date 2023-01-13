package com.spring.javawspring.dao;

import org.apache.ibatis.annotations.Param;

public interface AdminDAO {

	public int setMemberLevelCheck(@Param("idx") int idx, @Param("level") int level);

	public void setMemberDelete(@Param("idx") int idx);

	public int getNewMemberCount();

	public int getNewBoardCount();

}
