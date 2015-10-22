//
//  LecturaViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 16/07/15.
//  Copyright (c) 2015 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface LecturaViewController : UIViewController
{
    NSString *gema;
    NSMutableString *textoModificado;
}
@property (nonatomic,strong) IBOutlet UITextView *textview;
@property (nonatomic,strong) NSString *texto;
-(IBAction)share:(id)sender;
@property (nonatomic, strong) AVSpeechSynthesizer* speechSynth;
@property (nonatomic, strong) AVSpeechUtterance *utterance;
@property BOOL yaEmpezeALeer;
@property (nonatomic, readwrite) NSInteger font;
@end
