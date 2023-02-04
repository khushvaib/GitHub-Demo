public class Services {

    // future method 
    @future(callout=true)
    public static void getWeatherData(String city){
        
        String apiKey = '5340a8fd26ea3ab4f4d228be2a3c4b70';
        // setting up endpoint url
        String requestEndPoint = 'https://api.openweathermap.org/data/2.5/weather';
        requestEndPoint += '?q='+city;
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

            system.debug('temprature: '+ String.valueOf(mainResults.get('temp')));
            system.debug('pressure: '+ String.valueOf(mainResults.get('pressure')));
            system.debug('humidity: '+ String.valueOf(mainResults.get('humidity')));
            system.debug('minimum temprature: '+ String.valueOf(mainResults.get('temp_min')));
            system.debug('maximum temprature: '+ String.valueOf(mainResults.get('temp_max')));
            
        }else{
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'There was an error reading Data');
            ApexPages.addMessage(msg);
        }
    }

}