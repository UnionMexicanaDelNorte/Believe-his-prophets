//
//  SpanishTableViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 04/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"
@interface SpanishTableViewController : UITableViewController
{
    NSMutableArray *titulos;
    NSMutableArray *subtitulos;
    NSMutableArray *nombres;
    NSString *texto;
    NSString *fechaLabel;
    int indexGlobal;
    int hastaCuantos,cuantosVoy;
    int idioma,diaN,mesN,anioN;
    LoadingView *load1;
}
@end
