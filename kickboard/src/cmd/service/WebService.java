package cmd.service;

import java.util.List;
import java.util.Map;

public interface WebService {

	public List<Object> selectAll_list(Map<String, Object> map);
	
	public List<Object> select_AllDangerAreaList(Map<String, Object> map);
}
