package cmd.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cmd.service.CmdService;
import cmd.vo.CmdVO;




@Controller("cmd")
@RequestMapping("/cmd")
public class CmdController
{
    private final static Log logger = LogFactory.getLog(CmdController.class);
   
	@Resource(name = "cmdService")
	private CmdService cmdService;
	
	//메인페이지 호출
    @RequestMapping("/main.do")
    public String main(){  
    	
    	
    	return "main/main";
    	
    }
    
	//정보 화면
	@RequestMapping(value="/info.do")
	public String info(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
		return "main/info";

	}
	
	//충전 화면
	@RequestMapping(value="/money.do")
	public String money(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
		return "main/money";

	}
	
	

    //관리자 화면
  	@RequestMapping(value="/admin.do")
  	public String admin(HttpServletRequest req, HttpServletResponse res,
   			@RequestParam Map<String, Object> pMap) throws Exception {
  		return "admin/main";

  	}
    //회원가입페이지 호출
    @RequestMapping("/join.do")
    public String join(){      	    
    	return "main/join";
    }
 
    //아이디찾기 호출
    @RequestMapping("/findId.do")
    public String findId(){      	    
    	return "main/findId";
    }
    
    //비밀번호찾기 호출
    @RequestMapping("/findPw.do")
    public String findPw(){      	    
    	return "main/findPw";
    }
    
