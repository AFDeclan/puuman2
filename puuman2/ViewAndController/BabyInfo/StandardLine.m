//
//  Standard.m
//  puman
//
//  Created by 祁文龙 on 13-11-6.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "StandardLine.h"
#import "BabyData.h"
#import "NSDate+Compute.h"

@implementation StandardLine

- (NSString *)getNodeStringStandardwithDate:(NSDate *)date andHeightValue:(float)heightValue andWeightValue:(float)weightValue
{
    
    subHeight = 0;
    subWeight = 0;
  
   //if ([self dateIsToday:date]) {
     NSString *nodeString = @"今日宝宝";
//    }else{
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateFormat = @"YYYY年M月d日";
//        nodeString = [NSString stringWithFormat:@"您更新了%@的",[dateFormatter stringFromDate:date]];
//    }
    
//    if (heightValue !=0 && weightValue != 0) {
//            nodeString = [nodeString stringByAppendingString:@"身高和体重"];
//    }else{
//        if (weightValue !=0) {
//            nodeString = [nodeString stringByAppendingString:@"体重"];
//        }
//        if (heightValue != 0) {
//            nodeString = [nodeString stringByAppendingString:@"身高"];
//        }
//    }

    
    int nextStandard = 0;
    int preStandard = 0;
    
    NSArray *age = [date ageFromDate:[[BabyData sharedBabyData] babyBirth]];
    NSString *y = [age objectAtIndex:0];
    NSString *m = [age objectAtIndex:1];
    // NSString *d = [age objectAtIndex:2];
    float nowMonth = [y intValue]*12+[m intValue];
    nowMonth= nowMonth>0?nowMonth:1;
    for (int i =0;  i <25; i++) {
        float  month = [standardHeightWeight[i][0] floatValue];
        if (nowMonth>=month) {
            preStandard = i;
        }
        if (nowMonth<=month) {
            nextStandard = i;
            break;
        }
    }
    
   
        Standard heightStandard =  [self getStandardHeightWithPreStandard:preStandard andNextStandard:nextStandard withMyHeight:heightValue withNowMonth:nowMonth];
        Standard weightStandard = [self getStandardWeightWithPreStandard:preStandard andNextStandard:nextStandard withMyWeight:weightValue withNowMonth:nowMonth];
  
    if (heightValue != 0) {
        nodeString = [nodeString stringByAppendingFormat:@"身高%0.1fcm：",heightValue];
    
        switch (heightStandard) {
            case kHeightHigh:
                nodeString = [nodeString stringByAppendingString:[NSString stringWithFormat:@"宝宝好棒，高于平均身高%0.1fcm唷^^",subHeight]];
                break;
            case kHeight:
                    nodeString = [nodeString stringByAppendingString:@" 在正常范围内，宝宝健康成长中:D "];
                break;
            case kHeightLow:
                    nodeString = [nodeString stringByAppendingString:@" 低于平均一点点，有些担心: 宝宝加油哦！！"];
                break;
                
            default:
                break;
        }
    }
    if (weightValue !=0) {
        if (heightValue !=0) {
             nodeString = [nodeString stringByAppendingString:@"；"];
        }
        nodeString = [nodeString stringByAppendingFormat:@"体重%0.1fkg：",weightValue];
    switch (weightStandard) {
        case kWeight:
             nodeString = [nodeString stringByAppendingString:@" 宝宝不胖不瘦刚刚好^^"];
            break;
        case kWeightHigh:
             nodeString = [nodeString stringByAppendingString:@" 宝宝在平均体重以上，白白胖胖有福气:D 不过也要注意科学的营养搭配哦。"];
            break;
        case kWeightLow:
             nodeString = [nodeString stringByAppendingString:@" 有点点偏瘦，迷人的魔鬼身材。不过要确保科学的营养摄取哦。"];
            break;
            
        default:
            break;
    }
    }
    return nodeString;

    
}

