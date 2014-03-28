//
//  HealthCell.h
//  puman
//
//  Created by 祁文龙 on 13-11-11.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalHomeView.h"
#import "HealthHowView.h"

typedef enum{
    kHealthWhy,
    kHealthHow,
    kHealthWhere
}HealthQuestionView;
@interface HealthCell : UITableViewCell<HospitalHomeViewDelegate,HealthHowViewDelegate>
{
    UIButton *selectedBtn;
    HospitalHomeView *hospital;
    HealthQuestionView questionView;
       
}
@property(weak,nonatomic)IBOutlet UIButton *whyBtn;
@property(weak,nonatomic)IBOutlet UIButton *howBtn;
@property(weak,nonatomic)IBOutlet UIButton *whereBtn;
@property(weak,nonatomic)IBOutlet UIImageView *whyImgView;
@property(weak,nonatomic)IBOutlet UIImageView *howImgView;
@property(weak,nonatomic)IBOutlet UIImageView *whereImgView;
@property(weak,nonatomic)IBOutlet UIImageView *pumanImgView;
@property(weak,nonatomic)IBOutlet UIScrollView *content;
@property(weak,nonatomic)IBOutlet UILabel *title;
@property(weak,nonatomic)IBOutlet UILabel *detail;
@property(weak,nonatomic)IBOutlet UIButton *backBtn;
-(IBAction)whyBtnPressed:(UIButton *)sender;
-(IBAction)howBtnPressed:(UIButton *)sender;
//-(IBAction)whereBtnPressed:(UIButton *)sender;
- (IBAction)backBtnPressed:(UIButton *)sender;
-(void)initialize;

@end
