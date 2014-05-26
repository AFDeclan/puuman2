//
//  BabyPreView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyPreView.h"
#import "ColorsAndFonts.h"
#import "AFImageView.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
#import "DateFormatter.h"
#import "NSDate+Compute.h"
#import "BabyData.h"

#define  BABY_COLUMN_CNT   40

@implementation BabyPreView
@synthesize columnImgBMode = _columnImgBMode;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [showAndHiddenBtn setAlpha:0];
        [leftView setAlpha:0];
        [self initialization];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
    }
    return self;
}

- (void)initialization
{
      selectedIndex = 1;
    bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [bgScrollView setScrollEnabled:NO];
    [bgScrollView setContentSize:CGSizeMake(816, 576)];
    [rightView addSubview:bgScrollView];
    
    
    bgLine = [[UIView alloc] initWithFrame:CGRectMake(134, 476, 548, 1)];
    [bgLine setBackgroundColor:PMColor3];
    [bgScrollView addSubview:bgLine];
    _columnImgBMode = NO;
   
    
    
    _titles = [[UIScrollView alloc] initWithFrame:CGRectMake(74, 480, 688, 24)];
    [bgScrollView addSubview:_titles];
    
    _points = [[UIScrollView alloc] initWithFrame:CGRectMake(134, 474, 548, 4)];
    [_points setBackgroundColor:[UIColor clearColor]];
    [bgScrollView addSubview:_points];
    
    _controlView = [[UIScrollView alloc] initWithFrame:CGRectMake(24, 0, 816, 0)];
    [_controlView setDelegate:self];
    [_controlView setPagingEnabled:YES];
    [_controlView setBackgroundColor:[UIColor clearColor]];
    [_controlView setFrame:CGRectMake(0, 0, 816, 576)];
    [_controlView setContentSize:CGSizeMake( 40*816, 576)];

    [bgScrollView addSubview:_controlView];
    NSArray *ages = [[NSDate date] ageFromDate:[[BabyData sharedBabyData] babyBirth]];
    int age = 0;
    if ([ages count] == 2) {
    
        age = [[ages objectAtIndex:0] intValue];
        
    }
    for (int i = 0; i<BABY_COLUMN_CNT; i++) {
        UILabel *week = [[UILabel alloc]init];
        
        [week setTextAlignment:NSTextAlignmentCenter];
        [week setFont:PMFont2];
        [week setBackgroundColor:[UIColor clearColor]];
        [week setFrame:CGRectMake(i*272+272, 0, 120, 24)];
        [self setColumnLabel:week withIndex:i+1];
        [_titles addSubview:week];
        if (age >= i+1) {
            [week setTextColor:PMColor6];
        }else{
            [week setTextColor:PMColor2];
        }  
        
    }

    for (int i = 0; i<BABY_COLUMN_CNT; i++) {
        
        UIImageView *point = [[UIImageView alloc] initWithFrame:CGRectMake(i*272+272, 0, 4, 4)];
        [point setImage:[UIImage imageNamed:@"dot3_baby_diary.png"]];
        [_points addSubview:point];
        
        
    }

    UITapGestureRecognizer *gestureRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [gestureRecognizer setDelegate:self];
    [self addGestureRecognizer:gestureRecognizer];
  
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
     CGPoint pos = [touch locationInView:self];
    UITableViewCell *cell =[_showColumnView cellForIndex:selectedIndex];
    if ([cell isKindOfClass:[BabyPreTableViewCell class]]) {
        pos.x +=   _showColumnView.contentOffset.x + bgScrollView.contentOffset.x-bgScrollView.frame.origin.x -_showColumnView.frame.origin.x ;
        pos.y -= (_showColumnView.frame.origin.y + bgScrollView.frame.origin.y);
        
        CGRect frame1 = cell.frame;
        frame1.origin.x += 8;
        frame1.size.width = 256;
        frame1.size.height = 296;

        if (!CGRectContainsPoint(frame1, pos)) {
            [(BabyPreTableViewCell *)cell setShowInfo:NO];
            [_controlView setAlpha:1];
                                                                                                                                                      
            
            
        }else{
                CGRect frame = CGRectMake(cell.frame.origin.x+180, cell.frame.origin.y+16, 64, 64);
                if (CGRectContainsPoint(frame,pos)) {
                    [(BabyPreTableViewCell *)cell setShowInfo:YES];
                    [_controlView setAlpha:0];
                }
            return YES;
            }
        
        
        UITableViewCell *cell_pre = [_showColumnView cellForIndex:selectedIndex-1];
        if([cell_pre isKindOfClass:[BabyPreTableViewCell class]]){
            
            CGRect frame2 = cell_pre.frame;
            frame2.origin.x +=8;
            frame2.size.width = 256;
            frame2.size.height = 296;
            
            if(CGRectContainsPoint(frame2, pos)){
                
                frame2 = cell.frame;
                return YES;
            }
    }
    UITableViewCell *cell_next = [_showColumnView cellForIndex:selectedIndex +1];
    
    if([cell_next isKindOfClass:[BabyPreTableViewCell class]]){
     
        CGRect frame3 = cell_next.frame;
        frame3.origin.x += 8;
        frame3.size.width = 256;
        frame3.size.height = 296;
        if((CGRectContainsPoint(frame3, pos))){
        
            
            
            return YES;
        
        }
    
    }
    
        }
    return YES;
}

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
//    if (index == selectedIndex ) {
//        [self showPhotoAtIndex:index];
    //  }

    
}



- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 272;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return BABY_COLUMN_CNT+2;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == _controlView) {
        CGPoint pos= _controlView.contentOffset;
        
        float nowX = pos.x/816;
        float indexX = (int)(pos.x/816);
        selectedIndex = pos.x/816 +1;
        UITableViewCell *cell = [_showColumnView cellForIndex:selectedIndex];
         UITableViewCell *nextCell = [_showColumnView cellForIndex:selectedIndex+1];
        if ([cell isKindOfClass:[BabyPreTableViewCell class]]) {
            [(BabyPreTableViewCell *)cell setMaskAlpha:(nowX-indexX)*0.5];
            [(BabyPreTableViewCell *)cell setContentY:(nowX-indexX)*32];
            [(BabyPreTableViewCell *)cell setShowInfo:NO];
            

        }
        
        if ([nextCell isKindOfClass:[BabyPreTableViewCell class]]) {
            [(BabyPreTableViewCell *)nextCell setMaskAlpha:0.5-(nowX-indexX)*0.5];
            [(BabyPreTableViewCell *)nextCell setContentY:32- (nowX-indexX)*32];
            [(BabyPreTableViewCell *)nextCell setShowInfo:NO];

        }
        
        
        pos.x = pos.x*272/816;
        [_showColumnView setContentOffset:pos];
        [_points setContentOffset:pos];
        [_titles setContentOffset:pos];
        if (selectedIndex == 0) {
            if ([nextCell isKindOfClass:[BabyPreTableViewCell class]]) {
                [(BabyPreTableViewCell *)nextCell setMaskAlpha:0];
                [(BabyPreTableViewCell *)nextCell setContentY:0];
                [(BabyPreTableViewCell *)nextCell setShowInfo:NO];

            }
           
        }
        if (selectedIndex == BABY_COLUMN_CNT) {
            if ([cell isKindOfClass:[BabyPreTableViewCell class]]) {
                [(BabyPreTableViewCell *)cell setMaskAlpha:0];
                [(BabyPreTableViewCell *)cell setShowInfo:NO];

            }
            if ([nextCell isKindOfClass:[BabyPreTableViewCell class]]) {
                [(BabyPreTableViewCell *)nextCell setContentY:8];
                [(BabyPreTableViewCell *)nextCell setShowInfo:NO];

            }
            
        }
        
    }
   
    
}

- (void)scrollViewDidEndDecelerating:(UIColumnView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIColumnView *)scrollView willDecelerate:(BOOL)decelerate;
{
    
}
- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    if (index == 0 || index == BABY_COLUMN_CNT+1) {
        static NSString *identify = @"EmptyCell";
        UITableViewCell *cell = [columnView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
        
    }else{
        NSString * cellIdentifier = @"photoShowColumnCell";
        BabyPreTableViewCell *cell = (BabyPreTableViewCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[BabyPreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        
        
        [cell buildCellWithIndex:index andSelectedIndex:selectedIndex andColumnImgBMode:_columnImgBMode];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
        
    }
}

- (void)refresh
{

    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

- (void)setColumnImgBMode:(BOOL)columnImgBMode
{
    _columnImgBMode = columnImgBMode;
    CGPoint pos = _controlView.contentOffset;
    [_controlView setContentOffset:CGPointZero];
    if (_showColumnView) {
        [_showColumnView removeFromSuperview];
    }
    _showColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(24, 88, 816, 328)];
    [_showColumnView setBackgroundColor:[UIColor clearColor]];
    [_showColumnView setColumnViewDelegate:self];
    [_showColumnView setViewDataSource:self];
    [_showColumnView setPagingEnabled:NO];
    [_showColumnView setScrollEnabled:NO];
    [bgScrollView addSubview:_showColumnView];
    [bgScrollView bringSubviewToFront:_controlView];
    [_controlView setContentOffset:pos];
}

- (void)scrollToToday
{
    NSArray *ages = [[NSDate date] ageFromDate:[[BabyData sharedBabyData] babyBirth]];
    int age = 1;
    if ([ages count] == 2) {
        age = [[ages objectAtIndex:0] intValue];

    }
    if (age > 3) {
        [_controlView setContentOffset:CGPointMake(816*(age-2), 0)];
    }
    
    age = age>1?age:1;
    [UIView animateWithDuration:0.5 animations:^{
        [_controlView setContentOffset:CGPointMake(816*(age-1), 0)];
    }];

}

-(void)setVerticalFrame
{
    [super setVerticalFrame];
    [bgScrollView setContentOffset:CGPointMake(128, 0)];
    [bgScrollView setFrame:CGRectMake(24, 128, 560, 576)];

}

-(void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [bgScrollView setContentOffset:CGPointMake(0, 0)];

    [bgScrollView setFrame:CGRectMake(24, 0, 816, 576)];
    SetViewLeftUp(bgScrollView, 0, 0);
}

- (void)setColumnLabel:(UILabel *)label withIndex:(NSInteger)index
{
    if (index < 1 || index > BABY_COLUMN_CNT) label.text = @"";
    else label.text = [NSString stringWithFormat:@"孕期第%d周", index];
}

@end
