//
//  LineChartView.m
//  puman
//
//  Created by 祁文龙 on 13-10-22.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "LineChart.h"
#import "BabyData.h"
#import "ColorsAndFonts.h"
#import "NSDate+Compute.h"
#import "StandardLine.h"

#define showHeight 280
#define lowestWeight 2
#define lowestHeight 40
#define highestWeight 50
#define highestHeight 160
#define maxPointX 498
#define minPointX 48
#define highestHeightPoingY 27

#define perHeight showHeight/(highestHeight-lowestHeight)
#define perWeight showHeight/(highestWeight-lowestWeight)
@implementation LineChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

       
        currentPosView = [[UIView alloc] init];
        currentPosView.backgroundColor = PMColor2;
        currentPosView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        currentPosView.alpha = 0.0;
        [self addSubview:currentPosView];
      
       
        dateLabel = [[UILabel alloc] init];
        dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        dateLabel.font = PMFont3;
        dateLabel.textColor = PMColor1;
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.alpha = 0.0;
        dateLabel.backgroundColor = [UIColor clearColor];
        [dateLabel sizeToFit];
        [self addSubview:dateLabel];
       
        nodeLabel = [[UILabel alloc]init];
        [nodeLabel setNumberOfLines:2];
        nodeLabel.font = PMFont3;
        nodeLabel.textColor = PMColor1;
        nodeLabel.backgroundColor = [UIColor clearColor];
        nodeLabel.alpha =0;
        [nodeLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:nodeLabel];
        points = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)setViewType:(BOOL)height andData:(NSArray *)data
{
    isHeight = height;
    records =data;
    [currentPosView setFrame:CGRectMake(0, 45, 1 / self.contentScaleFactor, 280)];
    [dateLabel setFrame:CGRectMake(0, 0, 150, 20)];
    [nodeLabel setFrame:CGRectMake(0, 10, 50, 36)];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self setClearsContextBeforeDrawing: YES];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画点线条------------------
    CGFloat pointLineWidth = 1;
    CGContextSetLineWidth(context, pointLineWidth);//主线宽度
    CGContextSetStrokeColorWithColor(context, PMColor2.CGColor);
    
    int recordCount = [records count];
     for (int i = recordCount-1; i >=0; i--)
      {
      
        NSDictionary *dic = [records objectAtIndex:i];
       
        float pointY = 0;
        float pointX = ((i+1)*(maxPointX-minPointX)/(recordCount+1)) +minPointX;
         
        if (isHeight) {
            //获取最高记录
            float max = [[BabyData sharedBabyData] highestHeightRecord];
             //获取最低记录
            float min = [[BabyData sharedBabyData] lowestHeightRecord];

            float removeHeight = ((highestHeight+lowestHeight)/2-(max+min)/2);
            float height = [[dic valueForKey:kBabyData_Height]floatValue];
             pointY =highestHeightPoingY + (highestHeight-height-removeHeight)*perHeight;

        }else
        {
            //获取最重记录
            int max = [[BabyData sharedBabyData] highestWeightRecord];
            //获取最轻记录
            int min = [[BabyData sharedBabyData] lowestWeightRecord];
            
            float removeWeight = ((highestWeight+lowestWeight)/2-(max+min)/2);
             float weight = [[dic valueForKey:kBabyData_Weight]floatValue];
             pointY =highestHeightPoingY +  (highestWeight-weight-removeWeight)*perWeight;
        }
        
        if (i ==recordCount-1) {
            CGContextMoveToPoint(context,pointX, pointY);
            UIImageView *newestFlag =[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 4, 4)];
            [newestFlag setBackgroundColor:[UIColor clearColor]];
            [newestFlag setImage:[UIImage imageNamed:@"dot_blue_baby.png"]];
            [newestFlag setCenter:CGPointMake(pointX, pointY)];
            [self addSubview:newestFlag];
            [points addObject:newestFlag];
            
        }else{
            
            CGContextAddLineToPoint(context, pointX, pointY);
            //添加节点
            UIImageView *img =[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 4, 4)];
            [img setImage:[UIImage imageNamed:@"dot_gray_baby.png"]];
            [img setBackgroundColor:[UIColor clearColor]];
            [img setCenter:CGPointMake(pointX, pointY)];
            [self addSubview:img];
            [points addObject:img];
        }

    }
     CGContextStrokePath(context);
  
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self showIndicatorForTouch:[touches anyObject]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self showIndicatorForTouch:[touches anyObject]];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self hideIndicator];
 
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self hideIndicator];
   
}

