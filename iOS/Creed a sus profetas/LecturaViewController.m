//
//  LecturaViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 16/07/15.
//  Copyright (c) 2015 UMN. All rights reserved.
//

#import "LecturaViewController.h"
#import "AppDelegate.h"
@interface LecturaViewController ()

@end

@implementation LecturaViewController
@synthesize textview=_textview,texto=_texto,utterance=_utterance,speechSynth=_speechSynth,dia=_dia,mes=_mes,anio=_anio,barButton=_barButton,vistaTextview=_vistaTextview,labelFecha=_labelFecha,fechaLabel=_fechaLabel;
-(void)scrolea
{
    float numeroDePalabras = 0;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        numeroDePalabras = [[standardUserDefaults valueForKey:@"palabras"] floatValue];
    }
    int numeroDeLetrasPorPalabra = 6;
    NSRange range = NSMakeRange(loc, numeroDePalabras*numeroDeLetrasPorPalabra);
    loc=loc+numeroDePalabras*numeroDeLetrasPorPalabra;
    [self.textview scrollRangeToVisible:range];
}

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favoritos" inManagedObjectContext:[app managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[app managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}    

-(void)resaltaLectura
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favoritos" inManagedObjectContext:[app managedObjectContext]];
    [fetchRequest setEntity:entity];
    NSString *fecha = [NSString stringWithFormat:@"%d-%d-%d",(int)_dia,(int)_mes,(int)_anio];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fecha=%@",fecha ];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchBatchSize:20];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[app managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    int i;
    int cuantos = (int)aFetchedResultsController.fetchedObjects.count;
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:self.textview.text];
    for(i=0;i<cuantos;i++)
    {
        NSManagedObject *man = [aFetchedResultsController.fetchedObjects objectAtIndex:i];
        NSString *string2 = [string string];
        NSRange range = [string2 rangeOfString:[[man valueForKey:@"texto"]description]];
        if(modoNocturno)
        {
            [string addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:range];
        }
        else
        {
            [string addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:range];
        }
        
        
    }
    if(modoNocturno)
    {
        self.textview.backgroundColor=[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
        self.vistaTextview.backgroundColor=[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
        self.textview.textColor=[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
    }
    else
    {
        self.textview.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
        self.vistaTextview.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
        self.textview.textColor=[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
    }
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    [self.textview setAttributedText:string];
    
    if (standardUserDefaults) {
        NSInteger tamano = [[standardUserDefaults valueForKey:@"tamanoLetra"] integerValue];
        _textview.font = [UIFont systemFontOfSize:tamano];
    }
    

}
-(void)favorite
{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:self.textview.text];
    UITextRange *rangeText = [self.textview selectedTextRange];
    UITextPosition* selectionStart = rangeText.start;
    UITextPosition* selectionEnd = rangeText.end;
    UITextPosition* beginning = self.textview.beginningOfDocument;

    const NSInteger location = [self.textview offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self.textview offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    NSRange range = NSMakeRange(location, length);
    
    if(modoNocturno)
    {
        [string addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:range];
    }
    else
    {
        [string addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:range];
    }
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    

    [self.textview setAttributedText:string];
    
    if (standardUserDefaults) {
        NSInteger tamano = [[standardUserDefaults valueForKey:@"tamanoLetra"] integerValue];
        _textview.font = [UIFont systemFontOfSize:tamano];
    }

    //graba en bd !
    NSString *textoAGrabar = [self.textview.text substringWithRange:range];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:[app managedObjectContext]];
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    NSNumber *marbleNumber = [NSNumber numberWithInt:(int)time];
    [newManagedObject setValue:marbleNumber forKey:@"timestamp"];
    [newManagedObject setValue:[NSString stringWithFormat:@"%d-%d-%d",(int)_dia,(int)_mes,(int)_anio] forKey:@"fecha"];
    [newManagedObject setValue:textoAGrabar forKey:@"texto"];
    NSError *error = nil;
    if (![app.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self resaltaLectura];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    primeraVez1=1;
    _labelFecha.text=_fechaLabel;
    
    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"favorito", nil)
                                                      action:@selector(favorite)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:menuItem]];
    [UIMenuController sharedMenuController].menuVisible = YES;

    
    
    
    
    self.title=@"";
    
    
    
    _speechSynth = [[AVSpeechSynthesizer alloc] init];
    loc=0;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    float segundos=0.0f;
    if (standardUserDefaults) {
        int modo = (int)[[standardUserDefaults valueForKey:@"modoNocturno"] integerValue];
        if(modo==1)
        {
            modoNocturno=YES;
        }
        else
        {
            modoNocturno=NO;
        }
        
        if(modoNocturno)
        {
            self.textview.backgroundColor=[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
            self.vistaTextview.backgroundColor=[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
            self.textview.textColor=[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
        }
        else
        {
            self.textview.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
            self.vistaTextview.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
            self.textview.textColor=[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
        }
        segundos = [[standardUserDefaults valueForKey:@"segundos"] floatValue];
    }
    if(segundos!=0)
    {
        timerAutoscroll = [NSTimer scheduledTimerWithTimeInterval:segundos target:self selector:@selector(scrolea) userInfo:nil repeats:YES];
    }
    
  // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timerAutoscroll invalidate];
    timerAutoscroll=nil;
    [_speechSynth stopSpeakingAtBoundary:AVSpeechBoundaryWord];
}
-(IBAction)share:(id)sender
{
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:NSLocalizedString(@"creed", nil)
                                 message:NSLocalizedString(@"selecciona", nil)
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* compartir = [UIAlertAction
                                actionWithTitle:NSLocalizedString(@"compartir", nil)
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
                               actionWithTitle:NSLocalizedString(@"leemelo", nil)
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   [view dismissViewControllerAnimated:YES completion:nil];
                                   
                                   if(!_yaEmpezeALeer)
                                   {
                                       _utterance = [[AVSpeechUtterance alloc] initWithString:textoModificado];
                                       _utterance.rate = AVSpeechUtteranceDefaultSpeechRate;
                                       [_speechSynth speakUtterance:_utterance];
                                       _yaEmpezeALeer=YES;
                                   }
                                   else
                                   {
                                       [_speechSynth continueSpeaking];
                                   }
                                   
                                   
                                   
                               }];
    
    UIAlertAction* detener = [UIAlertAction
                              actionWithTitle:NSLocalizedString(@"detenerLectura", nil)
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  [_speechSynth pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
                                  
                              }];
    
    UIAlertAction* modoNoche = [UIAlertAction
                              actionWithTitle:NSLocalizedString(@"colores", nil)
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  int modo;
                                  
                                  if(modoNocturno)
                                  {
                                      modoNocturno=NO;
                                      modo=0;
                                      self.textview.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
                                      self.vistaTextview.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
                                      self.textview.textColor=[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f];

                                  }
                                  else
                                  {
                                      modoNocturno=YES;
                                      modo=1;
                                      self.textview.backgroundColor=[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
                                       self.vistaTextview.backgroundColor=[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
                                      self.textview.textColor=[UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
                                      
                                      
                                  }
                                  
                                  
                                  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                  [defaults setInteger:modo forKey:@"modoNocturno"];
                                  [defaults synchronize];
                                  
                                      
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  [_speechSynth pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
                                  
                              }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Cancelar", nil)
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:compartir];
    [view addAction:modoNoche];
    [view addAction:leemelo2];
    [view addAction:detener];
    [view addAction:cancel];
    
    if ( IDIOM == IPAD )
    {
        [view setModalPresentationStyle:UIModalPresentationPopover];
        view.popoverPresentationController.barButtonItem = _barButton;
        view.popoverPresentationController.sourceView = self.view;
    }
    
    [self presentViewController:view animated:YES completion:nil];
    

}

- (void)viewDidLayoutSubviews {
    if(primeraVez1==1)
    {
        primeraVez1=0;
        [self.textview setContentOffset:CGPointZero animated:NO];
    }
}
-(BOOL)esNumeroChar:(NSString*)charn
{
    if([charn isEqualToString:@"0"])
    {
        return YES;
    }
    if([charn isEqualToString:@"1"])
    {
        return YES;
    }
    if([charn isEqualToString:@"2"])
    {
        return YES;
    }
    if([charn isEqualToString:@"3"])
    {
        return YES;
    }
    if([charn isEqualToString:@"4"])
    {
        return YES;
    }
    if([charn isEqualToString:@"5"])
    {
        return YES;
    }
    if([charn isEqualToString:@"6"])
    {
        return YES;
    }
    if([charn isEqualToString:@"7"])
    {
        return YES;
    }
    if([charn isEqualToString:@"8"])
    {
        return YES;
    }
    if([charn isEqualToString:@"9"])
    {
        return YES;
    }
    return NO;
}
-(BOOL)stringEsNumero:(NSString*)cadena
{
    for(int i =0 ;i<[cadena length]; i++)
    {
        NSString *character =[NSString stringWithFormat:@"%c", [cadena characterAtIndex:i]];
        if(![self esNumeroChar:character])
        {
            return NO;
        }
    }
    return YES;
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
    int i;
    for(i=0;i<listItems.count;i++)
    {
        NSString *linea = [listItems objectAtIndex:i];
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
    
    NSMutableString *nuevoTexto = [[NSMutableString alloc] init];
    for(i=0;i<listItems.count;i++)
    {
        [nuevoTexto appendString:[NSString stringWithFormat:@"%@\n",[listItems objectAtIndex:i]]];
    }
    _texto=nuevoTexto;
    //self.textview.text=_texto;
    //[listItems removeObjectsInArray:forRemove];
    [self resaltaLectura];
    
    
    
    
    
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
