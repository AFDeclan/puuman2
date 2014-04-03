//
//  MyTopicViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "MyTopicViewController.h"
#import "VotingCell.h"
#import "TopicCell.h"
#import "TextTopicCell.h"
#import "PhotoTopicCell.h"

@interface MyTopicViewController ()

@end

@implementation MyTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         replays = [[NSMutableArray alloc] init];
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

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    return [replays count];;
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    TopicCell *cell;
    Reply *replay = [replays objectAtIndex:[indexPath row]];
    if ([replay.textUrls count] != 0) {
        identifier = @"ReplayTextTopicCell";
        cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell  =[[TextTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
    }else if ([replay.photoUrls count] !=0)
    {
        identifier = @"ReplayPhotoTopicCell";
        cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell  =[[PhotoTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }else{
        if (!cell) {
            cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    [cell setIsMyTopic:YES];
    [cell buildWithReply:replay];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
      return  [TopicCell heightForReplay:[replays objectAtIndex:[indexPath row]] andIsMyTopic:YES];
  
    
}



@end
