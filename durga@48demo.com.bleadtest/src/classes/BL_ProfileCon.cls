public with sharing class BL_ProfileCon {

    public Blob boothadminimage { get; set; }
    public Document mydoc {get; set;}
    public String imagename { get; set; }
    public List<inn> listinn{get;set;}
public List<SelectOption> optionsevediversity {get;set;}
List<SelectOption> optionsevediversity2 {get;set;}
public List<string> optionsAttdiversity {get;set;}
public List<Event_Attendee_Mapping__c> eventslist{get;set;}
public List<string> optionsattdiversity2 {get;set;}
    public MAP<Id,Event_Attendee_Mapping__c> mapIdandObject{get;set;}
    public String selectedgender { get; set; }

    public String HomePoBox { get; set; }

    public String HomeZipcode { get; set; }

    public String ShippingPoBox { get; set; }

    public String ShippingZipcode { get; set; }

    public String WorkPoBox { get; set; }

    public String WorkZipCode { get; set; }

    public String NAICSCode5 { get; set; }

    public String NAICSCode4 { get; set; }

    public String NAICSCode3 { get; set; }

    public String NAICSCode2 { get; set; }

    public String NAICSCode1 { get; set; }

    public String BusinessDunsNumber { get; set; }

    public String BusinessTaxId { get; set; }

    public String BusinessRevenue { get; set; }

    public String NumberOfEmployees { get; set; }

    public String age { get; set; }
    
   
    
    public PageReference login() {
   if(userInfo.getUserType()=='guest'){
    Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
    pg.setredirect(true);
        return pg;
   
   } 
   
   List<User_Profile_Event__c> ty =new  List<User_Profile_Event__c>();
      ty=[select Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:userInfo.getUserName() and Profile_id__r.PR_Name__c='eventadmin'];
       if(ty.size()>0){
       Pagereference pg = new pagereference('/apex/BL_EventAdmin_Dashboard');
       pg.setredirect(true);
        return pg;
       
       }else{
       return null;
       }    
      
  }

   


    
    public boolean booleanforDisplayBoothadminTab { get; set; }

  public PageReference save() {
   
   try{ 
   if(boothadminimage.size() != null)
   { 
      document mydoc =new document();
      mydoc.body = boothadminimage;
      mydoc.folderid = UserInfo.getUserId();
      mydoc.ispublic=true;
      mydoc.Name = 'erererer';
      insert mydoc; 
      listOfSummary.AS_ImageUrl__c= mydoc.id;
     }
  }catch(exception e){
  
  }
    
  listOfSummary.AS_Gender__c =selectedgender; 
  if(age != null && age !=''){
  listOfSummary.AS_Age__c= decimal.valueOf(age);
  }
   if(NumberOfEmployees!= null && NumberOfEmployees!=''){
  listOfSummary.AS_NumberOfEmployees__c =decimal.valueOf(NumberOfEmployees);
  }
   if(BusinessRevenue!= null && BusinessRevenue!=''){
  listOfSummary.AS_BusinessRevenue__c =decimal.valueOf(BusinessRevenue);  }
  /**
  if(BusinessTaxId!= null && BusinessTaxId!=''){
  listOfSummary.AS_BusinessTaxId__c =decimal.valueOf(BusinessTaxId);  
  }
  if(BusinessDunsNumber!= null && BusinessDunsNumber!=''){
  listOfSummary.AS_BusinessDunsNumber__c = decimal.valueOf(BusinessDunsNumber); 
  }
  */
   if(NAICSCode1!= null && NAICSCode1!=''){
  listOfSummary.AS_NAICSCode1__c =decimal.valueOf(NAICSCode1); 
  }
  if(NAICSCode2!= null && NAICSCode2!=''){
  listOfSummary.AS_NAICSCode1__c =decimal.valueOf(NAICSCode2); 
  }
  if(NAICSCode3!= null && NAICSCode3!=''){
  listOfSummary.AS_NAICSCode1__c =decimal.valueOf(NAICSCode3); 
  }
  if(NAICSCode4!= null && NAICSCode4!=''){
  listOfSummary.AS_NAICSCode1__c =decimal.valueOf(NAICSCode4); 
  }
  if(NAICSCode5!= null && NAICSCode5!=''){
  listOfSummary.AS_NAICSCode1__c =decimal.valueOf(NAICSCode5); 
  }
  if(WorkZipCode!= null && WorkZipCode!=''){
  listOfSummary.AS_WorkZipCode__c= decimal.valueOf(WorkZipCode); 
  }
  
  if(WorkPoBox!= null && WorkPoBox!=''){
  listOfSummary.AS_WorkPoBox__c= decimal.valueOf(WorkPoBox);
  }
    if(ShippingZipcode!= null && ShippingZipcode!=''){
  listOfSummary.AS_ShippingZipcode__c= decimal.valueOf(ShippingZipcode); 
  }
     if(ShippingPoBox!= null && ShippingPoBox!=''){
  listOfSummary.AS_ShippingPoBox__c= decimal.valueOf(ShippingPoBox); 
  }
   if(HomePoBox!= null && HomePoBox!=''){
  listOfSummary.AS_HomePoBox__c= decimal.valueOf(HomePoBox); 
  }
    if(HomeZipcode!= null && HomeZipcode!=''){
  listOfSummary.AS_HomeZipcode__c= decimal.valueOf(HomeZipcode);
  }
listOfSummary.AS_uniqueField__c =(listOfSummary.AS_FirstName__c+listOfSummary.AS_LastName__c+listOfSummary.AS_Email__c).tolowercase();

  saveDiversity();
   
  update listOfSummary;
    
   user u=[select FirstName,LastName,Email,Title from user where email =:userInfo.getUserName() limit 1];
   //user u=[select FirstName,LastName,Email,Title from user where email =:'durga+boothadmin1@globalnest.com' limit 1];
   
    u.FirstName = listOfSummary.AS_FirstName__c;
    u.LastName =listOfSummary.AS_LastName__c;
    u.Title =listOfSummary.AS_Title__c;
    u.States__c=listOfSummary.AS_Work_States__c;
    u.Country__c=listOfSummary.AS_Work_Country__c;
    u.City =listOfSummary.AS_WorkCity__c;
    update u;
    
    
   List<Event_Attendee_Mapping__c> updateList= new List<Event_Attendee_Mapping__c>();
   map<id,string> mapAejandDiversity = new map<id,string>();   
   for(inn h:listinn){
   string strAfterformation='';
   string[] total = new string[]{};
   total=h.optionsAttdiversityInn; 
   total.addAll(h.optionsAttdiversityInn2);
   for(string tre:total){
   if(strAfterformation ==''){
   strAfterformation=tre+';';
   }else{
   strAfterformation = strAfterformation+tre+';';
   }
   }
   system.debug('yyyyyyyyyyyy '+strAfterformation);
   Event_Attendee_Mapping__c obj =mapIdandObject.get(h.iInn);
   obj.DiversityType__c = strAfterformation;
   updateList.add(obj);
   } 
   update updateList;
   
   
   
  string urlforRedirect =Apexpages.Currentpage().getParameters().get('url');  
  system.debug('ZZZZZZZZZZZZZZZZ '+urlforRedirect );
  if(urlforRedirect !=null && urlforRedirect !=''){
   pageReference pg = new pageReference('/apex/'+urlforRedirect);
   pg.setRedirect(true);
   return pg; 
   }else{
   pageReference pg = new pageReference('/apex/BL_BoothAdmin_Dashboard');
   pg.setRedirect(true);
   return pg; 
    }   
}
public string bolId {get;set;}
public AttendeeSummary__c listOfSummary {get;set;}
public LIST<selectoption> states{get;set;}
 public  List<SelectOption> options {get;set;}
public string nodiversity{get;set;}
    public BL_ProfileCon(){ 
   listOfSummary = new AttendeeSummary__c();
   nodiversity='';
   listOfSummary=[Select a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById,
                  a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                  a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, 
                  a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                  a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode5__c, a.AS_NAICSCode4__c, a.AS_NAICSCode3__c, 
                  a.AS_NAICSCode2__c, a.AS_NAICSCode1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                  a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, 
                  a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c,
                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c From AttendeeSummary__c a 
                  where a.AS_Email__c =: UserInfo.getUserName()  limit 1];
                  
                  //UserInfo.getUserName()---a.AS_BusinessTaxId__c, a.AS_BusinessDunsNumber__c,
           
        options = new  List<SelectOption>();
          
        options.add(new SelectOption('Male','Male')); 
        options.add(new SelectOption('Female','Female')); 
         
         if(listOfSummary.AS_Gender__c =='Male'){
         selectedgender ='Male';
         }else if(listOfSummary.AS_Gender__c =='Female'){
         selectedgender ='Female';
         }
         
         
eventslist = new List<Event_Attendee_Mapping__c>();
eventslist  =[select EV_id__c,EV_id__r.EV_Title__c,EV_id__r.EventDiversityValues__c,DiversityType__c from Event_Attendee_Mapping__c where AS_id__c=:listOfSummary.Id and (EV_id__r.Status__c='Event in Progress' Or EV_id__r.Status__c='Event Registration Open')];
listinn = new List<inn>();
mapIdandObject = new MAP<Id,Event_Attendee_Mapping__c>();
if(eventslist.size()==0){
 nodiversity ='No Diversities found';
 
 }

for(Event_Attendee_Mapping__c at :eventslist){
mapIdandObject.put(at.Id,at);
optionsAttdiversity = new List<string>();
optionsevediversity = new List<SelectOption>();
optionsevediversity2 = new List<SelectOption>();
integer i=0;
 for(string s:at.EV_id__r.EventDiversityValues__c.split(';')){
    if(math.mod(i,2)==0){
    optionsevediversity.add(new SelectOption(s,s));
    }else{
    optionsevediversity2.add(new SelectOption(s,s));
    }
    i++;
  }
  
  if(at.DiversityType__c != null){
  optionsAttdiversity=at.DiversityType__c.split(';');
  optionsattdiversity2 =at.DiversityType__c.split(';');
}
  listinn.add(new inn(at.EV_id__r.EV_Title__c,optionsAttdiversity ,optionsevediversity2,optionsevediversity,at.id,optionsattdiversity2 ));
 
 
 
  }
   
           
           
   age =string.valueOf(listOfSummary.AS_Age__c); 
   NumberOfEmployees=string.valueOf(listOfSummary.AS_NumberOfEmployees__c); 
   BusinessRevenue =string.valueOf(listOfSummary.AS_BusinessRevenue__c); 
  // BusinessTaxId=string.valueOf(listOfSummary.AS_BusinessTaxId__c); 
  // BusinessDunsNumber =string.valueOf(listOfSummary.AS_BusinessDunsNumber__c); 
   NAICSCode1 =string.valueOf(listOfSummary.AS_NAICSCode1__c); 
   NAICSCode2 =string.valueOf(listOfSummary.AS_NAICSCode2__c); 
   NAICSCode3 =string.valueOf(listOfSummary.AS_NAICSCode3__c); 
   NAICSCode4 =string.valueOf(listOfSummary.AS_NAICSCode4__c); 
   NAICSCode5=string.valueOf(listOfSummary.AS_NAICSCode5__c); 
   WorkZipCode =string.valueOf(listOfSummary.AS_WorkZipCode__c); 
   WorkPoBox =string.valueOf(listOfSummary.AS_WorkPoBox__c); 
   ShippingZipcode =string.valueOf(listOfSummary.AS_ShippingZipcode__c); 
   ShippingPoBox =string.valueOf(listOfSummary.AS_ShippingPoBox__c); 
   HomeZipcode =string.valueOf(listOfSummary.AS_HomeZipcode__c); 
   HomePoBox =string.valueOf(listOfSummary.AS_HomePoBox__c); 
   
   
   states = new LIST<selectoption>();
        states.add(new SelectOption('None','--None--'));
        states.add(new SelectOption('AL','Alabama'));
        states.add(new SelectOption('AK', 'Alaska'));
        states.add(new SelectOption('AZ','Arizona'));
        states.add(new SelectOption('AR','Arkansas'));
        states.add(new SelectOption('CA','California'));
        states.add(new SelectOption('CO','Colorado'));
        states.add(new SelectOption('CT','Connecticut'));
        states.add(new SelectOption('DE','Delaware'));
        states.add(new SelectOption('DC','District of Columbia'));
        states.add(new SelectOption('FL','Florida'));
        states.add(new SelectOption('GA','Georgia'));
        states.add(new SelectOption('HI','Hawaii'));
        states.add(new SelectOption('ID','Idaho'));
        states.add(new SelectOption('IL','Illinois'));
        states.add(new SelectOption('IN','Indiana'));
        states.add(new SelectOption('IA','Iowa'));
        states.add(new SelectOption('KS','Kansas'));
        states.add(new SelectOption('KY','Kentucky'));
        states.add(new SelectOption('LA','Louisiana'));
        states.add(new SelectOption('ME','Maine'));
        states.add(new SelectOption('MD','Maryland'));
        states.add(new SelectOption('MA','Massachusetts'));
        states.add(new SelectOption('MI','Michigan'));
        states.add(new SelectOption('MN','Minnesota'));
        states.add(new SelectOption('MS','Mississippi'));
        states.add(new SelectOption('MO','Missouri'));
        states.add(new SelectOption('MT','Montana'));
        states.add(new SelectOption('NE','Nebraska'));
        states.add(new SelectOption('NV','Nevada'));
        states.add(new SelectOption('NH','New Hampshire'));
        states.add(new SelectOption('NJ','New Jersey'));
        states.add(new SelectOption('NM','New Mexico'));
        states.add(new SelectOption('NY','New York'));
        states.add(new SelectOption('NC','North Carolina'));
        states.add(new SelectOption('ND','North Dakota'));
        states.add(new SelectOption('OH','Ohio'));
        states.add(new SelectOption('OK','Oklahoma'));
        states.add(new SelectOption('OR','Oregon'));
        states.add(new SelectOption('PA','Pennsylvania'));
        states.add(new SelectOption('RI','Rhode Island'));
        states.add(new SelectOption('SC','South Carolina'));
        states.add(new SelectOption('SD','South Dakota'));
        states.add(new SelectOption('TN','Tennessee'));
        states.add(new SelectOption('TX','Texas'));
        states.add(new SelectOption('UT','Utah'));
        states.add(new SelectOption('VT','Vermont'));
        states.add(new SelectOption('VA','Virginia'));
        states.add(new SelectOption('WA','Washington'));
        states.add(new SelectOption('WV','West Virginia'));
        states.add(new SelectOption('WI','Wisconsin'));
        states.add(new SelectOption('WY','Wyoming'));
   
   
   
   
   if(listOfSummary.AS_DiversityType__c != NULL){
   if(listOfSummary.AS_DiversityType__c.contains('Minority Owned Business Enterprise'))
   Select0 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Disadvantaged Business Enterprise'))
   select1 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Service Disabled Veteran Business Enterprise'))
   Select2 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Small Business Enterprise'))
   select3 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Ability One'))
   Select4 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Woman Owned Business Enterprise'))
    Select5 = True;
   if(listOfSummary.AS_DiversityType__c.contains('SBA 8(A) Program'))
   Select6 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Veteran Owned Business Enterprise'))
   Select7 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Lesbian Gay Bisexual Transgender Business'))
   Select8 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Alaskan Native Corporation Owned Firm'))
   Select9 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Small Disadvantaged Business'))
   Select10 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Historically Underutilized Business Zone'))
   Select11 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Disabled Business Enterprise'))
   Select12 = True;
   if(listOfSummary.AS_DiversityType__c.contains('Historically Black Colleges And Universities'))
   Select13 = True;
   if(listOfSummary.AS_DiversityType__c.contains('SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS '))
   Select14 = True;
 }  
 
 booleanforDisplayBoothadminTab = false;
 List<User_Profile_Event__c>  forDisplayBoothdmintab= [Select u.User_id__c,u.Profile_id__r.PR_Name__c,u.User_id__r.Name, u.UEP_isActive__c, u.SystemModstamp, u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c u where u.User_id__r.Email=:userInfo.getUserName()];
    for(User_Profile_Event__c tt:forDisplayBoothdmintab){
      if(tt.Profile_id__r.PR_Name__c !='Attendee' && tt.Profile_id__r.PR_Name__c !='BoothPersonnel' ){
       booleanforDisplayBoothadminTab = true;
      }   
    }
 
  }
    
 //Diversity Type
 
   Public List<String> Selvalue {get;set;}
    Public Boolean Select0{get;set;}
    Public Boolean Select1{get;set;}
    Public Boolean Select2{get;set;}
    Public Boolean Select3{get;set;}
    Public Boolean Select4{get;set;}
    Public Boolean Select5{get;set;}
    Public Boolean Select6{get;set;}
    Public Boolean Select7{get;set;}
    Public Boolean Select8{get;set;}
    Public Boolean Select9{get;set;}
    Public Boolean Select10{get;set;} 
    Public Boolean Select11{get;set;}
    Public Boolean Select12{get;set;}
    Public Boolean Select13{get;set;}
    Public Boolean Select14{get;set;}   
    
    Public string selectedvaluesfordiversity{get;set;}
    
    Public Void saveDiversity(){
    
    Selvalue =new LIST<String> ();
    if(Select0 == TRUE)
    selValue.add('Minority Owned Business Enterprise');
    if(Select1== TRUE)
    selValue.add('Disadvantaged Business Enterprise');
    if(Select2== TRUE)
    selValue.add('Service Disabled Veteran Business Enterprise');
    if(Select3== TRUE)
    selValue.add('Small Business Enterprise');
    if(Select4== TRUE)
    selValue.add('Ability One');
    if(Select5== TRUE)
    selValue.add('Woman Owned Business Enterprise');
    if(Select6== TRUE)
    selValue.add('SBA 8(A) Program');
    if(Select7== TRUE)
    selValue.add('Veteran Owned Business Enterprise');
    if(Select8== TRUE)
    selValue.add('Lesbian Gay Bisexual Transgender Business');
    if(Select9== TRUE)
    selValue.add('Alaskan Native Corporation Owned Firm');
    if(Select10== TRUE)
    selValue.add('Small Disadvantaged Business');
    if(Select11== TRUE)
    selValue.add('Historically Underutilized Business Zone');
    if(Select12== TRUE)
    selValue.add('Disabled Business Enterprise');
    if(Select13== TRUE)
    selValue.add('Historically Black Colleges And Universities');
    if(Select14== TRUE)
    selValue.add('SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ');
    
    selectedvaluesfordiversity= '';
    for(string s: selValue)
        {
            selectedvaluesfordiversity+=s+';';
    listOfSummary.AS_DiversityType__c = selectedvaluesfordiversity;
        }
    
    }

public class inn{
 public List<SelectOption> optionsevediversityInn {get;set;}
 public List<string> optionsAttdiversityInn {get;set;}
 public List<SelectOption> optionsevediversityInn2 {get;set;}
 public List<string> optionsAttdiversityInn2 {get;set;}
 public Id iInn{get;set;}
 public string eventName{get;set;}
 public inn(string s,List<string> l1,List<selectOption> l2,List<selectOption> l3,id i,List<string> l4){
 this.eventName =s;
 this.optionsAttdiversityInn =l1;
 this.optionsAttdiversityInn2 =l4;
 this.optionsevediversityInn =l2;
 this.optionsevediversityInn2 =l3;
 this.iInn =i;
 }
}
static testmethod void BL_ProfileCon()
{
 Profile p = [select id from profile where name='Standard User'];
   
   User u = new User(alias = 'test123', email='test123@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing',firstname='FirstTesting', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123@noemail.com');
   insert u;
   
   Event__c ev = new Event__c(EV_Title__c='TestEvent',
                             EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/16/2014'),
                             EV_EndTime__c='09:00 PM',
                             StartTime__c='09:00 AM',
                             EventDiversityValues__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS '
                             );
   insert ev;
   
   User_Profile_Event__c upe=new User_Profile_Event__c(EV_id__c=ev.id,BoothAdmin_id__c=u.id,EventAdmin_Id__c=u.id,User_id__c=u.id);
   insert upe;  
      
   AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c=20,AS_BirthDate__c=date.valueOf('1995-05-05'),AS_BlogUrl__c='www.globalnest.com',AS_BusinessDescription__c='fgsdamnabfbhsd',AS_BusinessDunsNumber__c='2450153',
               AS_BusinessEstablishedDate__c=date.valueOf('1995-05-06'),AS_BusinessRevenue__c=324533,AS_BusinessTaxId__c='hngsdvdvf',AS_CellPhone__c='9858590231',
               AS_Company__c='testattendeecompany',AS_DiversityType__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
               AS_Email__c='test123@noemail.com',AS_FaxNumber__c='9858985032',AS_FirstName__c='testattendeesummaryfirstname',AS_Gender__c='Male',
               AS_HomeAddress1__c='mjbfnmf',AS_HomeAddress2__c='nbdfhj',AS_HomeCity__c='mhsdfgfd',As_Home_Country__c='India',AS_HomePhone__c='6998878422',
               AS_HomePoBox__c=22125,AS_HomePoboxNo__c='84367',As_Home_State__c='Goa',AS_HomeZipcode__c=32121,AS_ImageUrl__c='www.globalnest.com',AS_LastName__c='testattendeelastname',AS_NAICSCode1__c=524621,
               AS_NAICSCode2__c=524421,AS_NAICSCode3__c=524671,AS_NAICSCode4__c=523621,AS_NAICSCode5__c=528921,AS_NumberOfEmployees__c=200,AS_prefixNew__c='mr',
               AS_PrimaryBusinessCategory1__c='Accounting',AS_SecondaryBusinessCategory1__c='Animation',AS_ShippingAddress1__c='dfdf',AS_ShippingAddress2__c='dsyhg',
               AS_ShippingCity__c='asfdsf',As_Shipping_Country__c='India',AS_ShippingPhone__c='3554353132',AS_ShippingPoBox__c=32224,AS_Shippingpoboxno__c='35521',As_Shipping_States__c='Goa',
               AS_shippingzip__c='32122',AS_ShippingZipcode__c=89524,AS_SuffixNew__c='dr',AS_ThroughEventBrite__c=true,AS_Title__c='hmjnhgh',AS_WebsiteUrl__c='hasdas.com',AS_WorkAddress1__c='dsag',
               AS_WorkAddress2__c='fdwe',AS_WorkCity__c='ewqrwd',AS_Work_Country__c='India',AS_WorkPhone__c='3554353132',AS_WorkPoBox__c=52346,AS_Workpoboxno__c='85231',AS_Work_States__c='Goa',AS_WorkZipCode__c=85246,AS_WorkZip__c='89523',
               Registration_type__c='kdsmkas');
   insert att; 
   
   AttendeeSummary__c att1 = new AttendeeSummary__c(AS_Age__c=20,AS_BirthDate__c=date.valueOf('1995-05-05'),AS_BlogUrl__c='www.globalnest.com',AS_BusinessDescription__c='fgsdamnabfbhsd',AS_BusinessDunsNumber__c='2450153',
               AS_BusinessEstablishedDate__c=date.valueOf('1995-05-06'),AS_BusinessRevenue__c=324533,AS_BusinessTaxId__c='hngsdvdvf',AS_CellPhone__c='9858590231',
               AS_Company__c='testattendeecompany',AS_DiversityType__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
               AS_Email__c='test123@noemail.com',AS_FaxNumber__c='9858985032',AS_FirstName__c='testattendeesummaryfirstname',AS_Gender__c='Female',
               AS_HomeAddress1__c='mjbfnmf',AS_HomeAddress2__c='nbdfhj',AS_HomeCity__c='mhsdfgfd',As_Home_Country__c='India',AS_HomePhone__c='6998878422',
               AS_HomePoBox__c=22125,AS_HomePoboxNo__c='84367',As_Home_State__c='Goa',AS_HomeZipcode__c=32121,AS_ImageUrl__c='www.globalnest.com',AS_LastName__c='testattendeelastname',AS_NAICSCode1__c=524621,
               AS_NAICSCode2__c=524421,AS_NAICSCode3__c=524671,AS_NAICSCode4__c=523621,AS_NAICSCode5__c=528921,AS_NumberOfEmployees__c=200,AS_prefixNew__c='mr',
               AS_PrimaryBusinessCategory1__c='Accounting',AS_SecondaryBusinessCategory1__c='Animation',AS_ShippingAddress1__c='dfdf',AS_ShippingAddress2__c='dsyhg',
               AS_ShippingCity__c='asfdsf',As_Shipping_Country__c='India',AS_ShippingPhone__c='3554353132',AS_ShippingPoBox__c=32224,AS_Shippingpoboxno__c='35521',As_Shipping_States__c='Goa',
               AS_shippingzip__c='32122',AS_ShippingZipcode__c=89524,AS_SuffixNew__c='dr',AS_ThroughEventBrite__c=true,AS_Title__c='hmjnhgh',AS_WebsiteUrl__c='hasdas.com',AS_WorkAddress1__c='dsag',
               AS_WorkAddress2__c='fdwe',AS_WorkCity__c='ewqrwd',AS_Work_Country__c='India',AS_WorkPhone__c='3554353132',AS_WorkPoBox__c=52346,AS_Workpoboxno__c='85231',AS_Work_States__c='Goa',AS_WorkZipCode__c=85246,AS_WorkZip__c='89523',
               Registration_type__c='kdsmkas');
   insert att1; 
   
   Event_Attendee_Mapping__c eam=new Event_Attendee_Mapping__c(EV_id__c=ev.id,AS_id__c=att.id,
   DiversityType__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
   TicketTypes__c='Reception',EA_AttendeeBarcode__c='a0DO0000002nMqmMAE-a0EO0000002fPtZMAU');
   insert eam;
   
   Event_Attendee_Mapping__c eam1=new Event_Attendee_Mapping__c(EV_id__c=ev.id,AS_id__c=att1.id,
   DiversityType__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
   TicketTypes__c='Reception',EA_AttendeeBarcode__c='a0DO0000002nMqmMAE-a0EO0000002fPtZMAU');
   insert eam1;
  
   BoothVisitSummary__c bvs=new BoothVisitSummary__c(ScanTime__c=datetime.valueOf('2012-05-15 00:00:00'),User_id__c=u.id,EA_AttendeeBarcode__c=eam.id);
   insert bvs;
   
   BoothVisitSummary__c bvs1=new BoothVisitSummary__c(ScanTime__c=datetime.valueOf('2012-05-15 00:00:00'),User_id__c=u.id,EA_AttendeeBarcode__c=eam1.id);
   insert bvs1;
  
   User_Event_BVS__c ueb=new User_Event_BVS__c(BVS_id__c=bvs.id,EV_id__c=ev.id,UPE_id__c=upe.id);
   insert ueb;

   List<Event_Attendee_Mapping__c> listOfEvent = new List<Event_Attendee_Mapping__c>();
   listOfEvent.add(eam);
      
   list<Event__c> lev = new list<Event__c>();
   lev.add(ev);
   
   list<User_Profile_Event__c> lupe = new list<User_Profile_Event__c>();
   lupe.add(upe);  
   
   List<id> listid =new List<id>();
   listid.add(eam.id);
   
  // document mydoc =new document();
  // insert mydoc;   
   
 system.runAs(u)
 {   
  BL_ProfileCon blp=new BL_ProfileCon();
  
  blp.login();
  blp.save();
 /** blp.mydoc.body = EncodingUtil.base64Decode('WW91IGNhbiBlbmNvZGUgYSB0ZXN0IGRvY3VtZW50IGFzIGEgYmFzZTY0IHN0cmluZywgdGhlbiBoYW5kIHRoYXQgdmFsdWUgdG8gdGhlIGJsb2Igb2JqZWN0IHlvdSd2ZSBib3VuZCB0byB5b3VyIGlucHV0ZmlsZSdzIGJvZHkgYXR0cmlidXRlLg==');
  blp.mydoc.folderid = u.id;
  blp.mydoc.ispublic=true;
  blp.mydoc.Name = 'erererer';  
  blp.boothadminimage= 
  blp.mydoc.Name = 'erererer';
  blp.mydoc.Body = Blob.valueOf('erererer');
  blp.save(); */
  blp.login();
  blp.saveDiversity();   
  
 }
}
}