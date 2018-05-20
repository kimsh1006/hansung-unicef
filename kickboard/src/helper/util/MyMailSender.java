package helper.util;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.springframework.stereotype.Service;

import cmd.vo.MailInfoVO;


@Service("mail.myMailSender")
public class MyMailSender {
     private String mailType; // 메일 타입
    
     public MyMailSender() {
          this.mailType = "text/html; charset=utf-8";
          // this.mailType = "text/plain; charset=euc-kr";
     }
    
     private class SMTPAuthenticator extends javax.mail.Authenticator { 
                public PasswordAuthentication getPasswordAuthentication() { 
                
                	  String username =  "rlatmdgks1006@gmail.com"; // gmail 사용자; 
                      String password = "dnflwlq902gh"; // 패스워드;        
                	
                	return new PasswordAuthentication(username, password); 
                 } 
     }
    
     public void mailSend(MailInfoVO mailInfo) {
          Properties p = new Properties();  
 
          // SMTP 서버의 계정 설정  
          // Naver와 연결할 경우 네이버 아이디
          // Gmail과 연결할 경우 Gmail 아이디
          p.put("mail.smtp.user", "rlatmdgks1006");  
 
          // SMTP 서버 정보 설정  
        //  p.put("mail.smtp.host", "smtp.naver.com"); // 네이버  
          p.put("mail.smtp.host", "smtp.gmail.com");    //gmail
                
          // 네이버와 지메일 동일  
          p.put("mail.smtp.port", "465");  
          p.put("mail.smtp.starttls.enable", "true");  
          p.put("mail.smtp.auth", "true");  
          p.put("mail.smtp.debug", "true");  
          p.put("mail.smtp.socketFactory.port", "465");  
          p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");  
          p.put("mail.smtp.socketFactory.fallback", "false"); 
         
          try {
               Authenticator auth = new SMTPAuthenticator(); 
               Session session = Session.getDefaultInstance(p, auth);
               // 메일 전송시 상세 정보 콘솔에 출력 여부
               //session.setDebug(true);
              
               Message message = new MimeMessage(session);

               // 보내는 사람
               if(mailInfo.getSenderName() == null || mailInfo.getSenderName().equals(""))
                    message.setFrom(new InternetAddress(mailInfo.getSenderEmail()));
               else
                    message.setFrom(new InternetAddress(mailInfo.getSenderEmail(), mailInfo.getSenderName(), "utf-8"));
              
               // 받는 사람
               message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(mailInfo.getReceiverEmail()));
              
               // 제목
               message.setSubject(mailInfo.getSubject());
              
               // HTML 형식인 경우 \r\n을  <br/>로 변환
               if(mailType.indexOf("text/html") != -1) {
                    mailInfo.setContent(mailInfo.getContent().replaceAll("\n", "<br/>"));
               }
               makeMessage(message, mailInfo);
               message.setHeader("X-Mailer", mailInfo.getSenderName());
              
               // 메일 보낸 날짜
               message.setSentDate(new Date());
              
               // 메일 전송
               Transport.send(message);
             
              
                             
          } catch (Exception e) {
               System.out.println(e.toString());
          }
     }
    
     // 첨부 파일이 있는 경우 MIME을 MultiMime로 파일을 전송 한다.
     private void makeMessage(Message msg, MailInfoVO user) throws MessagingException {
          if(user.getFullpathname() == null || user.getFullpathname().length()==0) {
               // 파일을 첨부하지 않은 경우
               msg.setText(user.getContent());
           
               msg.setHeader("Content-Type", mailType);
          } else {
               // 파일을 첨부하는 경우
              
               // 메일 내용
               MimeBodyPart mbp1 = new MimeBodyPart();
               mbp1.setText(user.getContent());
               mbp1.setHeader("Content-Type", mailType);
              
               // 첨부 파일
               MimeBodyPart mbp2 = new MimeBodyPart();
               FileDataSource fds = new FileDataSource(user.getFullpathname());
               mbp2.setDataHandler(new DataHandler(fds));
              
               try {
                    if(user.getOriginalFileName() == null || user.getOriginalFileName().length()==0)
                         mbp2.setFileName(MimeUtility.encodeWord(fds.getName()));
                    else
                         mbp2.setFileName(MimeUtility.encodeWord(user.getOriginalFileName()));
               } catch(UnsupportedEncodingException e) {
                    System.out.println(e.toString());
               }
              
               Multipart mp = new MimeMultipart();
               mp.addBodyPart(mbp1);
               mp.addBodyPart(mbp2);
              
               msg.setContent(mp);
          }
     }
}