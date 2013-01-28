public with sharing class sampleapgeUrl {

    public PageReference save() {
    system.debug('1111111111111111111111 '+ datetimevalue);
    bvs.Follow_Update__c=dateTime.valueOf(datetimevalue);
    system.debug('222222222222222222 '+ bvs.Follow_Update__c);
    update bvs; 
        return null;
    }


    public String datetimevalue { get; set; }
public BoothVisitSummary__c bvs {get;set;}

public sampleapgeUrl(){
 bvs = [select id,Follow_Update__c from BoothVisitSummary__c  where id='a08O0000002mqx1'];
}









/**
public dateTime urlbase{get;set;}
public Datetime orgId {get;set;}
public Account bv{get;set;}
public dateTime br{get;set;}
public sampleapgeUrl (){
dateTime d=system.now();
system.debug('1111111111111111 '+d);
br = getLocalDateTime(dateTime.valueOf(string.valueOf('2012-12-21 16:16:29 Am')));

bv =[select CreatedDate from Account where  createdDate>:br];
urlbase =bv.createdDate;
// dateTime urlbase1 =bv.createdDate;
//urlbase =getLocalDateTime(urlbase1);


}
**/
public static Datetime getLocalDateTime(Datetime z)
    {    
        Datetime l = z.Date();
        l = l.addHours(z.hour());
        l = l.addMinutes(z.minute());
        l = l.addSeconds(z.second());
       
        return l;
    }
  

}