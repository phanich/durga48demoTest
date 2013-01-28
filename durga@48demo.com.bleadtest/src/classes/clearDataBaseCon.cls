public with sharing class clearDataBaseCon {
 public string  s{get;set;}
 public string  p{get;set;}
 public string  q{get;set;}
    public String selected { get; set; }
public List<Sobject> listOfObjects{get;set;}
public  List<SelectOption> options {get;set;}
public clearDataBaseCon() {
s='BL_Pricing__c,Event__c,EventSchedule__c';

p ='Event_Attendee_Mapping__c';

q ='SecurityControls__c,User_CheckinHistory__c,User_Profile_Event__c,Reports__c,Event_Invitee__c,TicketTypes__c,AttendeePaidHistory__c,Booth_Qrcode__c,DeviceUsage__c';


}


public Pagereference clear(){

listOfObjects = new  List<Sobject>();
string [] po = new string[]{};
po=s.split(',');
for(string sl:po){
string cun ='select id from '+sl; 
listOfObjects = dataBase.query(cun);
system.debug('rrrrrrrrrrrr '+listOfObjects.size());
if(listOfObjects !=null){
delete listOfObjects;
listOfObjects  = new List<Sobject>();
}
}






for(string s3:q.split(',')){
string cun ='select id from '+s3; 
listOfObjects = dataBase.query(cun);
system.debug('rrrrrrrrrrrr '+listOfObjects.size());
if(listOfObjects !=null){
delete listOfObjects;
listOfObjects  = new List<Sobject>();
}
}




for(string s3:p.split(',')){
string cun ='select id from '+s3; 
listOfObjects = dataBase.query(cun);
system.debug('rrrrrrrrrrrr '+listOfObjects.size());
if(listOfObjects !=null){
delete listOfObjects;
listOfObjects  = new List<Sobject>();
}
}

return null;
}





}