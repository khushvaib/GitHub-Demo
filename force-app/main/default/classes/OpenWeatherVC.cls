public class OpenWeatherVC {

    public static string city {get;set;}
    public static string temp {get;set;}
    public static string pressure {get;set;}
    public static string humidity {get;set;}
    public static string temp_min {get;set;}
    public static string temp_max {get;set;}

    public OpenWeatherVC(ApexPages.StandardController stdController) {
		Account account = (Account)stdController.getRecord();
        account = [select id, ShippingCity from Account where id =:account.id];
        String accountCity=account.ShippingCity;
        String apiKey = '5340a8fd26ea3ab4f4d228be2a3c4b70';

        system.debug('city ## '+accountCity);

        String requestEndPoint = 'https://api.openweathermap.org/data/2.5/weather';
        requestEndPoint += '?q='+accountCity;
        requestEndPoint += '&units=metric';
        requestEndPoint += '&APPID='+apiKey;
        system.debug('endPoint: '+requestEndPoint);
        
        // http object creation to connect with server
        Http http = new Http();
        // http request object to set the pre request parameters 
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            city = String.valueOf(results.get('name'));
            Map<String, Object> mainResults = (Map<String, Object>)(results.get('main'));
            
            temp = String.valueOf(mainResults.get('temp'));
            pressure = String.valueOf(mainResults.get('pressure'));
            humidity = String.valueOf(mainResults.get('humidity'));
            temp_min = String.valueOf(mainResults.get('temp_min'));
            temp_max = String.valueOf(mainResults.get('temp_max'));
            
        }else{
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'There was an error reading Data');
            ApexPages.addMessage(msg);
        }
    }

    @future(callout=true)
    public static void getWeatherData(String accountCity, String apiKey){
        
    }

}