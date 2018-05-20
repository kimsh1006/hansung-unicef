package cmd.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cmd.service.MainService;
import cmd.vo.CompanyVO;

@Controller
@RequestMapping(value="/main")
public class MainController {
	
	@Resource(name="main.MainService")
	private MainService mainService;
	
	//메인 페이지 이동
	@RequestMapping(value="/main.do")
	public ModelAndView mainWeb(){
		ModelAndView mav = new ModelAndView("main/main");
		return mav;
	}
	
	//주변 리스트 페이지 이동
	@RequestMapping(value="/move_list.do")
	public ModelAndView listWeb(@RequestParam Map<String, Object> map){
		ArrayList<CompanyVO> companyList = new ArrayList<CompanyVO>();
		companyList = mainService.selectMyPosition_list(map);
		ModelAndView mav = new ModelAndView("main/list");
		mav.addObject("latitude", map.get("latitude"));
		mav.addObject("longitude", map.get("longitude"));
		mav.addObject("companyList", companyList);
		return mav;
	}
	
	//위험지역 페이지 이동
	@RequestMapping(value="/dangerArea.do")
	public ModelAndView dangerArea(){
		ModelAndView mav = new ModelAndView("main/dangerArea");
		return mav;
	}
	
	//위험지역 check
	@RequestMapping(value="/dangerArea_check.do")
	public ModelAndView dangerArea_check(@RequestParam Map<String, Object> map){
		ArrayList<CompanyVO> dangerAreaList = new ArrayList<CompanyVO>();
		dangerAreaList = mainService.selectMyPosition_dangerlist(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("dangerAreaList", dangerAreaList);
		return mav;
	}
	
	//관리자 페이지 이동
	@RequestMapping(value="/admin_login.do")
	public ModelAndView adminLoginWeb_move(){
		ModelAndView mav = new ModelAndView("main/admin_cagegory");
		return mav;
	}
	
	
	//5km 밖 확인
	@RequestMapping(value="/selectOutChk.do")
	public ModelAndView selectOutChk(@RequestParam Map<String, Object> map){
		String check = mainService.selectOutChk(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("check", check);
		return mav;
	}
	
	//관리자 로그인
	@RequestMapping(value="/adminLogin.do")
	public ModelAndView adminLogin(@RequestParam Map<String, Object> map){
		String check = mainService.check_admin(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("check", check);
		return mav;
	}
	
	//관리자 업체 관리 adminCompany
	@RequestMapping(value="/adminCompany.do")
	public ModelAndView adminCompany(){
		ModelAndView mav = new ModelAndView("main/companyAdd");
		return mav;
	}
	
	//관리자 업체 관리 modifyCompany
	@RequestMapping(value="/modify_companyMove.do")
	public ModelAndView modify_companyMove(@RequestParam Map<String, Object> map){
		List<Object> companyList = null;
		companyList = mainService.selectMy_list(map);
		ModelAndView mav = new ModelAndView("main/companyModify");
		mav.addObject("companyList", companyList);
		mav.addObject("search_c_name", map.get("search_c_name"));
		return mav;
	}
	
	//관리자 업체 관리 deleteCompany
	@RequestMapping(value="/delete_company_Move.do")
	public ModelAndView delete_company_Move(@RequestParam Map<String, Object> map){
		List<Object> companyList = null;
		companyList = mainService.selectMy_list(map);
		ModelAndView mav = new ModelAndView("main/companyDelete");
		mav.addObject("companyList", companyList);
		return mav;
	}
	
	//업체 등록
	@RequestMapping(value="/addCompany_form.do")
	public ModelAndView addCompany_form(@RequestParam Map<String, Object> map){
		mainService.insertCompanny(map);
		ModelAndView mav = new ModelAndView("admin/company");
		mav.addObject("return_value", "addOk");
		return mav;
	}
	
	//위험지역 등록
	@RequestMapping(value="/addDangerArea.do")
	public ModelAndView addDangerArea(@RequestParam Map<String, Object> map){
		mainService.insertDangerArea(map);
		ModelAndView mav = new ModelAndView("admin/danger");
		mav.addObject("return_value", "addOk");
		return mav;
	}
	
	//업체 수정
	@RequestMapping(value="/modifyCompany_form.do")
	public ModelAndView modifyCompany_form(@RequestParam Map<String, Object> map){
		mainService.updateCompany(map);
		ModelAndView mav = new ModelAndView("redirect:/main/modify_companyMove.do?member_no="+map.get("member_no"));
		return mav;
	}
	
	//업체 삭제
	@RequestMapping(value="/companyDelete.do")
	public ModelAndView companyDelete(@RequestParam Map<String, Object> map){
		mainService.deleteCompany(map);
		ModelAndView mav = new ModelAndView("redirect:/main/delete_company_Move.do?member_no="+map.get("member_no"));
		return mav;
	}
	
	// ★★★★★ 리스트 불러오기 ★★★★★
	@RequestMapping(value="/selectAll_list.do")
	public ModelAndView selectAll_list(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView("");
		return mav;
	}
	
	// 업체번호로 정보 불러오기 c_noInformation.do
	@RequestMapping(value="/c_noInformation.do")
	public ModelAndView c_noInformation(@RequestParam Map<String, Object> map){
		CompanyVO companyVo = null;
		companyVo = (CompanyVO) mainService.selectC_no(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("companyVo", companyVo);
		return mav;
	}
	
	// 업체 상세 페이지 이동
	@RequestMapping(value="/details.do")
	public ModelAndView details(@RequestParam Map<String, Object> map){
		CompanyVO companyVo = null;
		companyVo = (CompanyVO) mainService.selectC_no(map);
		ModelAndView mav = new ModelAndView("main/details");
		mav.addObject("companyVo", companyVo);
		return mav;
	}
	
	//위험지역 관리자 페이지 이동 (등록)
	@RequestMapping(value="/adminDangerAreaAdd.do")
	public ModelAndView adminDangerArea(){
		ModelAndView mav = new ModelAndView("main/adminDangerAreaAdd");
		return mav;
	}
	
	//위험지역 관리자 페이지 이동 (삭제)
	@RequestMapping(value="/adminDangerAreaDelete.do")
	public ModelAndView adminDangerAreaDelete(@RequestParam Map<String, Object> map){
		List<Object> resultList = mainService.select_MyDangerAreaList(map);
		ModelAndView mav = new ModelAndView("main/adminDangerAreaDelete");
		mav.addObject("dangerArea_list", resultList);
		return mav;
	}
	
	//위험지역 삭제
	@RequestMapping(value="/dangerArea_delete.do")
	public ModelAndView dangerArea_delete(@RequestParam Map<String, Object> map){
		mainService.deleteDangerArea(map);
		ModelAndView mav = new ModelAndView("redirect:/main/adminDangerAreaDelete.do?member_no="+map.get("member_no"));
		return mav;
	}
	
}