- (NSString *)getNodeStringStandardwithDate:(NSDate *)date andValue:(float)value andIsHeight:(BOOL)isHeight
{
    subHeight = 0;
    subWeight = 0;
    NSString *nodeString = @"";
    
    int nextStandard = 0;
    int preStandard = 0;
    
    NSArray *age = [date ageFromDate:[[BabyData sharedBabyData] babyBirth]];
    NSString *y = [age objectAtIndex:0];
    NSString *m = [age objectAtIndex:1];
   // NSString *d = [age objectAtIndex:2];
    float nowMonth = [y intValue]*12+[m intValue];
    nowMonth= nowMonth>0?nowMonth:1;
    for (int i =0;  i <25; i++) {
        float  month = [standardHeightWeight[i][0] floatValue];
        if (nowMonth>=month) {
            preStandard = i;
        }
        if (nowMonth<=month) {
            nextStandard = i;
            break;
        }
    }
    
    if (isHeight) {
        Standard heightStandard =  [self getStandardHeightWithPreStandard:preStandard andNextStandard:nextStandard withMyHeight:value withNowMonth:nowMonth];
        switch (heightStandard) {
            case kHeight:
                nodeString =  @"身高正常";
                break;
            case kHeightHigh:
                nodeString = [NSString stringWithFormat:@"高于标准%0.1fcm",subHeight];
                break;
            case kHeightLow:
                nodeString = [NSString stringWithFormat:@"低于标准%0.1fcm",subHeight];
                break;
                
            default:
                break;
        }
    }else{
        Standard weightStandard = [self getStandardWeightWithPreStandard:preStandard andNextStandard:nextStandard withMyWeight:value withNowMonth:nowMonth];
        switch (weightStandard) {
            case kWeight:
                nodeString =  @"体重正常";
                break;
            case kWeightHigh:
                nodeString =  [NSString stringWithFormat:@"高于标准%0.1fkg",subWeight];
                break;
            case kWeightLow:
                nodeString =  [NSString stringWithFormat:@"低于标准%0.1fkg",subWeight];
                break;
                
            default:
                break;
        }
        
    }
    
    return nodeString;

    
}
-(Standard)getStandardHeightWithPreStandard:(int)preStandard andNextStandard:(int)nextStandard withMyHeight:(float)height withNowMonth:(int)month
{
    float preMaxheight = 0;
    float nextMaxheight = 0;
    float preMinheight = 0;
    float nextMinheight = 0;
    if([[BabyData sharedBabyData] babyIsBoy])
    {
        preMinheight = [standardHeightWeight[preStandard][5] floatValue];
        preMaxheight = [standardHeightWeight[preStandard][6] floatValue];
        nextMinheight = [standardHeightWeight[nextStandard][5] floatValue];
        nextMaxheight = [standardHeightWeight[nextStandard][6] floatValue];
        
        
    }else{
        preMinheight = [standardHeightWeight[preStandard][7] floatValue];
        preMaxheight = [standardHeightWeight[preStandard][8] floatValue];
        nextMinheight = [standardHeightWeight[nextStandard][7] floatValue];
        nextMaxheight = [standardHeightWeight[nextStandard][8] floatValue];
    }
    
    if (nextStandard == preStandard) {
        if (height>preMaxheight) {
            subHeight = height-preMaxheight;
            return kHeightHigh;
        }else if (height<preMinheight){
            subHeight = preMinheight-height;
            return kHeightLow;
        }else
        {
            return kHeight;
        }
    }else
    {
        
        
        float nowMaxHeight = (nextMaxheight-preMaxheight)*month/(nextStandard-preStandard)+(nextStandard*preMaxheight-preStandard*nextMaxheight)/(nextStandard-preStandard);
        float nowMinHeight = (nextMinheight-preMinheight)*month/(nextStandard-preStandard)+(nextStandard*preMinheight-preStandard*nextMinheight)/(nextStandard-preStandard);
        if (height>nowMaxHeight){
            subHeight = height -nowMaxHeight;
            return kHeightHigh;
        }else if (height<nowMinHeight)
        {
            subHeight = nowMinHeight - height;
            return kHeightLow;
        }else
        {
            return kHeight;
        }
        
    }
    
}
-(float)getStandardWeightWithPreStandard:(int)preStandard andNextStandard:(int)nextStandard withMyWeight:(float)weight withNowMonth:(int)month
{
    float preMaxWeight = 0;
    float nextMaxWeight = 0;
    float preMinWeight = 0;
    float nextMinWeight = 0;
    if([[BabyData sharedBabyData] babyIsBoy])
    {
        preMinWeight = [standardHeightWeight[preStandard][1] floatValue];
        preMaxWeight = [standardHeightWeight[preStandard][2] floatValue];
        nextMinWeight = [standardHeightWeight[nextStandard][1] floatValue];
        nextMaxWeight = [standardHeightWeight[nextStandard][2] floatValue];
        
        
    }else{
        preMinWeight = [standardHeightWeight[preStandard][3] floatValue];
        preMaxWeight = [standardHeightWeight[preStandard][4] floatValue];
        nextMinWeight = [standardHeightWeight[nextStandard][3] floatValue];
        nextMaxWeight = [standardHeightWeight[nextStandard][4] floatValue];
    }
    
    if (nextStandard == preStandard) {
        if (weight>preMaxWeight) {
            subWeight = weight-preMaxWeight;
            return kWeightHigh;
        }else if (weight<preMinWeight)
        {
            subWeight = preMinWeight - weight;
            return kWeightLow;
        }else{
            return kWeight;
        }
        
    }else
    {
        
        float nowMaxWeight = (nextMaxWeight-preMaxWeight)*month/(nextStandard-preStandard)+(nextStandard*preMaxWeight-preStandard*nextMaxWeight)/(nextStandard-preStandard);
        float nowMinWeight = (nextMinWeight-preMinWeight)*month/(nextStandard-preStandard)+(nextStandard*preMinWeight-preStandard*nextMinWeight)/(nextStandard-preStandard);
        if (weight>nowMaxWeight){
            subWeight = weight - nowMaxWeight;
            return kWeightHigh;
        }else if (weight<nowMinWeight)
        {
            subWeight = nowMinWeight - weight;
            return kWeightLow;
        }else
        {
            return kWeight;
        }
    }
    
    
}
//- (BOOL)dateIsToday:(NSDate *)date
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSInteger unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
//    NSDateComponents *comp_ = [calendar components:unit fromDate:date];
//    NSDateComponents *comp_now = [calendar components:unit fromDate:[NSDate date]];
//    if ([comp_ year] == [comp_now year] && [comp_ month] == [comp_now month] && [comp_ day] == [comp_now day])
//        return YES;
//    else return NO;
//}
@end
