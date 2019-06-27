/* This is the test class of GetCustomerDetails */
@isTest
public class GetCustomerDetails_Test {
	
    public static testmethod void fetchCustomerTest(){
        Test.setMock(HttpCalloutMock.class, new CustomerDetailMock());
        Test.startTest();
        	HttpResponse res = GetCustomerDetails.fetchCustomer();
        	System.assertEquals(200, res.getStatusCode());
        Test.stopTest();
    }
    
}