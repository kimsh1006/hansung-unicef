package cmd.service;

import java.util.List;
import java.util.Map;

import cmd.vo.CmdVO;

public interface CmdService {
	
	public String insertMember_join(Map<String, Object> pMap) throws Exception;
	public String eqChk(Map<String, Object> pMap) throws Exception;
    public CmdVO getMemberInfo( Map<String, Object> pMap );
    public List<Object> get_school_list(Map<String, Object> pMap);
    public int insert_school(Map<String, Object> pMap);
    public int insert_money(Map<String, Object> pMap);
    public List<Object> get_bike_list(Map<String, Object> pMap);
    public List<Object>  get_bike_list_admin(Map<String, Object> pMap);
   
    public List<Object> get_money_list(Map<String, Object> pMap);
    public int insert_bike(Map<String, Object> pMap);
    public int update_money(Map<String, Object> pMap);
    public int update_member(Map<String, Object> pMap);
    public int use_bike(Map<String, Object> pMap);
    public CmdVO get_bikeInfo( Map<String, Object> pMap );
    public int sendEmailId(Map<String, Object> pMap);
    public int sendEmailPw(Map<String, Object> pMap);
    
    public List<Object> get_board_list(Map<String, Object> pMap);


	
	public int insert_board(Map<String, Object> pMap);
	public int delete_board(Map<String, Object> pMap);
	public int update_board(Map<String, Object> pMap);
	public int insert_answer(Map<String, Object> pMap);
	public int delete_answer(Map<String, Object> pMap);
	
	public Object get_article(Map<String, Object> pMap);
	public List<Object> get_answer(Map<String, Object> pMap);

    
 
}


