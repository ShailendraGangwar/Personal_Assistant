//
//  ExpenseDetailViewController.h
//  Personal Assistant
//
//  Created by Aricent Group on 24/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpenseViewController.h"
#import "Expense.h"

@interface ExpenseDetailViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray          *mainArray;
    UIButton                *doneButton ;
    NSDate*                 birthDate;
    UITextField             *currentTextField;
}
@property (weak,nonatomic) IBOutlet UITextField *transactionAmount;
@property (weak,nonatomic) IBOutlet UITextField *transactionDate;
@property (weak,nonatomic) IBOutlet UITextField *transactionCategory;
@property (weak,nonatomic) IBOutlet UITextField *transactionMode;
@property (weak,nonatomic) IBOutlet UILabel *transactionAmountLabel;
@property (weak,nonatomic) IBOutlet UILabel *transactionDateLabel;
@property (weak,nonatomic) IBOutlet UILabel *transactionModeLabel;
@property (weak,nonatomic) IBOutlet UILabel *transactionCategoryLabel;
@property (weak,nonatomic) IBOutlet UILabel *transactionNoteLabel;
@property (weak,nonatomic) IBOutlet UILabel *transactionCurrency;
@property (weak,nonatomic) IBOutlet UIButton *expenceIncomeButton;
@property (weak,nonatomic) IBOutlet UIButton *saveButton;
@property (weak,nonatomic) IBOutlet UIButton *cancelButton;
@property (weak,nonatomic) IBOutlet UIButton *deleteRecordButton;
@property (strong, nonatomic)       UIPickerView *mPickerView;
@property (weak,nonatomic) IBOutlet UIScrollView *mScrollView;
@property (strong, nonatomic)       UIDatePicker *datePickerView;
@property (weak,nonatomic) IBOutlet UITextView *transactionNote;
@property(nonatomic)                Expense *mTempExpenseData;
@property (weak,nonatomic) IBOutlet UIView *mExpenseView;
@property (strong,nonatomic) UISegmentedControl *segmentControl;
-(IBAction)save:(id)sender;


@end
