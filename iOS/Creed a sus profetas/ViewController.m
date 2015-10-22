//
//  ViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 16/07/15.
//  Copyright (c) 2015 UMN. All rights reserved.
//

#import "ViewController.h"

#import "LoadingView.h"
#import "LecturaViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize datepicker=_datepicker;

-(IBAction)goToOpciones:(id)sender;
{
    
}

-(IBAction)goToRead:(id)sender
{
    NSDate *fechaDeLaLectura = [_datepicker date];
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:fechaDeLaLectura];
    
    
    int day = (int)[components day];
    int month = (int)[components month];
    int year = (int)[components year];
    
    
    NSString *mes;
    switch (month) {
        case 1:
            mes=@"enero";
            break;
        case 2:
            mes=@"febrero";
            break;
        case 3:
            mes=@"marzo";
            break;
        case 4:
            mes=@"abril";
            break;
        case 5:
            mes=@"mayo";
            break;
        case 6:
            mes=@"junio";
            break;
        case 7:
            mes=@"julio";
            break;
        case 8:
            mes=@"agosto";
            break;
        case 9:
            mes=@"septiembre";
            break;
        case 10:
            mes=@"octubre";
            break;
        case 11:
            mes=@"noviembre";
            break;
        case 12:
            mes=@"diciembre";
            break;
        default:
            break;
    }
    
    
    NSString *nombreDelArchivo = [NSString stringWithFormat:@"%@%dy%d",mes,day,year];
    
    texto = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:nombreDelArchivo ofType:@"txt"] encoding:NSASCIIStringEncoding error:nil];
    
    if([texto isEqualToString:@""] || texto==nil)
    {
        LoadingView *load = [LoadingView loadingViewInView:self.view];
        NSError *error3;
        NSString *url =[NSString stringWithFormat:@"http://unionnorte.org/bhp/l/%@.txt",nombreDelArchivo];
        texto= [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSASCIIStringEncoding error:&error3];
       // NSLog(@"%@",error3.description);
        if(texto==nil)
        {
            
            UIAlertController * view=   [UIAlertController
                                         alertControllerWithTitle:@"Creed a sus profetas"
                                         message:@"No existe todavia la lectura para ese día, favor de esperar la actualización."
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancel = [UIAlertAction
                                     actionWithTitle:@"Aceptar"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [view dismissViewControllerAnimated:YES completion:nil];
                                     }];
            [view addAction:cancel];
            [self presentViewController:view animated:YES completion:nil];

        }
        else
        {
            [self performSegueWithIdentifier:@"vamosALeer" sender:self];
        }
        [load removeView];
        
       
    }
    else
    {
        [self performSegueWithIdentifier:@"vamosALeer" sender:self];

    }
    
    
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"vamosALeer"])
    {
        LecturaViewController *lectura = [segue destinationViewController];
        [lectura setTexto:texto];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"fondo"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
