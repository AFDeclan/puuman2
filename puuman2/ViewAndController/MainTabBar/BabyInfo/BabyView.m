//
//  BabyView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-6-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyView.h"
#import "UserInfo.h"
#import "BabyInfoBornViewCell.h"
#import "BabyInfoPregnancyViewCell.h"
#import "BabyInfoPropViewCell.h"
#import "BabyInfoVaciViewCell.h"
#import "BabyInfoBodyViewCell.h"
#import "CustomNotiViewController.h"
#import "MainTabBarController.h"
#import "BabyInfoChooseButton.h"
#import "NSDate+Compute.h"
#import "DateFormatter.h"
#import "CAKeyframeAnimation+DragAnimation.h"
#import "MainTabBarController.h"



@implementation BabyView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        [self setBackgroundColor:[UIColor clearColor]];

      
    }
    return self;
}

- (void)initialization
{
    [self initContentView];
    [self initTitleInfoView];
    [self refreshBabyInfo];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }


}

- (void)initTitleInfoView
{
    titleInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,1024,96)];
    [titleInfoView setBackgroundColor:PMColor5];
    [self addSubview:titleInfoView];

    info_sexIcon = [[UIImageView alloc] initWithFrame:CGRectMake(230, 60, 22, 22)];
    [info_sexIcon setBackgroundColor:[UIColor clearColor]];
    [titleInfoView addSubview:info_sexIcon];
    
    info_name = [[UILabel alloc] initWithFrame:CGRectMake(256, 58, 65, 25)];
    [info_name setTextAlignment:NSTextAlignmentLeft];
    [info_name setTextColor:PMColor6];
    [info_name setFont:PMFont1];
    [info_name setText:@"扑满"];
    [info_name setBackgroundColor:[UIColor clearColor]];
    [titleInfoView addSubview:info_name];
    
    info_age= [[UILabel alloc] initWithFrame:CGRectMake(325, 64, 110, 21)];
    [info_age setTextAlignment:NSTextAlignmentLeft];
    [info_age setTextColor:PMColor1];
    [info_age setFont:PMFont2];
    [info_age setText:@"一岁8个月"];
    [info_age setBackgroundColor:[UIColor clearColor]];
    [titleInfoView addSubview:info_age];
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        info_birthday = [[UILabel alloc] initWithFrame:CGRectMake(436, 64, 200, 21)];
        [info_birthday setTextAlignment:NSTextAlignmentLeft];
        [info_birthday setTextColor:PMColor3];
        [info_birthday setFont:PMFont2];
        [info_birthday setText:@"水瓶座  酉鸡"];
        [info_birthday setBackgroundColor:[UIColor clearColor]];
        [titleInfoView addSubview:info_birthday];
    }
    
    modifyBtn = [[ColorButton alloc] init];
    [modifyBtn initWithTitle:@"修改" andIcon:[UIImage imageNamed:@"icon_fix_baby.png"] andButtonType:kGrayLeft];
    [modifyBtn addTarget:self action:@selector(changeBabyInfo) forControlEvents:UIControlEventTouchUpInside];
    [titleInfoView addSubview:modifyBtn];

    portraitBg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, 180, 180)];
    [portraitBg setImage:[UIImage imageNamed:@"circle_photo_babyInfo.png"]];
    [self addSubview:portraitBg];
    portraitView = [[AFImageView alloc] initWithFrame:CGRectMake(15, 12, 150, 150)];
    portraitView .layer.cornerRadius = 75;
    portraitView.layer.masksToBounds = YES;
    portraitView.layer.shadowRadius = 0.1;
    portraitView.contentMode = UIViewContentModeScaleAspectFill;
    [portraitBg addSubview:portraitView];

    
}


-(void)initContentView
{
    if ([[[UserInfo sharedUserInfo]babyInfo] WhetherBirth]) {
        currentNum = 1;
    }else{
        currentNum = 0;

    }
    babyInfoColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [babyInfoColumnView setBackgroundColor:[UIColor clearColor]];
    [babyInfoColumnView setColumnViewDelegate:self];
    [babyInfoColumnView  setViewDataSource:self];
    [babyInfoColumnView setPagingEnabled:YES];
    [babyInfoColumnView setScrollEnabled:NO];
    [self addSubview:babyInfoColumnView];


}

- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{


}

- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    if ([MainTabBarController sharedMainViewController].isVertical) {
        return 768;
    }else{
        return 1024;
    }

}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    if ( [[[UserInfo sharedUserInfo]babyInfo]WhetherBirth]) {
    
        return 3;
    } else {
    
        return 2;
    }

}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        

        if (index == 1) {
        
            NSString *cellIdentifier = @"BabyInfoBornViewCell";
    
            BabyInfoBornViewCell *cell = (BabyInfoBornViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    
            if (!cell) {
    
                 cell = [[BabyInfoBornViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
        
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setDelegate:self];
            [cell refresh];
            return cell;
    
        } else if ( index == 0) {
    
            NSString *cellIdentifier = @"bodyViewCell";
        
            BabyInfoBodyViewCell *cell = (BabyInfoBodyViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        
            if (!cell) {
                cell = [[BabyInfoBodyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
    
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setDelegate:self];
            [cell refresh];
            return cell;
            
        } else {
            
          if(prop) {
            
              NSString *cellIdentifier = @"propViewCell";
              
              BabyInfoPropViewCell *cell = (BabyInfoPropViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
              
              if (!cell) {
                  cell = [[BabyInfoPropViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
              }
              
              [cell setBackgroundColor:[UIColor clearColor]];
              [cell setDelegate:self];
              [cell refresh];
              
              return cell;
        } else {
            
            NSString *cellIdentifier = @"vaciViewCell";
            
            BabyInfoVaciViewCell *cell = (BabyInfoVaciViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (!cell) {
                cell = [[BabyInfoVaciViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setDelegate:self];
            [cell refresh];
            return cell;
            
            }
        
        }
        
        
    } else {
    
        if (index == 0) {
    
            NSString *cellIdentifier = @"BabyInfoPregnancyViewCell";
        
            BabyInfoPregnancyViewCell *cell = (BabyInfoPregnancyViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
       
            if (!cell) {
        
            cell = [[BabyInfoPregnancyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
          
        }
        
            [cell setBackgroundColor:[UIColor clearColor]];
            
            [cell setDelegate:self];
         
        
             return cell;
            
        } else if (index == 1) {
            
            
            NSString *cellIdentifier = @"propViewCell";
            
            BabyInfoPropViewCell *cell = (BabyInfoPropViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (!cell) {
                
                cell = [[BabyInfoPropViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
            }
            
            [cell setBackgroundColor:[UIColor clearColor]];
            
            [cell setDelegate:self];
            
            return cell;
        
        } else {
        
            
        }
   
    }
    return nil;
}

- (void)gotoNextCellWithProp:(BOOL)isProp
{
    prop = isProp;
    currentNum ++ ;
    if ([MainTabBarController sharedMainViewController].isVertical) {
        
        [babyInfoColumnView setContentOffset:CGPointMake(currentNum*768, 0) animated:YES];
    }else{
        [babyInfoColumnView setContentOffset:CGPointMake(currentNum*1024, 0) animated:YES];

    }

}

- (void)gotoPreCell
{
    currentNum -- ;
    if ([MainTabBarController sharedMainViewController].isVertical) {
        
        [babyInfoColumnView setContentOffset:CGPointMake(currentNum*768, 0) animated:YES];
    }else{
        [babyInfoColumnView setContentOffset:CGPointMake(currentNum*1024, 0) animated:YES];
        
    }
}

- (void)backToMianCell
{
    
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        currentNum = 1;
        if ([MainTabBarController sharedMainViewController].isVertical) {
            
            [babyInfoColumnView setContentOffset:CGPointMake(768, 0) animated:YES];
        }else{
            [babyInfoColumnView setContentOffset:CGPointMake(1024, 0) animated:YES];
            
        }
    }else{
        currentNum = 0;
        [babyInfoColumnView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    
    
    
    
}

- (void)gotoTheNextVaciView
{
    
    prop = YES;
    currentNum ++;

    
}

- (void)gotoTheNextPropView
{
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth]) {
        prop = NO;
        [babyInfoColumnView setContentOffset:CGPointMake(1024*2, 0) animated:YES];
    } else {
    
        [babyInfoColumnView setContentOffset:CGPointMake(1024, 0) animated:YES];
    
    }
}

- (void)gotoThePreView
{
    [babyInfoColumnView setContentOffset:CGPointMake(0, 0) animated:YES];
    if (currentNum>0) {
        currentNum -- ;
    }
}

- (void)backTheBornView {

    [babyInfoColumnView setContentOffset:CGPointMake(1024, 0) animated:YES];
    if (currentNum > 0) {
        currentNum --;
    }else{
        currentNum ++;

    }
}

- (void)backThePregnancyView
{
    [babyInfoColumnView setContentOffset:CGPointMake(0, 0) animated:YES];
    if (currentNum > 0) {
        currentNum --;
    }
}


- (void)changeBabyInfo
{
    if ([MainTabBarController sharedMainViewController].babyInfoShowed) {
        LoginViewController *modifyInfoVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        [[MainTabBarController sharedMainViewController].view addSubview:modifyInfoVC.view];
        [modifyInfoVC setControlBtnType:kCloseAndFinishButton];
        [modifyInfoVC setTitle:@"欢迎使用扑满日记！" withIcon:nil];
        [modifyInfoVC loginSetting];
        [modifyInfoVC show];

    }
    
}


- (void)portraitUploadFinish:(BOOL)suc
{
    
    if (suc) {
        [portraitView getImage:[[[UserInfo sharedUserInfo] babyInfo] PortraitUrl] defaultImage:default_portrait_image];
    }
    
}

- (void)infoUploadFinish:(BOOL)suc
{
    
    if (suc) {
        [CustomNotiViewController showNotiWithTitle:@"修改成功" withTypeStyle:kNotiTypeStyleRight];
        [[[UserInfo sharedUserInfo] babyInfo] setOriginInfo:nil];
        [self refreshBabyInfo];
        
    }else{
        [[[UserInfo sharedUserInfo] babyInfo] setWithDic:[[[UserInfo sharedUserInfo] babyInfo] originInfo]];
        [CustomNotiViewController showNotiWithTitle:@"网络异常" withTypeStyle:kNotiTypeStyleNone];
        [[[UserInfo sharedUserInfo] babyInfo] setOriginInfo:nil];
        
        
    }
}


- (void)refreshBabyInfo
{
    BabyInfo *babyInfo = [[UserInfo sharedUserInfo] babyInfo];
    [portraitView getImage:[[[UserInfo sharedUserInfo] babyInfo] PortraitUrl] defaultImage:default_portrait_image];
    info_name.text = [babyInfo Nickname];
    info_age.text = [[NSDate date] ageStrFromDate:babyInfo.Birthday];
    if ([[[UserInfo sharedUserInfo] babyInfo] WhetherBirth])
    {
        //[info_name setFrame:CGRectMake(0, 50, 152, 24)];
        if ([[[UserInfo sharedUserInfo]babyInfo] Gender]) {
            [info_sexIcon setImage:[UIImage imageNamed:@"icon_male_baby.png"]];
        }else
        {
            [info_sexIcon setImage:[UIImage imageNamed:@"icon_female_baby.png"]];
        }
        
        
    }else{
        [info_sexIcon setImage:nil];
        //[info_name setFrame:CGRectMake(0, 50, 180, 24)];
    }
        NSString *birthStr = [DateFormatter stringFromDate:[babyInfo Birthday]];
        NSString *constellationStr = [[babyInfo Birthday] constellation];
        info_birthday.text = [NSString stringWithFormat:@"%@ %@", birthStr, constellationStr];
  
    [babyInfoColumnView reloadData];
}

-(void) disAppearBabyView
{
    
}


- (void)loadDataInfo
{
   
    [self refreshBabyInfo];
    
    if ([[[UserInfo sharedUserInfo]babyInfo] WhetherBirth]) {
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [babyInfoColumnView setContentOffset:CGPointMake(768, 0)];
            
        }else{
            [babyInfoColumnView setContentOffset:CGPointMake(1024, 0)];

        }
    } else {

        [babyInfoColumnView setContentOffset:CGPointMake(0, 0)];
 
    }
}

-(void)setHorizontalFrame
{
    [titleInfoView setFrame:CGRectMake(0, 0, 1024, 96)];
    SetViewLeftUp(modifyBtn, 912, 28);
    [babyInfoColumnView setFrame:CGRectMake(0, 0, 1024, 768)];
    [babyInfoColumnView reloadData];
    [babyInfoColumnView setContentOffset:CGPointMake(1024*currentNum, 0)];
 
}

-(void)setVerticalFrame
{
    [titleInfoView setFrame:CGRectMake(0, 0, 768, 96)];
    SetViewLeftUp(modifyBtn, 656, 28);
    [babyInfoColumnView setFrame:CGRectMake(0, 0, 768, 1024)];
    [babyInfoColumnView reloadData];
    [babyInfoColumnView setContentOffset:CGPointMake(currentNum*768, 0)];

}



@end
