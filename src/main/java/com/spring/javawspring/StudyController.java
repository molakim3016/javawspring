package com.spring.javawspring;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawspring.common.ARIAUtil;
import com.spring.javawspring.common.SecurityUtil;
import com.spring.javawspring.service.MemberService;
import com.spring.javawspring.service.StudyService;
import com.spring.javawspring.vo.GuestVO;
import com.spring.javawspring.vo.MailVO;
import com.spring.javawspring.vo.MemberVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	
	@Autowired
	StudyService studyService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="/ajax/ajaxMenu", method = RequestMethod.GET)
	public String ajaxMenuGet() {
		return "study/ajax/ajaxMenu";
	}
	
	// 일반 String값의 전달 1(숫자/영문자)
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest1_1",method=RequestMethod.POST)
	public String ajaxTest1_1Post(int idx) {
		idx = (int)(Math.random()*idx) + 1;
		String res = idx + " : Happy a Good Time!!!";
		return res;
	}
	
	// 일반 String값의 전달 2(숫자/영문자/한글)
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest1_2",method=RequestMethod.POST , produces = "application/text; charset=utf8") // produces는 문자열을 보낼때 사용(한글등), 배열일때는 사용하지않는다.
	public String ajaxTest1_2Post(int idx) {
		idx = (int)(Math.random()*idx) + 1;
		String res = idx + " : 안녕하세요..... Happy a Good Time!!!";
		return res;
	}
	
	// 일반 배열값의 전달 폼
	@RequestMapping(value="/ajax/ajaxTest2_1",method=RequestMethod.GET)
	public String ajaxTest2_1Get() {
		return "study/ajax/ajaxTest2_1";
	}
	
	// 일반 배열값의 전달
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest2_1",method=RequestMethod.POST)
	public String[] ajaxTest2_1Post(String dodo) {
//		String[] strArr = new String[100];
//		strArr = studyService.getCityStringArr(dodo);
//		return strArr;
		return studyService.getCityStringArr(dodo);
	}
	
	// 객체 배열(ArrayList)값의 전달 폼
	@RequestMapping(value="/ajax/ajaxTest2_2",method=RequestMethod.GET)
	public String ajaxTest2_2Get() {
		return "study/ajax/ajaxTest2_2";
	}
	
	// 객체 배열(ArrayList)값의 전달
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest2_2",method=RequestMethod.POST)
	public ArrayList<String> ajaxTest2_2Post(String dodo) {
		return studyService.getCityArrayListArr(dodo);
	}
	
	// Map(HashMap<k,v>)값의 전달 폼
	@RequestMapping(value="/ajax/ajaxTest2_3",method=RequestMethod.GET)
	public String ajaxTest2_3Get() {
		return "study/ajax/ajaxTest2_3";
	}
	
	// Map(HashMap<k,v>)값의 전달
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest2_3",method=RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest2_3Post(String dodo) {
		ArrayList<String> vos = new ArrayList<String>();
		vos = studyService.getCityArrayListArr(dodo);
		
		HashMap<Object,Object> map = new HashMap<Object, Object>();
		map.put("city", vos);
		
		return map;
	}
	
	// DB를 활용한 값의 전달 폼
	@RequestMapping(value="/ajax/ajaxTest3",method=RequestMethod.GET)
	public String ajaxTest3Get() {
		return "study/ajax/ajaxTest3";
	}
	
	// DB를 활용한 값의 전달1(vo)
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest3_1",method=RequestMethod.POST)
	public GuestVO ajaxTest3_1Post(String mid) {
		//GuestVO vo = studyService.getGuestMid(mid);
		//return vo;
		return studyService.getGuestMid(mid);
	}
	
	// DB를 활용한 값의 전달2(vos)
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest3_2",method=RequestMethod.POST)
	public ArrayList<GuestVO> ajaxTest3_2Post(String mid) {
//		ArrayList<GuestVO> vos = studyService.getGuestNames(mid);
//		return vos;
		return studyService.getGuestNames(mid);
	}
	
	// DB를 활용한 값의 전달3(vos)
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest3_3",method=RequestMethod.POST)
	public ArrayList<GuestVO> ajaxTest3_3Post(String mid,String category) {
		return studyService.getGuestCategory(mid,category);
	}
	
	// 암호화 연습(sha256) 폼
	@RequestMapping(value = "/password/sha256",method=RequestMethod.GET)
	public String sha256Get() {
		return "study/password/sha256";
	}
	
	// 암호화 연습(sha256) 결과 처리
	@ResponseBody
	@RequestMapping(value = "/password/sha256",method=RequestMethod.POST,produces = "application/text; charset=utf8")
	public String sha256Post(String pwd) {
		String encPwd = SecurityUtil.encryptSHA256(pwd);
		pwd = "원본 비밀번호 : " + pwd + " <br/> 암호화된 비밀번호 : " + encPwd +"<br/>";
		
		return pwd;
	}
	
	// 암호화 연습(aria) 폼
	@RequestMapping(value = "/password/aria",method=RequestMethod.GET)
	public String ariaGet() {
		return "study/password/aria";
	}
	
	// 암호화 연습(aria) 결과 처리
	@ResponseBody
	@RequestMapping(value = "/password/aria",method=RequestMethod.POST,produces = "application/text; charset=utf8")
	public String ariaPost(String pwd) {
		String encPwd = "";
		String decPwd = "";
		try {
			encPwd = ARIAUtil.ariaEncrypt(pwd); // 암호화
			decPwd = ARIAUtil.ariaDecrypt(encPwd); // 암호화
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		pwd = "원본 비밀번호 : " + pwd + " <br/> 암호화된 비밀번호 : " + encPwd + "<br/> 복호화된 비밀번호 : " + decPwd +"<br/>";
		
		return pwd;
	}
	
	// 암호화 연습(BCryptPasswordEncoder) 폼
	@RequestMapping(value = "/password/bCryptPassword",method=RequestMethod.GET)
	public String bCryptPasswordGet() {
		return "study/password/security";
	}
	
	// 암호화 연습(BCryptPasswordEncoder) 결과 처리
	@ResponseBody
	@RequestMapping(value = "/password/bCryptPassword",method=RequestMethod.POST,produces = "application/text; charset=utf8")
	public String bCryptPasswordPost(String pwd) {
		String encPwd = "";
		encPwd = passwordEncoder.encode(pwd);  // 암호화
		
		pwd = "원본 비밀번호 : " + pwd + " <br/> 암호화된 비밀번호 : " + encPwd + "<br/>";
		
		return pwd;
	}
	
	// SMTP 메일 보내기
	// 메일작성 폼 
	@RequestMapping(value="/mail/mailForm",method=RequestMethod.GET)
	public String mailFormGet(Model model, String email) {
		
		ArrayList<MemberVO> vos = memberService.getMemberList(0, 1000);
		
		model.addAttribute("vos",vos);
		model.addAttribute("cnt",vos.size());
		model.addAttribute("email",email);
		
		return "study/mail/mailForm";
	}
	
	// 주소록 호출하기
	
	
	// 메일 전송하기
	@RequestMapping(value="/mail/mailForm",method=RequestMethod.POST)
	public String mailFormPost(MailVO vo,HttpServletRequest request) {
		try {
			String toMail = vo.getToMail();
			String title = vo.getTitle();
			String content = vo.getContent();
			
			// 메일을 전송하기위한 객체 : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송시킬수 있도록 한다.
			content = content.replace("\n", "<br/>");
			content += "<br><hr><h3>CJ Green에서 보냅니다.</h3><hr><br>";
			content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
			content += "<p>방문하기 : <a href='http://49.142.157.251:9090/green2209J_03/mallMain.mall'>Nike Shoe Store</a></p>";
			content += "<hr>";
			
			messageHelper.setText(content,true);
			
			// 본문에 기재된 그림파일의 경로를 따로 표시시켜준다. 그리고, 보관함에 다시 저장시켜준다.
			FileSystemResource file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\main.jpg");
			messageHelper.addInline("main.jpg", file);
			
			// 첨부파일 보내기(서버 파일시스템에 있는 파일)
			file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\chicago.jpg");
			messageHelper.addAttachment("chicago.jpg", file);
			
			file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\bandmember.jpg");
			messageHelper.addAttachment("bandmemberbbb.jpg", file);
			
			// file = new FileSystemResource(request.getRealPath("/resources/images/paris.jpg"));
			file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/sanfran.jpg"));
			messageHelper.addAttachment("sanfran.jpg", file);
			
			// 메일 전송하기
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/msg/mailSendOk";
	}
	
	// UUID 입력폼
	@RequestMapping(value="/uuid/uuidForm",method=RequestMethod.GET)
	public String uuidFormGet() {
		return "study/uuid/uuidForm";
	}
	
	// UUID 처리하기
	@ResponseBody
	@RequestMapping(value="/uuid/uuidProcess",method=RequestMethod.POST)
	public String uuidProcessPost() {
		UUID uid = UUID.randomUUID();
		
		return uid.toString();
	}
	
}
