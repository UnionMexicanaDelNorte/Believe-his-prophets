//
//  BHPTableViewCell.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 10/02/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHPTableViewCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UIImageView *imagenBiblia;
@property (nonatomic,strong) IBOutlet UILabel *capituloBiblia;
@property (nonatomic,strong) IBOutlet UILabel *capituloDelDia;
@property (nonatomic,strong) IBOutlet UILabel *EGW;
@property (nonatomic,strong) IBOutlet UILabel *capituloEGW;
@property (nonatomic,strong) IBOutlet UILabel *hoy;
@end
