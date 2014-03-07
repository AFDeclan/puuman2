//
//  NewDiaryDeleteCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewDiaryDeleteCellDelegate;
@interface NewDiaryDeleteCell : UIView
{
    UIButton *delBtn;
    UIImageView *imgView;
}
@property(assign,nonatomic)id<NewDiaryDeleteCellDelegate> delegate;
@property(assign,nonatomic)UIImage *img;
@property(assign,nonatomic)NSInteger index;
@end

@protocol NewDiaryDeleteCellDelegate <NSObject>

- (void)deleteWithIndex:(NSInteger)index;

@end