//
//  TaskInfoViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TaskInfoViewController.h"
#import "UILabel+AdjustSize.h"
const CGFloat kInfoInset = 16;
@interface TaskInfoViewController ()

@end

@implementation TaskInfoViewController
@synthesize taskInfo = _taskInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self initContent];
        
        
    }
    return self;
}

- (void)initContent
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(32, 112, 640, 460)];
    [_content addSubview:_scrollView];
    _infoImgView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _infoImgView.delegate = self;
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _infoLabel.numberOfLines = 0;
    _infoLabel.font = PMFont2;
    _infoLabel.textColor = PMColor1;
    _infoLabel.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_infoImgView];
    [_scrollView addSubview:_infoLabel];
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

- (void)setTaskInfo:(NSDictionary *)taskInfo
{
    _taskInfo = taskInfo;
    NSString *info = [taskInfo valueForKey:@"info"];
    [_infoLabel setText:info];
    [_infoLabel adjustSizeFixLeftUpWithWidth:640-2*kInfoInset];
    SetViewLeftUp(_infoLabel, kInfoInset, 16);
    _scrollView.contentSize = CGSizeMake(320, _infoLabel.frame.size.height +32) ;
    
    NSString *infoImgUrl = [taskInfo valueForKey:@"infoimage"];
    if (infoImgUrl)
    {
        [_infoImgView getImage:infoImgUrl defaultImage:nil animated:YES];
    }
}

- (void)imageView:(AFImageView *)afImageView imageDownloaded:(UIImage *)image
{
    if (!image) return;
    CGSize size = image.size;
    CGFloat infoViewWidth = 640 - 2*kInfoInset;
    if (size.width > infoViewWidth)
    {
        size.height = size.height * infoViewWidth / size.width;
        size.width = infoViewWidth;
    }
    _infoImgView.frame = CGRectMake(kInfoInset, 16, size.width, size.height);
    SetViewLeftUp(_infoLabel, kInfoInset, size.height+16);
    _scrollView.contentSize = CGSizeMake(640, _infoLabel.frame.origin.y + _infoLabel.frame.size.height+32);
}


@end
