//
//  ComposeViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoadingView.h"
#import "MensajesTableViewController.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController
@synthesize textView=_textView,fecha=_fecha;
-(IBAction)save:(id)sender
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (app.hasInternet)
    {
        LoadingView *load = [LoadingView loadingViewInView:self.view];
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
            NSString *urlString = [NSString stringWithFormat:@"http://unionnorte.org/bhp/bhp.php"];
            NSString *idF;
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            if (standardUserDefaults) {
                idF = [[standardUserDefaults valueForKey:@"idF"] description];
            }
            if([idF isEqualToString:@""])
            {
                UIAlertController * view=   [UIAlertController
                                             alertControllerWithTitle:NSLocalizedString(@"creed", nil)
                                             message:NSLocalizedString(@"primeroConectate", nil)
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
                return;
            }
            if([self.textView.text isEqualToString:@""])
            {
                UIAlertController * view=   [UIAlertController
                                             alertControllerWithTitle:NSLocalizedString(@"creed", nil)
                                             message:NSLocalizedString(@"primeroEscribe", nil)
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
                return;
            }
            self.textView.text = [self.textView.text stringByReplacingOccurrencesOfString:@"'" withString:@""];
            
            NSString *post = [NSString stringWithFormat:@"servicio=mensajes&accion=save&idF=%@&fecha=%@&mensaje=%@",idF,_fecha,self.textView.text];
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
                        UITabBarController *tabbar = (UITabBarController*)[self presentingViewController];
                        
                        UINavigationController *navController = tabbar.selectedViewController;
                        
                        MensajesTableViewController *mensajes = (MensajesTableViewController *)([navController viewControllers][1]);
                        
                        
                        
                        [mensajes reload];
                        [self dismissViewControllerAnimated:YES completion:nil];
                        [load removeView];
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

-(IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    [self.textView becomeFirstResponder];
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
