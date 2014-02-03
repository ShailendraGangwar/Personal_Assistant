//
//  PCPieChart.h
//  HeyZooka
//
//  Created by Apple on 20/01/14.
//  Copyright (c) 2014 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCPieChart.h"

@interface PCPieComponent : NSObject
{
    float value, startDeg, endDeg;
    NSString *title;
    UIColor *colour;
    
}
@property (nonatomic, assign) float value, startDeg, endDeg;
@property (nonatomic, strong) UIColor *colour;
@property (nonatomic, strong) NSString *title;


- (id)initWithTitle:(NSString*)_title value:(float)_value;
+ (id)pieComponentWithTitle:(NSString*)_title value:(float)_value;
@end

#define PCColorBlue [UIColor colorWithRed:0.0 green:153/255.0 blue:204/255.0 alpha:1.0]
#define PCColorGreen [UIColor colorWithRed:153/255.0 green:204/255.0 blue:51/255.0 alpha:1.0]
#define PCColorOrange [UIColor colorWithRed:1.0 green:153/255.0 blue:51/255.0 alpha:1.0]
#define PCColorRed [UIColor colorWithRed:1.0 green:51/255.0 blue:51/255.0 alpha:1.0]
#define PCColorYellow [UIColor colorWithRed:1.0 green:220/255.0 blue:0.0 alpha:1.0]
#define PCColorDefault [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]

@interface PCPieChart : UIView {
    NSMutableArray *components;
    int diameter;
	UIFont *titleFont, *percentageFont;
	BOOL showArrow, sameColorLabel;
}
@property (nonatomic, assign) int diameter;
@property (nonatomic, strong) NSMutableArray *components;
@property (nonatomic, strong) UIFont *titleFont, *percentageFont;
@property (nonatomic, assign) BOOL showArrow, sameColorLabel;

@end
