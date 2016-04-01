//
//  OpcionesViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 16/07/15.
//  Copyright (c) 2015 UMN. All rights reserved.
//

#import "OpcionesViewController.h"
#import "AppDelegate.h"
#import "LoadingView.h"
#import "LanguageManager.h"
@interface OpcionesViewController ()

@end

@implementation OpcionesViewController
@synthesize slider=_slider,prueba=_prueba,segundosLabel=_segundosLabel,segundosSlider=_segundosSlider,palabrasLabel=_palabrasLabel,palabrasSlider=_palabrasSlider,tituloSegundos=_tituloSegundos,segundosAuxLabel=_segundosAuxLabel,loginFacebook=_loginFacebook,conectadoComo=_conectadoComo,segmented=_segmented;


- (void)reloadRootViewController
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSString *storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    delegate.window.rootViewController = [storyboard instantiateInitialViewController];
}
-(void)SegmentChangeViewValueChanged:(UISegmentedControl *)SControl
{
    if(_segmented.selectedSegmentIndex==0)//spanish
    {
        [LanguageManager saveLanguageByIndex:0];
    }
    else
    {
        if(_segmented.selectedSegmentIndex==1)//english
        {
            [LanguageManager saveLanguageByIndex:1];
        }
        else
        {
            [LanguageManager saveLanguageByIndex:2];
        }
    }
    [self reloadRootViewController];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *idF,*name;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        idF = [[standardUserDefaults valueForKey:@"idF"] description];
        name = [[standardUserDefaults valueForKey:@"name"] description];
    }
    if(name!=NULL)
    {
        if(name.length>0)
        {
            [_conectadoComo setText:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"Conectado", nil),name]];
            [_loginFacebook setTitle:NSLocalizedString(@"desconectar", nil) forState:UIControlStateNormal];
        }
        else
        {
            [_conectadoComo setText:@""];
            [_loginFacebook setTitle:NSLocalizedString(@"conectar", nil) forState:UIControlStateNormal];
        }
    }
    else
    {
        [_conectadoComo setText:@""];
        [_loginFacebook setTitle:NSLocalizedString(@"conectar", nil) forState:UIControlStateNormal];
    }

}
-(void)cambiaTamanoDeLetra
{
    [_prueba setFont:[UIFont systemFontOfSize:_slider.value]];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setInteger:_slider.value forKey:@"tamanoLetra"];
        [standardUserDefaults synchronize];
    }
}

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

-(void)cambiaSegundos
{
    if(_segundosSlider.value==0.0f)
    {
        _segundosLabel.text=NSLocalizedString(@"desactivado", nil);
        _tituloSegundos.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"cada1", nil),NSLocalizedString(@"cada2", nil)];
    }
    else
    {
        _segundosLabel.text=[NSString stringWithFormat:@"%@ %.1f %@",NSLocalizedString(@"cada", nil),_segundosSlider.value, NSLocalizedString(@"segundos", nil)];
        _tituloSegundos.text=[NSString stringWithFormat:@"%@ %.1f %@",NSLocalizedString(@"cada1", nil),_segundosSlider.value,NSLocalizedString(@"cada2", nil)];
    }
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setInteger:_segundosSlider.value forKey:@"segundos"];
        [standardUserDefaults synchronize];
    }
}

