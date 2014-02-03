//
//  mainStoryboard.h
//  Personal Assistant
//
//  Created by Aricent Group on 15/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

//Custom fonts
#define UNIVERS_65_BOLD_LATIN "Univers LT W01 65 Bold"
#define UNIVERS_55_ROMAN_LATIN "Univers LT W01 55 Roman"
#define UNIVERS_57_CONDENSED_LATIN "Univers LT W01 57 Condensed"
#define UNIVERS_67_CONDENSED_BOLD_LATIN "Univers LT W01 67 Bold Cn"
#define UNIVERS_75_BLACK_LATIN "Univers LT W01 75 Black"
#define UNIVERSE_55_OBLIQUE_LATIN "Univers LT W01 55 Oblique"
#define UNIVERS_45_STD_LIGHT     "Univers LT Std"
/**
 * Utilities for translating color from hex and rgb to UIColor instance.
 */
#define UIColorFromHexRGB(rgbHexValue) [UIColor colorWithRed:((float)((rgbHexValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbHexValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbHexValue & 0xFF))/255.0 alpha:1.0]
//define macro for RGB values
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define IS_IPHONE_5 ( [ [ UIScreen mainScreen ] bounds ].size.height == WIDTH_IPHONE_5 )
#define IS_IPHONE_4 ( [ [ UIScreen mainScreen ] bounds ].size.height == WIDTH_IPHONE_4 )
#define WIDTH_IPHONE_5 568
#define WIDTH_IPHONE_4 480