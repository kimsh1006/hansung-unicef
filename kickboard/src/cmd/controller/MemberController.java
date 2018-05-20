package cmd.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cmd.vo.MemberVO;
import cmd.service.MemberService;

@Controller
@RequestMapping(value="/member")
public class MemberController {
	
	@Resource(name="member.MemberService")
	private MemberService memberService;
	
	//로그인 페이지 이동
	@RequestMapping(value="/login.do")
	public ModelAndView login(){
		ModelAndView mav = new ModelAndView("member/login");
		return mav;
	}
	
	//로그인 아이디 & 비밀번호 체크
	@SuppressWarnings("unused")
	@RequestMapping(value="/login_check.do")
	public ModelAndView login_check(@RequestParam Map<String, Object> map, HttpServletRequest req, HttpServletResponse res){
		String check = null;
		MemberVO memberVo = null;
		Map<String, Object> rMap = new HashMap<String, Object>();
		memberVo = (MemberVO) memberService.login_check(map);
		
		if(memberVo == null){
			check = "no";
		} else {
			check = "yes";
			rMap.put("memberInfo", memberVo);
			HttpSession session = req.getSession(true);
			session.setAttribute("sessionData", rMap);
			session.setAttribute("member_no", memberVo.getMember_no());
		}		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("check", check);
		return mav;
	}
		
	//회원가입 페이지 이동
	@RequestMapping(value="/join.do")
	public ModelAndView join(){
		ModelAndView mav = new ModelAndView("member/join");
		return mav;
	}
	
	//회원가입 ID 중복 체크
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/member_id_check.do")
	public ModelAndView member_id_check(@RequestParam Map<String, Object> map){
		Map<String, Object> rMap = new HashMap<String, Object>();
		rMap = (Map<String, Object>) memberService.member_id_check(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("check", rMap.get("member_id_check"));
		return mav;
	}
	
	// 회원가입 DB 등록
	@RequestMapping(value="/insert_member.do")
	public ModelAndView insert_member(MemberVO memberVo){
	
		memberService.insert_member(memberVo);
		ModelAndView mav = new ModelAndView("member/login");
		return mav;
	}

}