-(void)cambiaPalabras
{
    if(_palabrasSlider.value==0.0f)
    {
        _segundosLabel.text=NSLocalizedString(@"desactivado", nil);
    }
    else
    {
        _palabrasLabel.text=[NSString stringWithFormat:@"%.1f %@ %.1f %@",_palabrasSlider.value,NSLocalizedString(@"palabrasCada", nil),_segundosSlider.value, NSLocalizedString(@"segundos", nil)];
    }
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setInteger:_palabrasSlider.value forKey:@"palabras"];
        [standardUserDefaults synchronize];
    }
}
-(IBAction)loginDesloginFacebook:(id)sender
{
    UIButton *but = (UIButton*)sender;
    if([[but currentTitle] isEqualToString:NSLocalizedString(@"desconectar", nil)])
    {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
        [FBSDKAccessToken setCurrentAccessToken:nil];
        [_loginFacebook setTitle:NSLocalizedString(@"conectar", nil) forState:UIControlStateNormal];
        [_conectadoComo setText:@""];

    }
    else
    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login
         logInWithReadPermissions: @[@"public_profile"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error) {
                 NSLog(@"Process error");
             } else if (result.isCancelled) {
                 NSLog(@"Cancelled");
             } else {
                 NSLog(@"Logged in");
                 
                 NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                 [parameters setValue:@"id,name" forKey:@"fields"];
                 
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                               id result, NSError *error) {
                      NSDictionary *dic =result;
                      NSString *idF = [dic valueForKey:@"id"];
                      NSString *name = [dic valueForKey:@"name"];
                      
                      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                      [defaults setObject:idF forKey:@"idF"];
                      [defaults setObject:name forKey:@"name"];
                      [defaults synchronize];
                      [_conectadoComo setText:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"Conectado", nil),name]];
                      //post
                      
                      AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                      

                      [_loginFacebook setTitle:NSLocalizedString(@"desconectar", nil) forState:UIControlStateNormal];
                      
                      
                      if (app.hasInternet)
                      {
                          LoadingView *load = [LoadingView loadingViewInView:self.view];
                          dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                              NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
                              NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
                              NSString *urlString = [NSString stringWithFormat:@"http://unionnorte.org/bhp/bhp.php"];
                              
                              
                              NSString *post = [NSString stringWithFormat:@"servicio=nombres&accion=save&idF=%@&name=%@",idF,name];
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
                                      NSError* error;
                                      NSDictionary* json = [NSJSONSerialization
                                                            JSONObjectWithData:data
                                                            options:kNilOptions
                                                            error:&error];
                                      int success = [[json objectForKey:@"success"] intValue];
                                      if(success==1)
                                      {
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
                  }];
             }
         }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    idioma =0;
    [_segmented addTarget:self action:@selector(SegmentChangeViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    //FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    //loginButton.center = self.view.center;
    //loginButton.delegate = self;
    //loginButton.readPermissions = @[@"public_profile"];
    //[loginButton setTitle:NSLocalizedString(@"conectar", nil) forState:UIControlStateNormal];
    //[self.view addSubview:loginButton];
    [_loginFacebook setTitle:NSLocalizedString(@"conectar", nil) forState:UIControlStateNormal];
    
    
   


    
    
    
    

    

    //    _loginFacebook=loginButton;
    
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
    
    _segundosAuxLabel.text=NSLocalizedString(@"cadaLargo", nil);
    
    
    self.title=NSLocalizedString(@"Opciones", nil);
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:121.0f/255.0f blue:132.0f/255.0f alpha:1.0f];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.0f/255.0f green:121.0f/255.0f blue:132.0f/255.0f alpha:1.0f];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [_slider addTarget:self action:@selector(cambiaTamanoDeLetra) forControlEvents:UIControlEventValueChanged];
    
    [_segundosSlider addTarget:self action:@selector(cambiaSegundos) forControlEvents:UIControlEventValueChanged];
    
    [_palabrasSlider addTarget:self action:@selector(cambiaPalabras) forControlEvents:UIControlEventValueChanged];
    
     NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
     if (standardUserDefaults) {
         _segundosSlider.value = [[standardUserDefaults valueForKey:@"segundos"] floatValue];
         _palabrasSlider.value = [[standardUserDefaults valueForKey:@"palabras"] floatValue];
         _prueba.text = NSLocalizedString(@"texto", nil);
         _tituloSegundos.text= [NSString stringWithFormat:@"%@ %.1f %@",NSLocalizedString(@"cada1", nil),[[standardUserDefaults valueForKey:@"segundos"] floatValue], NSLocalizedString(@"cada2", nil)];
     }
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
