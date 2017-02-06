//
//  SearchPlanetViewController.m
//  GeekTrustApplication
//
//  Created by Prajakta Vishwas Sonawane on 1/17/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "SearchPlanetViewController.h"
#import "Packets.h"
#import "APIFile.h"
#import "DataObject.h"
#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "NSObject+SBJson.h"
#import "FindingFalconeResultViewController.h"
#import "Reachability.h"

//static int tapCount = 0;

@interface SearchPlanetViewController ()
{
    int totalNo;
    int vehicalSpeedValue;
    int planetDistanceValue;
    int tapCount;
   
    UIActivityIndicatorView *spinner;
    NSString *vehicalNameString;
    NSMutableArray *totalTempPlanetArry;
    NSMutableArray *totalDistancePlanetArry;

}

@property (strong, nonatomic) NSMutableArray *planetNameArry;
@property (strong, nonatomic) NSMutableArray *totalVehicalArry;
@property (strong, nonatomic) NSMutableArray *totalPlanetArry;
@property (strong, nonatomic) NSMutableArray *totalVehicalDistanceArry;
@property (strong, nonatomic) NSMutableArray *totalPlanetDistanceArry;
@property (strong, nonatomic) NSMutableArray *totalSpeedArry;
@property (strong, nonatomic) NSMutableArray *vehicalNameArry;
@property (strong, nonatomic) NSMutableArray *vehicalTotalNoArry;
@property (strong, nonatomic) NSMutableArray *selectedPlanetIntergerNo;
@property (strong, nonatomic) NSString *planetNameString;
@property (strong, nonatomic) NSString *planetDistanceString;
@property (strong, nonatomic) UITextField *searchPlanetTextField;
@property (strong, nonatomic)  NSMutableDictionary *selectedImageViewDict;
@property (strong, nonatomic) UIView *middleView;
@property (assign,nonatomic) BOOL isClicked;
@property (assign,nonatomic) BOOL isBtnPress;
@property (assign,nonatomic) BOOL isBackBtnPress;
@property (assign,nonatomic) BOOL isSelectedCell;
@property (assign,nonatomic) int tempSelectedRow;
@property (assign,nonatomic) int previousTotalNo;
@property (assign,nonatomic) int tempSelectedRowForPlanet;


@end

