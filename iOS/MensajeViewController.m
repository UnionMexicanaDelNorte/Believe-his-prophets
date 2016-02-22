//
//  MensajeViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import "MensajeViewController.h"

@interface MensajeViewController ()

@end

@implementation MensajeViewController
@synthesize textView=_textView;
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.textView.text = men;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        NSInteger tamano = [[standardUserDefaults valueForKey:@"tamanoLetra"] integerValue];
        self.textView.font = [UIFont systemFontOfSize:tamano];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setNombreN:(NSString*)nombre1
{
    self.title=nombre1;
}
-(void)setMen:(NSString*)mensaje
{
    men=mensaje;
    self.textView.text=mensaje;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        NSInteger tamano = [[standardUserDefaults valueForKey:@"tamanoLetra"] integerValue];
        self.textView.font = [UIFont systemFontOfSize:tamano];
    }
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