	//학번관리 화면
	@RequestMapping(value="/get_school_list.do")
	public ModelAndView get_school_list(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {

		List<Object> list = null;

		list = cmdService.get_school_list(pMap);
		
		ModelAndView mav = new ModelAndView("admin/school");
		mav.addObject("school_list", list);
	
		
		return mav;

	}
	
	//자전거관리-관리자용 화면
	@RequestMapping(value="/get_bike_list.do")
	public ModelAndView get_bike_list(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {

		List<Object> list = null;

		list = cmdService.get_bike_list_admin(pMap);
		
		ModelAndView mav = new ModelAndView("admin/bike");
		mav.addObject("bike_list", list);
	
		
		return mav;

	}
	
	
	//자전거관리-관리자용 화면
	@RequestMapping(value="/get_money_list.do")
	public ModelAndView get_money_list(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {

		List<Object> list = null;

		list = cmdService.get_money_list(pMap);
		
		ModelAndView mav = new ModelAndView("admin/money");
		mav.addObject("list", list);
	
		
		return mav;

	}
	
	//자전거관리-회원용 화면
	@RequestMapping(value="/get_bike_list_member.do")
	public ModelAndView get_bike_list_member(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {

		List<Object> list = null;

		list = cmdService.get_bike_list(pMap);
		
		ModelAndView mav = new ModelAndView("main/bike");
		mav.addObject("bike_list", list);
	
		
		return mav;

	}
	
	

	
		
	
	//아이디 중복체크
	@RequestMapping(value="/eqChk.do")
	public ModelAndView eqChk(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {

		ModelAndView output = new ModelAndView();
 		Map<String, Object> rMap = new HashMap<String, Object>();
		String eqChk = null;
		
 		try {
 			
 			eqChk = this.cmdService.eqChk(pMap);
 			
 		} catch (Exception e) {
 			throw new Exception(e.toString());
 		}
 		
 		rMap.put("eqChk", eqChk);
 		output.addAllObjects(rMap);
 		output.setViewName("jsonView");

 		return output;
	

	}
	
	// 회원가입
	 	@RequestMapping(value = "/insertMember_join.do")
	 	public ModelAndView insertMember_join(HttpServletRequest req, HttpServletResponse res,
	 			@RequestParam Map<String, Object> pMap) throws Exception {
	 		
	 		ModelAndView output = new ModelAndView();
	 		Map<String, Object> rMap = new HashMap<String, Object>();
	 		String member_join_chk = null;
	 		
	 		try {
	 			
	 			member_join_chk = this.cmdService.insertMember_join(pMap);
	 			
	 		} catch (Exception e) {
	 			throw new Exception(e.toString());
	 		}

	 		rMap.put("member_join_chk", member_join_chk);
	 		output.addAllObjects(rMap);
	 		output.setViewName("jsonView");

	 		return output;

	 	}
	    
		// 로그인
		@RequestMapping(value = "/doMember_login.do")
		public ModelAndView doMember_login(HttpServletRequest req, HttpServletResponse res,
				@RequestParam Map<String, Object> pMap) throws Exception {

			ModelAndView output = new ModelAndView();
			Map<String, Object> rMap = new HashMap<String, Object>();
			int resultCode = 0;
			String resultMsg = "";
			try {
			
				CmdVO vo = this.cmdService.getMemberInfo(pMap);
			
				if (vo == null) {
					
					resultMsg = "ID 또는 비밀번호가 틀렸습니다.";
					resultCode = 0;
				} else{
				
					resultMsg = "로그인";
					resultCode = 1;
					HttpSession session = req.getSession(true);
					
					String member_id = vo.getMember_id();
					
					
				
					rMap.put("member_id", member_id);
					rMap.put("nm",  vo.getNm());
					rMap.put("hp", vo.getHp());
					rMap.put("password", vo.getPassword());
					rMap.put("email", vo.getEmail());
					rMap.put("money", vo.getMoney());
					rMap.put("bike_no", vo.getBike_no());
					rMap.put("member_no", vo.getMember_no());
					
				
					session.setAttribute("sessionData", rMap);
					
					session.setAttribute("member_id", member_id);
					
					
				}
		
				rMap.put("resultCode", resultCode);
				rMap.put("resultMsg", resultMsg);

			} catch (Exception e) {
				throw new Exception(e.toString());
			}

			output.addAllObjects(rMap);
			output.setViewName("jsonView");

			return output;

		}
		
		 // 학번등록
		@RequestMapping(value = "/insert_school.do")
		public ModelAndView insert_school(HttpServletRequest req, HttpServletResponse res,
				@RequestParam Map<String, Object> pMap) throws Exception {
			
			ModelAndView output = new ModelAndView();
			Map<String, Object> rMap = new HashMap<String, Object>();
			int result = 0;
			
			try {
				
				result = this.cmdService.insert_school(pMap);
				
			} catch (Exception e) {
				throw new Exception(e.toString());
			}

			rMap.put("result", result);
			output.addAllObjects(rMap);
			output.setViewName("jsonView");

			return output;

		}
		
		
		 // 금액충전
		@RequestMapping(value = "/insert_money.do")
		public ModelAndView insert_money(HttpServletRequest req, HttpServletResponse res,
				@RequestParam Map<String, Object> pMap) throws Exception {
			
			ModelAndView output = new ModelAndView();
			Map<String, Object> rMap = new HashMap<String, Object>();
			int result = 0;
			
			try {
				
				result = this.cmdService.insert_money(pMap);
				
			} catch (Exception e) {
				throw new Exception(e.toString());
			}

			rMap.put("result", result);
			output.addAllObjects(rMap);
			output.setViewName("jsonView");

			return output;

		}
		
		
		 // 자전거등록
		@RequestMapping(value = "/insert_bike.do")
		public ModelAndView insert_bike(HttpServletRequest req, HttpServletResponse res,
				@RequestParam Map<String, Object> pMap) throws Exception {
			
			ModelAndView output = new ModelAndView();
			Map<String, Object> rMap = new HashMap<String, Object>();
			int result = 0;
			
			try {
				
				result = this.cmdService.insert_bike(pMap);
				
			} catch (Exception e) {
				throw new Exception(e.toString());
			}

			rMap.put("result", result);
			output.addAllObjects(rMap);
			output.setViewName("jsonView");

			return output;

		}
		
		
		 // 포인트충전
		@RequestMapping(value = "/update_money.do")
		public ModelAndView update_money(HttpServletRequest req, HttpServletResponse res,
				@RequestParam Map<String, Object> pMap) throws Exception {
			
			ModelAndView output = new ModelAndView();
			Map<String, Object> rMap = new HashMap<String, Object>();
			int result = 0;
			
			try {
				/*HttpSession session = req.getSession(true);
				Map<String, Object> sessionData = (Map<String, Object>) session.getAttribute("sessionData");

				
				String money = sessionData.get("money").toString();	
				int m = Integer.parseInt(money) + Integer.parseInt(pMap.get("money").toString());
				sessionData.put("money", m+"");
				
				pMap.put("money",m+"");*/
				
				result = this.cmdService.update_money(pMap);
				
				/*session.setAttribute("sessionData", sessionData);*/
				
				
				
			} catch (Exception e) {
				throw new Exception(e.toString());
			}

			
			
			rMap.put("result", result);
			output.addAllObjects(rMap);
			output.setViewName("jsonView");
			
			return output;

		}
		
		
		 // 자전거사용
		@RequestMapping(value = "/use_bike.do")
		public ModelAndView use_bike(HttpServletRequest req, HttpServletResponse res,
				@RequestParam Map<String, Object> pMap) throws Exception {
			
			ModelAndView output = new ModelAndView();
			Map<String, Object> rMap = new HashMap<String, Object>();
			int result = 0;
			HttpSession session = req.getSession(true);
			Map<String, Object> sessionData = (Map<String, Object>) session.getAttribute("sessionData");
			
			try {
				
				if(pMap.get("use_yn").equals("N")){
					sessionData.put("bike_no", "0");
					
					double latitude = Double.parseDouble(pMap.get("latitude").toString());
			
			    	double longitude = Double.parseDouble(pMap.get("longitude").toString());
			    
			    	GpsToAddress gps;
					try {
						gps = new GpsToAddress(latitude, longitude);
						System.out.println(gps);
						pMap.put("addr",gps.getAddress().toString());
						result = this.cmdService.use_bike(pMap);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}else{
					result = this.cmdService.use_bike(pMap);
					if(result != -1){
						sessionData.put("bike_no", pMap.get("bike_no").toString());
					}
				
					
				}
				
				
				if(result != -1){
					sessionData.put("money", result+"");
				}
				
				
				session.setAttribute("sessionData", sessionData);
				
				
			} catch (Exception e) {
				throw new Exception(e.toString());
			}

			
			
			rMap.put("result", result);
			output.addAllObjects(rMap);
			output.setViewName("jsonView");
			
			return output;

		}
		
		 // 자전거정보
			@RequestMapping(value = "/get_bikeInfo.do")
			public ModelAndView get_bikeInfo(HttpServletRequest req, HttpServletResponse res,
					@RequestParam Map<String, Object> pMap) throws Exception {
				
				ModelAndView output = new ModelAndView();
				Map<String, Object> rMap = new HashMap<String, Object>();
				
				try {
					
					CmdVO vo = this.cmdService.get_bikeInfo(pMap);
	
					rMap.put("bikePW", vo.getBikePW());
		

				}catch (Exception e) {
					throw new Exception(e.toString());
				}

				
		
				
				output.addAllObjects(rMap);
				output.setViewName("jsonView");
				
				return output;

			}
	

		
	// 아이디찾기
	@RequestMapping(value = "/findIdEmail.do")
	public ModelAndView findId(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws Exception {

		ModelAndView output = new ModelAndView();

		Map<String, Object> rMap = new HashMap<String, Object>();

		int result = 0;

		try {
			result = this.cmdService.sendEmailId(pMap);
		} catch (Exception e) {
			throw new Exception(e.toString());
		}

		rMap.put("result", result);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}	
		
	
	// 비밀번호찾기
	@RequestMapping(value = "/findPwEmail.do")
	public ModelAndView findPw(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws Exception {

		ModelAndView output = new ModelAndView();

		Map<String, Object> rMap = new HashMap<String, Object>();

		int result = 0;

		try {
			result = this.cmdService.sendEmailPw(pMap);
		} catch (Exception e) {
			throw new Exception(e.toString());
		}

		rMap.put("result", result);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}	
	//로그아웃
	@RequestMapping("/logout.do")
	public void logout(HttpServletRequest req, HttpServletResponse res) throws Exception {

		//ModelAndView output = new ModelAndView();
		//ModelAndView mav = new ModelAndView("main/main");
		try {
			HttpSession session = req.getSession(true);
			Map<String, Object> sessionData = (Map<String, Object>) session.getAttribute("sessionData");

			if (sessionData != null) {
				session.removeAttribute("sessionData");
				session.invalidate();
				session = req.getSession(true);		
			}
			String cp = req.getContextPath();
			res.sendRedirect(cp + "/cmd/main.do");
		} catch (Exception e) {
			throw new Exception(e.toString());
		}

		
		
		//return output;
	}
	
	
	
	 //회원정보수정
	@RequestMapping(value = "/update_member.do")
	public ModelAndView update_member(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws Exception {
		
		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		int result = 0;
		
		try {
			HttpSession session = req.getSession(true);

			
			result = this.cmdService.update_member(pMap);
			

			session.setAttribute("sessionData", pMap);
			
			
		} catch (Exception e) {
			throw new Exception(e.toString());
		}

		
		
		rMap.put("result", result);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");
		
		return output;

	}
	
	
	
	//문의게시판-회원용 화면
	
	@RequestMapping(value="/board.do")
	public ModelAndView board(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
		List<Object> list = null;
		list = cmdService.get_board_list(pMap);
		ModelAndView mav = new ModelAndView("board/board");
		mav.addObject("board_list", list);
	
		mav.addObject("dataCnt", list.size());
		
		return mav;
		
		
	}
	
	
	//문의게시판-관리자용 화면
	
	@RequestMapping(value="/board_admin.do")
	public ModelAndView board_admin(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
		List<Object> list = null;
		list = cmdService.get_board_list(pMap);
		ModelAndView mav = new ModelAndView("admin/board");
		mav.addObject("board_list", list);
	
		mav.addObject("dataCnt", list.size());
		
		return mav;
		
		
	}
	
	
	
	
	//맛집-관리자용 화면
	
	@RequestMapping(value="/store_admin.do")
	public ModelAndView store_admin(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
		List<Object> list = null;
		list = cmdService.get_board_list(pMap);
		ModelAndView mav = new ModelAndView("admin/company");
		mav.addObject("board_list", list);
	
		mav.addObject("dataCnt", list.size());
		
		return mav;
		
		
	}
	
	
	//위험지역-관리자용 화면
	
	@RequestMapping(value="/danger_admin.do")
	public ModelAndView danger_admin(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
		List<Object> list = null;
		list = cmdService.get_board_list(pMap);
		ModelAndView mav = new ModelAndView("admin/danger");
		mav.addObject("board_list", list);
	
		mav.addObject("dataCnt", list.size());
		
		return mav;
		
		
	}

	
	//글쓰기페이지 호출
	@RequestMapping(value="/get_write.do")
	public ModelAndView get_write(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap){
		
		
		ModelAndView mav = new ModelAndView("board/write");
		
		
		return mav;
		
		
	}
	
	
	
	//글상세보기-관리자
	@RequestMapping(value="/get_article_admin.do")
	public ModelAndView get_article_admin(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap){
		ModelAndView mav = new ModelAndView("admin/article");
		List<Object> list = null;
		CmdVO vo = null;
		vo = (CmdVO)cmdService.get_article(pMap);
		mav.addObject("article", vo);
		list = cmdService.get_answer(pMap);
		mav.addObject("answer", list);

		return mav;
		
		
	}
	
	//글수정페이지 호출
	@RequestMapping(value="/get_update.do")
	public ModelAndView get_update(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap){
		
		
		CmdVO vo = null;
		vo = (CmdVO)cmdService.get_article(pMap);
		ModelAndView mav = new ModelAndView("board/update");
		mav.addObject("article", vo);
	
	
		return mav;
		
		
	}
	
	//글상세보기
	@RequestMapping(value="/get_article.do")
	public ModelAndView get_article(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap){
		ModelAndView mav = new ModelAndView("board/article");
		List<Object> list = null;
		CmdVO vo = null;
		vo = (CmdVO)cmdService.get_article(pMap);
		mav.addObject("article", vo);
		list = cmdService.get_answer(pMap);
		mav.addObject("answer", list);

		return mav;
		
		
	}

    
   
 	//글등록
 	@RequestMapping(value = "/insert_board.do")
 	public ModelAndView insert_board(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
 		
 		ModelAndView output = new ModelAndView();
 		Map<String, Object> rMap = new HashMap<String, Object>();
 		int result = 0;
 		
 		try {
 			
 			result = this.cmdService.insert_board(pMap);
 			
 		} catch (Exception e) {
 			throw new Exception(e.toString());
 		}
 		String result_code = "0";
 		if(result == 1){
 			result_code = "1";
 		}
 		rMap.put("result_code", result_code);
 		output.addAllObjects(rMap);
 		output.setViewName("jsonView");

 		return output;

 	}
 	
 	//글수정
 	@RequestMapping(value = "/update_board.do")
 	public ModelAndView update_board(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
 		
 		ModelAndView output = new ModelAndView();
 		Map<String, Object> rMap = new HashMap<String, Object>();
 		int result = 0;
 		
 		try {
 			
 			result = this.cmdService.update_board(pMap);
 			
 		} catch (Exception e) {
 			throw new Exception(e.toString());
 		}
 		String result_code = "0";
 		if(result == 1){
 			result_code = "1";
 		}
 		rMap.put("result_code", result_code);
 		output.addAllObjects(rMap);
 		output.setViewName("jsonView");

 		return output;

 	}
 	
 	//글삭제
 	@RequestMapping(value = "/delete_board.do")
 	public ModelAndView delete_board(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
 		
 		ModelAndView output = new ModelAndView();
 		Map<String, Object> rMap = new HashMap<String, Object>();
 		int result = 0;
 		
 		try {
 			
 			result = this.cmdService.delete_board(pMap);
 			
 		} catch (Exception e) {
 			throw new Exception(e.toString());
 		}
 		
 		String result_code = "0";
 		if(result == 1){
 			result_code = "1";
 		}
 		rMap.put("result_code", result_code);
 		output.addAllObjects(rMap);
 		output.setViewName("jsonView");

 		return output;

 	}
 	
 	//답변등록
 	@RequestMapping(value = "/insert_answer.do")
 	public ModelAndView insert_answer(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
 		
 		ModelAndView output = new ModelAndView();
 		Map<String, Object> rMap = new HashMap<String, Object>();
 		int result = 0;
 		
 		try {
 			
 			result = this.cmdService.insert_answer(pMap);
 			
 		} catch (Exception e) {
 			throw new Exception(e.toString());
 		}
 		String result_code = "0";
 		if(result == 1){
 			result_code = "1";
 		}
 		rMap.put("result_code", result_code);
 		output.addAllObjects(rMap);
 		output.setViewName("jsonView");

 		return output;

 	}
 	
 	
 	//답변삭제
 	@RequestMapping(value = "/delete_answer.do")
 	public ModelAndView delete_answer(HttpServletRequest req, HttpServletResponse res,
 			@RequestParam Map<String, Object> pMap) throws Exception {
 		
 		ModelAndView output = new ModelAndView();
 		Map<String, Object> rMap = new HashMap<String, Object>();
 		int result = 0;
 		
 		try {
 			
 			result = this.cmdService.delete_answer(pMap);
 			
 		} catch (Exception e) {
 			throw new Exception(e.toString());
 		}
 		String result_code = "0";
 		if(result == 1){
 			result_code = "1";
 		}
 		rMap.put("result_code", result_code);
 		output.addAllObjects(rMap);
 		output.setViewName("jsonView");

 		return output;

 	}
	
	


}

