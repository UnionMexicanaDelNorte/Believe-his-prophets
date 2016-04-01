//
//  OpcionesViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 16/07/15.
//  Copyright (c) 2015 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <FBSDKCoreKit/FBSDKProfile.h>
//#import <FBSDKCoreKit/FBSDKGraphRequest.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface OpcionesViewController : UIViewController
{
    int idioma;
}
@property (nonatomic,strong) IBOutlet UISlider *slider;
@property (nonatomic,strong) IBOutlet UILabel *prueba;

-(IBAction)loginDesloginFacebook:(id)sender;
@property (nonatomic,strong) IBOutlet UILabel *tituloSegundos;
@property (nonatomic,strong) IBOutlet UIButton *loginFacebook;
@property (nonatomic,strong) IBOutlet UISegmentedControl *segmented;
@property (nonatomic,strong) IBOutlet UISlider *segundosSlider;
@property (nonatomic,strong) IBOutlet UILabel *segundosLabel;
@property (nonatomic,strong) IBOutlet UILabel *conectadoComo;
@property (nonatomic,strong) IBOutlet UILabel *segundosAuxLabel;
@property (nonatomic,strong) IBOutlet UISlider *palabrasSlider;
@property (nonatomic,strong) IBOutlet UILabel *palabrasLabel;
@end
