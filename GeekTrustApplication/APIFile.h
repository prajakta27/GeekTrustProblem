//
//  APIFile.h
//  GeekTrustApplication
//
//  Created by Prajakta Vishwas Sonawane on 1/17/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Packets.h"
#import "ConstantStrings.h"
#import "DataObject.h"

@interface APIFile : NSObject
+ (APIFile*)getInstance;
-(void) sendHTTPGet:(NSString*)APIurl withRequestIDIdentifier:(REQUESTID)requestIDIdentifier;

+ (void)callServerAPIWithRequest:(Request**)passedRequest httpMethodType:(HTTPMethodNames)httpMethodType AndDictionry:(NSDictionary*)dic AndRequestIDIdentifier:(REQUESTID)requestIDIdentifier;



@end
