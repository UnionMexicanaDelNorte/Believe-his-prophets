//
//  BHPTableViewCell.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 10/02/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import "BHPTableViewCell.h"

@implementation BHPTableViewCell
@synthesize imagenBiblia=_imagenBiblia,capituloBiblia=_capituloBiblia,capituloDelDia=_capituloDelDia,EGW=_EGW,capituloEGW=_capituloEGW,hoy=_hoy;
- (void)awakeFromNib {
    // Initialization code
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    _capituloDelDia.text=NSLocalizedString(@"capituloDelDia", nil);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
