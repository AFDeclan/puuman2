//
//  AllWareView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AllWareView.h"
#import "ColorsAndFonts.h"
#import "HealthCell.h"
#import "InsuranceCell.h"
#import "WareCell.h"
#import "MainTabBarController.h"

@implementation AllWareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
        _shopMallTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 648, 688)];
        [_shopMallTable setDataSource:self];
        [_shopMallTable setDelegate:self];
        [self addSubview:_shopMallTable];
        
     
        
        [_shopMallTable setBackgroundColor:[UIColor clearColor]];
        [_shopMallTable setSeparatorColor:[UIColor clearColor]];
        [_shopMallTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_shopMallTable setShowsHorizontalScrollIndicator:NO];
        [_shopMallTable setShowsVerticalScrollIndicator:NO];
        [_shopMallTable setContentSize:CGSizeMake(448, 904)];
        _refreshFooter = [[MJRefreshFooterView alloc] init];
        [_refreshFooter setDelegate:self];
        _refreshFooter.scrollView = _shopMallTable;
        [_shopMallTable addSubview:_refreshFooter];
        _refreshFooter.alpha = 0;
        __block MJRefreshFooterView * blockRefreshFooter = _refreshFooter;
        _refreshFooter.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            if (![[ShopModel sharedInstance] loadMore])
            {
                [blockRefreshFooter endRefreshing];
            }
        };
        [self reloadShopMall];
     
        noti_insurance = [[UILabel alloc] initWithFrame:CGRectMake(0, 492, 608, 48)];
        [noti_insurance setBackgroundColor:[UIColor clearColor]];
        [noti_insurance setTextColor:PMColor2];
        [noti_insurance setFont:PMFont2];
        [noti_insurance setTextAlignment:NSTextAlignmentCenter];
        [noti_insurance setText:@"请在横屏下查看此页面"];
        [noti_insurance setAlpha:0];
        [_shopMallTable addSubview:noti_insurance];
        headView= [[ShopAllWareHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 56)];
        [self addSubview:headView];
        
       
        
    }
    return self;
}



#pragma mark - Tableview Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (_shopState) {
        case ShopStateNormal:
            return [ShopClassModel sectionCnt];
        default:
            return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self rowNumForSection:section]+1;
    
}


