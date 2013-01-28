public with sharing class BL_Eventadmin_privateSignupCon {

       
    Public string Loginname{get;set;}
    Public string Password{get;set;}
    Public Boolean Signuppopup{get;set;}
    Public User U{get;set;}
    Public string DisplayError{get;set;}
    Public String EvEmail{get;set;}
    Public BL_Pricing__c PricingTable{get;set;}
    Public Boolean SucessPopUp{get;set;}
    public User userid{get; set;}
    Public String Email {get;set;}
   
    
   Public BL_Eventadmin_privateSignupCon(){//Constructor   
    U = new User();
   } 
 
 
    
 /**
    Public void Signuppop(){
    Signuppopup = True; 
     U = new User();   
    }
   */
    //-------------------------------------mythily----------------
    public string errormessage{get;set;}
    public boolean error{get;set;}
    Public Pagereference EventAdminReg(){
    
    List<Account> accList = new List<Account>();
    accList = [select id from Account where Name='BoothleadsPhani'];
   
    Id accoutId;
    if(accList.size()>0){
    accoutId = accList[0].Id;   
    
    }else{
     Account acc = new account(Name='BoothleadsPhani');
     insert acc;
     accoutId =acc.Id;
    }
    
   
    
    system.debug('_____________'+evemail);
    try{
    List<User> EventAdminUser = [Select Username,Email From User where Username=:EvEmail];
 if(EventAdminUser.size()>0){
    
    
            
            List<User_Profile_Event__c> FindingDuplicates = [select User_id__r.Email,User_id__r.UserName From User_Profile_Event__c where User_id__r.UserName=:EvEmail AND Profile_id__r.PR_Name__c = 'EventAdmin'];
            
            if(FindingDuplicates.size()>0){            
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Your already Registerd as Event Admin with this Email'));
            }
            else{
              //  BL_Pricing__c PricingTable = [Select Id From BL_Pricing__c Where BLP_Applicable__c = 'Event Admin' AND PR_Type__c= 'Monthly' AND  PackageName__c='Basic'];
            
              //  system.debug('======@@@@@@@ Getting Pricing Record @@@@@@ ============='+PricingTable);
            
                Profile__c EventAdmCustProfile = [Select Id from Profile__c where PR_Name__c = 'EventAdmin'];
            
                User_Profile_Event__c UPE = new User_Profile_Event__c();
                UPE.EventAdmin_Id__c = EventAdminUser[0].id;
                UPE.UEP_isActive__c = True;
                UPE.Profile_id__c = EventAdmCustProfile.id;
                UPE.User_id__c = EventAdminUser[0].id; 
                //UPE.BLP_id__c = PricingTable.Id;
                
              /**  Database.DMLOptions dmo = new Database.DMLOptions();
                dmo.EmailHeader.triggerUserEmail = true;
                UPE.setOptions(dmo); */
                
                Insert UPE; 
                
                system.debug('===========Inserting Duplicate Record in to Junction object ======='+UPE); 
                
               
            
            }
          }
           else{
    
            Profile p = [select Id,Name from Profile where Name = 'Event Admin'];
            
            system.debug('===========Getting Profile ID ======='+p); 
           
            String EmailNote = 'Welcome to BoothLeads.com Event Administration Portal.\n\nYour login details are provided at the end of this email.\n\n\nYou will be asked to set a password when you first login.Passwords are case sensitive.\nIf you forget the password, please use the forgot password link in the login page.\n\n\nTo login, go to http://www.boothleads.com and click on Login.\n\n\nFor assistance, contact us at support@boothleads.com\n\n\nOnce again Welcome to BoothLeads.com\n\n Please note that your Booth Leads portal access is valid only for 30 days from the end of your event.\nPlease remember to export all your leads.\nIf you need access beyond this, please contact support.\n\n\nThank you,\nBooth Leads Customer Support\nSupport@boothleads.com';
   
            Contact Contact = new Contact();
            Contact.Lastname = U.LastName;
            Contact.Firstname = U.firstName;
            Contact.AccountID = '001F000000qdOJp';  
           // Contact.AccountID=accoutId;
            Contact.email_Notes__c =EmailNote; 
            insert Contact;
            
            system.debug('--------Contact Insertion-------'+Contact);
    
            
            //U.Contact = Contact.Id;
           
            U.ContactID = Contact.id;
            U.FirstName = U.FirstName;
            system.debug('--------Contact Insertion-------'+U.FirstName);
            U.LastName = U.LastName;
            U.Username = EvEmail;
            U.Email = EvEmail;
            U.Alias = 'EventAdm';
            U.ProfileID = P.id;
            U.LocaleSidKey = 'en_US';
            U.LanguageLocaleKey = 'en_US';
            U.TimeZoneSidKey = 'America/Los_Angeles';
            U.EmailEncodingKey='UTF-8';
            Database.insert(u);
           
           
           System.ResetPasswordResult rt= system.ResetPassword(u.id,true);
           u.password__c =rt.getPassword();
           system.debug('22222222222222 '+u.password__c);
           system.debug('3333333333333333 '+u.id);
           system.debug('444444444444444444 '+u);
           update u;
            
        
       /**    
           
     String emailMessage =  'Dear '+U.FirstName+' '+U.LastName+','+'<br/><br/>'+
     'Welcome to BoothLeads.com Event Administration Portal.'+'<br />'+
     'Your login details are provided at the end of this email.'+'<br />'+'<br />'+
     'You will be asked to set a password when you first login.Passwords are case sensitive.'+'<br />'+
     'If you forget the password, please use the forgot password link in the login page.'+'<br /><br />'+
     'To login, go to http://www.boothleads.com and click on Login.'+'<br /><br />'+
     
     'For assistance, contact us at support@boothleads.com'+'<br /><br />'+
     'Once again Welcome to BoothLeads.com'+'<br /><br />'+
         
     'Please note that you will have 30 days of access to the leads at Boothleads.com portal after the event.'+'<br />'+
   'Please export your leads to a csv file prior to the expiration of your access.'+'<br /><br />'+

   'Your Login ID is: '+U.Username+'<br />'+'PassWord : '+u.password__c+   
   '<br /><br />'+'Thank you!'+ 
   '<br />'+'BoothLeads Customer Support' ;
   
    system.debug('444444444444444444444 '+emailMessage);
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
             String[] toAddresses = new String[] {U.Username};
             
             mail.setToAddresses(toAddresses);
             mail.setSubject('Event admin ID has been created successfully!');
             mail.setPlainTextBody(emailMessage);
             mail.setHtmlBody(emailMessage);
            
             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
             
**/
            
            Profile__c EventAdmCustProfile1 = [Select Id from Profile__c where PR_Name__c = 'EventAdmin'];
            
            User_Profile_Event__c UPE = new User_Profile_Event__c();
            UPE.EventAdmin_Id__c = U.id;
            UPE.UEP_isActive__c = True;
            UPE.Profile_id__c = EventAdmCustProfile1.id;
            UPE.User_id__c = U.id; 
           // UPE.BLP_id__c = PricingTable1.Id;
            
            Insert UPE; 
           system.debug('======@@@@@@@ Inserting in to Junction Object @@@@@@ ============='+UPE);
           
          
           
           
           
     }         
                List<AttendeeSummary__c> AttendeeDetails = [select  id,Name,AS_Email__c from AttendeeSummary__c Where AS_uniqueField__c =:(U.FirstName+ U.LastName+EvEmail).tolowercase()];
                
                system.debug(' ===== Alredy Existed Attendee Email Id ===='+AttendeeDetails);
                
                if(AttendeeDetails.size() > 0){
               
            }else {
                       AttendeeSummary__c AttendeeSummary = new AttendeeSummary__c();
                       AttendeeSummary.AS_Email__c = EvEmail;
                       AttendeeSummary.AS_FirstName__c = U.FirstName;
                       AttendeeSummary.AS_LastName__c = U.LastName;
                       AttendeeSummary.AS_uniqueField__c=(U.FirstName + U.LastName + EvEmail).tolowercase();
                       insert AttendeeSummary ;
                }    
           
           SucessPopUp = true;
           Signuppopup = false;
           EvEmail='';
   }
   catch(Exception e){
   ApexPages.addMessages(e);

   } 

      return null;
  }

  
  Public void CancelSignUp(){
  Signuppopup = False;
  errormessage = '';
  EvEmail='';
  error = FALSE;
  
  }
  
  Public pagereference SuccesPopUpClose(){
   SucessPopUp = False;
    pagereference pg= new pagereference('/apex/BL_Eventadmin_Signup');
    pg.setRedirect(true);
  return pg;
  }
  
 //----------------------------------------------Test Classes-------------- 
  public Pagereference checkuserName(){

     
       
       if(userInfo.getUserType()=='guest'){
         System.debug('AAAAAAAAAAAAAAAAAAAAAAA    ');  
            return null;
       } else {
           
               userid =[select Name,Profile.Name from user where ID=: userInfo.getUserId()]; 
               
             if(userid.Profile.Name =='Event Admin'){
             
                 pagereference pg = new Pagereference('/BL_EventAdmin_Dashboard');
                pg.setredirect(true);    
                return pg;  
                     
             }else if(userid.Profile.Name =='Booth Admin'){
                
                 List<User_Profile_Event__c>  listOfupe = new List<User_Profile_Event__c>();
                listOfupe =[select id from User_Profile_Event__c where User_id__r.ID =: userInfo.getUserId() and (status__c !='Inactive' and status__c!='Mobile only access')];
                  if(listOfupe.size()>0){   
                    pagereference pg = new Pagereference('/BL_BoothAdmin_Dashboard');
                    pg.setredirect(true);    
                    return pg;
             }     
             
           }
          return null;
    }
    
  }
   static testMethod void test_EventAdminSignin (){
        
        
         account a=new account(name='govtnm');
        insert a;
        
         contact c=new contact(lastname='n',accountid = a.id);
        insert c;
        
        Profile p = [select id,name FROM profile where name='Event Admin'];
        
        User us = new User(alias = 'test123', email='test123@noemail.com',
        emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='test123@noemail.com', ContactID = c.id);
        insert us;
        
         System.ResetPasswordResult rt= system.ResetPassword(us.id,true);
         us.password__c =rt.getPassword();
         string pwd = rt.getPassword();
         update us;
        
        
        
         account a1=new account(name='govtnm1');
        insert a1;
        
         contact c1=new contact(lastname='n1',accountid = a1.id,firstname='phani' );
        insert c1;
        
         Profile pbAdmin = [select id,name FROM profile where name='Booth Admin'];
        
        User bAdmin = new User(alias = 'test1234', email='test1234@noemail.com',
        emailencodingkey='UTF-8',profileid = pbAdmin.Id, lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='test1234@noemail.com',ContactID = c1.id);
        insert bAdmin ;
        
         System.ResetPasswordResult rtad= system.ResetPassword(bAdmin .id,true);
         bAdmin .password__c =rtad.getPassword();
         string pwdad = rtad.getPassword();
         update bAdmin ;
        
        Profile__c EventAdmCustProfile = new Profile__c(PR_Name__c = 'EventAdmin');
        insert EventAdmCustProfile;  
           
        
        User_Profile_Event__c upe=new User_Profile_Event__c(User_id__c=us.id,Profile_id__c=EventAdmCustProfile.id, status__c='Active');
        insert upe;
        
       
       BL_Eventadmin_privateSignupCon  testsignin=new BL_Eventadmin_privateSignupCon ();
       testsignin.Loginname  =us.Email;
       testsignin.password =pwd ;      
      testsignin.EvEmail='test1234@noemail.com';
      testsignin.EventAdminReg();
      testsignin.EvEmail='phani@noemail.com';
     testsignin.EvEmail='phani@noemail.com';
       
      
       testsignin.EventAdminReg();
      
     
       testsignin.CancelSignUp();
       testsignin.SuccesPopUpClose();
       system.runas(us){
       testsignin.checkuserName();
      }

      system.runas(bAdmin){
       testsignin.checkuserName();
   }


}



}