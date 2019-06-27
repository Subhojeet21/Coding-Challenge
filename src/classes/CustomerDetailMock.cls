/* This class is used to generate a dummy response to mock the REST callout done from the test class*/ 
@isTest
public class CustomerDetailMock implements HttpCalloutMock {
    
    public HttpResponse respond(HttpRequest req){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"CustomerId":1,"CustomerName":"Testgym ASDF"},{"CustomerId":2,"CustomerName":"Testgym qwertz"},{"CustomerId":123,"CustomerName":"Testgym ChangeName 2"},{"CustomerId":200,"CustomerName":"Testgym 200"},{"CustomerId":201,"CustomerName":"Testgym 201"}]');
        response.setStatusCode(200);
        return response;
    }

}