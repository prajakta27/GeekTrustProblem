//
//  FindingFalconeResultViewController.m
//  GeekTrustApplication
//
//  Created by Prajakta Vishwas Sonawane on 1/22/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "FindingFalconeResultViewController.h"
#import "Packets.h"
#import "APIFile.h"
#import "DataObject.h"
#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "NSObject+SBJson.h"
#import "FindingFalconeResultViewController.h"

@interface FindingFalconeResultViewController ()
{
    UIView *upperView;
    UILabel *findingFalLabel;
    UIView *containerView;
    UIButton *startAgainButton;

}

@end

@implementation FindingFalconeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void) viewWillAppear:(BOOL)animated
{
    upperView = [[UIView alloc] init];
    findingFalLabel = [[UILabel alloc] init];
    containerView = [[UIView alloc]init];
    startAgainButton = [[UIButton alloc] init];
    
    [containerView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    [containerView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:containerView];
    
    [upperView setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    [upperView setBackgroundColor:[UIColor whiteColor]];
    [containerView addSubview:upperView];
    [containerView addSubview:startAgainButton];
    
    [findingFalLabel setFrame:CGRectMake(120, 25,self.view.frame.size.width , 30)];
    [findingFalLabel setFont:[UIFont fontWithName:@"Helvetica Neue bold" size:17]];
    findingFalLabel.text = @"Finding Folcone !";
    findingFalLabel.textColor = [UIColor orangeColor];
    [upperView addSubview:findingFalLabel];
    [startAgainButton setFrame:CGRectMake(0, containerView.frame.origin.y+containerView.frame.size.height-60,self.view.frame.size.width , 60)];
    
    UILabel *startAgainlabel =  [[UILabel alloc] initWithFrame:CGRectMake(130,2 ,150 , 38)];
    [startAgainlabel setText:@"Start Again"];
    [startAgainlabel setFont:[UIFont fontWithName:@"Helvetica Neue Bold" size:10]];
    [startAgainButton addTarget:self action:@selector(startAgainBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    startAgainlabel.textColor = [UIColor whiteColor];
    [startAgainButton addSubview:startAgainlabel];
    [startAgainButton setBackgroundColor:[UIColor darkGrayColor]];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, startAgainButton.frame.size.width , 1)];
    [lineView setBackgroundColor:[UIColor whiteColor]];
    [startAgainButton addSubview:lineView];
   
    
    UILabel *successLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, upperView.frame.origin.y + upperView.frame.size.height + 60, containerView.frame.size.width - 90, 120)];
    successLabel.numberOfLines = 5;
    successLabel.textAlignment = NSTextAlignmentCenter;
 
    
   


   
    //@"Failure!! King Shah Failed in Finding Falcone.";
    //@"Success!! Congratulations on Finding Falcone. King Shah is mighty pleased.";
    //self.succesOrFailStr;
    [successLabel setTextColor:[UIColor whiteColor]];
     [startAgainlabel setFont:[UIFont fontWithName:@"Helvetica Neue Bold" size:12]];
    [containerView addSubview:successLabel];
    
    UIView *timeAndFoundPlanetView = [[UIView alloc] init];
     [containerView addSubview:timeAndFoundPlanetView];
    UILabel *timeTakenLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 150, 31)];
    timeTakenLabel.text = @"Time Taken :";
    timeTakenLabel.textAlignment = NSTextAlignmentRight;
    [timeTakenLabel setTextColor:[UIColor darkGrayColor]];
    [timeTakenLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
    [timeAndFoundPlanetView addSubview:timeTakenLabel];
    
    
    UILabel *timeTakenLabText = [[UILabel alloc] initWithFrame:CGRectMake(timeTakenLabel.frame.origin.x+timeTakenLabel.frame.size.width +10, 10, 60, 31)];
    timeTakenLabText.text = [NSString stringWithFormat:@"%d",self.timeTaken];
    [timeTakenLabText setTextColor:[UIColor darkGrayColor]];
    [timeTakenLabText setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
    [timeAndFoundPlanetView addSubview:timeTakenLabText];
    
    
    UILabel *planetFoundLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, timeTakenLabText.frame.origin.y + timeTakenLabText.frame.size.height + 30, 150, 31)];
    planetFoundLabel.text = @"Planet Found :";
    planetFoundLabel.textAlignment = NSTextAlignmentRight;
    [planetFoundLabel setTextColor:[UIColor darkGrayColor]];
    [planetFoundLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
    [timeAndFoundPlanetView addSubview:planetFoundLabel];
    
    
    UILabel *planetFoundLabText = [[UILabel alloc] initWithFrame:CGRectMake(timeTakenLabel.frame.origin.x+timeTakenLabel.frame.size.width +10, timeTakenLabText.frame.origin.y + timeTakenLabText.frame.size.height + 30, 150, 31)];
    planetFoundLabText.text = [DataObject getInstance].resultPlanet;
    [planetFoundLabText setTextColor:[UIColor darkGrayColor]];
    [planetFoundLabText setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
    [timeAndFoundPlanetView addSubview:planetFoundLabText];
    
    [timeAndFoundPlanetView setFrame:CGRectMake(0, successLabel.frame.origin.y + successLabel.frame.size.height + 30, containerView.frame.size.width, planetFoundLabText.frame.origin.y + planetFoundLabText.frame.size.height + 20)];
    [timeAndFoundPlanetView setBackgroundColor:[UIColor clearColor]];
   
   
    if ([[DataObject getInstance].resultStatus isEqualToString:@"success"])
    {
        successLabel.text  = @"Success!! Congratulations on Finding Falcone. King Shah is mighty pleased.";
         [timeAndFoundPlanetView setHidden:NO];
    }
    else
    {
        successLabel.text = @"Failure!! King Shah Failed in Finding Falcone.";
         [timeAndFoundPlanetView setHidden:YES];
    }
}

-(IBAction)startAgainBtnAction:(id)sender
{
    [self performSegueWithIdentifier:@"serachPlanetVCSegue" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
