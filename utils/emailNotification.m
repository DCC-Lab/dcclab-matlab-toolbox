function emailNotification( toEmail, subject, message)
%emailNotification Sends an email to notify of a result, etc...

setpref('Internet','E_mail','dcclab.crulrg@gmail.com');
setpref('Internet','SMTP_Server','smtp.gmail.com');
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');
setpref('Internet','SMTP_Username','dcclab.crulrg@gmail.com');
setpref('Internet','SMTP_Password','microscope');

sendmail(toEmail, subject, message);

end

