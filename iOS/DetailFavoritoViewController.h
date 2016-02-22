//
//  DetailFavoritoViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailFavoritoViewController : UIViewController
{
    NSString *fecha;
}
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *next;
-(IBAction)goToInstagram:(id)sender;
@end