@implementation SearchPlanetViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.totalVehicalArry = [[NSMutableArray alloc]init];
    self.totalPlanetArry = [[NSMutableArray alloc]init];
    self.selectedPlanetIntergerNo = [[NSMutableArray alloc]init];
    self.totalPlanetDistanceArry = [[NSMutableArray alloc]init];
    self.totalVehicalDistanceArry = [[NSMutableArray alloc]init];
    self.selectedImageViewDict = [[NSMutableDictionary alloc]init];
    self.vehicalTotalNoArry = [[NSMutableArray alloc]init];
    totalDistancePlanetArry = [[NSMutableArray alloc]init];
    self.planetListTabel = [[UITableView alloc] init];
    self.vehicalTabel = [[UITableView alloc] init];
    totalTempPlanetArry = [[NSMutableArray alloc]init];
    self.planetListTabel.dataSource = self;
    self.planetListTabel.delegate = self;
    self.vehicalTabel.delegate = self;
    self.vehicalTabel.dataSource = self;
  
    tapCount = 0;
    self.previousTotalNo = -1;
 
}
-(void) viewWillAppear:(BOOL)animated
{
    
    self.tempSelectedRow = -1;
    self.timeTaken = 0;
    [self screenView];
    self.containerView = [[UIView alloc]init];
    self.middleView = [[UIView alloc] init];
    self.upperView = [[UIView alloc] init];
    self.findingFalLabel = [[UILabel alloc] init];
    self.textFeildView = [[UIView alloc] init];
    self.stepLabel = [[UILabel alloc] init];
    self.nextBtn = [[UIButton alloc] init];
    self.selectLabel = [[UILabel alloc] init];
    self.planetLabel = [[UILabel alloc] init];
    self.arrowBtn = [[UIButton alloc] init];
    self.backBtn = [[UIButton alloc]init];
    self.backgroundView = [[UIView alloc] init];
    self.planetDistanceLabel = [[UILabel alloc] init];
  
    [self.view addSubview:self.containerView];
    [self.upperView addSubview:self.findingFalLabel];
    [self.upperView addSubview:self.backBtn];
    [self.containerView addSubview:self.selectLabel];
    [self.containerView addSubview:self.nextBtn];
    [self.containerView addSubview:self.upperView];
    [self.middleView addSubview:self.stepLabel];
    [self.middleView  addSubview:self.textFeildView];
     [self.middleView addSubview:self.planetDistanceLabel];
    [self.middleView  addSubview:self.planetLabel];
    [self.middleView  addSubview:self.vehicalTabel];
    
    
    [self.backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *backBtnImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    backBtnImage.image = [UIImage imageNamed:@"backImage"];
    [self.backBtn addSubview:backBtnImage];
    
    [self.findingFalLabel setFrame:CGRectMake(120, 20,self.view.frame.size.width , 30)];
    [self.planetListTabel setHidden:YES];
    [spinner stopAnimating];
    [self.containerView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    [self.containerView setBackgroundColor:[UIColor orangeColor]];
    
    [self.upperView setFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    [self.upperView setBackgroundColor:[UIColor whiteColor]];
    
    [self.findingFalLabel setFont:[UIFont fontWithName:@"Helvetica Neue bold" size:18]];
    self.findingFalLabel.text = @"Finding Folcone !";
    self.findingFalLabel.textColor = [UIColor orangeColor];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(150, self.upperView.frame.origin.y + self.upperView.frame.size.height + 20, 70, 70)];
    img.image = [UIImage imageNamed:@"page2image4904"];
    [self.containerView addSubview:img];
    
    [self.selectLabel setFrame:CGRectMake(50, img.frame.origin.y + img.frame.size.height + 30, self.self.upperView.frame.size.width-80, 20)];
    [self.selectLabel setFont:[UIFont fontWithName:@"Helvetica Neue bold" size:13]];
    self.selectLabel.textColor = [UIColor whiteColor];
    self.selectLabel.text = @"Select planets you want to search in";
    
    [self.middleView setFrame:CGRectMake(50, self.selectLabel.frame.origin.y + self.selectLabel.frame.size.height + 20 ,self.view.frame.size.width-100, 340)];
    [self.middleView  setBackgroundColor:[UIColor whiteColor]];
    self.middleView .layer.cornerRadius = 3;
    [self.containerView addSubview:self.middleView];
    
    [self.backBtn setFrame:CGRectMake(5, 10, 45, 45)];
    
    [self.nextBtn setFrame:CGRectMake(0, self.middleView.frame.origin.y + self.middleView.frame.size.height + 45,self.view.frame.size.width , 60)];
    UILabel *nextLabel =  [[UILabel alloc] initWithFrame:CGRectMake(140,2 ,100 , 38)];
    [nextLabel setText:@"Continue"];
    [nextLabel setFont:[UIFont fontWithName:@"Helvetica Neue Bold" size:11]];
    [self.nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    nextLabel.textColor = [UIColor whiteColor];
    [self.nextBtn addSubview:nextLabel];
    [self.nextBtn setBackgroundColor:[UIColor darkGrayColor]];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.nextBtn.frame.size.width , 1)];
    [lineView setBackgroundColor:[UIColor whiteColor]];
    [self.nextBtn addSubview:lineView];
    [self screenView];
    //[self postAPI:nil];
}
-(IBAction)backBtnAction:(id)sender
{
    if (tapCount != 0) {
        
        self.isBackBtnPress = YES;
        tapCount --;
        [self.selectedPlanetIntergerNo removeLastObject];
        [self.totalPlanetArry removeLastObject];
        [self.totalVehicalArry removeLastObject];
        [self.totalPlanetDistanceArry removeLastObject];
        [self.totalVehicalDistanceArry removeLastObject];
    
        self.previousTotalNo = self.previousTotalNo+1;
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.vehicalTotalNoArry];
        [mutableArray replaceObjectAtIndex:self.tempSelectedRow withObject:[NSNumber numberWithInteger:self.previousTotalNo]];
        self.vehicalTotalNoArry = mutableArray;
       
        [self screenView];
        self.searchPlanetTextField.text = @"";
        self.planetDistanceLabel.text = @"";
        self.searchPlanetTextField.text = [NSString stringWithFormat:@"%@",[totalTempPlanetArry objectAtIndex:tapCount]];
        self.planetDistanceLabel.text = [NSString stringWithFormat:@"Distance  %@",[totalDistancePlanetArry objectAtIndex:tapCount]];
    
        [totalTempPlanetArry removeLastObject];
        [totalDistancePlanetArry removeLastObject];
    }
}

