//
//  DataObject.h
//  GeekTrustApplication
//
//  Created by Prajakta Vishwas Sonawane on 1/17/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIFile.h"

@interface DataObject : NSObject

+(DataObject*) getInstance;
-(void)handleSuccessResponseWithRequest:(Request *)request AndResponse:(Response *)response;
- (void)handleNetworkResponseWithRequest:(Request *)request withError:(NSError*)e;
-(void) handleFailureResponseWithRequest:(Request*) request withError:(NSError*)e;
-(void) storeResponseForGetPlanetApi:(Response*)response;
-(void) storeResponseForGetVehicalApi:(Response*)response;


@property (nonatomic, strong) NSMutableArray *searchPlanetNameRespArray;
@property (nonatomic, strong) NSMutableArray *reaultVehicalRespArray;
@property (nonatomic, strong) NSString *tokenString;
@property (nonatomic, copy)   NSString *resultStatus;
@property (nonatomic, copy)   NSString *resultPlanet;


@end
