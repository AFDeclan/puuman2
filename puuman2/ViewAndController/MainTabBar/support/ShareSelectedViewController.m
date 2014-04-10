//
//  ShareSelectedViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShareSelectedViewController.h"
#import "ColorsAndFonts.h"
#import "MainTabBarController.h"
#import "SocialNetwork.h"

@interface ShareSelectedViewController ()

@end

@implementation ShareSelectedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        SetViewLeftUp(_titleLabel, 0, 56);
        [_titleLabel setText:@"分享到？"];
        weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 130, 80, 20)];
        [weiboLabel setText:@"新浪微博"];
        [weiboLabel setTextColor:PMColor2];
        [weiboLabel setFont:PMFont2];
        [_content addSubview:weiboLabel];
        
        weiXinLabel = [[UILabel alloc] initWithFrame:CGRectMake(334, 130, 80, 20)];
        [weiXinLabel setText:@"微信朋友圈"];
        [weiXinLabel setTextColor:PMColor2];
        [weiXinLabel setFont:PMFont2];
        [_content addSubview:weiXinLabel];
        weiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(78, 112, 56, 56)];
        [weiboBtn setImage:[UIImage imageNamed:@"btn_share1_diary.png"] forState:UIControlStateNormal];
        [weiboBtn addTarget:self action:@selector(weiboBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:weiboBtn];
        weiXinBtn = [[UIButton alloc] initWithFrame:CGRectMake(270, 112, 56, 56)];
        [weiXinBtn setImage:[UIImage imageNamed:@"btn_share2_diary.png"] forState:UIControlStateNormal];
        [weiXinBtn addTarget:self action:@selector(weixinBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:weiXinBtn];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) setShareText:(NSString *) shareText_
{
    shareText = shareText_;
}

- (void) setShareTitle:(NSString *) shareTitle_
{
    shareTitle = shareTitle_;
}

- (void) setShareImg:(UIImage *) shareImg_
{
    shareImg = shareImg_;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)weixinBtnPressed
{
    [[SocialNetwork sharedInstance] shareText:shareText title:shareTitle image:shareImg toSocial:Weixin];

}

- (void)weiboBtnPressed
{
    [[SocialNetwork sharedInstance] shareText:shareText title:shareTitle image:shareImg toSocial:Weibo];


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
    [super finishOut];
    
}

+ (void)shareText:(NSString *)sharetext_ title:(NSString *)title image:(UIImage *)img;
{
    ShareSelectedViewController *shareVC = [[ShareSelectedViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:shareVC.view];
    [shareVC setShareText:sharetext_];
    [shareVC setShareTitle:title];
    [shareVC setShareImg:img];
    [shareVC setStyle:ConfirmError];
    [shareVC show];
}
@end
