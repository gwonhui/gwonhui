package dao;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class VisitDao implements HttpSessionListener {
	private static int totalCount;
	private static int accessCount; // 접속한 사용자수
	
	public static Map<String, Integer> getAccessCount() {
		Map<String, Integer> map = new HashMap<>();
		map.put("totalCount", totalCount);
		map.put("accessCount", accessCount);
		return map;
		
	}
	
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		// 세션이 최초로 생성됐을때.(웹프로그램에 접속했을때)
		HttpSession session = event.getSession();
		session.setMaxInactiveInterval(300); // 초단위
		
		totalCount++;
		System.out.println("VisitDao sessionCreated totalCount: " + totalCount + "\n");
		accessCount++;
		System.out.println("VisitDao sessionCreated accessCount: " + accessCount + "\n");
		
		// 애플리케이션 영역객체 가져오기
		ServletContext application = session.getServletContext();
//		Integer loginCount = (Integer) application.getAttribute("loginCount");
//		if (loginCount == null) {
//			application.setAttribute("loginCount", 0);
//		}
		
		// 로그인 아이디 저장할 컬렉션 객체 준비
		Set<String> set = (Set) application.getAttribute("idsSet");
		if (set == null) {
			application.setAttribute("idsSet", new HashSet<String>());
		}
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		// 세션이 제거되기 직전에(sesssion객체가 살아있음)
		// sessionDestroyed() 호출 이후 session이 제거됨.
		HttpSession session = event.getSession();
		
		
		accessCount--;
		if (accessCount < 0) {
			accessCount = 0;
		}
		System.out.println("VisitDao sessionDestroyed accessCount: " + accessCount);
		
		long interval = System.currentTimeMillis() - session.getCreationTime();
		interval = interval / 1000 / 60; // 밀리초를 분 단위로 변환
		
		String id = (String) session.getAttribute("id");
		
		ServletContext application = session.getServletContext();
		Set<String> set = (Set) application.getAttribute("idsSet");
		set.remove(id);
	}

}





