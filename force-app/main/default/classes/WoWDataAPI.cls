public with sharing class WoWDataAPI {
    
    public static String fetchItemMedia(Integer itemId) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:US_Data_API/data/wow/media/item/' + itemId + '?locale=en_US&namespace=static-us');
        request.setMethod('GET');
        
        return UtilityMethods.callRetry(request, 'WoWDataAPI.fetchItemMedia()');
    }

}