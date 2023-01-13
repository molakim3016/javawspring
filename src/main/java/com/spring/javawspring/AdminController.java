package com.spring.javawspring;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawspring.pagination.PageProcess;
import com.spring.javawspring.pagination.PageVO;
import com.spring.javawspring.service.AdminService;
import com.spring.javawspring.service.BoardService;
import com.spring.javawspring.service.MemberService;
import com.spring.javawspring.vo.BoardVO;
import com.spring.javawspring.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value="/adminMain",method=RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@RequestMapping(value="/adminLeft",method=RequestMethod.GET)
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	
	@RequestMapping(value="/adminContent",method=RequestMethod.GET)
	public String adminContentGet(Model model) {
		
		int memCount = adminService.getNewMemberCount();
		int boardCount = adminService.getNewBoardCount();
		
		model.addAttribute("memCount",memCount);
		model.addAttribute("boardCount",boardCount);
		
		return "admin/adminContent";
	}
	
	@RequestMapping(value="/member/adminMemberList",method=RequestMethod.GET)
	public String adminMemberListGet(Model model,
			@RequestParam(name="mid",  defaultValue = "", required = false) String mid,
			@RequestParam(name="pag",  defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize",  defaultValue = "3", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag,pageSize,"member","",mid);
		
		List<MemberVO> vos = memberService.getMemberList(pageVO.getStartIndexNo(), pageSize,mid);

		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("mid", mid);
		
		return "admin/member/adminMemberList";
	}
	
	// 회원 등급 변경 하기
	@ResponseBody
	@RequestMapping(value = "/member/adminMemberLevel", method = RequestMethod.POST)
	public String adminMemberLevelPost(int idx, int level) {
		int res = adminService.setMemberLevelCheck(idx,level);
		
		return res+"";
	}
	
	// 회원삭제
	@ResponseBody
	@RequestMapping(value = "/member/adminMemberDel", method = RequestMethod.POST)
	public void adminMemberDelPost(int idx) {
		adminService.setMemberDelete(idx);
		
	}
	
	// ckdeitor폴더의 파일 리스트 보여주기
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/file/fileList", method = RequestMethod.GET)
	public String fileListGet(HttpServletRequest request, Model model) {
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		
		String[] files = new File(realPath).list();
		
		model.addAttribute("files",files);
		
		return "admin/file/fileList";
	}

	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/file/fileDelete", method = RequestMethod.POST)
	public void fileDeletePost(HttpServletRequest request, String delItems) {
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		String[] files = new File(realPath).list();
		String[] delItem = delItems.split("/");
		for(int i=0;i<files.length;i++) {
			for(int j=0;j<delItem.length;j++) {
				if(Integer.parseInt(delItem[j])==i) {
					File delFile = new File(realPath + files[i]);
					if(delFile.exists()) delFile.delete();
				}
			}
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/adminBoardDelete", method = RequestMethod.POST)
	public void adminBoardDeletePost(HttpServletRequest request, String delItems) {
		String[] delItem = delItems.split("/");
		for(int i=0;i<delItem.length;i++) {
			boardService.setBoardDeleteOk(Integer.parseInt(delItem[i]));
		}
	}
	
	@RequestMapping(value="/board/adminBoardList",method=RequestMethod.GET)
	public String adminBoardListGet(Model model,
			@RequestParam(name="part",defaultValue = "title",required = false) String part,
			@RequestParam(name="searchString",defaultValue = "",required = false) String searchString,
			@RequestParam(name="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name="pageSize",defaultValue = "5",required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", part, searchString);
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(),pageSize,part,searchString);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("part",part);
		model.addAttribute("searchString",searchString);
		
		return "admin/board/adminBoardList";
	}
	
}
