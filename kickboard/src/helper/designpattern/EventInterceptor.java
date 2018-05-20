package helper.designpattern;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;





public class EventInterceptor extends HandlerInterceptorAdapter{

	private final static Log logger = LogFactory.getLog(EventInterceptor.class);
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
/*
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {	
		
		//ModelAndView output = null;
        String combo = request.getParameter("combo");
        
        String uri = request.getRequestURI();
        int i = uri.indexOf("/", uri.indexOf("/")+1) + 1;
        int j = uri.indexOf(".", i+1);
        String method = uri.substring(i, j);
        
        logger.debug("* URI : " + uri);
        
        if((!method.equals("loginInit") && !method.equals("doLogin")  && !method.equals("autoLogin")   && !method.equals("modifyOutUserPswd") 
        		&& !method.equals("doLogout") && !method.equals("sessionCheck")) && !sessionChk(request, response)) {
        	String cp = request.getContextPath();
        	response.sendRedirect(cp+"/login/doLogout.do");
        	return false;
        }
        
      //로그인  사용자 계정의 정보 취득
        Map<String, Object> uMap = new HashMap<String, Object>();
        HttpSession session = request.getSession(true);
        if(session != null) {
        	uMap = (Map<String, Object>)session.getAttribute("sessionData");
        	if(uMap != null) {
        		UserInfoVO user = (UserInfoVO)uMap.get("userInfo");
        		request.setAttribute("user_id", user.getBp_usr_id());
        	}
        }
        
        
        if ("combo".equals(combo))
        {
            //콤보
        	String hiCode = request.getParameter("p_hiCode");
        	String hiName = request.getParameter("p_hiName");
        	String gCode = request.getParameter("p_gCode");
        	String gName = request.getParameter("p_gName");
            String mCode = request.getParameter("p_mCode");
            String mName = request.getParameter("p_mName");
            
            request.setAttribute("hiCode", hiCode);
            request.setAttribute("hiName", hiName);
            request.setAttribute("gCode", gCode);
            request.setAttribute("gName", gName);
            request.setAttribute("mCode", mCode);
            request.setAttribute("mName", mName);
        }
  		
        return true;
	}
*/	
	

	
	
	
}
