//
//  RecordCell.h
//  Personal Assistant
//
//  Created by Aricent Group on 24/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
@interface RecordCell : UITableViewCell


@property (strong,nonatomic) IBOutlet UIView *backgroundView;

@property (weak,nonatomic) IBOutlet UILabel *amountLabel;
@property (weak,nonatomic) IBOutlet UILabel *dateLabel;
@property (weak,nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak,nonatomic) IBOutlet UILabel *descLabel;
@property (weak,nonatomic) IBOutlet UILabel *typeLabel;
@property (weak,nonatomic) IBOutlet UILabel *expenseLabel;
@property (weak,nonatomic) IBOutlet UIView *upperView;
@property (weak,nonatomic) IBOutlet UIView *lowerView;


@end
