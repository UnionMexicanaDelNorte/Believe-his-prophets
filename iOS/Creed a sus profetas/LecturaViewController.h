//
//  LecturaViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 16/07/15.
//  Copyright (c) 2015 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreData/CoreData.h>
@interface LecturaViewController : UIViewController<NSFetchedResultsControllerDelegate>
{
    NSString *gema;
    NSMutableString *textoModificado;
    BOOL modoNocturno;
    NSTimer *timerAutoscroll;
    int loc,primeraVez1;
}
@property (nonatomic,strong) IBOutlet UITextView *textview;
@property (nonatomic,strong) IBOutlet UILabel *labelFecha;
@property (nonatomic,strong) IBOutlet UIView *vistaTextview;
@property (nonatomic,strong) NSString *texto;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *barButton;
-(IBAction)share:(id)sender;
@property (nonatomic, strong) AVSpeechSynthesizer* speechSynth;
@property (nonatomic, strong) AVSpeechUtterance *utterance;
@property BOOL yaEmpezeALeer;
@property (nonatomic, readwrite) NSInteger font;
@property (nonatomic, strong) NSString *fechaLabel;

@property (nonatomic, readwrite) NSInteger dia;
@property (nonatomic, readwrite) NSInteger mes;
@property (nonatomic, readwrite) NSInteger anio;


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
