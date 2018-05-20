package cmd.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import helper.dao.CommonDAO;
import cmd.service.WebService;

@Service("web.WebService")
public class WebServiceImpl implements WebService {
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public List<Object> selectAll_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Object> resultList = null;
		
		try {
			resultList = this.commonDao.getListData("web.selectAll_list", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultList;
	}

	@Override
	public List<Object> select_AllDangerAreaList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Object> resultList = null;
		
		try {
			resultList = this.commonDao.getListData("web.selectAllDangerAreaList", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultList;
	}

}
