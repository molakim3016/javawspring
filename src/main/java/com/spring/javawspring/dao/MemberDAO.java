package com.spring.javawspring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickNameCheck(@Param("nickName") String nickName);

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public void setTodayCntUpdate(@Param("mid") String mid);

	public void setMemTotalUpdate(@Param("mid") String mid, @Param("nowTodayPoint") int nowTodayPoint, @Param("todayCnt") int todayCnt);

	public int totRecCnt(@Param("searchString") String searchString);

	public ArrayList<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize, @Param("mid") String mid);

	public int totTermRecCnt(@Param("mid") String mid);

	public ArrayList<MemberVO> getTermMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public void setMemberPwdUpdate(@Param("mid") String mid,@Param("pwd") String pwd);

	public void setMemberDelete(@Param("mid") String mid);

	public String getMemberIdSearch(@Param("name") String name, @Param("email") String email);

}
