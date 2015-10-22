//
//  LecturaViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 16/07/15.
//  Copyright (c) 2015 UMN. All rights reserved.
//

#import "LecturaViewController.h"

@interface LecturaViewController ()

@end

@implementation LecturaViewController
@synthesize textview=_textview,texto=_texto,utterance=_utterance,speechSynth=_speechSynth;
- (void)viewDidLoad {
    [super viewDidLoad];
    _speechSynth = [[AVSpeechSynthesizer alloc] init];
    
  // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_speechSynth stopSpeakingAtBoundary:AVSpeechBoundaryWord];
}
-(IBAction)share:(id)sender
{
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Creed a sus profetas"
                                 message:@"Selecciona una opción"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* compartir = [UIAlertAction
                                actionWithTitle:@"Compartir"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    [view dismissViewControllerAnimated:YES completion:nil];
                                    
                                    NSArray *activityItems;
                                    
                                    activityItems = @[[NSString stringWithFormat:@"%@ https://itunes.apple.com/us/app/creed-a-sus-profetas/id1020338022?l=es&mt=8",gema]];
                                    
                                    
                                    UIActivityViewController *activityController =
                                    [[UIActivityViewController alloc]
                                     initWithActivityItems:activityItems
                                     applicationActivities:nil];
                                    
                                    [self presentViewController:activityController
                                                       animated:YES completion:nil];
                                    
                                }];
    
    UIAlertAction* leemelo2 = [UIAlertAction
                               actionWithTitle:@"Léemelo"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   [view dismissViewControllerAnimated:YES completion:nil];
                                   
                                   if(!_yaEmpezeALeer)
                                   {
                                       _utterance = [[AVSpeechUtterance alloc] initWithString:textoModificado];
                                       _utterance.rate = AVSpeechUtteranceMinimumSpeechRate;
                                       [_speechSynth speakUtterance:_utterance];
                                       _yaEmpezeALeer=YES;
                                   }
                                   else
                                   {
                                       [_speechSynth continueSpeaking];
                                   }
                                   
                                   
                                   
                               }];
    
    UIAlertAction* detener = [UIAlertAction
                              actionWithTitle:@"Detener Lectura"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  [_speechSynth pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
                                  
                              }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancelar"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:compartir];
    [view addAction:leemelo2];
    [view addAction:detener];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _textview.text=_texto;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
       NSInteger tamano = [[standardUserDefaults valueForKey:@"tamanoLetra"] integerValue];
        _textview.font = [UIFont systemFontOfSize:tamano];
    }

    textoModificado = [[NSMutableString alloc] initWithString:@""];
    _texto = [_texto stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    BOOL primeraVez=YES;
    
    
    NSMutableArray *listItems = [[_texto componentsSeparatedByString:@"\n"]mutableCopy];
    NSMutableArray *forRemove = [NSMutableArray array];
    for(NSString *linea in listItems)
    {
        
        
        if([linea isEqualToString:@""])
        {
            [forRemove addObject:linea];
        }
        else
        {
            
            NSMutableArray *palabras = [[linea componentsSeparatedByString:@" "]mutableCopy];
            
            NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
            BOOL isDecimal = [nf numberFromString:[palabras objectAtIndex:0]] != nil;
            
            
            if (isDecimal)
            {
                [palabras replaceObjectAtIndex:0 withObject:@""];
                if(primeraVez)
                {
                    gema = linea;
                }
                for(NSString *palabra in palabras)
                {
                     [textoModificado appendFormat:@" %@",palabra];
                }
                
                
            }
            else
            {
                [textoModificado appendFormat:@" %@",linea];
            }
        }
        
    }
    [listItems removeObjectsInArray:forRemove];

    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   

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
