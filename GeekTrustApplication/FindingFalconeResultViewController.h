//
//  FindingFalconeResultViewController.h
//  GeekTrustApplication
//
//  Created by Prajakta Vishwas Sonawane on 1/22/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindingFalconeResultViewController : UIViewController

@property (strong, nonatomic) NSString *status;
 @property (strong, nonatomic) NSString *planetFoundStr;
@property (strong, nonatomic)  UILabel *successLabel;
@property (strong, nonatomic) UILabel *tameTaken;
@property (strong, nonatomic) UILabel *planetFound;

@property (strong, nonatomic)  UIButton *startAgainButton;
@property (strong, nonatomic) NSString *succesStr;
@property (strong, nonatomic) NSString *failStr;
@property (assign, nonatomic) int timeTaken;

@end
