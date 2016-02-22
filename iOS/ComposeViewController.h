//
//  ComposeViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewController : UIViewController
-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) NSString *fecha;
@end
