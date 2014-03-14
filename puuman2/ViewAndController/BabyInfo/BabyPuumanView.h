//
//  BabyPuumanView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyInfoContentView.h"
#import "AFTextImgButton.h"
@interface BabyPuumanView : BabyInfoContentView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *inBookTable;
    UITableView *outBookTable;
    AFTextImgButton *inBookTitle;
    AFTextImgButton *outBookTitle;
}
- (void)refresh;
@end
