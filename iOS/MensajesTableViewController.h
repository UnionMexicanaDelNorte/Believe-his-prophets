//
//  MensajesTableViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MensajesTableViewController : UITableViewController
{
    int indiceDelMensaje;
}
-(void)reload;
@property (nonatomic,strong) NSArray *mensajes;
@property (nonatomic,strong) NSString *fecha;
@end
