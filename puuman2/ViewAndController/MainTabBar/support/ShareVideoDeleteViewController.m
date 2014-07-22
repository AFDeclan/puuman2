//
//  ShareVideoDeleteViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-22.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShareVideoDeleteViewController.h"
#import "UniverseConstant.h"

@interface ShareVideoDeleteViewController ()

@end

@implementation ShareVideoDeleteViewController
@synthesize delegate =_delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        SetViewLeftUp(_titleLabel, 0, 56);
        [_titleLabel setText:@"您还未保存，确定要退出么？"];
        saveLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 130, 80, 20)];
        [saveLabel setText:@"现在保存"];
        [saveLabel setTextColor:PMColor2];
        [saveLabel setFont:PMFont2];
        [saveLabel setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:saveLabel];
        
        deleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(334, 130, 80, 20)];
        [deleteLabel setText:@"直接退出"];
        [deleteLabel setTextColor:PMColor2];
        [deleteLabel setFont:PMFont2];
        [deleteLabel setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:deleteLabel];
        
        saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(78, 112, 56, 56)];
        [saveBtn setImage:[UIImage imageNamed:@"saveShareVideo.png"] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:saveBtn];
        
        deleteBtn= [[UIButton alloc] initWithFrame:CGRectMake(270, 112, 56, 56)];
        [deleteBtn setImage:[UIImage imageNamed:@"deleteShareVideo.png"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:deleteBtn];

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


- (void)saveBtnPressed
{
    [saveBtn setEnabled:NO];

    [_deleteDelegate saveShareVideo];
    
}

- (void)deleteBtnPressed
{
    [_deleteDelegate deleteShareVideo];
    
    
}

- (void)show
{
    [self.view showInFrom:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
}

- (void)hidden
{
    
    [self.view hiddenOutTo:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
}


- (void)finishOut
{
    [_delegate popViewfinished];
    [super finishOut];
    
}


@end
