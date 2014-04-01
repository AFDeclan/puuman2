//
//  CompareCartViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CompareCartViewController.h"
#import "CartModel.h"
#import "CartTableViewCell.h"
#import "UniverseConstant.h"

@interface CompareCartViewController ()

@end

@implementation CompareCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       [self initWithContent];
    }
    return self;
}

- (void)initWithContent
{
    
    
    first_ImgView = [[AFImageView alloc] initWithFrame:CGRectMake(136, 112, 192, 192)];
    [_content addSubview:first_ImgView];
    second_ImgView = [[AFImageView alloc] initWithFrame:CGRectMake(424, 112, 192, 192)];
    [_content addSubview:second_ImgView];
    vs = [[UILabel alloc] initWithFrame:CGRectMake(328, 270, 48, 52)];
    [vs setTextColor:PMColor2];
    [vs setFont:PMFont(26)];
    [vs setBackgroundColor:[UIColor clearColor]];
    [vs setText:@"VS"];
    [vs setTextAlignment:NSTextAlignmentCenter];
    [_content addSubview:vs];
   

    
    cartTable = [[UITableView alloc] initWithFrame:CGRectMake(48, 112, 528, 448)];
    [cartTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cartTable setShowsVerticalScrollIndicator:NO];
    [cartTable setDelegate:self];
    [cartTable setDataSource:self];
    [cartTable setBackgroundColor:[UIColor clearColor]];
    [cartTable setBounces:YES];
    [cartTable setAlpha:1];
    [_content addSubview:cartTable];
    
    infoTable = [[UITableView alloc] initWithFrame:CGRectMake(48, 112, 528, 448)];
    [infoTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [infoTable setShowsVerticalScrollIndicator:NO];
    [infoTable setDelegate:self];
    [infoTable setDataSource:self];
    [infoTable setBackgroundColor:[UIColor clearColor]];
    [infoTable setBounces:YES];
    [infoTable setAlpha:1];
    [_content addSubview:infoTable];
    
    first_winBtn = [[ColorButton alloc] init];
    [first_winBtn  initWithTitle:@"胜出" andButtonType:kBlueRight];
    [first_winBtn addTarget:self action:@selector(firstWin) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:first_winBtn];
    second_winBtn = [[ColorButton alloc] init];
    [first_winBtn  initWithTitle:@"胜出" andButtonType:kBlueLeft];
    [first_winBtn addTarget:self action:@selector(secondWin) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:first_winBtn];
    SetViewLeftUp(first_winBtn, 0, 520);
    SetViewLeftUp(first_winBtn, 592, 520);

}

- (void)firstWin
{

}

- (void)secondWin
{

}



#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{

    return [[CartModel sharedCart] UndoCount];
 
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identify = @"ShopTableCell";
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell =  [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }

    [cell setIsCompare:YES];
    [cell buildCellWithPaid:NO andWareIndex:[indexPath row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show
{
    [bgView setBackgroundColor:[UIColor clearColor]];
    [bgView setAlpha:1];
    [_content showInFrom:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
    
}

- (void)closeBtnPressed
{
    [self hidden];
}

- (void)hidden
{
   
    [bgView setAlpha:0];
    [_content hiddenOutTo:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
}

- (void)finishOut
{
    [super dismiss];
    [self.delegate popViewfinished];
    [self.view removeFromSuperview];
}

@end
