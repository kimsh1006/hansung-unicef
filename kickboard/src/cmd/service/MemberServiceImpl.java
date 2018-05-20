package cmd.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmd.vo.MemberVO;
import helper.dao.CommonDAO;
import cmd.service.MemberService;

@Service("member.MemberService")
public class MemberServiceImpl implements MemberService {
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;
	
	@Override
	public Object member_id_check(Map<String, Object> map) {
		// TODO Auto-generated method stub
		MemberVO memberVo = null;
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		try {
			memberVo = (MemberVO) this.commonDao.getReadData("member.member_id_check", map);
			
			if(memberVo == null){
				rMap.put("member_id_check", "yes");
			} else {
				rMap.put("member_id_check", "no");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rMap;
	}

	@Override
	public void insert_member(MemberVO memberVo) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.insertData("member.insert_member", memberVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Object login_check(Map<String, Object> map) {
		// TODO Auto-generated method stub
		MemberVO memberVO = null;
		
		try {
			memberVO = (MemberVO) this.commonDao.getReadData("member.login_check", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return memberVO;
	}



}
