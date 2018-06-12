package email;


import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;


public class SimpleEmailExample {

	public static void main(String[] args) {
		// 메일 전송기능 라이브러리 준비
		// CommonsEmail  https://commons.apache.org/proper/commons-email/download_email.cgi
		// JavaMail  https://javaee.github.io/javamail/
		// JAF(java activation framework)
		
		// SimpleEmail 클래스 : 텍스트 전송
		
		// MultiPartEmail 클래스 : 메시지와 파일을 함께 전송
		// EmailAttachment 클래스 : 첨부파일 역할
		
		// HtmlEmail 클래스 : 이메일을 HTML 형식으로 전송
		
		// 이메일 서비스는 메일 전송용 프로토콜인 SMTP를 사용함.
		// SMTP 서버 호스트명(IP주소)
		// SMTP 서버 포트: 기본포트는 465번
		// SMTP 서버 계정정보: 로그인할 아이디,패스워드
		
		// smtp.naver.com
		// smtp.daum.net
		
		// 465
		// 아이디,패스워드
		
		
		long beginTime = System.currentTimeMillis();
		
		// SimpleEmail 객체생성
		SimpleEmail simpleEmail = new SimpleEmail();
		// SMTP 서버 연결설정
		simpleEmail.setHostName("smtp.google.com");
		simpleEmail.setSmtpPort(465);
		simpleEmail.setAuthentication("admiadmi2222", "qawsedrf%"); //비밀번호
		
		// SMTP SSL, TLS 설정
		simpleEmail.setSSLOnConnect(true);
		simpleEmail.setStartTLSEnabled(true);		
		
		String rt = "fail";
		try {
			// 보내는사람 설정
			simpleEmail.setFrom("admiadmi2222@gmail.com", "***", "utf-8");
			// 받는사람 설정
			simpleEmail.addTo("admiadmi2222@gmail.com", "운영진", "utf-8");
			// 받는사람(참조인) 설정
//			simpleEmail.addCc(email, name, charset);
			// 받는사람(숨은참조인) 설정
//			simpleEmail.addBcc(email, name, charset);
			
			// 제목 설정
			simpleEmail.setSubject("메일 제목입니다.");
			// 본문 설정
			simpleEmail.setMsg("메일 본문입니다.\n두번째 줄 입니다.\n\n세번째 줄입니다.");
			// 메일 전송
			rt = simpleEmail.send();
			
		} catch (EmailException e) {
			e.printStackTrace();
		} finally {
			long execTime = System.currentTimeMillis() - beginTime;
			System.out.println("execTime : " + execTime);
			System.out.println("rt : " + rt);
		}
		
	}

}
