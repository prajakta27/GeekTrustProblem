//
//  DataObject.m
//  GeekTrustApplication
//
//  Created by Prajakta Vishwas Sonawane on 1/17/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "DataObject.h"
#import <UIKit/UIKit.h>

@implementation DataObject

static DataObject *DataObjectObject =nil;

+(DataObject*) getInstance
{
    if (DataObjectObject == nil) {
        
        DataObjectObject = [[self alloc] init];
    }
    return DataObjectObject;
}
-(void) handleFailureResponseWithRequest:(Request*) request withError:(NSError*)e
{
    NSLog(@"error-->>%@",e);
}

- (void)handleNetworkResponseWithRequest:(Request *)request withError:(NSError*)e
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                    message:@"There is some internet problem, Thank you"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    NSLog(@"net not working");
    
}

- (void)handleSuccessResponseWithRequest:(Request *)request AndResponse:(Response *)response
{
    NSDictionary *resp = nil;
    resp = (NSDictionary *)response.responseData;
    if([response.responseData isKindOfClass:[NSDictionary class]])
    {
        resp = (NSDictionary *)response.responseData;
    }
    else if([response.responseData isKindOfClass:[NSArray class]]){
        
    }
    switch (request.requestID)
    {
        case GET_PLANETS_GET_REQUEST_ID:
            [self storeResponseForGetPlanetApi:response];
            break;
            
        case GET_VEHICALS_DATA_INFO_REQUEST_ID:
            [self storeResponseForGetVehicalApi:response];
            break;
        case POST_TOKEN_REQUEST_ID:
            [self storeTokenApi:response];
            break;
        case POST_RESULT_REQUEST_ID:
            [self storeResultApi:response];
            break;
            
        default:
            break;
    }
    request.requestStatus.requestStatus = REQUEST_FINISHED;
    
}

-(void) storeResponseForGetPlanetApi:(Response*)response
{
    NSMutableArray *resp = (NSMutableArray *)response.responseData;
    self.searchPlanetNameRespArray = [[NSMutableArray alloc]init];
    if([resp isKindOfClass:[NSArray class]])
    {
        self.searchPlanetNameRespArray = resp;
    }
}

-(void) storeResponseForGetVehicalApi:(Response*)response
{
    NSMutableArray *resp = (NSMutableArray *)response.responseData;
    self.reaultVehicalRespArray = [[NSMutableArray alloc]init];
    if([resp isKindOfClass:[NSArray class]])
    {
        self.reaultVehicalRespArray = resp;
    }
}
-(void) storeTokenApi:(Response*)response
{
    NSMutableArray *resp = (NSMutableArray *)response.responseData;
    self.tokenString = [NSString stringWithFormat:@"%@",[resp valueForKey:@"token"]];
    NSLog(@"%@",resp);
}
-(void) storeResultApi:(Response*)response
{
    NSMutableArray *resp = (NSMutableArray *)response.responseData;
//    if([resp isKindOfClass:[NSArray class]])
//    {
        self.resultStatus = [NSString stringWithFormat:@"%@",[resp valueForKey:@"status"]];
        self.resultPlanet = [NSString stringWithFormat:@"%@",[resp valueForKey:@"planet_name"]];
 //   }
}



@end
