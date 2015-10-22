//
//  ViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 16/07/15.
//  Copyright (c) 2015 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSString *texto;
}
@property (nonatomic, strong) IBOutlet UIDatePicker *datepicker;
-(IBAction)goToOpciones:(id)sender;
-(IBAction)goToRead:(id)sender;
@end

