//
//  ToolsUnitView.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolsSelectedButton.h"

@protocol ToolsUnitViewDelegate;
@interface ToolsUnitView : UIView
{
    ToolsSelectedButton *settingBtn;
    UIView *content;

}
@property(nonatomic,assign)id<ToolsUnitViewDelegate>delegate;
@property(nonatomic,assign) NSInteger flagNum;
- (void)refreshInfo;
- (void)initialization;
- (void)foldTool;
- (void)unFoldTool;
+(float)heightWithTheIndex:(NSInteger)index;
@end
@protocol ToolsUnitViewDelegate <NSObject>
- (void)foldOrUnFoldWithFlag:(NSInteger)flag;
@end