- (NSInteger)rowNumForSection:(NSInteger)section
{
    NSArray* data = [self waresForSection:section];
    switch (_shopState) {
        case ShopStateInsurance:
            return 2;
        case ShopStateNormal:
            return 0;
        default:
            break;
    }
    NSInteger cnt = [data count];
    return (cnt % 3) ? cnt/3+1 : cnt/3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    

    
    switch (_shopState) {
        case ShopStateInsurance:
            
           
            
            if (row == 0) {
                NSString *identifier = @"HealthCell";
                HealthCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil]lastObject];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    [cell initialize];
                }
                
                [cell setBackgroundColor:[UIColor clearColor]];
                if ([MainTabBarController sharedMainViewController].isVertical) {
                    [cell.contentView setAlpha:0];
                    [self setVerticalFrame];
                }else{
                    [cell.contentView setAlpha:1];
                    [self setHorizontalFrame];
                }
                
                return cell;
                
            }else
            {
                NSString *identifier = @"InsuranceCell";
                InsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil) {
                    cell = [[InsuranceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                // NSArray *data = [self insurancesForSection];
                NSArray *data = [NSArray arrayWithObjects:
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"pic_cigna_shop.png",@"image",@"招商信诺寰球至尊高端个人医疗保险A款",@"name",@"http://appui.oss-cn-hangzhou.aliyuncs.com/%E4%BF%9D%E9%99%A9%E8%AF%B4%E6%98%8E%E6%96%87%E6%A1%A3/%E6%8B%9B%E5%95%86%E4%BF%A1%E8%AF%BA.jpg",@"introduce", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"pic_minan_shop.png",@"image",@"民安-时康全球保尊乐计划",@"name",@"http://appui.oss-cn-hangzhou.aliyuncs.com/%E4%BF%9D%E9%99%A9%E8%AF%B4%E6%98%8E%E6%96%87%E6%A1%A3/%E6%B0%91%E5%AE%89.jpg",@"introduce", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"pic_redefining_shop.png",@"image",@"安盛常青藤亲子计划",@"name",@"http://appui.oss-cn-hangzhou.aliyuncs.com/%E4%BF%9D%E9%99%A9%E8%AF%B4%E6%98%8E%E6%96%87%E6%A1%A3/%E5%AE%89%E7%9B%9B.jpg",@"introduce", nil],nil];
                
                
                NSMutableArray *insurances = [[NSMutableArray alloc] init];
                for (int i=(row-1)*3; i<(row-1)*3+3; i++)
                {
                    if (i >= [data count]) break;
                    [insurances addObject:[data objectAtIndex:i]];
                }
                [cell setInsurances:insurances];
                if ([MainTabBarController sharedMainViewController].isVertical) {
                    [cell.contentView setAlpha:0];
                    [self setVerticalFrame];
                }else{
                    [cell.contentView setAlpha:1];
                    [self setHorizontalFrame];
                }
                return cell;
            }
            
        default:
        {
            
            if (row == [self rowNumForSection:section]) {
                NSString *identifier = @"PartCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                }
                [cell setBackgroundColor:[UIColor clearColor]];
                return cell;
                
            }else{
                NSString *identifier = @"WareCell";
                WareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil) {
                    cell = [[WareCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                NSArray *data = [self waresForSection:section];
                NSMutableArray *wares = [[NSMutableArray alloc] init];
                for (int i=row*3; i<row*3+3; i++)
                {
                    if (i >= [data count]) break;
                    [wares addObject:[data objectAtIndex:i]];
                }
                [cell setWares:wares];
                return cell;
            }

        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (_shopState) {
        case ShopStateInsurance:
            return row == 0? 568 :320 ;
            break;
        default:
            if ([indexPath row] == [self rowNumForSection:[indexPath section]]) {
                return 8;
            }else{
                return 272;
            }
           
    }

}





#pragma mark - 获取相应section的数据

- (NSArray *)waresForSection:(NSInteger)section
{
    NSArray* data = nil;
    switch (_shopState) {
        case ShopStateNormal:
            data = [[ShopModel sharedInstance] waresForSectionIndex:section];
            break;
        case ShopStateFiltered:
            data = [[ShopModel sharedInstance] filteredWares];
            break;
        case ShopStateInsurance:
            break;
    }
    return data;
}

- (void)sectionHeaderTapped:(UIGestureRecognizer *)sender
{
    [MobClick event:umeng_event_click label:@"Tap_ShopViewController"];
    NSInteger section = sender.view.tag;
    switch (_shopState) {
        case ShopStateNormal:
        {
            [ShopModel sharedInstance].sectionIndex = section;
            _shopState = ShopStateFiltered;
            
            
        }
            break;
        case ShopStateFiltered:
        {
             _shopState = ShopStateNormal;
            [ShopModel sharedInstance].sectionIndex = -1;
            
    
        }
            break;
        case ShopStateInsurance:
        {
            _shopState = ShopStateNormal;
            [ShopModel sharedInstance].sectionIndex = -1;
          
            
        }
            break;
        default:
            break;
    }
    PostNotification(Noti_RefreshMenu, nil);
  
}




-(void)reloadShopMall
{

    NSInteger type = [ShopModel sharedInstance].sectionIndex;
    
    if (type < 0 && ![ShopModel sharedInstance].searchOn)
        _shopState = ShopStateNormal;
    else if (type == 11)
    {
        _shopState = ShopStateInsurance;
    }
    else
    {
        _shopState = ShopStateFiltered;
        _refreshFooter.alpha = 1;
        if ([[[ShopModel sharedInstance] filteredWares] count] <= 2)
            [[ShopModel sharedInstance] loadMore];
    }
    if (_refreshFooter.isRefreshing)
        [_refreshFooter endRefreshing];
    [_shopMallTable reloadData];
    
    [headView setStatusWithKindIndex:type andUnfold:_shopState == ShopStateNormal?NO:YES];

    
}


- (void)setVerticalFrame
{
    
    [headView setFrame:CGRectMake(0, 0, self.frame.size.width, 56)];
    [headView setVerticalFrame];
    [_shopMallTable setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if (_shopState == ShopStateInsurance) {
        [noti_insurance setAlpha:1];
    }
}

- (void)setHorizontalFrame
{
   
    [headView setFrame:CGRectMake(0, 0, self.frame.size.width, 56)];
    [headView setHorizontalFrame];
    [_shopMallTable setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if (_shopState == ShopStateInsurance) {
          [noti_insurance setAlpha:0];
    }
}







@end
