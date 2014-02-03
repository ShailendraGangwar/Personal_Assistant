//
//  URLViewController.h
//  HeyZooka
//
//  Created by Apple on 23/01/14.
//  Copyright (c) 2014 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface URLViewController : UIViewController<NSURLConnectionDelegate>
{
    NSMutableData *responseData;
}
@property (nonatomic,weak) IBOutlet UIWebView *data;
@property (nonatomic,weak) IBOutlet UITextField *address;
-(IBAction)GoConnection:(id)sender;

@end
