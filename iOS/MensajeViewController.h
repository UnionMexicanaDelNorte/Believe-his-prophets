//
//  MensajeViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MensajeViewController : UIViewController
{
    NSString *men,*nombre;
}
@property (strong, nonatomic) IBOutlet UITextView *textView;
-(void)setMen:(NSString*)mensaje;
-(void)setNombreN:(NSString*)nombre;
@end
