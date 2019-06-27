/*
 * This class makes a REST callout to the external system and synchronize the accounts in Salesforce.
 * Call fetchCustomer() method - to make a REST callout.
 * insertUpdateCustomers method - will be called internally to insert/update accounts
 * 
 * Before intial synchronization - Comment line number 16 which add the header to the request.
 */
public class GetCustomerDetails {

    /* Method to make callout and fetch customer details from external system*/
    public static HttpResponse fetchCustomer(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Customer_Details');
        req.setMethod('GET');
        req.setHeader('If-Modified-Since', '2019-06-28T12:00:27.87'); // Comment this line on intial synchronization
        HttpResponse res = http.send(req);
        if(res.getStatusCode() == 200){
            List<CustomerDetail> customerDetails = (List<CustomerDetail>) JSON.deserialize(res.getBody(), List<CustomerDetail>.class);
        	
        	insertUpdateCustomers(customerDetails);
        }
        return res;
    }
    
    /* Method to insert/update customer details fetched from external system*/
    private static void insertUpdateCustomers(List<CustomerDetail> details){
        List<Account> accList = new List<Account>();
        for(CustomerDetail detail : details){
            accList.add(new Account(Name = detail.CustomerName, CustomerId__c = detail.CustomerId));
        }
        try{
            upsert accList CustomerId__c;
        }catch(DmlException ex){
            System.debug(ex.getMessage());
		}
    }
    
    /* Inner class to map the HTTP response */
    public class CustomerDetail {
        String CustomerId;
        String CustomerName;
    }
}