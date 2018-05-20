package cmd.service;

import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import cmd.vo.CmdVO;
import helper.util.MyMailSender;
import cmd.vo.MailInfoVO;
import helper.dao.CommonDAO;
import net.sf.json.JSONObject;




@Service("cmdService")
public class CmdServiceImpl implements CmdService
{
	private final static Log logger = LogFactory.getLog(CmdServiceImpl.class);
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;


	@Override
	public String insertMember_join(Map<String, Object> pMap) throws Exception {
	
	    int chk = 0; 
	    String member_chk = "";
		try {
		
				chk =  this.commonDao.insertData("cmd.insertMember_join", pMap);
			
		
		} catch (Exception e) {
			
			logger.debug(e.toString());
			throw e;
		}
		
		if(chk==0){
			member_chk = "0";
		}else if(chk==9){
			member_chk = "9";
		}else{
			member_chk = "1";
		}

		return member_chk;
	
	}
	
	
	@Override
	public String eqChk(Map<String, Object> pMap) throws Exception {
	
	    int chk = 0; 
	    String eqChk = "";
		try {
			String tmp = (String)this.commonDao.getReadData("cmd.eqChk", pMap);
			
			if(tmp != null && !tmp.equals(null)){
				eqChk = "9";
			}else{
				eqChk = "1";
			}
		
			
			
		} catch (Exception e) {
			
			logger.debug(e.toString());
			throw e;
		}
		
		
		return eqChk;
	
	}
	
	
	@Override
    public CmdVO getMemberInfo( Map<String, Object> pMap ) {
		CmdVO vo = null;
    	
        try {
			vo = (CmdVO)this.commonDao.getReadData("cmd.getMemberInfo", pMap);
		} catch (Exception e) {
			logger.debug(e.toString());
		}
        
        return vo;
    }



