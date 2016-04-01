//
//  DiaMensajesTableViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import "DiaMensajesTableViewController.h"
#import "AppDelegate.h"
#import "MensajesTableViewController.h"

@interface DiaMensajesTableViewController ()

@end

@implementation DiaMensajesTableViewController
@synthesize mensajes=_mensajes;
-(void)showNoHayInternet
{
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:NSLocalizedString(@"creed", nil)
                                 message:NSLocalizedString(@"noHayInternet", nil)
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Aceptar", nil)
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:121.0f/255.0f blue:132.0f/255.0f alpha:1.0f];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.0f/255.0f green:121.0f/255.0f blue:132.0f/255.0f alpha:1.0f];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.title=NSLocalizedString(@"Mensajes", nil);

    titulos = [[NSMutableArray alloc] init];
    subtitulos = [[NSMutableArray alloc] init];
    nombres = [[NSMutableArray alloc] init];
    NSDate *today = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today]; // Get necessary date components
    
    int mesActual = (int) [components month]; //gives you month
    int anoActual = (int) [components year];
    int diaActual = (int) [components day];
    int mes, anio, dia;
    self.navigationController.tabBarItem.title=NSLocalizedString(@"Mensajes", nil);
    idioma =0;
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
    
    
    NSString *mesS,*nombreArchivo,*titulo,*mesM;
    for(anio=anoActual;anio>=2016;anio--)
    {
        for (mes=mesActual; mes>=1; mes--)
        {
            
            switch (mes) {
                case 1:
                    mesS=@"enero";
                    mesM=@"Enero";
                    if(mes!=mesActual)
                    {
                        diaActual=31;
                    }
                    break;
                case 2:
                    mesS=@"febrero";
                    mesM=@"Febrero";
                    if(mes!=mesActual)
                    {
                        diaActual=29;
                    }
                    break;
                case 3:
                    mesS=@"marzo";
                    mesM=@"Marzo";
                    if(mes!=mesActual)
                    {
                        diaActual=31;
                    }
                    break;
                case 4:
                    mesS=@"abril";
                    mesM=@"Abril";
                    if(mes!=mesActual)
                    {
                        diaActual=30;
                    }
                    break;
                case 5:
                    mesS=@"mayo";
                    mesM=@"Mayo";
                    if(mes!=mesActual)
                    {
                        diaActual=31;
                    }
                    break;
                case 6:
                    mesS=@"junio";
                    mesM=@"Junio";
                    if(mes!=mesActual)
                    {
                        diaActual=30;
                    }
                    break;
                case 7:
                    mesS=@"julio";
                    mesM=@"Julio";
                    if(mes!=mesActual)
                    {
                        diaActual=31;
                    }
                    break;
                case 8:
                    mesS=@"agosto";
                    mesM=@"Agosto";
                    if(mes!=mesActual)
                    {
                        diaActual=31;
                    }
                    break;
                case 9:
                    mesS=@"septiembre";
                    mesM=@"Septiembre";
                    if(mes!=mesActual)
                    {
                        diaActual=30;
                    }
                    break;
                case 10:
                    mesS=@"octubre";
                    mesM=@"Octubre";
                    if(mes!=mesActual)
                    {
                        diaActual=31;
                    }
                    break;
                case 11:
                    mesS=@"noviembre";
                    mesM=@"Noviembre";
                    if(mes!=mesActual)
                    {
                        diaActual=30;
                    }
                    break;
                case 12:
                    mesS=@"diciembre";
                    mesM=@"Diciembre";
                    if(mes!=mesActual)
                    {
                        diaActual=31;
                    }
                    break;
                default:
                    break;
            }
          
            
            
            for(dia=diaActual;dia>=1;dia--)
            {
                if(anio==2016 && mes==1 && dia <24)
                {
                    return;
                }
                if(idioma==1)
                {
                    nombreArchivo = [NSString stringWithFormat:@"%@%dy%d",mesS,dia,anio];
                }
                else
                {
                    if(idioma==2)
                    {
                        nombreArchivo = [NSString stringWithFormat:@"%@%dy%d_en",mesS,dia,anio];
                    }
                    else
                    {
                        if(idioma==3)
                        {
                            nombreArchivo = [NSString stringWithFormat:@"%@%dy%d_fr",mesS,dia,anio];
                        }
                    }
                }
                [nombres addObject:nombreArchivo];
                //configura titulo
                texto = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:nombreArchivo ofType:@"txt"] encoding:NSMacOSRomanStringEncoding error:nil];
                
                if([texto isEqualToString:@""] || texto==nil)
                {
                    //   LoadingView *load = [LoadingView loadingViewInView:self.view];
                    NSError *error3;
                    NSString *url =[NSString stringWithFormat:@"http://unionnorte.org/bhp/l/%@.txt",nombreArchivo];
                    texto= [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSMacOSRomanStringEncoding error:&error3];
                    // NSLog(@"%@",error3.description);
                    if(texto==nil)
                    {
                        
                        UIAlertController * view=   [UIAlertController
                                                     alertControllerWithTitle:NSLocalizedString(@"creed", nil)
                                                     message:NSLocalizedString(@"noExiste", nil)
                                                     preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction* cancel = [UIAlertAction
                                                 actionWithTitle:NSLocalizedString(@"Aceptar", nil)
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
                        NSArray *lineas = [texto componentsSeparatedByString:@"\n"];
                        if(lineas.count>4)
                        {
                            [titulos addObject:[[lineas objectAtIndex:2]capitalizedString]];
                            [subtitulos addObject:[[lineas objectAtIndex:4]capitalizedString] ];
                        }
                        else
                        {
                            titulo = [NSString stringWithFormat:@"%d %@ %d",dia,mesM,anio];
                            [titulos addObject:[titulo capitalizedString]];
                        }
                        
                        //[self performSegueWithIdentifier:@"vamosALeer" sender:self];
                    }
                    // [load removeView];
                    
                    
                }
                else
                {
                    NSArray *lineas = [texto componentsSeparatedByString:@"\r\n"];
                    if(lineas.count>4)
                    {
                        [titulos addObject:[[lineas objectAtIndex:2]capitalizedString]];
                        [subtitulos addObject:[[lineas objectAtIndex:4]capitalizedString]];
                    }
                    else
                    {
                        titulo = [NSString stringWithFormat:@"%d %@ %d",dia,mesM,anio];
                        [titulos addObject:[titulo capitalizedString]];
                    }
                    //                    [self performSegueWithIdentifier:@"vamosALeer" sender:self];
                    
                }
                
                //configura titulo
                
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titulos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"diamensajes" forIndexPath:indexPath];
    if(titulos.count>indexPath.row)
    {
        cell.textLabel.text = [titulos objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = @"";
    }
    if(subtitulos.count>indexPath.row)
    {
        cell.detailTextLabel.text = [subtitulos objectAtIndex:indexPath.row];
    }
    else
    {
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (app.hasInternet)
    {
        LoadingView *load = [LoadingView loadingViewInView:self.view];
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
            NSString *urlString = [NSString stringWithFormat:@"http://unionnorte.org/bhp/bhp.php"];
        
            NSString *base = [nombres objectAtIndex:indexPath.row];
            if([base rangeOfString:@"enero"].location != NSNotFound || [base rangeOfString:@"january"].location != NSNotFound || [base rangeOfString:@"janvier"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"enero"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"january"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"janvier"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=1;
            }
            
            if([base rangeOfString:@"febrero"].location != NSNotFound || [base rangeOfString:@"february"].location != NSNotFound || [base rangeOfString:@"février"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"febrero"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"february"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"février"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=2;
            }
            
            
            if([base rangeOfString:@"marzo"].location != NSNotFound || [base rangeOfString:@"march"].location != NSNotFound || [base rangeOfString:@"mars"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"marzo"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"march"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"mars"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=3;
            }
            
            
            if([base rangeOfString:@"abril"].location != NSNotFound || [base rangeOfString:@"april"].location != NSNotFound || [base rangeOfString:@"avril"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"abril"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"april"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"avril"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=4;
            }
            
            
            if([base rangeOfString:@"mayo"].location != NSNotFound || [base rangeOfString:@"may"].location != NSNotFound || [base rangeOfString:@"mai"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"mayo"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"may"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"mai"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=5;
            }
            
            
            if([base rangeOfString:@"junio"].location != NSNotFound || [base rangeOfString:@"june"].location != NSNotFound || [base rangeOfString:@"juin"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"junio"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"june"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"juin"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=6;
            }
            
            if([base rangeOfString:@"julio"].location != NSNotFound || [base rangeOfString:@"july"].location != NSNotFound || [base rangeOfString:@"juillet"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"julio"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"july"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"juillet"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=7;
            }
            
            
            if([base rangeOfString:@"agosto"].location != NSNotFound || [base rangeOfString:@"august"].location != NSNotFound || [base rangeOfString:@"aout"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"agosto"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"august"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"aout"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=8;
            }
            
            if([base rangeOfString:@"septiembre"].location != NSNotFound || [base rangeOfString:@"september"].location != NSNotFound || [base rangeOfString:@"septembre"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"septiembre"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"september"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"septembre"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=9;
            }
            
            if([base rangeOfString:@"octubre"].location != NSNotFound || [base rangeOfString:@"october"].location != NSNotFound || [base rangeOfString:@"octobre"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"octubre"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"october"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"octobre"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=10;
            }
            
            if([base rangeOfString:@"noviembre"].location != NSNotFound || [base rangeOfString:@"november"].location != NSNotFound || [base rangeOfString:@"novembre"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"noviembre"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"november"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"novembre"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=11;
            }
            
            if([base rangeOfString:@"diciembre"].location != NSNotFound || [base rangeOfString:@"december"].location != NSNotFound || [base rangeOfString:@"décembre"].location != NSNotFound)
            {
                NSRange range;
                range = [base rangeOfString:@"diciembre"];
                if(range.location==NSNotFound)
                {
                    range = [base rangeOfString:@"december"];
                    if(range.location==NSNotFound)
                    {
                        range = [base rangeOfString:@"décembre"];
                    }
                }
                NSString *aux1 = [base substringFromIndex:range.length];
                NSArray *test2 = [aux1 componentsSeparatedByString:@"y"];
                diaN = (int)[[test2 objectAtIndex:0] integerValue];
                NSArray *test1 = [[test2 objectAtIndex:1] componentsSeparatedByString:@"_"];
                anioN = (int)[[test1 objectAtIndex:0] integerValue];
                mesN=12;
            }    

            
            NSString *fecha = [NSString stringWithFormat:@"%d-%d-%d",diaN,mesN,anioN];
        
            NSString *post = [NSString stringWithFormat:@"servicio=mensajes&accion=listDia&fecha=%@",fecha];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
            NSString *postLength = [NSString stringWithFormat:@"%d", (int)[postData length]];
        
        
        
            NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
            
            NSString* encodedUrl = [urlString stringByAddingPercentEncodingWithAllowedCharacters:
                                    set];
            NSURL * url = [NSURL URLWithString:encodedUrl];
            NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
            [urlRequest setHTTPMethod:@"POST"];//GET
            [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
            [urlRequest setHTTPBody:postData];
            NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest                                                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSLog(@"%@",[error description]);
                if(error == nil)
                {
                    //NSString *aver = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSError* error;
                    NSDictionary* json = [NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:kNilOptions
                                      error:&error];
                    int success = [[json objectForKey:@"success"] intValue];
                    if(success==1)
                    {
                         _mensajes = [json objectForKey:@"mensajes"];
                        [self performSegueWithIdentifier:@"showMessages" sender:nil];
                    }
                    else
                    {
                    }
                }
                [load removeView];
            }];
        
            [dataTask resume];
        
            dispatch_async(dispatch_get_main_queue(), ^{
            // Code to update the UI/send notifications based on the results of the background processing
            //            [_message show];
            
            
            });
        });
    }
    else
    {
        [self showNoHayInternet];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMessages"])
    {
        NSString *fecha = [NSString stringWithFormat:@"%d-%d-%d",diaN,mesN,anioN];
        MensajesTableViewController *post = [segue destinationViewController];
        [post setMensajes:_mensajes];
        [post setFecha:fecha];
    }
}


@end
