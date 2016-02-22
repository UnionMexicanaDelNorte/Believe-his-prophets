//
//  ImagenViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 14/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollCustom.h"
#import "UIImageX.h"
#import "LoadingView.h"
@interface ImagenViewController : UIViewController
{
    CIContext *context;
    UIImage *imageOriginalParaFiltros, *imageOriginalParaFont;
    int deboObtenerOriginal;
    LoadingView *load;
    int indexImagen;
}
@property (strong, nonatomic) IBOutlet UIButton *imagen1;
@property (strong, nonatomic) IBOutlet UIButton *imagen2;
@property (strong, nonatomic) IBOutlet UIButton *imagen3;
@property (strong, nonatomic) IBOutlet UIButton *imagen4;
@property (strong, nonatomic) IBOutlet UIButton *imagen5;
@property (strong, nonatomic) IBOutlet UIButton *imagen6;
@property (strong, nonatomic) IBOutlet UIButton *imagen7;
@property (strong, nonatomic) IBOutlet UIButton *imagen8;
@property (strong, nonatomic) IBOutlet UIButton *imagen9;
@property (strong, nonatomic) IBOutlet UIButton *imagen10;
@property (strong, nonatomic) IBOutlet UIButton *imagen11;
@property (strong, nonatomic) IBOutlet UIScrollCustom *scroll;
@property (strong, nonatomic) IBOutlet UIView *vista;
@property (strong, nonatomic) IBOutlet UIView *vistaAbajo;
@property (strong, nonatomic) IBOutlet UIScrollCustom *scrollAbajo;
@property (strong, nonatomic) IBOutlet UIImageView *imagen;
@property (strong, nonatomic) IBOutlet UIButton *filtro1;
@property (strong, nonatomic) IBOutlet UIButton *filtro2;
@property (strong, nonatomic) IBOutlet UIButton *filtro3;
@property (strong, nonatomic) IBOutlet UIButton *filtro4;
@property (strong, nonatomic) IBOutlet UIButton *filtro5;
@property (strong, nonatomic) IBOutlet UIButton *filtro6;
@property (strong, nonatomic) IBOutlet UIButton *filtro7;
@property (strong, nonatomic) IBOutlet UIButton *filtro8;
@property (strong, nonatomic) IBOutlet UIButton *filtro9;
@property (strong, nonatomic) IBOutlet UIButton *filtro10;
@property (strong, nonatomic) IBOutlet UIButton *filtro11;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *barButton;
@property (strong, nonatomic) NSString *textoADibujar;
@property (strong, nonatomic) NSString *font;
@property (strong, nonatomic) NSString *fecha;

-(IBAction)filtro1:(id)sender;
-(IBAction)filtro2:(id)sender;
-(IBAction)filtro3:(id)sender;
-(IBAction)filtro4:(id)sender;
-(IBAction)filtro5:(id)sender;
-(IBAction)filtro6:(id)sender;
-(IBAction)filtro7:(id)sender;
-(IBAction)filtro8:(id)sender;
-(IBAction)filtro9:(id)sender;
-(IBAction)filtro10:(id)sender;
-(IBAction)filtro11:(id)sender;

-(IBAction)action:(id)sender;

-(IBAction)imagen1:(id)sender;
-(IBAction)imagen2:(id)sender;
-(IBAction)imagen3:(id)sender;
-(IBAction)imagen4:(id)sender;
-(IBAction)imagen5:(id)sender;
-(IBAction)imagen6:(id)sender;
-(IBAction)imagen7:(id)sender;
-(IBAction)imagen8:(id)sender;
-(IBAction)imagen9:(id)sender;
-(IBAction)imagen10:(id)sender;
-(IBAction)imagen11:(id)sender;
@end