- (void)showIndicatorForTouch:(UITouch *)touch {
    
  CGPoint pos = [touch locationInView:self];
    if (pos.x > maxPointX) {
        pos.x = maxPointX;
    }
    if (pos.x < 0) {
        pos.x = 0;
    }
    float subDistace =(maxPointX - minPointX)/([records count]+1);
    int num  =2*(pos.x-minPointX)/subDistace;
     num = num%2 == 0 ? num/2 :(num +1)/2;
    if (num <= 0) {
        num =1;
    }
    if (num >= [records count]+1) {
        num = [records count];
    }
    //num = [records count]-num+1;
   

    if(!infoView) {
        
        infoView = [[InfoView alloc] init];
        [self addSubview:infoView];
    }
    UIImageView *flag =[points objectAtIndex:[records count] - num];
    float pointX = flag.frame.origin.x +1;
    float pointY = flag.frame.origin.y;
    
    NSDictionary *dic = [records objectAtIndex:num-1];
    NSDate *date =[dic valueForKey:kBabyData_Date];
    NSString *string = @"";
    NSString *nodeString = @"";
    if (isHeight) {
         nodeString = [[StandardLine alloc] getNodeStringStandardwithDate:date andValue:[[dic valueForKey:kBabyData_Height] floatValue] andIsHeight:isHeight];
    }else{
         nodeString = [[StandardLine alloc] getNodeStringStandardwithDate:date andValue:[[dic valueForKey:kBabyData_Weight] floatValue] andIsHeight:isHeight];
    }
    
    NSArray *age = [date ageFromDate:[[[UserInfo sharedUserInfo] babyInfo] Birthday];
    NSString *y ;
    NSString *m ;
    NSString *d ;
    if ([age count] == 3) {
        y = [age objectAtIndex:0];
        m = [age objectAtIndex:1];
        d = [age objectAtIndex:2];
    }else{
        y = @"0";
        m = @"0";
        d = @"0";
    }

    
 
    
    if ([y integerValue] > 0)
    {
       string = [string stringByAppendingFormat:@"%@岁",y];
    }
    if ([m integerValue] > 0)
    {
       string = [string stringByAppendingFormat:@"%@个月",m];
    }
    if ([d integerValue] >= 0)
    {
       string = [string stringByAppendingFormat:@"%@天",d];
    }

    [UIView animateWithDuration:0.1 animations:^{
        dateLabel.alpha = 1.0;
        currentPosView.alpha = 1.0;
        infoView.alpha = 1.0;
        nodeLabel.alpha = 1.0;
        nodeLabel.text = nodeString;
        dateLabel.text = string;
      
        if (isHeight) {
              infoView.infoLabel.text =[NSString stringWithFormat:@"%0.1fcm",[[dic valueForKey:kBabyData_Height] floatValue]];
        }else
        {
              infoView.infoLabel.text =[NSString stringWithFormat:@"%0.1fkg",[[dic valueForKey:kBabyData_Weight] floatValue]];
        }

    
        infoView.tapPoint = CGPointMake(pointX-3,pointY);
        [infoView sizeToFit];
        [infoView setNeedsLayout];
        [infoView setNeedsDisplay];
        [nodeLabel setFrame:CGRectMake(pointX-50/2, 10, 50,36)];
        
        CGRect posframe = currentPosView.frame;
        posframe.origin.x = pointX;
        currentPosView.frame =posframe;
        if(dateLabel.text != nil) {
            CGSize size =[string sizeWithFont:PMFont3];
             CGRect frame = dateLabel.frame;
            frame.size =size;
             frame.origin.x =pointX-size.width/2;
             frame.origin.y =0;
             [dateLabel setFrame:frame];
        }
    }];
}

- (void)hideIndicator {
    [UIView animateWithDuration:0.1 animations:^{
        dateLabel.alpha = 0.0;
        currentPosView.alpha = 0.0;
        nodeLabel.alpha = 0.0;
        infoView.alpha = 0.0;
    }];
}
@end
