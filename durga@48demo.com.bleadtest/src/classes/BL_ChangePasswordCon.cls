/**
 * An apex page controller that exposes the change password functionality
 */

public class BL_ChangePasswordCon {
    
    
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    public Boolean backBoolean{get; set;}        
    
    public Pagereference changePassword() {
      
    try{
    pageReference success ;
      // return Site.changePassword(newPassword, verifyNewPassword, oldpassword);    
     success  = Site.changePassword(newPassword, verifyNewPassword, oldpassword);  
     
     system.debug('1111111111111111111 '+success );  
     if(success!=null){    
      Id loggedid = UserInfo.getUserId();
       User Us =[select id,password__c from User where id=:loggedid];
       Us.password__c = newPassword;
       Update Us;
      system.debug('22222222222222222222 '+success ); 
      
      system.debug('3333333333333333333  '+userInfo.getProfileId()); 
       if(userInfo.getProfileId()=='00eF0000000FYkB'){
       	 system.debug('4444444444444  '); 
       Pagereference pg = new Pagereference('/apex/BL_EventAdmin_Dashboard');
       pg.setredirect(True); 
       return pg;
      }else if(userInfo.getProfileId()=='00eF0000000FYkG'){
       system.debug('5555555555555555555   '); 
       Pagereference pg = new Pagereference('/apex/BL_boothadmin_dashboard');
       pg.setredirect(True); 
       return pg;
      
      } else{
      	 system.debug('66666666666666666666666  '); 
        return null;
      } 
      
           
 }else{
 return null;
 }
 
        
    }catch(exception ex){
    
      
    
    
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
    Apexpages.addMessage(myMsg);
     return null;
    
   
    }  
   
       
  } 
  
  public PageReference Back() {
        Pagereference pg = new Pagereference('/apex/BL_Eventadmin_Profile');
        pg.setredirect(True); 
            return pg;
  }
    
     
    public BL_ChangePasswordCon() {backBoolean = FALSE;}
    
    public BL_ChangePasswordCon(Boolean b) {
        backBoolean = b;
    }
    public static testMethod void testChangePasswordController() {
        // Instantiate a new controller with all parameters in the page
        ChangePasswordController controller = new ChangePasswordController();
        controller.oldPassword = '123456';
        controller.newPassword = 'qwerty1'; 
        controller.verifyNewPassword = 'qwerty1';                
        
        System.assertEquals(controller.changePassword(),null);                           
    }    
}