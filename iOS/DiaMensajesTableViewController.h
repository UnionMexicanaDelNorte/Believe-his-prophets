//
//  DiaMensajesTableViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"
@interface DiaMensajesTableViewController : UITableViewController
{
    NSMutableArray *titulos;
    NSMutableArray *subtitulos;
    NSMutableArray *nombres;
    NSString *texto;
    int idioma,diaN,mesN,anioN;
}
@property (nonatomic,strong) NSArray *mensajes;
@end
