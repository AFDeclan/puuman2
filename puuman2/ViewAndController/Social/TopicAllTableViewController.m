//
//  TopicAllTableViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicAllTableViewController.h"

@interface TopicAllTableViewController ()

@end

@implementation TopicAllTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [left_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_like1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_like2_topic.png"] andTitle:@"最多喜欢" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
        [right_sortBtn setSelectedImg:[UIImage imageNamed:@"icon_time1_topic.png"] andUnselectedImg:[UIImage imageNamed:@"icon_time2_topic.png"] andTitle:@"最多喜欢" andButtonType:kButtonTypeTwo andSelectedType:kBlueAndClear];
        [self leftSortSelected];
       
    }
    return self;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,608, 24)];
    [view addSubview:left_sortBtn];
    [view addSubview:right_sortBtn];
    return view;
}


- (void)setVerticalFrame
{
    
}

- (void)setHorizontalFrame
{
    [self.view setFrame:CGRectMake(128, 144, 608, 544)];
}
@end
