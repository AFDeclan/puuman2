//
//  HealthCell.m
//  puman
//
//  Created by 祁文龙 on 13-11-11.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "HealthCell.h"
#import "ColorsAndFonts.h"
#import "MobClick.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
#import "UniverseConstant.h"

@implementation HealthCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
    }
    return self;
}
- (void)initialize
{
    [self.contentView addSubview:self.whereBtn];
    [self.contentView addSubview:self.whyBtn];
    [self.contentView addSubview:self.howBtn];
    [self.whereBtn setEnabled:YES];
    [self.whyBtn setEnabled:YES];
    [self.howBtn setEnabled:YES];
    [self.title setTextColor:PMColor1];
    [self.title setFont:PMFont1];
    [self.title setBackgroundColor:[UIColor clearColor]];
    [self.detail setTextColor:PMColor2];
    [self.detail setBackgroundColor:[UIColor clearColor]];
    [self.detail setFont:PMFont2];
    [self setBackgroundColor:PMColor4];
   
    [self setDatawithHospital:kNoneHospital];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        
        [self setVerticalFrame];
    }else{
        
        [self setHorizontalFrame];
        
    }
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setHorizontalFrame) name:NOTIFICATION_Horizontal object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(setVerticalFrame) name:NOTIFICATION_Vertical object:nil];
    
   
}

- (void)setVerticalFrame
{
   // SetViewLeftUp(self.contentView, -24, 0);
    [self.contentView setAlpha:0];
    [self setAlpha:0];
  
}

- (void)setHorizontalFrame
{
    if (!selectedBtn) {
        selectedBtn = self.whyBtn;
        [self whyBtnPressed:self.whyBtn];
    }
     [self.contentView setAlpha:1];
    [self setAlpha:1];
    //SetViewLeftUp(self.contentView, 0, 0);
}

-(IBAction)whyBtnPressed:(UIButton *)sender
{
    [MobClick event:umeng_event_click label:@"Why_HealthCell"];
    questionView = kHealthWhy;
    [sender setEnabled:NO];
    if (selectedBtn) {
          [selectedBtn setEnabled:YES];
    }
    selectedBtn = sender;
 
    [self addSubview:self.whyImgView];
    [self.whyImgView setAlpha:1];
   // [self.whereImgView setAlpha:0.3];
    [self.howImgView setAlpha:0.3];
    for (UIView *view in [self.content subviews]) {
        [view removeFromSuperview];
    }
    if (!hospital) {
         hospital = [[HospitalHomeView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
         [hospital setDelegate:self];
         [hospital initialization];
       
    }else{
        
        [self setDatawithHospital:hospital.hospitalOnShow];
    }
    [_content addSubview:hospital];
    
}
-(IBAction)howBtnPressed:(UIButton *)sender
{
     [MobClick event:umeng_event_click label:@"How_HealthCell"];
    questionView = kHealthHow;

   //  [self backBtnPressed:self.backBtn];
    [selectedBtn setEnabled:YES];
    selectedBtn = sender;
    [sender setEnabled:NO];
    [self addSubview:self.howImgView];
    [self.whyImgView setAlpha:0.3];
   // [self.whereImgView setAlpha:0.3];
    [self.howImgView setAlpha:1];
    
    for (UIView *view in [self.content subviews]) {
        [view removeFromSuperview];
    }
    HealthHowView *how =[[HealthHowView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
    [how setHowdelegate:self];
    [_content addSubview:how];
}
-(IBAction)whereBtnPressed:(UIButton *)sender
{
//    [MobClick event:umeng_event_click label:@"Where_HealthCell"];
//    questionView = kHealthWhere;
//    
//    //[self backBtnPressed:self.backBtn];
//    [selectedBtn setEnabled:YES];
//    selectedBtn = sender;
//    [sender setEnabled:NO];
//   // [self addSubview:self.whereImgView];
//    [self.whyImgView setAlpha:0.3];
//    //[self.whereImgView setAlpha:1];
//    [self.howImgView setAlpha:0.3];
//    for (UIView *view in [self.content subviews]) {
//        [view removeFromSuperview];
//    }


}
- (void)setDatawithHospital:(HospitalOnShow)hospitalType
{

    switch (hospitalType) {
        case kNoneHospital:
            [self setPumanImg:@"puuman1_insure_shop.png" andTitle:@"小扑满生病了，该去哪里看病呢？" andDetail:@"请帮帮扑满，为他选择一个合适的地方就诊把！" withHospital:kNoneHospital];
            break;
        case kSmallHospital:
            [self setPumanImg:@"puuman1_insure_shop.png" andTitle:@"医生去马尔代夫旅游了？！" andDetail:@"医疗资源差强人意，医生水平不敢保证" withHospital:kSmallHospital];
            break;
        case kPrivateHospital:
            [self setPumanImg:@"puuman1_insure_shop.png" andTitle:@"扑满存折的余额不够了……" andDetail:@"私立医院环境好，服务佳，但费用真的很高昂" withHospital:kPrivateHospital];
            break;
        case kBigHospital:
            [self setPumanImg:@"puuman2_insure_shop.png" andTitle:@"天哪，什么时候才能轮到扑满呢？" andDetail:@"为了小扑满的病，重新选择一个地方就医吧！" withHospital:kBigHospital];
            break;
        case kEndHospital:
            [self setPumanImg:@"puuman3_insure_shop.png" andTitle:@"给宝宝未来的承诺：高端医疗险" andDetail:@"" withHospital:kEndHospital];
            
        default:
            break;
    }
}
- (void)setFlagImg:(NSString *)imgName andTitle:(NSString *)title andDetail:(NSString *)detail;
{
    
    [self setPumanImg:imgName andTitle:title andDetail:detail withHospital:kNoneHospital];
    
}
- (void)setPumanImg:(NSString *)imgName andTitle:(NSString *)title andDetail:(NSString *)detail withHospital:(HospitalOnShow)hospitalType
{
    [self.pumanImgView setImage:[UIImage imageNamed:imgName]];
    [self.title setText:title];
    [self.detail setText:detail];
    if (hospitalType == kNoneHospital) {
       [self.backBtn setAlpha:0];
    }else{
      [self.backBtn setAlpha:1];
    }
    for (UIView *view in [self.pumanImgView subviews]) {
        [view removeFromSuperview];
    }
    if (hospitalType == kEndHospital) {
        [self.backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        [self.backBtn setImage:[UIImage imageNamed:@"btn_back_insure_shop.png"] forState:UIControlStateNormal];
    }
    if (hospitalType == kBigHospital) {
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 68, 64, 16)];
        [numLabel setTextColor:PMColor1];
        [numLabel setFont:PMFont2];
        [self.pumanImgView addSubview:numLabel];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        int num =rand()%100+300;
        [numLabel setTextAlignment:NSTextAlignmentCenter];
        [numLabel setText:[NSString stringWithFormat:@"%d号",num]];
    }

}
- (IBAction)backBtnPressed:(UIButton *)sender
{
 
    [MobClick event:umeng_event_click label:@"Back_HealthCell"];
    for (UIView *view in [self.pumanImgView subviews]) {
        [view removeFromSuperview];
    }
    if (self.backBtn.alpha != 0) {
        [hospital back];
        [self setDatawithHospital:kNoneHospital];
    }
    [self.backBtn setAlpha:0];
}
- (void)restartBtnAppear
{
    [self.backBtn setImage:[UIImage imageNamed:@"btn_back2_insure_shop.png"] forState:UIControlStateNormal];
}
@end
