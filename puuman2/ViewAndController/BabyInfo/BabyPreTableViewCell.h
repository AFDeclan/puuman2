//
//  BabyPreTableViewCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"

@interface BabyPreTableViewCell : UITableViewCell
{
    AFImageView *imgView;
    UIImageView *mask;
    UIImageView *qusetionView;
    UITextView *infoTextView;
    
    UIView *content;
    UIView *infoView;
    UILabel *weekTitle;
    
}
@property(nonatomic,assign)BOOL showInfo;
@property(nonatomic,assign)float maskAlpha;
@property(nonatomic,assign)float contentY;
- (void)buildCellWithIndex:(NSInteger)index andSelectedIndex:(NSInteger)selectedIndex andColumnImgBMode:(BOOL)bModel;

@end
