package cmd.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import helper.dao.CommonDAO;
import cmd.service.MainService;
import cmd.vo.CompanyVO;

@Service("main.MainService")
public class MainServiceImpl implements MainService {

	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@SuppressWarnings("unchecked")
	@Override
	public String check_admin(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Map<String, Object> return_map = new HashMap<String, Object>();
		String check = "";
		
		try {
			return_map = (Map<String, Object>) this.commonDao.getReadData("main.admin_check", map);
			
			if(return_map == null){
				check = "no";
			} else {
				check = "yes";
			}
						
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return check;
	}

	@Override
	public void insertCompanny(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		try {
			this.commonDao.insertData("main.addCompany", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

	@Override
	public void updateCompany(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		try {
			this.commonDao.updateData("main.updateCompany", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Object> selectAll_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Object> resultList = null;
		
		try {
			resultList = this.commonDao.getListData("main.selectMy_list", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultList;
	}
	
	@Override
	public List<Object> selectMy_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Object> resultList = null;
		
		try {
			resultList = this.commonDao.getListData("main.selectMy_list", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultList;
	}

	@Override
	public Object selectC_no(Map<String, Object> map) {
		// TODO Auto-generated method stub
		CompanyVO companyVo = null;
		
		try {
			companyVo = (CompanyVO) this.commonDao.getReadData("main.selectC_no_details", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return companyVo;
	}

	@Override
	public ArrayList<CompanyVO> selectMyPosition_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		ArrayList<CompanyVO> result_list = new ArrayList<CompanyVO>();
		
		try {
			List<Object> all_list = this.commonDao.getListData("main.selectAll_list", map);
			
			Iterator<Object> it = all_list.iterator();			
			CompanyVO cVo = new CompanyVO();
			
			while (it.hasNext()){
				cVo = (CompanyVO) it.next();
				double resultDis = calDistance((String)map.get("latitude"), (String)map.get("longitude"), cVo.getC_latitude(), cVo.getC_longitude());
				
				//범위계산
				double getAdius = 10000;
				//double getAdius = 1000000000;
				if (resultDis < getAdius){
					String distance = Double.toString(Math.round((resultDis/1000)*100d) / 100d);
					cVo.setDistance(distance);
					result_list.add(cVo);
				}
				
			}
			
			Collections.sort(result_list, new Comparator<CompanyVO>() {

				@Override
				public int compare(CompanyVO ojb1, CompanyVO ojb2) {
					// TODO Auto-generated method stub
//					return ojb1.getDistance().compareTo(ojb2.getDistance());
					return Double.compare(Float.parseFloat(ojb1.getDistance()), Float.parseFloat(ojb2.getDistance()));
				}
			});
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result_list;
	}
	
	//5km 밖인지 체크
	@Override
	public String selectOutChk(Map<String, Object> map) {
		// TODO Auto-generated method stub 
		double resultDis = calDistance((String)map.get("latitude"), (String)map.get("longitude"), "37.5817849", "127.01036899999997");
		//범위계산
		double getAdius = 5000;
		String result = "IN";
		if (resultDis > getAdius){
			 result = "OUT";
		}
		
		
		return result;
	}
	
	
	//
	@Override
	public ArrayList<CompanyVO> selectMyPosition_dangerlist(Map<String, Object> map) {
		// TODO Auto-generated method stub
		ArrayList<CompanyVO> result_list = new ArrayList<CompanyVO>();
		
		try {
			List<Object> all_list = this.commonDao.getListData("main.selectAll_Dangerlist", map);
			
			Iterator<Object> it = all_list.iterator();			
			CompanyVO cVo = new CompanyVO();
			
			while (it.hasNext()){
				cVo = (CompanyVO) it.next();
				double resultDis = calDistance((String)map.get("latitude"), (String)map.get("longitude"), cVo.getD_latitude(), cVo.getD_longitude());
				
				//범위계산
				double getAdius = 999999999;
				
				if (resultDis < getAdius){
					String distance = Double.toString(Math.round((resultDis/1000)*100d) / 100d);
					cVo.setDistance(distance);
					result_list.add(cVo);
				}
				
			}
			
			Collections.sort(result_list, new Comparator<CompanyVO>() {

				@Override
				public int compare(CompanyVO ojb1, CompanyVO ojb2) {
					// TODO Auto-generated method stub
//					return ojb1.getDistance().compareTo(ojb2.getDistance());
					return Double.compare(Float.parseFloat(ojb1.getDistance()), Float.parseFloat(ojb2.getDistance()));
				}
			});
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result_list;
	}
	
	//내 위치 거리 구하기
	public double calDistance(String strLat1, String strLon1, String strLat2, String strLon2){    
		
		double lat1 = Double.parseDouble(strLat1);
		double lon1 = Double.parseDouble(strLon1);
		double lat2 = Double.parseDouble(strLat2);
		double lon2 = Double.parseDouble(strLon2);
	    
	    double theta, dist;  
	    theta = lon1 - lon2;  
	    dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1))   
	          * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));  
	    dist = Math.acos(dist);  
	    dist = rad2deg(dist);
	    dist = dist * 60 * 1.1515;   
	    dist = dist * 1.609344;    // 단위 mile 에서 km 변환.  
	    dist = dist * 1000.0;    // 단위  km 에서 m 로 변환  
	  
	    System.out.println(dist);
	    return dist;  
	    
	} 
	
    // 주어진 도(degree) 값을 라디언으로 변환  
	private double deg2rad(double deg){  
	    return (double)(deg * Math.PI / (double)180d);  
	}  
	  
	// 주어진 라디언(radian) 값을 도(degree) 값으로 변환  
	private double rad2deg(double rad){  
	    return (double)(rad * (double)180d / Math.PI);  
	} 
	

	@Override
	public void insertDangerArea(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		try {
			this.commonDao.insertData("main.insertDangerArea", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Object> select_MyDangerAreaList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Object> resultList = null;
		
		try {
			resultList = this.commonDao.getListData("main.selectMyDangerAreaList", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultList;
	}

	@Override
	public void deleteDangerArea(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.deleteData("main.deleteDangerArea", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void deleteCompany(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.deleteData("main.deleteCompany", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
