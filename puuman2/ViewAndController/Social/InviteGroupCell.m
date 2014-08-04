//
//  InviteGroupCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-31.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "InviteGroupCell.h"
#import "FigureHeaderCell.h"
#import "UniverseConstant.h"
#import "ColorsAndFonts.h"
#import "DateFormatter.h"

@implementation InviteGroupCell
@synthesize delegate= _delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        groupMembers = [[NSArray alloc] init];
        figuresColumnView = [[UIColumnView alloc] initWithFrame:CGRectMake(22, 36, 576, 120)];
        [figuresColumnView setBackgroundColor:[UIColor clearColor]];
        [figuresColumnView setColumnViewDelegate:self];
        [figuresColumnView setViewDataSource:self];
        [figuresColumnView setPagingEnabled:NO];
        [figuresColumnView setScrollEnabled:YES];
        [self.contentView addSubview:figuresColumnView];
        
        noti_Title = [[UILabel alloc] initWithFrame:CGRectMake(12, 16, 320, 16)];
        noti_Title.backgroundColor = [UIColor clearColor];
        noti_Title.textColor = PMColor1;
        noti_Title.font = PMFont2;
        [self addSubview:noti_Title];

        date_invite = [[UILabel alloc] initWithFrame:CGRectMake(16, 128, 480, 12)];
        date_invite.backgroundColor = [UIColor clearColor];
        date_invite.textColor = PMColor3;
        date_invite.font = PMFont3;
    
        [self addSubview:date_invite];

        addBtn = [[AFColorButton alloc] init];
        [addBtn.title setText:@"加入"];
        [addBtn setColorType:kColorButtonGrayColor];
        [addBtn setDirectionType:kColorButtonLeft];
        [addBtn resetColorButton];
        SetViewLeftUp(addBtn, 496, 144);
        [addBtn addTarget:self action:@selector(acceptInvite) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addBtn];
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

#pragma mark - UIColumnViewDelegate and UIColumnViewDataSource
- (void)columnView:(UIColumnView *)columnView didSelectColumnAtIndex:(NSUInteger)index
{
}


- (CGFloat)columnView:(UIColumnView *)columnView widthForColumnAtIndex:(NSUInteger)index
{
    
    return 96;
    
}

- (NSUInteger)numberOfColumnsInColumnView:(UIColumnView *)columnView
{
    
    return [groupMembers count]>6?6:[groupMembers count];
    
}

- (UITableViewCell *)columnView:(UIColumnView *)columnView viewForColumnAtIndex:(NSUInteger)index
{
    
    NSString * cellIdentifier = @"FigursHeader";
    FigureHeaderCell *cell = (FigureHeaderCell *)[columnView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[FigureHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    [cell setRecommend:NO];
    [cell setMember:[groupMembers objectAtIndex:index]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}

- (void)buildCellWithGroup:(Group *)group
{
    inviteGroup = group;
    noti_Title.text = [NSString stringWithFormat:@"“%@”邀请您入团：",group.GName] ;
    date_invite.text = [DateFormatter stringFromDate:group.GCreateTime];
    groupMembers = group.GMember;
    [figuresColumnView reloadData];
    
}

- (void)acceptInvite
{
    [_delegate acceptInviteWithGroup:inviteGroup];
   
}

-(void)dealloc
{

}


@end