-(void) postAPI:(NSDictionary*)dic
{
    
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithDictionary:dic];//if your json structure is something like {"title":"first title","blog_id":"1"}
    
    if ([NSJSONSerialization isValidJSONObject:userDictionary])
    {
        NSError* error;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error: &error];
        NSURL* url = [NSURL URLWithString:@"https://findfalcone.herokuapp.com/token"];
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
        [request setHTTPMethod:@"POST"];//use POST
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-length"];
        [request setHTTPBody:jsonData];//set data
        __block NSError *error1 = [[NSError alloc] init];
        
        //use async way to connect network
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse* response,NSData* data,NSError* error)
         {
             if ([data length]>0 && error == nil) {
                 NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
                 NSLog(@"resultsDictionary is %@",resultsDictionary);
                 
             } else if ([data length]==0 && error ==nil) {
                 NSLog(@" download data is null");
             } else if( error!=nil) {
                 NSLog(@" error is %@",error);
             }
         }];
    }
    
}

-(void) shadowBtn:(UIButton*)btnName
{
    btnName.layer.cornerRadius = btnName.frame.size.width / 2;
    [btnName setBackgroundColor:[UIColor orangeColor]];
    [btnName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnName.layer.shadowColor = [UIColor whiteColor].CGColor;
    btnName.layer.shadowRadius = 1.0;
    btnName.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    btnName.layer.shadowOpacity = 1.0;

    
}

-(void) shadowSelectedBtn:(UIButton*)btnName
{
    btnName.layer.cornerRadius = btnName.frame.size.width / 2;
    [btnName setBackgroundColor:[UIColor orangeColor]];
    [btnName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnName.layer.shadowColor = [UIColor blackColor].CGColor;
    btnName.layer.shadowRadius = 1.0;
    btnName.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    btnName.layer.shadowOpacity = 1.0;
}
-(void) screenView
{

    if (tapCount == 0)
        [self.backBtn setHidden:YES];
    else
        [self.backBtn setHidden:NO];
    

    [self.planetLabel setFrame:CGRectMake(25, 10, self.middleView .frame.size.width-90, 30)];
    self.planetLabel.text = @"planet";
    [self.planetLabel setTextColor:[UIColor lightGrayColor]];
    [self.planetLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];

    
    [self.stepLabel setFrame:CGRectMake(self.planetLabel.frame.origin.x + self.planetLabel.frame.size.width , 10,self.view.frame.size.width , 30)];
    [self.stepLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    
    switch (tapCount) {
        case 0:
            self.stepLabel.text = @"STEP 1";
        break;
            
        case 1:
            self.stepLabel.text = @"STEP 2";
        break;
            
        case 2:
            self.stepLabel.text = @"STEP 3";
        break;
            
        case 3:
            self.stepLabel.text = @"STEP 4";
        break;
        default:
            break;
    }
    
    self.stepLabel.textColor = [UIColor orangeColor];
    
    [self.textFeildView setFrame:CGRectMake(23, self.planetLabel.frame.origin.y + self.planetLabel.frame.size.height + 5,self.middleView .frame.size.width -50, 40)];
    [self.textFeildView setBackgroundColor:[UIColor orangeColor]];
    
    
    [self.backgroundView setFrame:CGRectMake(1, 1,self.textFeildView.frame.size.width-2 , self.textFeildView.frame.size.height-2)];
    [self.backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self.textFeildView addSubview:self.backgroundView];
    
    self.searchPlanetTextField = [[UITextField alloc] init];
    self.searchPlanetTextField.delegate = self;
    [self.searchPlanetTextField  setFrame:CGRectMake(3, 1,self.backgroundView.frame.size.width-3 , self.backgroundView.frame.size.height-1)];
    [self.searchPlanetTextField setBackgroundColor:[UIColor whiteColor]];
    [self.searchPlanetTextField setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    self.searchPlanetTextField.textColor = [UIColor orangeColor];
    self.searchPlanetTextField.placeholder = @" Select planet";
    
    
    [self.planetDistanceLabel setFrame:CGRectMake(150, self.textFeildView.frame.origin.y + self.textFeildView.frame.size.height + 10 , 100, 20)];
    [self.planetDistanceLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
    self.planetDistanceLabel.textColor = [UIColor orangeColor];
   
    
    [self.arrowBtn setFrame:CGRectMake(0, 0, self.searchPlanetTextField.frame.size.width,  self.searchPlanetTextField.frame.size.height)];
    [self.arrowBtn setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(180, 15, 15, 10)];
    [self.arrowBtn addTarget:self action:@selector(downArrowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    arrowImg.image = [UIImage imageNamed:@"images.png"];
    [self.arrowBtn addSubview:arrowImg];
    [self.searchPlanetTextField addSubview:self.arrowBtn];
    [self.backgroundView addSubview:self.searchPlanetTextField];
    
    
    
    [self.planetListTabel setFrame:CGRectMake(21, self.textFeildView.frame.origin.y + self.textFeildView.frame.size.height + 5,self.middleView .frame.size.width - 60, 200)];
    [self.middleView  addSubview:self.planetListTabel];
    [self.planetListTabel setHidden:YES];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(140, 160);
    spinner.tag = 12;
    [self.middleView addSubview:spinner];
   

    [self.vehicalTabel setFrame:CGRectMake(23, self.textFeildView.frame.origin.y + self.textFeildView.frame.size.height+50 ,self.middleView .frame.size.width - 60, 200)];
    
    [self.vehicalTabel setHidden:YES];
   
}

-(void) callVehicalAPI
{

    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please check your newtwork availability" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else{
        Request *pRequest = nil;
        [APIFile callServerAPIWithRequest:&pRequest httpMethodType:hTTPMethodGet AndDictionry:nil AndRequestIDIdentifier:GET_VEHICALS_DATA_INFO_REQUEST_ID];
        
        RequestStatus *reqSt=pRequest.requestStatus;
        [reqSt addObserver:self forKeyPath:KEY_PATH_REQUEST_STATUS options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(__bridge void*)pRequest];
        
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

-(void) callSerachPlanetAPI
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please check your newtwork availability" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else {
        //other actions.
        Request *pRequest = nil;
        [APIFile callServerAPIWithRequest:&pRequest httpMethodType:hTTPMethodGet AndDictionry:nil AndRequestIDIdentifier:GET_PLANETS_GET_REQUEST_ID];
        
        RequestStatus *reqSt=pRequest.requestStatus;
        [reqSt addObserver:self forKeyPath:KEY_PATH_REQUEST_STATUS options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(__bridge void*)pRequest];
    }

    
    

    
}

-(IBAction)downArrowButtonAction:(id)sender
{
    if (tapCount == 0 && self.isBtnPress == NO && self.isBackBtnPress == NO) {
        [self callSerachPlanetAPI];
        [self.backgroundView setUserInteractionEnabled:NO];
    }
    if (self.vehicalTabel.isHidden == NO) {
        [self.vehicalTabel setHidden:YES];
    }
   
    [self.planetListTabel reloadData];
    [spinner startAnimating];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView == self.planetListTabel)
    {
        return [self.planetNameArry count];
    }
    else if(tableView == self.vehicalTabel)
    {
        return [self.vehicalNameArry count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"TableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if (tableView == self.planetListTabel) {
        
         [self.planetListTabel setHidden:NO];
        self.planetListTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        int i =(int) [indexPath row];
        
        
        [spinner stopAnimating];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.planetNameArry valueForKey:@"name"] objectAtIndex:indexPath.row]];
        [self.planetListTabel setHidden:NO];
        [cell.textLabel setTextColor:[UIColor orangeColor]];
        [cell setUserInteractionEnabled:YES];
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            if ([self.selectedPlanetIntergerNo containsObject:[NSNumber numberWithInteger:i]])
            {
                [cell.textLabel setTextColor:[UIColor lightGrayColor]];
                [cell setUserInteractionEnabled:NO];
            }

            else
            {
                
                [cell.textLabel setTextColor:[UIColor orangeColor]];
                [cell setUserInteractionEnabled:YES];
            }
    }
    else if(tableView == self.vehicalTabel)
    {
        [self.vehicalTabel setHidden:NO];
        [spinner stopAnimating];
        self.vehicalTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIButton *selectButton = [[UIButton alloc]init];
        [selectButton setFrame:CGRectMake(0,0, 45, 45)];
        [selectButton setUserInteractionEnabled:NO];
        [selectButton setTag:indexPath.row];
        [cell addSubview:selectButton];
        
        UIImageView *selectButtonImageView = [[UIImageView alloc]init];
        [selectButtonImageView setFrame:CGRectMake(10, 10, 20, 20)];
        [selectButton addSubview:selectButtonImageView];
        [selectButtonImageView setImage:[UIImage imageNamed:@"Active State-50"]];
      
        [spinner stopAnimating];

        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectButton.frame.origin.x+selectButton.frame.size.width+3, 13, self.vehicalTabel.frame.size.width - 70, 15)];
        textLabel.text = [NSString stringWithFormat:@"%@",[[ self.vehicalNameArry valueForKey:@"name"] objectAtIndex:indexPath.row]];
        [textLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
        [cell addSubview:textLabel];
        
        UILabel *totalTextlabel = [[UILabel alloc] initWithFrame:CGRectMake(textLabel.frame.origin.x+textLabel.frame.size.width, 13, 20, 15)];
        [totalTextlabel setTextColor:[UIColor darkGrayColor]];
        

        totalTextlabel.text =  [NSString stringWithFormat:@"%@",[self.vehicalTotalNoArry objectAtIndex:indexPath.row]];
        [cell addSubview:totalTextlabel];
        
        
        int planetDistance = [[[self.vehicalNameArry valueForKey:@"max_distance"]objectAtIndex:indexPath.row] intValue];
        
        if ([totalTextlabel.text isEqualToString:@"0"]  || planetDistance < [self.planetDistanceString intValue])
        {
            
            textLabel.textColor = [UIColor lightGrayColor];
            [selectButtonImageView setImage:[UIImage imageNamed:@"unchecked"]];
            totalTextlabel.textColor = [UIColor lightGrayColor];
            [cell.textLabel setTextColor:[UIColor lightGrayColor]];
            cell.userInteractionEnabled = NO;
        }
        else
        {
            
            [self.selectedImageViewDict setObject:selectButtonImageView forKey:[NSNumber numberWithLong:indexPath.row]];
            textLabel.textColor = [UIColor darkGrayColor];
            totalTextlabel.textColor = [UIColor darkGrayColor];
            [selectButtonImageView setImage:[UIImage imageNamed:@"Active State-50"]];
            [cell.textLabel setTextColor:[UIColor orangeColor]];
            cell.userInteractionEnabled = YES;
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
        
        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectButton.frame.origin.x+selectButton.frame.size.width+3, textLabel.frame.origin.y+textLabel.frame.size.height+3, 100, 20)];
        distanceLabel.text = [NSString stringWithFormat:@"Distance  %@",[[ self.vehicalNameArry valueForKey:@"max_distance"] objectAtIndex:indexPath.row]];
        [distanceLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10]];
        distanceLabel.textColor = [UIColor lightGrayColor];
        [cell addSubview:distanceLabel];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.planetListTabel ) {
        self.planetNameString = [NSString stringWithFormat:@"%@", [[self.planetNameArry valueForKey:@"name"] objectAtIndex:indexPath.row]];
        self.planetDistanceLabel.text = nil;
        
        self.planetDistanceString = [NSString stringWithFormat:@"%@", [[self.planetNameArry valueForKey:@"distance"] objectAtIndex:indexPath.row]];
        
        planetDistanceValue = [self.planetDistanceString intValue];
        self.searchPlanetTextField.text = self.planetNameString;
        self.planetDistanceLabel.text = @"";
        self.planetDistanceLabel.text = [NSString stringWithFormat:@"Distance  %@",self.planetDistanceString];
        [spinner startAnimating];
        [self.searchPlanetTextField setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
        [self.searchPlanetTextField setTextColor:[UIColor orangeColor]];
        [self.planetListTabel setHidden:YES];
        self.tempSelectedRowForPlanet = (int)indexPath.row;
        if ([self.vehicalTabel isHidden]==YES && tapCount == 0)
               [self callVehicalAPI];
        else
             [self.vehicalTabel reloadData];
            
    }
    else if (tableView == self.vehicalTabel)
    {
        
        UIImageView *imageView = [self.selectedImageViewDict objectForKey:[NSNumber numberWithLong:indexPath.row]];
        [imageView setImage:[UIImage imageNamed:@"Circled Dot-50"]];
        if(self.tempSelectedRow >= 0)
        {
                UIImageView *imageView = [self.selectedImageViewDict objectForKey:[NSNumber numberWithInt:self.tempSelectedRow]];
                [imageView setImage:[UIImage imageNamed:@"Active State-50"]];
        }
        if(self.tempSelectedRow == indexPath.row)
        {
            UIImageView *imageView = [self.selectedImageViewDict objectForKey:[NSNumber numberWithInt:self.tempSelectedRow]];
            self.isClicked = (self.isClicked == YES) ? NO: YES;
            
            if(self.isClicked == YES)
                [imageView setImage:[UIImage imageNamed:@"Circled Dot-50"]];
            else
                [imageView setImage:[UIImage imageNamed:@"Active State-50"]];
        }
        else
        {
            self.isClicked = NO;
        }
       
        self.tempSelectedRow = (int)indexPath.row;
        vehicalNameString = [NSString stringWithFormat:@"%@",[[self.vehicalNameArry valueForKey:@"name"]objectAtIndex:indexPath.row]];
        
        vehicalSpeedValue =[ [[self.vehicalNameArry valueForKey:@"speed"]objectAtIndex:indexPath.row]intValue];
        self.previousTotalNo = [[self.vehicalTotalNoArry objectAtIndex:indexPath.row]intValue];
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    Request *pRequest = ((__bridge Request*)context);
    switch (pRequest.requestStatus.requestStatus)
    {
        case REQUEST_INITIALIZED:
        case REQUEST_ON_NETWORKING:
        case REQUEST_ON_DATAPROCESSING:
            break;
            
        case REQUEST_FINISHED:
        {
            if(pRequest.requestID == GET_PLANETS_GET_REQUEST_ID)
            {
                self.planetNameArry = [DataObject getInstance].searchPlanetNameRespArray;
                [self.planetListTabel reloadData];
               
        
            }
            else if(pRequest.requestID == GET_VEHICALS_DATA_INFO_REQUEST_ID)
            {
                
                self.vehicalNameArry = [DataObject getInstance].reaultVehicalRespArray;
                self.vehicalTotalNoArry = [self.vehicalNameArry valueForKey:@"total_no"];
                [self.vehicalTabel setHidden:NO];
                [self.vehicalTabel reloadData];
                [self.planetListTabel setHidden:YES];
                
            }
            else if(pRequest.requestID == POST_TOKEN_REQUEST_ID)
            {
                if(pRequest.requestStatus.statusMessage == nil)
                {
                    [self callFinalResultAPI];
                }
                else if ([pRequest.requestStatus.statusMessage isEqualToString:@"false"])
                {
                    [spinner stopAnimating];
                }
            }
            else if(pRequest.requestID == POST_RESULT_REQUEST_ID)
            {
                if ([[DataObject getInstance].resultStatus isEqualToString:@"success"] || [[DataObject getInstance].resultStatus isEqualToString:@"false"])
                {
                    [spinner stopAnimating];
                    [self performSegueWithIdentifier:@"resultScreenSegue" sender:self];
                }
            
            }
        }
    }
    [pRequest.requestStatus removeObserver:self forKeyPath:KEY_PATH_REQUEST_STATUS];
    
}

-(void)callFinalResultAPI
{
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please check your newtwork availability" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else
    {
    
        Request *pRequest = nil;
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
        NSString *jsonRequest = [NSString stringWithFormat:@"{\"token\":\"%@\",\"planet_names\":%@,\"vehicle_names\":%@}",[DataObject getInstance].tokenString,[self.totalPlanetArry JSONRepresentation],[self.totalVehicalArry JSONRepresentation]];
        [dataDic setObject:jsonRequest forKey:@"data"];
    
        [APIFile callServerAPIWithRequest:&pRequest httpMethodType:hTTPMethodPost AndDictionry:dataDic AndRequestIDIdentifier:POST_RESULT_REQUEST_ID];
    
        RequestStatus *reqSt=pRequest.requestStatus;
        [reqSt addObserver:self forKeyPath:KEY_PATH_REQUEST_STATUS options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(__bridge void*)pRequest];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.vehicalTabel) {
        return 60;
    }
    return 40;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchPlanetTextField resignFirstResponder];
    return YES;
}


-(void)callTokanAPI
{
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please check your newtwork availability" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else
    {
    
        Request *pRequest = nil;
        [APIFile callServerAPIWithRequest:&pRequest httpMethodType:hTTPMethodPost AndDictionry:nil AndRequestIDIdentifier:POST_TOKEN_REQUEST_ID];
    
        RequestStatus *reqSt=pRequest.requestStatus;
        [reqSt addObserver:self forKeyPath:KEY_PATH_REQUEST_STATUS options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(__bridge void*)pRequest];
    }
    
}

-(IBAction)nextBtnAction:(id)sender
{
    if (self.planetNameString == nil)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select planet" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    else if (vehicalNameString == nil)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select available vehical" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    else
    {
        tapCount++;
        self.isBtnPress = NO;
        
        self.previousTotalNo = self.previousTotalNo-1;
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.vehicalTotalNoArry];
        [mutableArray replaceObjectAtIndex:self.tempSelectedRow withObject:[NSNumber numberWithInteger:self.previousTotalNo]];
        self.vehicalTotalNoArry = mutableArray;
        [self.selectedPlanetIntergerNo addObject:[NSNumber numberWithInt:self.tempSelectedRowForPlanet]];
        [totalTempPlanetArry addObject:self.planetNameString];
        [totalDistancePlanetArry addObject:[NSNumber numberWithInt:planetDistanceValue]];
        [self.totalPlanetArry addObject:self.planetNameString];
        [self.totalVehicalArry addObject:vehicalNameString];
        [self.totalPlanetDistanceArry addObject:[NSNumber numberWithInt:planetDistanceValue]];
        [self.totalVehicalDistanceArry addObject:[NSNumber numberWithInt:vehicalSpeedValue]];
   
            if (tapCount == 4) {
        
                [self callTokanAPI];
                [self.backBtn setHidden:YES];
                [spinner startAnimating];
        
                int takenTimeCal = 0;
                for (int i = 0; i< [self.totalPlanetDistanceArry count]; i++) {
                    int planetDitance = [[self.totalPlanetDistanceArry objectAtIndex:i]intValue];
                    int vehicalSpeed = [[self.totalVehicalDistanceArry objectAtIndex:i]intValue];
                    takenTimeCal = planetDitance  / vehicalSpeed;
                    self.timeTaken = self.timeTaken + takenTimeCal;
                }
            }
            else
            {
                self.planetDistanceLabel.text = @"";
                [self.vehicalTabel setHidden:YES];
                [self.planetListTabel setHidden:YES];
                [self.backgroundView setUserInteractionEnabled:YES];
                [self screenView];
            }
    }
  
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"resultScreenSegue"]) {
        
        FindingFalconeResultViewController *findingVC = (FindingFalconeResultViewController*) segue.destinationViewController;
        findingVC.timeTaken = self.timeTaken;
    }
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
