//
//  TextLayoutLabel.m
//  tryCoretext
//
//  Created by 陈晔 on 13-4-10.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "TextLayoutLabel.h"
#import "UniverseConstant.h"

#import<CoreText/CoreText.h>

@interface TextLayoutLabel()

- (CTFrameRef)getCTFrame;

@end


@implementation TextLayoutLabel

@synthesize paragraphSpacing = paragraphSpacing_;

@synthesize characterSpacing = characterSpacing_;

@synthesize linesSpacing = linesSpacing_;

@synthesize didAbbr = didAbbr_;

-(id) initWithFrame:(CGRect)frame

{//初始化字间距、行间距
    
    if(self =[super initWithFrame:frame])
        
    {
        
        self.characterSpacing = 2.0f;
        
        self.linesSpacing = 5.0f;
        
        self.paragraphSpacing = 0.0;
        
    }
    
    return self;
    
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    //frame_ = frame;
    //NSLog(@"frame(%f,%f,%f,%f)", frame_.origin.x, frame_.origin.y, frame_.size.width, frame_.size.height);
}

- (CGFloat) setText:(NSString *)text abbreviated:(BOOL)abbr
{
    if ([text length] == 1) {
        text = [text stringByAppendingString:@" "];
    }
    [super setText:text];
    CGFloat extendedHeight;
    NSArray *linesTotal;
    if (abbr) {
        
        extendedHeight =  10000;    //足够大的高度
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, extendedHeight)];
        CTFrameRef textFrame1 = self.getCTFrame;
        linesTotal = (__bridge NSArray *) CTFrameGetLines(textFrame1);
        
    }
    
    extendedHeight = abbr? 80 : 10000;    //足够大的高度
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, extendedHeight)];
    CTFrameRef textFrame = self.getCTFrame;
    NSArray *linesArray = (__bridge NSArray *) CTFrameGetLines(textFrame);

    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    
    if ([linesArray count] == 0)
    {
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0)];
        return 0;
    }
    if ([linesArray count] <= 4) didAbbr_ = NO;
    else didAbbr_ = abbr;
    NSUInteger index = didAbbr_? 3 : [linesArray count] - 1;
    int line_y = (int) origins[index].y;  //需要显示的最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    CGFloat height = extendedHeight - line_y + descent + 1;
    
    //NSLog(@"height:%f", height);

    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height)];
    
    CFRelease(textFrame);
    if (abbr) {
        if ([linesTotal count] <= 4) didAbbr_ = NO;
        else didAbbr_ = YES;
    }
    

    return height;
}

- (CTFrameRef)getCTFrame

{
    
    //去掉空行
    
    NSString *labelString = self.text;
    
    NSString *myString = [labelString stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
    
    //创建AttributeString
    
    NSMutableAttributedString *string =[[NSMutableAttributedString alloc]initWithString:myString];
    
    //设置字体及大小
    
    CTFontRef helveticaBold = CTFontCreateWithName((__bridge CFStringRef)self.font.fontName,self.font.pointSize,NULL);
    
    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[string length])];
    
    //设置字间距
    
    if(self.characterSpacing)
        
    {
        
        long number = self.characterSpacing;
        
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        
        [string addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[string length])];
        
        CFRelease(num);
        
    }
    
    //设置字体颜色
    
    [string addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0,[string length])];
    
    //创建文本对齐方式
    
    CTTextAlignment alignment = kCTLeftTextAlignment;
    
    if(self.textAlignment == NSTextAlignmentCenter)
        
    {
        
        alignment = kCTCenterTextAlignment;
        
    }
    
    if(self.textAlignment == NSTextAlignmentRight)
        
    {
        
        alignment = kCTRightTextAlignment;
        
    }
    
    CTParagraphStyleSetting alignmentStyle;
    
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    
    alignmentStyle.valueSize = sizeof(alignment);
    
    alignmentStyle.value = &alignment;
    
    //设置文本行间距
    
    CGFloat lineSpace = self.linesSpacing;
    
    CTParagraphStyleSetting lineSpaceStyle;
    
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    
    lineSpaceStyle.value =&lineSpace;
    
    //设置文本段间距
    
    CGFloat paragraphSpace = self.paragraphSpacing;
    
    CTParagraphStyleSetting paragraphSpaceStyle;
    
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    
    paragraphSpaceStyle.valueSize = sizeof(CGFloat);
    
    paragraphSpaceStyle.value = &paragraphSpace;
    
    
    
    //创建设置数组
    
    CTParagraphStyleSetting settings[ ] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle};
    
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings , sizeof(settings));
    
    //给文本添加设置
    
    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0 , [string length])];
    
    //排版
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)string);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRect(path, NULL , self.bounds);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), path , NULL);
    
    CGPathRelease(path);
    
    CFRelease(framesetter);
    
    CFRelease(helveticaBold);

    return frame;
}


- (void) drawTextInRect:(CGRect)requestedRect

{
    //NSLog(@"%@", @"Draw!");
    //NSLog(@"frame(%f,%f,%f,%f)", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    //NSLog(@"requestRect(%f,%f,%f,%f)", requestedRect.origin.x, requestedRect.origin.y, requestedRect.size.width, requestedRect.size.height);
    CTFrameRef frame = self.getCTFrame;
    //翻转坐标系统（文本原来是倒的要翻转下）
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    //画出文本
    
    CTFrameDraw(frame, context);
    
    //释放
    
    CFRelease(frame);
    
    UIGraphicsPushContext(context);
    
}

@end