public with sharing class WoWDataAPI {
    
    public static void fetchItemMedia(Integer itemId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Data_API/data/wow/media/item/' + itemId + '?locale=en_US&namespace=static-us');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() == 200) {
            ItemMediaObject media = new ItemMediaObject();
            media = (ItemMediaObject)JSON.deserialize(res.getBody().replaceAll('_links', 'links'), ItemMediaObject.class);
            System.debug(media);
        } else {
            System.debug('Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
    }

}