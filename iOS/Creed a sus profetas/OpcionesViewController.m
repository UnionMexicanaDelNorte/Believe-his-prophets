//
//  OpcionesViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 16/07/15.
//  Copyright (c) 2015 UMN. All rights reserved.
//

#import "OpcionesViewController.h"

@interface OpcionesViewController ()

@end

@implementation OpcionesViewController
@synthesize slider=_slider,prueba=_prueba;
-(void)cambiaTamanoDeLetra
{
    [_prueba setFont:[UIFont systemFontOfSize:_slider.value]];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setInteger:_slider.value forKey:@"tamanoLetra"];
        [standardUserDefaults synchronize];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_slider addTarget:self action:@selector(cambiaTamanoDeLetra) forControlEvents:UIControlEventValueChanged];

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
