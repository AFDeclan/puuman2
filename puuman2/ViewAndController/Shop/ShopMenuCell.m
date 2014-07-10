//
//  ShopMenuCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ShopMenuCell.h"
#import "ShopViewController.h"

@implementation ShopMenuCell
@synthesize flagNum = _flagNum;
@synthesize  indexPath = _indexPath;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)initialization
{
    titleButton = [[MenuTitleButton alloc] init];
    [self.contentView addSubview:titleButton];
    [titleButton addTarget:self action:@selector(selectedSection) forControlEvents:UIControlEventTouchUpInside];
    [self.layer setMasksToBounds:YES];
    [self.contentView.layer setMasksToBounds:YES];
    subTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 216, 0)];
    [subTable setDataSource:self];
    [subTable setDelegate:self];
    [self.contentView addSubview:subTable];
    [subTable setBackgroundColor:PMColor5];
    [subTable setSeparatorColor:[UIColor clearColor]];
    [subTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [subTable setShowsHorizontalScrollIndicator:NO];
    [subTable setShowsVerticalScrollIndicator:NO];
    [subTable setScrollEnabled:NO];
}

- (void)setFlagNum:(NSInteger)flagNum
{
    _flagNum = flagNum;
    [titleButton setFlagNum:flagNum];
    if ([[ShopModel sharedInstance] sectionIndex] == flagNum ) {
        [self showSubView];
        NSInteger cnt = [ShopModel subTypeCntForSectionAtIndex:flagNum ];
        if (cnt != 0) {
            cnt = (cnt % 2) == 0 ? cnt/2 : cnt/2+1;
            [subTable setFrame:CGRectMake(0, 64, 216, 72+64+ 88 *cnt)];
            [subTable reloadData];
        }
      
    }else{
        [self hiddenSubView];

    }

}

- (void)selectedSection
{
   
    [_delegate selectedMenuWithCell:self];
}

- (void)showSubView
{
       [titleButton showSubView];
}

- (void)hiddenSubView
{
        [titleButton hiddenSubView];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger cnt = [ShopModel subTypeCntForSectionAtIndex:_flagNum ];
    if (cnt == 0) {
        return 0;
    }
    cnt = (cnt % 2) == 0 ? cnt/2 : cnt/2+1;
    return cnt + 2 ;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cnt = [ShopModel subTypeCntForSectionAtIndex:_flagNum ];
    cnt = (cnt % 2) == 0 ? cnt/2 : cnt/2+1;
    if ([indexPath row] == 0) {
        NSString *identifier = @"DetailTopCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        return cell;

    }else if([indexPath row] == cnt +1){
        NSString *identifier = @"DetailBottomCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        return cell;
    }else{
        NSString *identifier = @"DetalSortCell";
        DetailSortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[DetailSortTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        [cell setRow:[indexPath row]];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cnt = [ShopModel subTypeCntForSectionAtIndex:_flagNum ];
    if (cnt != 0) {
        cnt = (cnt % 2) == 0 ? cnt/2 : cnt/2+1;
        if (indexPath.row == 0){
            return 72;
        }else if([indexPath row] == cnt +1){
            return 64;
        }else{
            return 88;
        }

    }else{
        return 0;
    }
    
    
}



@end
