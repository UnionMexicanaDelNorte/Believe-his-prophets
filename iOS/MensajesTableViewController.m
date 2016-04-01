//
//  MensajesTableViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import "MensajesTableViewController.h"
#import "MensajeViewController.h"
#import "ComposeViewController.h"
#import "LoadingView.h"
#import "AppDelegate.h"

@interface MensajesTableViewController ()

@end

@implementation MensajesTableViewController
@synthesize mensajes=_mensajes,fecha=_fecha;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)reload
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (app.hasInternet)
    {
        LoadingView *load = [LoadingView loadingViewInView:self.view];
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
            NSString *urlString = [NSString stringWithFormat:@"http://unionnorte.org/bhp/bhp.php"];
            NSString *post = [NSString stringWithFormat:@"servicio=mensajes&accion=listDia&fecha=%@",_fecha];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", (int)[postData length]];
            NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
            
            NSString* encodedUrl = [urlString stringByAddingPercentEncodingWithAllowedCharacters:
                                    set];            NSURL * url = [NSURL URLWithString:encodedUrl];
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
                        _mensajes = [json objectForKey:@"mensajes"];
                        [self.tableView reloadData];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return _mensajes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mensaje" forIndexPath:indexPath];
    if([[[_mensajes objectAtIndex:indexPath.row] valueForKey:@"mensaje"] length]>20)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@..",[[[_mensajes objectAtIndex:indexPath.row] valueForKey:@"mensaje"] substringToIndex:18]];
    }
    else
    {
        cell.textLabel.text = [[_mensajes objectAtIndex:indexPath.row] valueForKey:@"mensaje"];
    }
    cell.detailTextLabel.text=[[_mensajes objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indiceDelMensaje=(int)indexPath.row;
    [self performSegueWithIdentifier:@"mensaje" sender:nil];
}
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"compose"])
    {
        UINavigationController *navController = [segue destinationViewController];
        ComposeViewController *compose = (ComposeViewController *)([navController viewControllers][0]);
        [compose setFecha:_fecha];
    }
    if ([segue.identifier isEqualToString:@"mensaje"])
    {
        MensajeViewController *men = [segue destinationViewController];
        [men setMen:[[_mensajes objectAtIndex:indiceDelMensaje] valueForKey:@"mensaje"]];
        [men setNombreN:[[_mensajes objectAtIndex:indiceDelMensaje] valueForKey:@"name"]];
    }
}


@end