	@Override
	public List<Object> get_school_list(Map<String, Object> pMap) {
		
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.get_school_list", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	@Override
	public List<Object> get_bike_list(Map<String, Object> pMap) {
		
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.get_bike_list_admin", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	@Override
	public List<Object> get_bike_list_admin(Map<String, Object> pMap) {
		
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.get_bike_list_admin", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<Object> get_money_list(Map<String, Object> pMap) {
		
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.get_money_list", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public int insert_school(Map<String, Object> pMap) {
		
		int result = 0;
		
		try {

			result = this.commonDao.insertData("cmd.insert_school",pMap);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public int insert_money(Map<String, Object> pMap) {
		
		int result = 0;
		
		try {

			result = this.commonDao.insertData("cmd.insert_money",pMap);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	@Override
	public int insert_bike(Map<String, Object> pMap) {
		
		int result = 0;
		
		try {

			result = this.commonDao.insertData("cmd.insert_bike",pMap);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	@Override
	public int update_money(Map<String, Object> pMap) {
		
		int result = 0;
		String m = "";
		try {
			this.commonDao.insertData("cmd.delete_money",pMap);
			
			m = (String) this.commonDao.getReadData("cmd.select_money",pMap);
			if(!m.equals(null)){
				pMap.put("money",Integer.parseInt(pMap.get("money").toString())+Integer.parseInt(m)) ;
			}
			
			result = this.commonDao.insertData("cmd.update_money",pMap);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public int update_member(Map<String, Object> pMap) {
		
		int result = 0;
		
		try {
			result = this.commonDao.insertData("cmd.update_member",pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	@Override
	public int use_bike(Map<String, Object> pMap) {
		
		int result = 0;
		int money = 0;
		int price = Integer.parseInt(pMap.get("price").toString());
		String use_yn = pMap.get("use_yn").toString();
		
		CmdVO vo = null;
		try {
			if(use_yn.equals("Y")){
				vo = (CmdVO)this.commonDao.getReadData("cmd.getMemberInfo", pMap);
				money = Integer.parseInt(vo.getMoney());
				
				if(money >= price){
					
					price = money - price;
					
					pMap.put("money",price);
					
					result = this.commonDao.insertData("cmd.use_bike",pMap);	
					result = price;
					
				}else{
					result = -1;
				}
			}else{
				vo = (CmdVO)this.commonDao.getReadData("cmd.getMemberInfo", pMap);
				money = Integer.parseInt(vo.getMoney());
				pMap.put("money",money);
				result = this.commonDao.insertData("cmd.update_bike",pMap);
				pMap.put("bike_no","0");
				result = this.commonDao.insertData("cmd.use_bike",pMap);
				result = money;
			}
		
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@Override
    public CmdVO get_bikeInfo( Map<String, Object> pMap ) {
		CmdVO vo = null;
    	
        try {
			vo = (CmdVO)this.commonDao.getReadData("cmd.get_bikeInfo", pMap);
		} catch (Exception e) {
			logger.debug(e.toString());
		}
        
        return vo;
    }
	
	
   
	
	
	
	@Override
	public int sendEmailId(Map<String, Object> pMap) {
	
		int result = 0;
		String member_id="";
		try{
			member_id = (String) this.commonDao.getReadData("cmd.getFindId",pMap);
			pMap.put("member_id",member_id);
			MailInfoVO mailInfo = new MailInfoVO();
			String content = "<div style='width:700px; margin:0 auto; text-align:center; padding:.3em; border:solid #d7d7d7 1px; background-color:#fff; font-size:12px; line-height:20px;'>"
					+ "<div style='text-align:left; padding:0 1.5em;'><p style='margin:2em 0 0 0;'>안녕하세요. 자전거 앱 입니다.</p><p style='margin:0 0 2em 0;'>저희'자전거' 어플을 이용해 주셔서 감사드립니다.</p>"
					+ "<p style='margin:0 0 3em 0;'><span style='color:#21b4d6; font-size:14px; font-weight:bold;'>"
					+ "</span> 고객님의아이디는 다음과 같습니다.</p>"
					+ "</div><div style='text-align:left; padding:0 1.5em;'>"
		            + "<p style='margin-top:1em;'><span style='border:solid #21b4d6 1px; background-color:#21b4d6; color:#fff; font-weight:bold; padding:.5em 1.5em;'>아이디</span><!--"
		            +  "--><span style='border:solid #d7d7d7 1px; padding:.5em 1.5em;'>"
		            +   pMap.get("member_id").toString()
		            + "</span>"
			        + "</p></div>"
			        + "</div>";
			//mailInfo.setReceiverEmail(pMap.get("member_id").toString());

			
			mailInfo.setReceiverEmail(pMap.get("email").toString());
			mailInfo.setSenderEmail("rlatmdgks1006@gmail.com");
			mailInfo.setSenderName("자전거앱");
			mailInfo.setSubject("자전거 앱 아이디입니다.");
			mailInfo.setContent(content);
			
			MyMailSender mail = new MyMailSender();
			 
			mail.mailSend(mailInfo);
			
		}catch(Exception e){
			logger.debug(e.toString());
		}
		
		return result;
	}
	
	
	@Override
	public int sendEmailPw(Map<String, Object> pMap) {
		int result = 0;
		String pw="";
		try{
			pw = (String) this.commonDao.getReadData("cmd.getFindPw",pMap);
			
			pMap.put("password",pw);
			
			MailInfoVO mailInfo = new MailInfoVO();
			String content = "<div style='width:700px; margin:0 auto; text-align:center; padding:.3em; border:solid #d7d7d7 1px; background-color:#fff; font-size:12px; line-height:20px;'>"	
					+ "<div style='text-align:left; padding:0 1.5em;'><p style='margin:2em 0 0 0;'>안녕하세요. 자전거 앱 입니다.</p><p style='margin:0 0 2em 0;'>저희'자전거' 어플을 이용해 주셔서 감사드립니다.</p>"
					+ "<p style='margin:0 0 3em 0;'><span style='color:#21b4d6; font-size:14px; font-weight:bold;'>"
					+ "</span> 고객님의 비밀번호는 다음과 같습니다.</p>"
					+ "</div><div style='text-align:left; padding:0 1.5em;'>"
		            + "<p style='margin-top:1em;'><span style='border:solid #21b4d6 1px; background-color:#21b4d6; color:#fff; font-weight:bold; padding:.5em 1.5em;'>아이디</span><!--"
		            +  "--><span style='border:solid #d7d7d7 1px; padding:.5em 1.5em;'>"
		            +  pMap.get("member_id").toString()
		            + "</span><!--"
					+  "--><span style='border:solid #21b4d6 1px; background-color:#21b4d6; color:#fff; font-weight:bold; padding:.5em 1.5em;'>비밀번호</span><!--"
			        +  "--><span style='border:solid #d7d7d7 1px; padding:.5em 1.5em;'>"
			        +  pMap.get("password").toString()
			        + "</span></p></div>"
			        + "</div>";
			//mailInfo.setReceiverEmail(pMap.get("member_id").toString());

			
			mailInfo.setReceiverEmail(pMap.get("email").toString());
			mailInfo.setSenderEmail("rlatmdgks1006@gmail.com");
			mailInfo.setSenderName("자전거앱");
			mailInfo.setSubject("자전거 앱 비밀번호입니다.");
			mailInfo.setContent(content);
			
			MyMailSender mail = new MyMailSender();
			mail.mailSend(mailInfo);
			
		}catch(Exception e){
			logger.debug(e.toString());
		}
		
		
		
		return result;
	}
	
	

	
	

	@Override
	public List<Object> get_board_list(Map<String, Object> pMap) {
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.get_board_list", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	

	@Override
	public int insert_board(Map<String, Object> pMap) {
		int result = 0;
		
		try {
			result = this.commonDao.insertData("cmd.insert_board",pMap);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int delete_board(Map<String, Object> pMap) {
		int result = 0;
		
		try {
			result = this.commonDao.insertData("cmd.delete_board",pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int update_board(Map<String, Object> pMap) {
		int result = 0;
		
		try {
			result = this.commonDao.insertData("cmd.update_board",pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Object get_article(Map<String, Object> pMap) {
	
		CmdVO vo = null;
		
		try {
			vo = (CmdVO) this.commonDao.getReadData("cmd.get_article", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public List<Object> get_answer(Map<String, Object> pMap) {
		
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.get_answer", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	
	@Override
	public int insert_answer(Map<String, Object> pMap) {
		int result = 0;
		
		try {
			result = this.commonDao.insertData("cmd.insert_answer",pMap);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int delete_answer(Map<String, Object> pMap) {
		int result = 0;
		
		try {
			result = this.commonDao.insertData("cmd.delete_answer",pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}	
	




}//end class

