//
//  APIFile.m
//  GeekTrustApplication
//
//  Created by Prajakta Vishwas Sonawane on 1/17/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "APIFile.h"

@implementation APIFile

static APIFile *APIfileObject =nil;

//CATEGORY---------------READ
//1. Create Object of file--->>static APIFile *APIfileObject =nil;
//2. Create method for file ------->>>> + (APIFile*)getInstance


+ (APIFile*)getInstance
{
    if (APIfileObject == nil)
        APIfileObject = [[self alloc] init];
    
    return APIfileObject;
}

+ (void)callServerAPIWithRequest:(Request**)passedRequest httpMethodType:(HTTPMethodNames)httpMethodType AndDictionry:(NSDictionary*)dic AndRequestIDIdentifier:(REQUESTID)requestIDIdentifier
{
    
    NSString *url;
    switch (requestIDIdentifier)
    {
        case POST_TOKEN_REQUEST_ID:
        {
             url = [NSString stringWithFormat:@"https://findfalcone.herokuapp.com/token"];
        }
            break;
            
        case POST_RESULT_REQUEST_ID:
        {
            url = [NSString stringWithFormat:@"https://findfalcone.herokuapp.com/find"];
        }
          break;
            
        case GET_PLANETS_GET_REQUEST_ID:
        {
            url = [NSString stringWithFormat:@"https://findfalcone.herokuapp.com/planets"];
        }
            break;
        
        case GET_VEHICALS_DATA_INFO_REQUEST_ID:
        {
            url = [NSString stringWithFormat:@"https://findfalcone.herokuapp.com/vehicles"];
        }
            break;
            
        default:
            break;
    }

    Request *pRequest = [[Request alloc] init];
    NSString *aRequestURL = nil;
    
    if(httpMethodType == hTTPMethodGet)
        aRequestURL = url;
    else
        aRequestURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    pRequest.url = [NSURL URLWithString:aRequestURL];
    pRequest.requestID = requestIDIdentifier;
    if(passedRequest)
    {
        *passedRequest = pRequest;
    }
    
    if(httpMethodType == hTTPMethodPost)
    {
        [self sendPostAPIWithURI:url requestId:requestIDIdentifier withDictionry:[dic mutableCopy] forRequest:pRequest];
    }
  
   else  if(httpMethodType == hTTPMethodGet)
    {
        [self sendGetAPIWithURI:url requestId:requestIDIdentifier forRequest:pRequest];
    }
    
}
+(void)sendPostAPIWithURI:(NSString*)urlString requestId:(REQUESTID)requestID withDictionry:(NSMutableDictionary*)dic forRequest:(Request*)pRequest
{
    
   
    NSString *data = [dic valueForKey:@"data"];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{
                                               @"Accept"       : @"application/json",
                                               @"Content-Type"  : @"application/json"
                                               };
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"RESPONSE: %@",response);
        NSLog(@"DATA: %@",data);
        
        if (!error) {
            // Success
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    // Error Parsing JSON
                    [[DataObject getInstance] handleFailureResponseWithRequest:pRequest withError:jsonError];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    Response *response = [[Response alloc]init];
                    response.responseData = jsonResponse;
                    [[DataObject getInstance] handleSuccessResponseWithRequest:pRequest AndResponse:response];
                    
                    NSLog(@"resp-->>%@",jsonResponse);
                }
            }  else
            {
                //Web server is returning an error
            }
        } else {
            // Fail
            NSLog(@"error : %@", error.description);
        }
    }];
    [postDataTask resume];
}

+(void)sendGetAPIWithURI:(NSString*)urlString requestId:(REQUESTID)requestID forRequest:(Request*)pRequest
{
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSString *encodedUrlAsString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"RESPONSE: %@",response);
        NSLog(@"DATA: %@",data);
        
        if (!error) {
            // Success
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    // Error Parsing JSON
                    [[DataObject getInstance] handleFailureResponseWithRequest:pRequest withError:jsonError];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    Response *response = [[Response alloc]init];
                    response.responseData = jsonResponse;
                    [[DataObject getInstance] handleSuccessResponseWithRequest:pRequest AndResponse:response];
                    
                    NSLog(@"resp-->>%@",jsonResponse);
                }
            }  else
            {
                //Web server is returning an error
            }
        }
        else
        {
            NSLog(@"error : %@", error.description);
        }
    }] resume];
    
    
}



@end
