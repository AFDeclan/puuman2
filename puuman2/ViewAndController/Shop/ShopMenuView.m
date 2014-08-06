//
//  ShopMenuView.m
//  puman
//
//  Created by 祁文龙 on 13-11-16.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "ShopMenuView.h"
#import "UniverseConstant.h"
#import "ShopViewController.h"
#import "ShopModel.h"
#import "MainTabBarController.h"

@implementation ShopMenuView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializaiton];
        
    }
    return self;
}

- (void)initializaiton
{
    [[ShopModel sharedInstance] setSectionIndex:-1];
    menuTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 256, 0)];
    [menuTable setDataSource:self];
    [menuTable setDelegate:self];
    [self addSubview:menuTable];
    [menuTable setBackgroundColor:PMColor6];
    [menuTable setSeparatorColor:[UIColor clearColor]];
    [menuTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [menuTable setShowsHorizontalScrollIndicator:NO];
    [menuTable setShowsVerticalScrollIndicator:NO];
}

-(void)setVerticalFrame
{
    [menuTable setFrame:CGRectMake(0, 0, 256, 944)];
}

-(void)setHorizontalFrame
{
    [menuTable setFrame:CGRectMake(0, 0, 256, 688)];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ShopModel sectionCnt]+1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString *identifier = @"MenuCell";
        ShopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[ShopMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        [cell setFlagNum:[indexPath row]-1];
        [cell setIndexPath:indexPath];
        [cell setDelegate:self];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        return cell;
}


- (void)selectedMenuWithCell:(ShopMenuCell *)cell
{
    if (cell.flagNum == -1 && [ShopModel sharedInstance].sectionIndex == -1) {

    }else{
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (ShopMenuCell *view in [menuTable visibleCells]) {
            if (view.flagNum == [ShopModel sharedInstance].sectionIndex) {
                [view hiddenSubView];
                [arr addObject:view.indexPath];
            }
        }
         [cell showSubView];
        if (cell.flagNum != -1) {
           
            [arr addObject:cell.indexPath];
        }
        
        [[ShopModel sharedInstance] setSectionIndex:cell.flagNum];
        [[ShopModel sharedInstance] setSubClassIndex:-1];
        if (cell.flagNum == -1 ) {
            PostNotification(Noti_ShowAllShopView, [NSNumber numberWithBool:NO]);
        }else{
            PostNotification(Noti_ShowAllShopView, [NSNumber numberWithBool:YES]);
        }
        [menuTable reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];

    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (([ShopModel sharedInstance].sectionIndex == indexPath.row- 1) && indexPath.row != 0) {
        NSInteger cnt = [ShopModel subTypeCntForSectionAtIndex:[indexPath row]-1];
        if (cnt == 0) {
            return 64;
        }
        cnt =  (cnt % 2) == 0 ? cnt/2 : cnt/2+1;
        return cnt*88 + 64 +72 + 64;
    }else{
        return 64;
    }


}









@end
