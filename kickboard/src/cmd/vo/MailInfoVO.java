package cmd.vo;

import org.springframework.web.multipart.MultipartFile;

public class MailInfoVO {
     private String receiverEmail;  // 받는 사람  이메일
     private String senderEmail; // 보내는 사람  이메일
     private String senderName; // 보내는 사람  이름
     private String subject; // 메일 제목
     private String content; // 메일 내용
     private String fullpathname; // 보낼 파일이 있는 경로 및 파일명
     private String originalFileName; // 보낼 파일명
     
     private MultipartFile upload; // file 태그 name 속성
     
     private String mode;

     public String getReceiverEmail() {
            return receiverEmail;
     }

     public void setReceiverEmail(String receiverEmail) {
            this. receiverEmail = receiverEmail;
     }

     public String getSenderEmail() {
            return senderEmail;
     }

     public void setSenderEmail(String senderEmail) {
            this. senderEmail = senderEmail;
     }

     public String getSenderName() {
            return senderName;
     }

     public void setSenderName(String senderName) {
            this. senderName = senderName;
     }

     public String getSubject() {
            return subject;
     }

     public void setSubject(String subject) {
            this. subject = subject;
     }

     public String getContent() {
            return content;
     }

     public void setContent(String content) {
            this. content = content;
     }

     public String getFullpathname() {
            return fullpathname;
     }

     public void setFullpathname(String fullpathname) {
            this. fullpathname = fullpathname;
     }

     public String getOriginalFileName() {
            return originalFileName;
     }

     public void setOriginalFileName(String originalFileName) {
            this. originalFileName = originalFileName;
     }

     public MultipartFile getUpload() {
            return upload;
     }

     public void setUpload(MultipartFile upload) {
            this. upload = upload;
     }

     public String getMode() {
            return mode;
     }

     public void setMode(String mode) {
            this. mode = mode;
     }
}
