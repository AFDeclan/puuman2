//
//  BabyPuumanView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoContentView.h"
#import "AFTextImgButton.h"
#import "ADTickerLabel.h"
#import "ColorButton.h"

@interface BabyPuumanView : BabyInfoContentView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *inBookTable;
    UITableView *outBookTable;
    AFTextImgButton *inBookTitle;
    AFTextImgButton *outBookTitle;
    ADTickerLabel *_numLabel_puuman;
    ADTickerLabel *_numLabel_record;
    UIImageView *icon_coin;
    UILabel *label_puuman;
    UILabel *label_record;
    ColorButton *ruleBtn;
    UIImageView *_newAddView;
    UILabel *_newAddLabel;
    UIImageView *pumanIcon;
    UIView *emptyInView;
    UIView *emptyoutView;
    
    
}
- (void)refresh;
- (void)setNums;
@end
