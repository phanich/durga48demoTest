public with sharing class BL_Eventadmin_BoothsCon {
    
    
    Public String selectBooth{get;set;}
    Public String SelectEvent{get;set;}
    Public String DisplayNoEvent {get;set;}
    Public Boolean DisplayNoEventMessage {get;set;}
    Public Boolean AddBoothPopUp {get;set;}
    Public Boolean AddBoothAdminPopUp {get;set;}
    Public String LoginUserId{get;set;}
    Public Booth__c Booth{get;set;}
    Public List<User_Profile_Event__c> User_Profile_Event{get;set;}
    Public String BoothAdminId{get;set;}
    Public User BoothAdminUser {get;set;}
    Public String Email{get;set;}
    Public Boolean CreatBoothAdminPopUp{get;set;}
    Public String FirstName{get;set;}
    Public string LastName{get;set;}
    Public List<Booth__c> BoothsList{get;set;}
    Public Boolean DisplayNoBoothMessage{get;set;} 
    Public string DisplayNoBooth{get;set;}
    Public Boolean OnlyBoothAdminPopUp{get;set;}
    Public Contact Con{get;set;}
    Public List<User_Profile_Event__c> E{get;set;}
    Public Boolean EditExhibitorPopUp{get;set;}
    Public Boolean displayBoothinfoPopUp{get;set;}
    Public Boolean displayBoothDetailsPopUp{get;set;}
    Public string PoBox{get;set;}
    Public String Zip{get;set;}
    Public String Selectedstates{get;set;}
    Public String SelectedCountry{get;set;}
   
    
    
    Public BL_Eventadmin_BoothsCon(){
     LoginUserId = UserInfo.getUserId();
   //  LoginUserId = '005O0000000ZJas';
    
    }
    
    Public List<selectoption> getListOfEvents(){
    //LoginUserId = UserInfo.getUserId(); 
    List<selectoption> Options = new List<selectoption>();
    List<User_Profile_Event__c> EventsList = [select Id,EV_id__c,EV_id__r.EV_Title__c from User_Profile_Event__c where EventAdmin_Id__c =: LoginUserId AND Profile_id__r.PR_Name__c ='EventAdmin' ]; 
    system.debug('===========$$$$$$$$$ Getting list of Events $$$$$$$$$ ============'+EventsList );
    Options.add(new Selectoption('--Choose Event--','--Choose Event--'));
    for(User_Profile_Event__c UserPEvent: EventsList){
    system.debug('11111111111111'+ UserPEvent.EV_id__c );
    
    if(UserPEvent.EV_id__c != null ){
    Options.add(new Selectoption(UserPEvent.EV_id__c,UserPEvent.EV_id__r.EV_Title__c));}
   }
     return Options;
 }
    
         Public List<selectOption> ChangeOfBooths(){
         E = new List<User_Profile_Event__c>();
        System.debug('---------Selected Booths From List--------'+SelectBooth);
        getListOfBooths();        
        return null;
        
        }
    
    
    Public List<selectoption> getListOfBooths(){ 
    
    List<selectoption> Options = new List<selectoption>();
    
     List<User_Profile_Event__c> BoothsList = new List<User_Profile_Event__c>();
    
     BoothsList = [select BT_id__c,BT_id__r.BT_Name__c from User_Profile_Event__c where EventAdmin_Id__r.id=: LoginUserId AND EV_id__c =:SelectEvent AND Profile_id__r.PR_Name__c ='BoothAdmin' ]; 
   // List<Booth__c> BoothsList = [select Id,BT_Name__c from Booth__c where EV_id__c =: SelectEvent ]; 
    system.debug('--------------:::::::: getting Selected Booths from Selected Event::::::::-----------'+BoothsList );
   
    Options.add(new Selectoption('--Choose Booth--','--Choose Booth--'));
    for(User_Profile_Event__c EventVBooth: BoothsList){
    
    Options.add(new Selectoption(EventVBooth.BT_id__c,EventVBooth.BT_id__r.BT_Name__c));
   }
     return Options;
 }
 
    Public List<User_Profile_Event__c> getListOfBoothAdmins(){
    
    User_Profile_Event = new List<User_Profile_Event__c>();
    
    User_Profile_Event = [Select Id,User_id__r.Name,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,BoothAdmin_id__r.LastName,
                          BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName from User_Profile_Event__c 
                          where EventAdmin_Id__c=:LoginUserId AND EV_id__c =:SelectEvent AND Profile_id__r.PR_Name__c ='BoothAdmin' AND BT_id__c=:selectBooth ];
    
    system.debug(':::::::::: -------- Getting List of BoothAdmins --------::::::::'+User_Profile_Event);
   
   for(User_Profile_Event__c hg :User_Profile_Event ){
   system.debug('yyyyyyyyyyyyyyyyyyyb  '+hg.User_id__r.Name);
   
   }
   
    
   
   
   
    return null;
    
    }

public  List<User_Profile_Event__c> Boothpersonnels {get;set;}


      Public void AddBooth(){
      if(selectEvent == '--Choose Event--'){
      DisplayNoBoothMessage = False; 
      DisplayNoEvent = 'Please Select an event';
      DisplayNoEventMessage = True;
      }
       else 
      {   
          DisplayNoEventMessage = False;
          AddBoothPopUp = True;
      }
       Con = New Contact();
       Booth = new Booth__c();
       BoothAdminUser = new User();
      }

        Public void Add_BoothAdmins(){//Adding Only BoothAdmin's Button
                if(SelectBooth == '--Choose Booth--'){
                 DisplayNoBooth = 'Please Select a Booth';
                 DisplayNoBoothMessage = True; 
                   }else {
                OnlyBoothAdminPopUp = True;
                  }
                  
                  Con = New Contact();
                  BoothAdminUser = new User();
               }
               
       Public void Next(){
           CreatBoothAdminPopUp = true; 
       }
       
       Public List<Selectoption> getCountries(){
       List<Selectoption> Options = new List<Selectoption>();
           Options.add(new selectoption('India','India'));
           Options.add(new selectoption('USA','USA'));
       return Options;
       
       }
       
       
       Public List<Selectoption> getStates(){
       List<Selectoption> Options = new List<Selectoption>();
            Options.add(new SelectOption('--None--','--None--'));
       if(SelectedCountry == 'United states of America'){
            Options.add(new SelectOption('AL','Alabama'));
            Options.add(new SelectOption('AZ','Arizona'));
            Options.add(new SelectOption('AR','Arkansas'));
            Options.add(new SelectOption('CA','California'));
            Options.add(new SelectOption('CO','Colorado'));
            Options.add(new SelectOption('CT','Connecticut'));
            Options.add(new SelectOption('DE','Delaware'));
            Options.add(new SelectOption('DC','District of Columbia'));
            Options.add(new SelectOption('FL','Florida'));
            Options.add(new SelectOption('GA','Georgia'));
            Options.add(new SelectOption('HI','Hawaii'));
            Options.add(new SelectOption('ID','Idaho'));
            Options.add(new SelectOption('IL','Illinois'));
            Options.add(new SelectOption('IN','Indiana'));
            Options.add(new SelectOption('IA','Iowa'));
            Options.add(new SelectOption('KS','Kansas'));
            Options.add(new SelectOption('KY','Kentucky'));
            Options.add(new SelectOption('LA','Louisiana'));
            Options.add(new SelectOption('ME','Maine'));
            Options.add(new SelectOption('MD','Maryland'));
            Options.add(new SelectOption('MA','Massachusetts'));
            Options.add(new SelectOption('MI','Michigan'));
            Options.add(new SelectOption('MN','Minnesota'));
            Options.add(new SelectOption('MS','Mississippi'));
            Options.add(new SelectOption('MO','Missouri'));
            Options.add(new SelectOption('MT','Montana'));
            Options.add(new SelectOption('NE','Nebraska'));
            Options.add(new SelectOption('NV','Nevada'));
            Options.add(new SelectOption('NH','New Hampshire'));
            Options.add(new SelectOption('NJ','New Jersey'));
            Options.add(new SelectOption('NM','New Mexico'));
            Options.add(new SelectOption('NY','New York'));
            Options.add(new SelectOption('NC','North Carolina'));
            Options.add(new SelectOption('ND','North Dakota'));
            Options.add(new SelectOption('OH','Ohio'));
            Options.add(new SelectOption('OK','Oklahoma'));
            Options.add(new SelectOption('OR','Oregon'));
            Options.add(new SelectOption('PA','Pennsylvania'));
            Options.add(new SelectOption('RI','Rhode Island'));
            Options.add(new SelectOption('SC','South Carolina'));
            Options.add(new SelectOption('SD','South Dakota'));
            Options.add(new SelectOption('TN','Tennessee'));
            Options.add(new SelectOption('TX','Texas'));
            Options.add(new SelectOption('UT','Utah'));
            Options.add(new SelectOption('VT','Vermont'));
            Options.add(new SelectOption('VA','Virginia'));
            Options.add(new SelectOption('WA','Washington'));
            Options.add(new SelectOption('WV','West Virginia'));
            Options.add(new SelectOption('WI','Wisconsin'));
            Options.add(new SelectOption('WY','Wyoming'));   
       }
       else if(selectedCountry == 'India'){
            Options.add(new selectoption('AP','Andhra Pradesh'));
            Options.add(new selectoption('AR','Arunachal Pradesh'));
            Options.add(new SelectOption('AS','Assam'));
            Options.add(new SelectOption('BR','Bihar'));
            Options.add(new SelectOption('CT','Chhattisgarh'));
            Options.add(new SelectOption('GA','Goa'));
            Options.add(new SelectOption('GJ','Gujarat'));
            Options.add(new SelectOption('HR','Haryana'));
            Options.add(new SelectOption('HP','Himachal Pradesh'));
            Options.add(new SelectOption('JK','Jammu and Kashmir'));
            Options.add(new SelectOption('JH','Jharkhand'));
            Options.add(new SelectOption('KA','Karnataka'));
            Options.add(new SelectOption('KL','Kerala'));
            Options.add(new SelectOption('MP','Madhya Pradesh'));
            Options.add(new SelectOption('MH','Maharashtra'));
            Options.add(new selectoption('MN','Manipur'));
            Options.add(new selectoption('ML','Meghalaya'));
            Options.add(new selectoption('MZ','Mizoram'));
            Options.add(new SelectOption('NL','Nagaland'));
            Options.add(new SelectOption('OR','Orissa'));
            Options.add(new SelectOption('PJ','Punjab'));
            Options.add(new SelectOption('RJ','Rajasthan'));
            Options.add(new SelectOption('SK','Sikkim'));
            Options.add(new SelectOption('TN','Tamil Nadu'));
            Options.add(new SelectOption('TR','Tripura'));
            Options.add(new SelectOption('UP','Uttar Pradesh'));
            Options.add(new SelectOption('UT','Uttarakhand'));
            Options.add(new SelectOption('WB','West Bengal'));
            Options.add(new SelectOption('AN','Andaman and Nicobar Islands'));
            Options.add(new SelectOption('DD','Daman and Diu'));
            Options.add(new SelectOption('LD','Lakshadweep  '));
            Options.add(new SelectOption('DL','National Capital Territory of Delhi'));
       }
       return Options;
       
       }
       
       
       Public Pagereference SaveBooth(){
       
               
   
  
               Booth.BT_BoothUserCount__c   =  Booth.BT_BoothUserCount__c;
               Booth.BT_ContactEmail__c     =  Booth.BT_ContactEmail__c;
               Booth.BT_ContactName__c      =  Booth.BT_ContactName__c;
               Booth.BT_ContactPhone__c     =  Booth.BT_ContactPhone__c;
               Booth.BT_Description__c      =  Booth.BT_Description__c;
               Booth.EV_id__c               =  SelectEvent;
               Booth.BT_isBoothActive__c    =  true;
               Booth.BT_Location__c         =  Booth.BT_Location__c;
               Booth.BT_Name__c             =  Booth.BT_Name__c;
               Booth.BT_Phone__c            =  Booth.BT_Phone__c;
               Booth.BT_RegistrationLink__c =  Booth.BT_RegistrationLink__c;
               Booth.BT_WebsiteURL__c       =  Booth.BT_WebsiteURL__c;
               
               insert Booth;
               
               system.debug('::::::::: Inserting Booth ::::::::::::'+Booth);
               
               List<User> ComparingUserEmails = [Select Id,Email,Username From User Where UserName =: Email Limit 1];
               
               System.debug('========@@@@@@ Comparing Email with Existing Email From User Object @@@@@ ========='+ComparingUserEmails);
                   
               if(ComparingUserEmails.size()>0){
               List<User_Profile_Event__c> FindingDuplicates = [select User_id__r.Email,User_id__r.UserName From User_Profile_Event__c where User_Profile_Event__c.User_id__r.UserName=:Email AND  EV_id__c=:selectEvent];
               System.debug('========@@@@@@ Comparing Email with Existing Email From User_Profile_Event Object @@@@@ ========='+FindingDuplicates);
               
               if(FindingDuplicates.size()>0){
               ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'He is Already Registerd as BoothAdmin for this Event'));
               }
               else{
               
               
                Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c where PR_Name__c='BoothAdmin'];
                
                User_Profile_Event__c GettingPRID = [Select Id,BLP_id__c from User_Profile_Event__c Where Ev_Id__c=: SelectEvent AND User_Id__c =: LoginUserID];
                
                
                User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c();
                
                UserBoothAdminProfile.BLP_id__c = GettingPRID.BLP_id__c;
                UserBoothAdminProfile.BoothAdmin_id__c =ComparingUserEmails[0].id;
                UserBoothAdminProfile.BT_id__c  = Booth.id;
                UserBoothAdminProfile.EV_id__c = SelectEvent;
                UserBoothAdminProfile.EventAdmin_Id__c = LoginUserId;
                UserBoothAdminProfile.UEP_isActive__c = True;
                UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                UserBoothAdminProfile.User_id__c = ComparingUserEmails[0].id;
                
                insert UserBoothAdminProfile;
                
                system.debug('-------:::::::: Inserting Event,Booth,Boothadmin into the CommonTable ::::::------'+UserBoothAdminProfile); 
           
                Booth__c UpdatingBoothUserCount = [select Id,BT_BoothUserCount__c from Booth__c where Id=:Booth.id AND EV_id__c=: SelectEvent]; 
           
                System.debug('--------::::::::::: Finding the Count of Userliscence Per Booth and updating :::::::::::::------'+UpdatingBoothUserCount);
           
                UpdatingBoothUserCount.BT_BoothUserCount__c = UpdatingBoothUserCount.BT_BoothUserCount__c-1;
                Update UpdatingBoothUserCount;
               
               
               }
            }   
               else{
               
               Profile UserAsBA = [Select Id,Name from Profile where Name = 'Booth Admin'];
               
               system.debug('======:::::::: Retriving Profile Id from Standard Profile Object ========::::::'+UserAsBA);              
              
               
               Con.LastName = BoothAdminUser.LastName;
               Con.AccountId = '001O00000072Oou';
               
               insert Con ;
               
               system.debug('=====::::::::: Inserting Contact :::::::======='+Con );
               
                              /**      string df = string.valueOf(Email);
                                    integer i = df.indexOf('@');
                                    if(i>3){
                                    string ght = df.substring(0,3);
                                    }else{
                                    string ght = df.substring(0,1);
                                    
                                    }
                                    System.debug('UserName'+Email);*/
               
                BoothAdminUser.ContactID = Con.id;
                BoothAdminUser.Username = Email;
                BoothAdminUser.Email = Email;
                BoothAdminUser.Firstname = BoothAdminUser.Firstname;
                BoothAdminUser.LastName = BoothAdminUser.LastName;
                BoothAdminUser.Alias ='BAdmin';
                BoothAdminUser.ProfileID =UserAsBA.Id;
                //BoothAdminUser.ProfileID ='00e90000000zItK';
                BoothAdminUser.LocaleSidKey ='en_US';
                BoothAdminUser.LanguageLocaleKey ='en_US';
                BoothAdminUser.TimeZoneSidKey ='America/Los_Angeles';
                BoothAdminUser.EmailEncodingKey='UTF-8';
                BoothAdminUser.companyName = BoothAdminUser.companyName;
                BoothAdminUser.Company_website__c = BoothAdminUser.Company_website__c;
                BoothAdminUser.CompanyAddr1__c = BoothAdminUser.CompanyAddr1__c;
                BoothAdminUser.CompanyAddr2__c = BoothAdminUser.CompanyAddr2__c;
                BoothAdminUser.CompanyCity__c = BoothAdminUser.CompanyCity__c;
               // BoothAdminUser.CompanyCountry__c = SelectedCountry;
              //  BoothAdminUser.CompanyState__c = Selectedstates;
                BoothAdminUser.CompanyFaxNumber__c  = BoothAdminUser.CompanyFaxNumber__c;
                BoothAdminUser.Companyphone__c = BoothAdminUser.Companyphone__c;
                
                Database.DMLOptions dmo = new Database.DMLOptions();
                dmo.EmailHeader.triggerUserEmail = true;
                BoothAdminUser.setOptions(dmo);
                
                insert BoothAdminUser;
                
                system.debug('----@@@:::Inserting Boothadmin into User Object:::@@@--------'+BoothAdminUser);
                
                Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c where PR_Name__c='BoothAdmin'];
                
                User_Profile_Event__c GettingPRID = [Select Id,BLP_id__c from User_Profile_Event__c Where Ev_Id__c=: SelectEvent AND User_Id__c =: LoginUserID];
                
                
                User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c();
                
                UserBoothAdminProfile.BLP_id__c = GettingPRID.BLP_id__c;
                UserBoothAdminProfile.BoothAdmin_id__c = BoothAdminUser.id;
                UserBoothAdminProfile.BT_id__c  = Booth.id;
                UserBoothAdminProfile.EV_id__c = SelectEvent;
                UserBoothAdminProfile.EventAdmin_Id__c = LoginUserId;
                UserBoothAdminProfile.UEP_isActive__c = True;
                UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                UserBoothAdminProfile.User_id__c = BoothAdminUser.Id;
                
                insert UserBoothAdminProfile;
                
                system.debug('-------:::::::: Inserting Event,Booth,Boothadmin into the CommonTable ::::::------'+UserBoothAdminProfile); 
     
                Booth__c UpdatingBoothUserCount = [select Id,BT_BoothUserCount__c from Booth__c where Id=:Booth.id AND EV_id__c=: SelectEvent]; 
           
               System.debug('--------::::::::::: Finding the Count of Userliscence Per Booth and updating :::::::::::::------'+UpdatingBoothUserCount);
           
               UpdatingBoothUserCount.BT_BoothUserCount__c = UpdatingBoothUserCount.BT_BoothUserCount__c-1;
               Update UpdatingBoothUserCount; 
      }    
                  
                List<AttendeeSummary__c> AttendeeDetails = [select  id,Name,AS_Email__c from AttendeeSummary__c Where AS_Email__c=:Email];
                
                system.debug(' ===== Alredy Existed Attendee Email Id ===='+AttendeeDetails);
                
                if(AttendeeDetails.size() > 0){
                
                List<Event_Attendee_Mapping__c> EventAttendeeJun = [select id,EV_id__c from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c =: Email AND EV_id__c =: SelectEvent];
                system.debug('========================= Attendee is inserted in Junction Object Or not ==========='+EventAttendeeJun );
                
                if(EventAttendeeJun.size()>0){}
                else{
                
                    Event_Attendee_Mapping__c InsertinginJun = new Event_Attendee_Mapping__c();
                    InsertinginJun.AS_id__c = AttendeeDetails[0].id;
                    InsertinginJun.EV_id__c = selectEvent;
                   // InsertinginJun.Attendee_Event_IDs__c  = AttendeeDetails[0].Name + EventAttendeeJun[0].EV_id__r.Name;
                    insert InsertinginJun; 
                
                
                }
            }else {
                       AttendeeSummary__c AttendeeSummary = new AttendeeSummary__c();
                       AttendeeSummary.AS_Email__c = Email;
                       AttendeeSummary.AS_FirstName__c = BoothAdminUser.FirstName;
                       AttendeeSummary.AS_LastName__c = BoothAdminUser.LastName;
                   
                       insert AttendeeSummary ;
                   
                       Event_Attendee_Mapping__c InsertinginJun = new Event_Attendee_Mapping__c();
                       InsertinginJun.AS_id__c = AttendeeSummary.id;
                       InsertinginJun.EV_id__c = SelectEvent;
                       InsertinginJun.Attendee_Event_IDs__c  = AttendeeSummary.Name;
                       
                       insert InsertinginJun;          
            
            
            }
               
               
      
                return null; 
     }
       
       Public void CancelBooth(){
       CreatBoothAdminPopUp = false;
      // AddBoothPopUp = false;   
       }
   
      Public Pagereference SaveOnlyBA(){//Inserting Admin to Selected Booth
       
           /**     List<User> ComparingUserEmails = [Select Id,Email,Username From User Where UserName =: Email Limit 1];
               
               System.debug('========@@@@@@ Comparing Email with Existing Email From User Object @@@@@ ========='+ComparingUserEmails);
                   
               if(ComparingUserEmails.size()>0){
               
               List<User_Profile_Event__c> FindingDuplicates = [select User_id__r.Email,User_id__r.UserName From User_Profile_Event__c where User_Profile_Event__c.User_id__r.UserName=:Email AND  EV_id__c=:selectEvent AND BT_id__c =:SelectBooth];
               System.debug('========@@@@@@ Comparing Email with Existing Email From User_Profile_Event Object @@@@@ ========='+FindingDuplicates);
               
               if(FindingDuplicates.size()>0){
               ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Booth Admin is Already an Admin for this Booth {!selectBooth}'));
               }
               else{
               User_Profile_Event__c CheckingForAdminLimit = [select BT_id__c,BT_id__r.BT_BoothUserCount__c from User_Profile_Event__c where User_Profile_Event__c.BT_id__c=:SelectBooth AND EV_id__c=: SelectEvent]; 
               system.debug('==========:::::::::::::: Checking For USerLimit ::::::::=========='+CheckingForAdminLimit);
               
               if(CheckingForAdminLimit.BT_id__r.BT_BoothUserCount__c == 0){
               ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No Licenses available for Booth {!selectBooth}'));               
              }
              else if(CheckingForAdminLimit.BT_id__r.BT_BoothUserCount__c > 0){
                      
               Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c where PR_Name__c='BoothAdmin'];
                
                User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c();
                UserBoothAdminProfile.BoothAdmin_id__c = ComparingUserEmails[0].id;
                UserBoothAdminProfile.BT_id__c  = CheckingForAdminLimit.BT_id__c;
                UserBoothAdminProfile.EV_id__c = SelectEvent;
                UserBoothAdminProfile.EventAdmin_Id__c = LoginUserId;
                UserBoothAdminProfile.UEP_isActive__c = True;
                UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                UserBoothAdminProfile.User_id__c = ComparingUserEmails[0].id;
                
                insert  UserBoothAdminProfile ;
                
                Booth__c BoothUserCountForDup = [select Id,BT_BoothUserCount__c from Booth__c where Id=:CheckingForAdminLimit.BT_id__c AND EV_id__c=: SelectEvent]; 
           
                System.debug('--------::::::::::: Finding the Count of Userliscence Per Booth and updating :::::::::::::------'+BoothUserCountForDup );
           
                BoothUserCountForDup.BT_BoothUserCount__c = BoothUserCountForDup.BT_BoothUserCount__c-1;
                Update BoothUserCountForDup;
           }    
          } 
        }
           else{
               Con = new Contact();
               Con.LastName = 'Shruthi';
               Con.AccountId = '001O00000072aPq';
               
               insert Con ;
               
               system.debug('=====::::::::: Inserting Contact :::::::======='+Con );
               
               Profile UserAsBA = [Select Id,Name from Profile where Name = 'standard User'];
               system.debug('======:::::::: Retriving Profile Id from Standard Profile Object ========::::::'+UserAsBA);              
             
               
                
                BoothAdminUser.Username = Email;
                BoothAdminUser.Email = Email;
                BoothAdminUser.Firstname = BoothAdminUser.Firstname;
                BoothAdminUser.LastName = BoothAdminUser.LastName;
                BoothAdminUser.Alias ='BAdmin';
                BoothAdminUser.ProfileID = UserAsBA.Id;    
                BoothAdminUser.LocaleSidKey ='en_US';
                BoothAdminUser.LanguageLocaleKey ='en_US';
                BoothAdminUser.TimeZoneSidKey ='America/Los_Angeles';
                BoothAdminUser.EmailEncodingKey='UTF-8';
                BoothAdminUser.companyName = BoothAdminUser.companyName;
                BoothAdminUser.Company_website__c = BoothAdminUser.Company_website__c;
                BoothAdminUser.CompanyAddr1__c = BoothAdminUser.CompanyAddr1__c;
                BoothAdminUser.CompanyAddr2__c = BoothAdminUser.CompanyAddr2__c;
                BoothAdminUser.CompanyCity__c = BoothAdminUser.CompanyCity__c;
                BoothAdminUser.CompanyCountry__c = BoothAdminUser.CompanyCountry__c;
                BoothAdminUser.CompanyState__c = BoothAdminUser.CompanyState__c;
                BoothAdminUser.CompanyFaxNumber__c  = BoothAdminUser.CompanyFaxNumber__c;
                BoothAdminUser.Companyphone__c = BoothAdminUser.Companyphone__c;
                
                insert BoothAdminUser;
                
                system.debug('----@@@:::Inserting Boothadmin into User Object:::@@@--------'+BoothAdminUser);
                
                Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c where PR_Name__c='BoothAdmin'];
                
                User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c();
                UserBoothAdminProfile.BoothAdmin_id__c = BoothAdminUser.id;
                UserBoothAdminProfile.BT_id__c  = selectBooth;
                UserBoothAdminProfile.EV_id__c = SelectEvent;
                UserBoothAdminProfile.EventAdmin_Id__c = LoginUserId;
                UserBoothAdminProfile.UEP_isActive__c = True;
                UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                UserBoothAdminProfile.User_id__c = BoothAdminUser.Id;
                
                insert UserBoothAdminProfile;
                
               system.debug('-------:::::::: Inserting Event,Booth,Boothadmin into the CommonTable ::::::------'+UserBoothAdminProfile); 
           
               Booth__c UpdatingBoothUserCount = [select Id,BT_BoothUserCount__c from Booth__c where Id=:selectBooth AND EV_id__c=: SelectEvent]; 
           
               System.debug('--------::::::::::: Finding the Count of Userliscence Per Booth and updating :::::::::::::------'+UpdatingBoothUserCount);
           
               UpdatingBoothUserCount.BT_BoothUserCount__c = UpdatingBoothUserCount.BT_BoothUserCount__c-1;
               Update UpdatingBoothUserCount; 
       
    
   } */
       return null;  
}   
       Public void CancelBA(){
       OnlyBoothAdminPopUp = False;
       }
   
   Public List<User> BoothDetails1{get;set;}
   Public List<User> returnList {get;set;}
   Public User Admin {get;set;}
   
   public void EditBoothAdmin()
        {
            system.debug('=========BoothAdminId::::'+BoothAdminId);
         
            User_Profile_Event__c ParticularJuncID = [select EV_ID__c,BT_id__c,User_Id__c from User_Profile_Event__c where id =: BoothAdminId];
            
            system.debug('=======::::::::::: Mapping Junction EventID :::::::::::========='+ParticularJuncID);           
            
            BoothDetails1 = [Select Id,FirstName,LastName,CompanyName,Email,Company_website__c,CompanyAddr1__c,
                             CompanyAddr2__c,CompanyCity__c,CompanyCountry__c,CompanyState__c,CompanyFaxNumber__c,
                             Companyphone__c from User where Id =:ParticularJuncID.User_Id__c];
            
            Admin = new User();
            
            system.debug('------:::::::::: For Editing Particular Event Record :::::::::::-------'+BoothDetails1 ); 
            
            for(User Admin1 :BoothDetails1 )
            {
                if(BoothAdminId!= null )
                {
                    
                   system.debug('-------+++++++++++-----------'+Admin1.Id);
                    EditExhibitorPopUp = True;
                    Admin = Admin1;
                    break;
                    
                }
              
            }
            
          // EditBoothadmin();
        } 
   
           Public Void UpdateBoothadmin(){
           
                //Admin.Username = Email;
               // Admin.Email = Email;
                Admin.Firstname = Admin.Firstname;
                Admin.LastName = Admin.LastName;
                Admin.companyName = Admin.companyName;
                Admin.Company_website__c = Admin.Company_website__c;
                Admin.CompanyAddr1__c = Admin.CompanyAddr1__c;
                Admin.CompanyAddr2__c = Admin.CompanyAddr2__c;
                Admin.CompanyCity__c = Admin.CompanyCity__c;
                Admin.CompanyCountry__c = Admin.CompanyCountry__c;
                Admin.CompanyState__c = Admin.CompanyState__c;
                Admin.CompanyFaxNumber__c  = Admin.CompanyFaxNumber__c;
                Admin.Companyphone__c = Admin.Companyphone__c;
                
                update Admin;
                
          }
          
          
          
    public void getBoothdetails()
    {
        system.debug('=========BoothAdminId::::'+BoothAdminId);
        
        returnList = new List<User>();
        
        User_Profile_Event__c ParticularJuncID = [select EV_ID__c,BT_id__c,User_Id__c from User_Profile_Event__c where id =: BoothAdminId];
        
         system.debug('==******************=====::::'+ParticularJuncID);
        
        BoothDetails1 = [Select Id,FirstName,LastName,CompanyName,Email,Company_website__c,CompanyAddr1__c,
                             CompanyAddr2__c,CompanyCity__c,CompanyCountry__c,CompanyState__c,CompanyFaxNumber__c,
                             Companyphone__c from User where Id =:ParticularJuncID.User_Id__c];
                           
                         system.debug('==&&&&&&&&&&&&&&&&&&=====::::'+BoothDetails1 );
         
        
        for(User BooAdm :BoothDetails1 )
        {
            if(BoothAdminId!= null && BoothAdminId!='')
            {
                displayBoothinfoPopUp = true;
                returnList.add(BooAdm);
                break;
            }
            
        }
        
        //return null;
    }
    
    Public void Close(){
    displayBoothinfoPopUp = false;
    }
    
    Public List<Booth__c> OnlyBoothInfo {get;set;}
    Public Booth__c MapBoothID{get;set;}
    
    public void getOnlyBoothdetails()
    {
        system.debug('=========BoothAdminId::::'+BoothAdminId);
        
        MapBoothID = new Booth__c();
        
        User_Profile_Event__c ParticularJuncID = [select EV_ID__c,BT_id__c,User_Id__c from User_Profile_Event__c where id =: BoothAdminId];
        
         system.debug('==******************=====::::'+ParticularJuncID);
        
        OnlyBoothInfo = [Select Id,BT_BoothUserCount__c,BT_ContactEmail__c,BT_ContactName__c,BT_ContactPhone__c,BT_Description__c,BT_isBoothActive__c,
                             BT_Location__c,BT_Name__c,BT_PDFLocation__c,   BT_Phone__c,BT_RegistrationLink__c,
                             BT_WebsiteURL__c from  Booth__c where Id =:ParticularJuncID.BT_id__c];
                           
                         system.debug('==&&&&&&&&&&&&&&&&&&=====::::'+OnlyBoothInfo);
         
        
        for(Booth__c BoothInfo:OnlyBoothInfo )
        {
            if(BoothAdminId!= null && BoothAdminId!='')
            {
                displayBoothDetailsPopUp = true;
                MapBoothID = BoothInfo;
                break;
            }
            
        }
        
        //return null;
    }
   
    Public Void UpdateBooth(){
    
               MapBoothID.BT_BoothUserCount__c   =  MapBoothID.BT_BoothUserCount__c;
               MapBoothID.BT_ContactEmail__c     =  MapBoothID.BT_ContactEmail__c;
               MapBoothID.BT_ContactName__c      =  MapBoothID.BT_ContactName__c;
               MapBoothID.BT_ContactPhone__c     =  MapBoothID.BT_ContactPhone__c;
               MapBoothID.BT_Description__c      =  MapBoothID.BT_Description__c;
               MapBoothID.EV_id__c               =  SelectEvent;
               MapBoothID.BT_isBoothActive__c    =  true;
               MapBoothID.BT_Location__c         =  MapBoothID.BT_Location__c;
               MapBoothID.BT_Name__c             =  MapBoothID.BT_Name__c;
               MapBoothID.BT_Phone__c            =  MapBoothID.BT_Phone__c;
               MapBoothID.BT_RegistrationLink__c =  MapBoothID.BT_RegistrationLink__c;
               MapBoothID.BT_WebsiteURL__c       =  MapBoothID.BT_WebsiteURL__c;
               
               Update MapBoothID;    
        }
   
   Public void CancelUpdateBooth(){
   displayBoothDetailsPopUp = false;
   }
   
    public PageReference Reportsaction() {
        return null;
    }


    public PageReference AttendeesAction() {
    pagereference pg = new Pagereference('/apex/qrcode_Eventadmin_attendees');
    pg.setredirect(true);
        return pg;
        
    }


    public PageReference BoothAction() {
        return null;
    }


    public PageReference EventAction() {
    pagereference pg = new Pagereference('/apex/BL_Eventadmin_Events');
    pg.setredirect(true);
        return pg;
    }


    public PageReference ProfileSettings() {
        return null;
    }

}