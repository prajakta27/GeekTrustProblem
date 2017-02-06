//
//  ConstantStrings.h
//  GeekTrustApplication
//
//  Created by Prajakta Vishwas Sonawane on 1/17/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#ifndef ConstantStrings_h
#define ConstantStrings_h

typedef enum
{
    GET_PLANETS_GET_REQUEST_ID,
    GET_VEHICALS_DATA_INFO_REQUEST_ID,
    POST_RESULT_REQUEST_ID,
    POST_TOKEN_REQUEST_ID,
    
    
}REQUESTID;

typedef enum
{
    hTTPMethodGet,
    hTTPMethodPost,
    hTTPMethodPut,
    hTTPMethodDelete,
} HTTPMethodNames;

#define KEY_PATH_REQUEST_STATUS @"requestStatus"
#define STEPONE  @"1"
#define STEPTWO  @"2"
#define STEPTHREE  @"3"
#define STEPFOUR  @"4"




#endif /* ConstantsFile_h */
