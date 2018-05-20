package helper.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository("commonDao")
public class MyBatisDaoImpl implements CommonDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private final static Log logger = LogFactory.getLog(MyBatisDaoImpl.class);
	
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// ******************************************************************
	// 데이터 추가
	@Override
    public int insertData(String id, Object value) throws Exception {
    	int result = 0;
    	
		try {
			result = sqlSession.insert(id, value);
		} catch (Exception e) {
			logger.debug(e.toString());
		} finally {
		}
		return result;
    }
    
	// ******************************************************************
	//데이터 수정
    @Override
	public int updateData(String id) throws Exception {
    	int result = 0;
		
		try {
	   	    result = sqlSession.update(id);
		} catch (Exception e) {
			logger.debug(e.toString());
		}
		
		return result;
	}
    
    @Override
    public int updateData(String id, Object value) throws Exception {
		int result = 0;
		
		try {
	   	    result = sqlSession.update(id, value);
		} catch (Exception e) {
			logger.debug(e.toString());
		}
		
		return result;
    }
    
    @Override
    public int updateData(String id, Map<String, Object> map) throws Exception {
		int result = 0;		
		try {
	   	    result = sqlSession.update(id, map);
		} catch (Exception e) {
			logger.debug(e.toString());
		}		
		return result;
    }
    
	// ******************************************************************
	// 데이터 삭제
    @Override
	public int deleteData(String id, Map<String, Object> map) throws Exception {
		int result = 0;

		try {
			result = sqlSession.delete(id, map);
		} catch (Exception e) {
			logger.debug(e.toString());
		}

		return result;
    }
    
    @Override
	public int deleteData(String id, Object value) throws Exception {
		int result = 0;
		
		try {
			result = sqlSession.delete(id, value);
		} catch (Exception e) {
			logger.debug(e.toString());
		}

		return result;
    }
    
    @Override
	public int deleteAll(String id) throws Exception {
		int result = 0;
		
		try {
	    	result = sqlSession.delete(id);
		} catch (Exception e) {
			logger.debug(e.toString());
		}

		return result;
    }

	// ******************************************************************
	// 레코드 수 / 최대값 구하기
    @Override
	public int getIntValue(String id, Map<String, Object> map) throws Exception {
		int num = 0;
		num = ((Integer)sqlSession.selectOne(id, map)).intValue();
		return num;
    }
    
    @Override
	public int getIntValue(String id, Object value) throws Exception {
		int num = 0;
		num = ((Integer)sqlSession.selectOne(id, value)).intValue();
		return num;
    }
    
    @Override
	public int getIntValue(String id) throws Exception {
		int num = 0;
		num = ((Integer)sqlSession.selectOne(id)).intValue();
		return num;
    }
	
	// ******************************************************************
	// 테이블의 레코드를 리스트에 저장
	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getListData(String id, Map<String, Object> map) throws Exception {
		List<Object> lists = (List<Object>)sqlSession.selectList(id, map);	
		return lists;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getListData(String id, Object value) throws Exception {
		List<Object> lists = (List<Object>)sqlSession.selectList(id, value);	
		return lists;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getListData(String id) throws Exception {
		List<Object> lists = (List<Object>)sqlSession.selectList(id);	
		return lists;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getListData(String id, Map<String, Object> map, RowBounds rowBounds) throws Exception {
		List<Object> lists = (List<Object>)sqlSession.selectList(id, map, rowBounds);	
		return lists;
	}
	
	// ******************************************************************
	// 해당 레코드 가져오기
	@Override
	public Object getReadData(String id) throws Exception {
		return  sqlSession.selectOne(id);
	}
	
	@Override
	public Object getReadData(String id, Object value) throws Exception {
		return  sqlSession.selectOne(id, value);
	}
	
	@Override
	public Object getReadData(String id, Map<String, Object> map) throws Exception {
		return  sqlSession.selectOne(id, map);
	}

	@Override
	public Map<String, Object> getPagingListData(String countQueryId, String listQueryId, Map<String, Object> pMap)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	
}
