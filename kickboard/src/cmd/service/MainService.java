package cmd.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cmd.vo.CompanyVO;

public interface MainService {
	
	public String check_admin(Map<String, Object> map);
	
	public void insertCompanny(Map<String, Object> map);
	
	public void updateCompany(Map<String, Object> map);
	
	// ★★★ 리스트 불러오기 메소드 ★★★
	public List<Object> selectAll_list(Map<String, Object> map);
	
	public List<Object> selectMy_list(Map<String, Object> map);
	
	public Object selectC_no(Map<String, Object> map);
	
	// ★★★ 내 주변 리스트 불러오기 메소드 ★★★
	public ArrayList<CompanyVO> selectMyPosition_list(Map<String, Object> map);
	
	// ★★★ 내 주변 위험지역 리스트 불러오기 메소드 ★★★
	public ArrayList<CompanyVO> selectMyPosition_dangerlist(Map<String, Object> map);
	
	public String selectOutChk(Map<String, Object> map);
	public void insertDangerArea(Map<String, Object> map);
	
	public List<Object> select_MyDangerAreaList(Map<String, Object> map);
	
	public void deleteDangerArea(Map<String, Object> map);
	
	public void deleteCompany(Map<String, Object> map);
	
}
