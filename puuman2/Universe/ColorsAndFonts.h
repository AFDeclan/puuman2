//
//  ColorsAndFonts.h
//  puman
//
//  Created by 陈晔 on 13-9-11.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#ifndef puman_ColorsAndFonts_h
#define puman_ColorsAndFonts_h

#pragma mark - colors

#define RGBColor(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define PMColor1 RGBColor(74, 74, 74)
#define PMColor2 RGBColor(125, 125, 125)
#define PMColor3 RGBColor(177, 177, 177)
#define PMColor4 RGBColor(219, 219, 219)
#define PMColor5 RGBColor(244, 244, 244)
#define PMColor6 RGBColor(7, 117, 202)
#define PMColor7 RGBColor(2, 61, 150)
#define PMColor8 RGBColor(246, 31, 35)

#define PMFont(size)       [UIFont systemFontOfSize:size]
#define PMFont_Bold(size)   [UIFont boldSystemFontOfSize:size]

#define PMFont1 PMFont(24)
#define PMFont2 PMFont(16)
#define PMFont3 PMFont(12)
#define PMFont4 PMFont(10)

#endif
