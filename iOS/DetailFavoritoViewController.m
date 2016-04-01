//
//  DetailFavoritoViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import "DetailFavoritoViewController.h"
#import "ImagenViewController.h"

@interface DetailFavoritoViewController ()

@end

@implementation DetailFavoritoViewController
@synthesize next=_next;
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

-(IBAction)goToInstagram:(id)sender
{
    [self performSegueWithIdentifier:@"goToInstagram" sender:self];
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.textView.text = [[self.detailItem valueForKey:@"texto"] description];
        NSString *aux = [[self.detailItem valueForKey:@"fecha"] description];
        NSArray *components1 = [aux componentsSeparatedByString:@"-"];
        int dia = (int)[[components1 objectAtIndex:0] integerValue];
        int mes = (int)[[components1 objectAtIndex:1] integerValue];
        int anio = (int)[[components1 objectAtIndex:2] integerValue];
        NSString *mesM=@"";
        int idioma =0;
        if([NSLocalizedString(@"Idioma", nil) isEqualToString:@"Español"])
        {
            idioma=1;//español
        }
        else
        {
            if([NSLocalizedString(@"Idioma", nil) isEqualToString:@"English"])
            {
                idioma=2;//english
            }
            else
            {
                if([NSLocalizedString(@"Idioma", nil) isEqualToString:@"French"])
                {
                    idioma=3;//french
                }
            }
        }
        if(idioma==3)
        {
            switch (mes) {
                case 1:
                    mesM=@"Janvier";
                    break;
                case 2:
                    mesM=@"Février";
                    break;
                case 3:
                    mesM=@"Mars";
                    break;
                case 4:
                    mesM=@"Avril";
                    break;
                case 5:
                    mesM=@"Mai";
                    break;
                case 6:
                    mesM=@"Juin";
                    break;
                case 7:
                    mesM=@"Juillet";
                    break;
                case 8:
                    mesM=@"Aout";
                    break;
                case 9:
                    mesM=@"Septembre";
                    break;
                case 10:
                    mesM=@"Octobre";
                    break;
                case 11:
                    mesM=@"Novembre";
                    break;
                case 12:
                    mesM=@"Décembre";
                    break;
                default:
                    break;
            }
        }

        if(idioma==2)
        {
            switch (mes) {
                case 1:
                    mesM=@"January";
                    break;
                case 2:
                    mesM=@"February";
                    break;
                case 3:
                    mesM=@"March";
                    break;
                case 4:
                    mesM=@"April";
                    break;
                case 5:
                    mesM=@"May";
                    break;
                case 6:
                    mesM=@"June";
                    break;
                case 7:
                    mesM=@"July";
                    break;
                case 8:
                    mesM=@"August";
                    break;
                case 9:
                    mesM=@"September";
                    break;
                case 10:
                    mesM=@"October";
                    break;
                case 11:
                    mesM=@"November";
                    break;
                case 12:
                    mesM=@"December";
                    break;
                default:
                    break;
            }
        }
        if(idioma==1)
        {
            switch (mes) {
                case 1:
                    mesM=@"Enero";
                    break;
                case 2:
                    mesM=@"Febrero";
                    break;
                case 3:
                    mesM=@"Marzo";
                    break;
                case 4:
                    mesM=@"Abril";
                    break;
                case 5:
                    mesM=@"Mayo";
                    break;
                case 6:
                    mesM=@"Junio";
                    break;
                case 7:
                    mesM=@"Julio";
                    break;
                case 8:
                    mesM=@"Agosto";
                    break;
                case 9:
                    mesM=@"Septiembre";
                    break;
                case 10:
                    mesM=@"Octubre";
                    break;
                case 11:
                    mesM=@"Noviembre";
                    break;
                case 12:
                    mesM=@"Diciembre";
                    break;
                default:
                    break;
            }
        }
        
        fecha=[NSString stringWithFormat:@"%@ %d, %d",mesM,dia,anio];
        
        
        

        

        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        if (standardUserDefaults) {
            NSInteger tamano = [[standardUserDefaults valueForKey:@"tamanoLetra"] integerValue];
            self.textView.font = [UIFont systemFontOfSize:tamano];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_next setTitle:NSLocalizedString(@"next", @"")];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToInstagram"])
    {
        ImagenViewController *controller = (ImagenViewController *)[segue destinationViewController] ;
        [controller setFont:@"Hermes-Bold"];
        [controller setFecha:fecha];
        [controller setTextoADibujar:self.textView.text];
    }
}


@end
