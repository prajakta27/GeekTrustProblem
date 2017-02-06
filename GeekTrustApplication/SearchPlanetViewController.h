//
//  SearchPlanetViewController.h
//  GeekTrustApplication
//
//  Created by Prajakta Vishwas Sonawane on 1/17/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPlanetViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>


@property (assign, nonatomic) int timeTaken;
@property (strong, nonatomic)  UITableView *planetListTabel;
@property (strong, nonatomic)  UITableView *vehicalTabel;
@property (strong, nonatomic)  UILabel *planetDistanceLabel;
@property (strong, nonatomic)  UIView *containerView;
@property (strong, nonatomic)  UIButton *radioBtn;
@property (strong, nonatomic)  UILabel *stepLabel;
@property (strong, nonatomic)  UIView *upperView ;
@property (strong, nonatomic)  UILabel *findingFalLabel;
@property (strong, nonatomic)  UIView *textFeildView;
@property (strong, nonatomic)  UIButton *nextBtn;
@property (strong, nonatomic)  UILabel *selectLabel;
@property (strong, nonatomic)  UILabel *planetLabel;
@property (strong, nonatomic)  UIButton *arrowBtn;
@property (strong, nonatomic)  UIButton *backBtn;
@property (strong, nonatomic) UIView *backgroundView;


@end
