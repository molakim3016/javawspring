package com.spring.javawspring.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javawspring.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickNameCheck(String nickName);

	public int setMemberJoinOk(MultipartFile fName, MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);

	public int totRecCnt(String searchString);

	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, String mid);

	public int totTermRecCnt(String mid);

	public ArrayList<MemberVO> getTermMemberList(int startIndexNo, int pageSize, String mid);

	public void setMemberPwdUpdate(String mid, String pwd);

	public void setMemberDelete(String mid);

	public String getMemberIdSearch(String name, String email);

}
