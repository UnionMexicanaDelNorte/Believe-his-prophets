//
//  ImagenViewController.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 14/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import "ImagenViewController.h"

@interface ImagenViewController ()

@end

@implementation ImagenViewController
@synthesize imagen1=_imagen1,imagen2=_imagen2,imagen3=_imagen3,imagen=_imagen,scroll=_scroll,vista=_vista,textoADibujar=_textoADibujar,vistaAbajo=_vistaAbajo,scrollAbajo=_scrollAbajo,imagen4=_imagen4,imagen5=_imagen5,imagen6=_imagen6,imagen7=_imagen7,imagen8=_imagen8,imagen9=_imagen9,imagen10=_imagen10,imagen11=_imagen11,barButton=_barButton,font=_font,fecha=_fecha,filtro6=_filtro6,filtro7=_filtro7,filtro8=_filtro8,filtro9=_filtro9,filtro10=_filtro10,filtro11=_filtro11;
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad



- (void)   savedPhotoImage:(UIImage *)image
  didFinishSavingWithError:(NSError *)error
               contextInfo:(void *)contextInfo
{
    [load removeView];
    
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:NSLocalizedString(@"creed", nil)
                                 message:NSLocalizedString(@"yaSeGuardo", nil)
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
-(void)muestraSelectFont
{
   
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:NSLocalizedString(@"creed", nil)
                                 message:NSLocalizedString(@"selecciona", nil)
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *hermes = [UIAlertAction
                                    actionWithTitle:@"Hermes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                        [view dismissViewControllerAnimated:YES completion:nil];
                                        _font=@"Hermes-Bold";
                                        deboObtenerOriginal=1;
                                        [self dibujaTextoEnLaImagen:1];
                                    }];
    UIAlertAction *antonio = [UIAlertAction
                             actionWithTitle:@"Antonio"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 _font=@"Antonio";
                                 deboObtenerOriginal=1;
                                 [self dibujaTextoEnLaImagen:1];
                             }];

    UIAlertAction *codePro = [UIAlertAction
                              actionWithTitle:@"Code Pro"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  _font=@"Code-Pro-Bold-LC";
                                  deboObtenerOriginal=1;
                                  [self dibujaTextoEnLaImagen:1];
                              }];
    
    UIAlertAction *Kaushan = [UIAlertAction
                              actionWithTitle:@"Kaushan"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  _font=@"KaushanScript-Regular";
                                  deboObtenerOriginal=1;
                                  [self dibujaTextoEnLaImagen:1];
                              }];

    
    UIAlertAction *Papyrus = [UIAlertAction
                              actionWithTitle:@"Papyrus"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  _font=@"Papyrus";
                                  deboObtenerOriginal=1;
                                  [self dibujaTextoEnLaImagen:1];
                              }];
    
    UIAlertAction *Modern = [UIAlertAction
                              actionWithTitle:@"Modern"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  _font=@"Modern-Regular";
                                  deboObtenerOriginal=1;
                                  [self dibujaTextoEnLaImagen:1];
                              }];
    UIAlertAction *Poster = [UIAlertAction
                             actionWithTitle:@"Poster"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 _font=@"PosterBodoniBT-Roman";
                                 deboObtenerOriginal=1;
                                 [self dibujaTextoEnLaImagen:1];
                             }];
    

    UIAlertAction *Oswald = [UIAlertAction
                         actionWithTitle:@"Oswald"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             [view dismissViewControllerAnimated:YES completion:nil];
                             _font=@"Oswald-Medium";
                             deboObtenerOriginal=1;
                             [self dibujaTextoEnLaImagen:1];
                         }];
    
    UIAlertAction *Capsuula = [UIAlertAction
                             actionWithTitle:@"Capsuula"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 _font=@"Capsuula";
                                 deboObtenerOriginal=1;
                                 [self dibujaTextoEnLaImagen:1];
                             }];
    
    UIAlertAction *GeezaPro = [UIAlertAction
                               actionWithTitle:@"GeezaPro"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   [view dismissViewControllerAnimated:YES completion:nil];
                                   _font=@"GeezaPro-Bold";
                                   deboObtenerOriginal=1;
                                   [self dibujaTextoEnLaImagen:1];
                               }];
    
    UIAlertAction *Noteworthy = [UIAlertAction
                               actionWithTitle:@"Noteworthy"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   [view dismissViewControllerAnimated:YES completion:nil];
                                   _font=@"Noteworthy-Bold";
                                   deboObtenerOriginal=1;
                                   [self dibujaTextoEnLaImagen:1];
                               }];
    
    UIAlertAction *Ping = [UIAlertAction
                                 actionWithTitle:@"Ping"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     _font=@"PingFangTC-Semibold";
                                     deboObtenerOriginal=1;
                                     [self dibujaTextoEnLaImagen:1];
                                 }];

    
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Cancelar", nil)
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [view addAction:hermes];
    [view addAction:antonio];
    [view addAction:codePro];
    [view addAction:Kaushan];
    [view addAction:Papyrus];
    [view addAction:Modern];
    [view addAction:Poster];
    [view addAction:Oswald];
    [view addAction:Capsuula];
    [view addAction:GeezaPro];
    [view addAction:Noteworthy];
    [view addAction:Ping];
    [view addAction:cancel];
    
    if ( IDIOM == IPAD )
    {
        [view setModalPresentationStyle:UIModalPresentationPopover];
        view.popoverPresentationController.barButtonItem = _barButton;
        view.popoverPresentationController.sourceView = self.view;
    }
    
    [self presentViewController:view animated:YES completion:nil];


    
}
-(IBAction)action:(id)sender
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
                                    
                                    NSString * message = @"#bhp #rpsp #umn";
                                    
                                    NSArray *activityItems;
                                    
                                    activityItems = @[message,self.imagen.image];
                                    
                                    
                                    UIActivityViewController *activityController =
                                    [[UIActivityViewController alloc]
                                     initWithActivityItems:activityItems
                                     applicationActivities:nil];
                                    
                                    [self presentViewController:activityController
                                                       animated:YES completion:nil];
                                  
                                    
                                    
                                }];
    
    UIAlertAction* cambiarFuente = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"cambiarFuente", nil)
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   [view dismissViewControllerAnimated:YES completion:nil];
                                   [self muestraSelectFont];
                                   
                               }];
    
    UIAlertAction* guardarImagen = [UIAlertAction
                              actionWithTitle:NSLocalizedString(@"guardarImagen", nil)
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  load = [LoadingView loadingViewInView:self.view];
                                  UIImageWriteToSavedPhotosAlbum(_imagen.image, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
                                  
                                  
                              }];
    
  
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Cancelar", nil)
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:compartir];
    [view addAction:cambiarFuente];
    [view addAction:guardarImagen];
    [view addAction:cancel];
    
    if ( IDIOM == IPAD )
    {
        [view setModalPresentationStyle:UIModalPresentationPopover];
        view.popoverPresentationController.barButtonItem = _barButton;
        view.popoverPresentationController.sourceView = self.view;
    }
    
    [self presentViewController:view animated:YES completion:nil];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    float sizeOfContent = 0, sizeOfContentAbajo=0;
    int i;
    for (i = 0; i < [_vista.subviews count]; i++) {
        UIView *view1 =[_vista.subviews objectAtIndex:i];
        sizeOfContent += view1.frame.size.width;
    }
    for (i = 0; i < [_vistaAbajo.subviews count]; i++) {
        UIView *view2 =[_vistaAbajo.subviews objectAtIndex:i];
        sizeOfContentAbajo += view2.frame.size.width;
    }

    _scroll.contentSize = CGSizeMake(sizeOfContent,_scroll.frame.size.height);
    [_scroll setShowsHorizontalScrollIndicator:NO];
    [_scroll setShowsVerticalScrollIndicator:NO];
    _vista.translatesAutoresizingMaskIntoConstraints=YES;
    _vista.frame=CGRectMake(0, 0, sizeOfContent, _vista.frame.size.height);
    
    _scrollAbajo.contentSize = CGSizeMake(sizeOfContentAbajo,_scrollAbajo.frame.size.height);
    [_scrollAbajo setShowsHorizontalScrollIndicator:NO];
    [_scrollAbajo setShowsVerticalScrollIndicator:NO];
    _vistaAbajo.translatesAutoresizingMaskIntoConstraints=YES;
    _vistaAbajo.frame=CGRectMake(0, 0, sizeOfContentAbajo, _vistaAbajo.frame.size.height);
}
-(IBAction)filtro1:(id)sender
{
    [_imagen setImage:imageOriginalParaFiltros];
}
-(IBAction)filtro2:(id)sender
{
    CIImage *filterPreviewImage = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    
    CIFilter *colorMonochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey,filterPreviewImage,
                                 @"inputColor",[CIColor colorWithString:@"Red"],
                                 @"inputIntensity",[NSNumber numberWithFloat:0.8], nil];
    
    CIImage *outputImage = [colorMonochrome outputImage];
    CGImageRef cgimg =
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *finalImage = [UIImage imageWithCGImage:cgimg];
    [_imagen setImage:finalImage];
}
-(IBAction)filtro3:(id)sender
{
    CIImage *filterPreviewImage3 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey,filterPreviewImage3,
                             @"inputIntensity",[NSNumber numberWithFloat:0.8],nil];
    
    CIImage *outputImage3 = [sepiaFilter outputImage];
    CGImageRef cgimg3 =
    [context createCGImage:outputImage3 fromRect:[outputImage3 extent]];
    UIImage *finalImage3 = [UIImage imageWithCGImage:cgimg3];
    [_imagen setImage:finalImage3];
}
-(IBAction)filtro4:(id)sender
{
    CIImage *filterPreviewImage4 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    
    CIFilter *vigneteFilter = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage4,
                             @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:200],nil ];
   
    
    
    CIImage *outputImage4 = [vigneteFilter outputImage];
    CGImageRef cgimg4 =
    [context createCGImage:outputImage4 fromRect:[outputImage4 extent]];
    UIImage *finalImage4 = [UIImage imageWithCGImage:cgimg4];
    [_imagen setImage:finalImage4];

}
-(IBAction)filtro5:(id)sender
{
    CIImage *filterPreviewImage5 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    
    CIFilter *sepiaFilter5 = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey,filterPreviewImage5,
                             @"inputIntensity",[NSNumber numberWithFloat:0.6],nil];
    
    CIImage *outputImage5 = [sepiaFilter5 outputImage];
    CGImageRef cgimg5 =
    [context createCGImage:outputImage5 fromRect:[outputImage5 extent]];
    UIImage *finalImage5 = [UIImage imageWithCGImage:cgimg5];
    CIImage *filterPreviewImage55 = [[CIImage alloc] initWithImage:finalImage5];
    
    
    CIFilter *vigneteFilter5 = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage55,
                               @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:200],nil ];
    
    CIImage *outputImage55 = [vigneteFilter5 outputImage];
    CGImageRef cgimg55 =
    [context createCGImage:outputImage55 fromRect:[outputImage55 extent]];
    UIImage *finalImage55 = [UIImage imageWithCGImage:cgimg55];
    
    
    
    [_imagen setImage:finalImage55];
}



-(IBAction)filtro6:(id)sender
{
    CIImage *filterPreviewImage6 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *chromeFilter = [CIFilter filterWithName:@"CIPhotoEffectChrome" keysAndValues:@"inputImage",filterPreviewImage6 ,nil];
    CIImage *outputImage6 = [chromeFilter outputImage];
    CGImageRef cgimg6 =
    [context createCGImage:outputImage6 fromRect:[outputImage6 extent]];
    UIImage *finalImage6 = [UIImage imageWithCGImage:cgimg6];
    [_imagen setImage:finalImage6];
}

-(IBAction)filtro7:(id)sender
{
    CIImage *filterPreviewImage7 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *instantFilter = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues:@"inputImage",filterPreviewImage7 ,nil];
    CIImage *outputImage7 = [instantFilter outputImage];
    CGImageRef cgimg7 =
    [context createCGImage:outputImage7 fromRect:[outputImage7 extent]];
    UIImage *finalImage7 = [UIImage imageWithCGImage:cgimg7];
    
    
    CIImage *filterPreviewImage77 = [[CIImage alloc] initWithImage:finalImage7];
    
    
    CIFilter *vigneteFilter7 = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage77,
                                @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:150],nil ];
    
    CIImage *outputImage77 = [vigneteFilter7 outputImage];
    CGImageRef cgimg77 =
    [context createCGImage:outputImage77 fromRect:[outputImage77 extent]];
    UIImage *finalImage77 = [UIImage imageWithCGImage:cgimg77];
    
    [_imagen setImage:finalImage77];
}

-(IBAction)filtro8:(id)sender
{
    CIImage *filterPreviewImage8 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *fadeFilter = [CIFilter filterWithName:@"CIPhotoEffectFade" keysAndValues:@"inputImage",filterPreviewImage8 ,nil];
    CIImage *outputImage8 = [fadeFilter outputImage];
    CGImageRef cgimg8 =
    [context createCGImage:outputImage8 fromRect:[outputImage8 extent]];
    UIImage *finalImage8 = [UIImage imageWithCGImage:cgimg8];
    
    
    
    CIImage *filterPreviewImage88 = [[CIImage alloc] initWithImage:finalImage8];
    
    
    CIFilter *vigneteFilter8 = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage88,
                                @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:100],nil ];
    
    CIImage *outputImage88 = [vigneteFilter8 outputImage];
    CGImageRef cgimg88 =
    [context createCGImage:outputImage88 fromRect:[outputImage88 extent]];
    UIImage *finalImage88 = [UIImage imageWithCGImage:cgimg88];
    [_imagen setImage:finalImage88];
}

-(IBAction)filtro9:(id)sender
{
    CIImage *filterPreviewImage9 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *noirFilter = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues:@"inputImage",filterPreviewImage9 ,nil];
    CIImage *outputImage9 = [noirFilter outputImage];
    CGImageRef cgimg9 =
    [context createCGImage:outputImage9 fromRect:[outputImage9 extent]];
    UIImage *finalImage9 = [UIImage imageWithCGImage:cgimg9];
    
    
    
    CIImage *filterPreviewImage99 = [[CIImage alloc] initWithImage:finalImage9];
    
    
    CIFilter *vigneteFilter9 = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage99,
                                @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:50],nil ];
    
    CIImage *outputImage99 = [vigneteFilter9 outputImage];
    CGImageRef cgimg99 =
    [context createCGImage:outputImage99 fromRect:[outputImage99 extent]];
    UIImage *finalImage99 = [UIImage imageWithCGImage:cgimg99];
    [_imagen setImage:finalImage99];
}

-(IBAction)filtro10:(id)sender
{
    CIImage *filterPreviewImage10 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *processFilter = [CIFilter filterWithName:@"CIPhotoEffectProcess" keysAndValues:@"inputImage",filterPreviewImage10 ,nil];
    CIImage *outputImage10 = [processFilter outputImage];
    CGImageRef cgimg10 =
    [context createCGImage:outputImage10 fromRect:[outputImage10 extent]];
    UIImage *finalImage10 = [UIImage imageWithCGImage:cgimg10];
    [_imagen setImage:finalImage10];
}

-(IBAction)filtro11:(id)sender
{
    CIImage *filterPreviewImage11 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *transferFilter = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues:@"inputImage",filterPreviewImage11 ,nil];
    CIImage *outputImage11 = [transferFilter outputImage];
    CGImageRef cgimg11 =
    [context createCGImage:outputImage11 fromRect:[outputImage11 extent]];
    UIImage *finalImage11 = [UIImage imageWithCGImage:cgimg11];
    [_imagen setImage:finalImage11];
}
-(BOOL)shouldAutorotate
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if(orientation!=UIDeviceOrientationPortrait)
    {
        return YES;
    }
    return NO;
}
-(void)hazPreviewDeLosFiltros
{
    [_filtro1 setBackgroundImage:imageOriginalParaFiltros forState:UIControlStateNormal];
    CIImage *filterPreviewImage = [[CIImage alloc] initWithImage:_imagen.image];
    
    CIFilter *colorMonochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey,filterPreviewImage,
                                 @"inputColor",[CIColor colorWithString:@"Red"],
                                 @"inputIntensity",[NSNumber numberWithFloat:0.8], nil];
    
    CIImage *outputImage = [colorMonochrome outputImage];
    
    CGImageRef cgimg =
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *finalImage = [UIImage imageWithCGImage:cgimg];
    [_filtro2 setBackgroundImage:finalImage forState:UIControlStateNormal];
    
    CIImage *filterPreviewImage3 = [[CIImage alloc] initWithImage:_imagen.image];
    
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey,filterPreviewImage3,
                             @"inputIntensity",[NSNumber numberWithFloat:0.8],nil];
    
    CIImage *outputImage3 = [sepiaFilter outputImage];
    CGImageRef cgimg3 =
    [context createCGImage:outputImage3 fromRect:[outputImage3 extent]];
    UIImage *finalImage3 = [UIImage imageWithCGImage:cgimg3];
    [_filtro3 setBackgroundImage:finalImage3 forState:UIControlStateNormal];
    
    
    CIImage *filterPreviewImage4 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    
    CIFilter *vigneteFilter = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage4,
                               @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:200],nil ];
    
    CIImage *outputImage4 = [vigneteFilter outputImage];
    CGImageRef cgimg4 =
    [context createCGImage:outputImage4 fromRect:[outputImage4 extent]];
    UIImage *finalImage4 = [UIImage imageWithCGImage:cgimg4];
    [_filtro4 setBackgroundImage:finalImage4 forState:UIControlStateNormal];
    
    
    
    
    CIImage *filterPreviewImage5 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    
    CIFilter *sepiaFilter5 = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey,filterPreviewImage5,
                              @"inputIntensity",[NSNumber numberWithFloat:0.6],nil];
    
    CIImage *outputImage5 = [sepiaFilter5 outputImage];
    CGImageRef cgimg5 =
    [context createCGImage:outputImage5 fromRect:[outputImage5 extent]];
    UIImage *finalImage5 = [UIImage imageWithCGImage:cgimg5];
    CIImage *filterPreviewImage55 = [[CIImage alloc] initWithImage:finalImage5];
    
    
    CIFilter *vigneteFilter5 = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage55,
                                @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:200],nil ];
    CIImage *outputImage55 = [vigneteFilter5 outputImage];
    CGImageRef cgimg55 =
    [context createCGImage:outputImage55 fromRect:[outputImage55 extent]];
    UIImage *finalImage55 = [UIImage imageWithCGImage:cgimg55];
    
    [_filtro5 setBackgroundImage:finalImage55 forState:UIControlStateNormal];
    CIImage *filterPreviewImage6 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *chromeFilter = [CIFilter filterWithName:@"CIPhotoEffectChrome" keysAndValues:@"inputImage",filterPreviewImage6 ,nil];
    CIImage *outputImage6 = [chromeFilter outputImage];
    CGImageRef cgimg6 =
    [context createCGImage:outputImage6 fromRect:[outputImage6 extent]];
    UIImage *finalImage6 = [UIImage imageWithCGImage:cgimg6];
    [_filtro6 setBackgroundImage:finalImage6 forState:UIControlStateNormal];
    CIImage *filterPreviewImage7 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *instantFilter = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues:@"inputImage",filterPreviewImage7 ,nil];
    CIImage *outputImage7 = [instantFilter outputImage];
    CGImageRef cgimg7 =
    [context createCGImage:outputImage7 fromRect:[outputImage7 extent]];
    UIImage *finalImage7 = [UIImage imageWithCGImage:cgimg7];
    CIImage *filterPreviewImage77 = [[CIImage alloc] initWithImage:finalImage7];
    
    
    CIFilter *vigneteFilter7 = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage77,
                                @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:150],nil ];
    
    CIImage *outputImage77 = [vigneteFilter7 outputImage];
    CGImageRef cgimg77 =
    [context createCGImage:outputImage77 fromRect:[outputImage77 extent]];
    UIImage *finalImage77 = [UIImage imageWithCGImage:cgimg77];
    [_filtro7 setBackgroundImage:finalImage77 forState:UIControlStateNormal];
    
    CIImage *filterPreviewImage8 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *fadeFilter = [CIFilter filterWithName:@"CIPhotoEffectFade" keysAndValues:@"inputImage",filterPreviewImage8 ,nil];
    CIImage *outputImage8 = [fadeFilter outputImage];
    CGImageRef cgimg8 =
    [context createCGImage:outputImage8 fromRect:[outputImage8 extent]];
    UIImage *finalImage8 = [UIImage imageWithCGImage:cgimg8];
    CIImage *filterPreviewImage88 = [[CIImage alloc] initWithImage:finalImage8];
    
    
    CIFilter *vigneteFilter8 = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage88,
                                @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:100],nil ];
    
    CIImage *outputImage88 = [vigneteFilter8 outputImage];
    CGImageRef cgimg88 =
    [context createCGImage:outputImage88 fromRect:[outputImage88 extent]];
    UIImage *finalImage88 = [UIImage imageWithCGImage:cgimg88];
    [_filtro8 setBackgroundImage:finalImage88 forState:UIControlStateNormal];
    CIImage *filterPreviewImage9 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *noirFilter = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues:@"inputImage",filterPreviewImage9 ,nil];
    CIImage *outputImage9 = [noirFilter outputImage];
    CGImageRef cgimg9 =
    [context createCGImage:outputImage9 fromRect:[outputImage9 extent]];
    UIImage *finalImage9 = [UIImage imageWithCGImage:cgimg9];
    
    
    
    CIImage *filterPreviewImage99 = [[CIImage alloc] initWithImage:finalImage9];
    
    
    CIFilter *vigneteFilter9 = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey,filterPreviewImage99,
                                @"inputIntensity",[NSNumber numberWithFloat:1.0],@"inputRadius",[NSNumber numberWithFloat:50],nil ];
    
    CIImage *outputImage99 = [vigneteFilter9 outputImage];
    CGImageRef cgimg99 =
    [context createCGImage:outputImage99 fromRect:[outputImage99 extent]];
    UIImage *finalImage99 = [UIImage imageWithCGImage:cgimg99];
    [_filtro9 setBackgroundImage:finalImage99 forState:UIControlStateNormal];
    CIImage *filterPreviewImage10 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *processFilter = [CIFilter filterWithName:@"CIPhotoEffectProcess" keysAndValues:@"inputImage",filterPreviewImage10 ,nil];
    CIImage *outputImage10 = [processFilter outputImage];
    CGImageRef cgimg10 =
    [context createCGImage:outputImage10 fromRect:[outputImage10 extent]];
    UIImage *finalImage10 = [UIImage imageWithCGImage:cgimg10];
    [_filtro10 setBackgroundImage:finalImage10 forState:UIControlStateNormal];
    CIImage *filterPreviewImage11 = [[CIImage alloc] initWithImage:imageOriginalParaFiltros];
    CIFilter *transferFilter = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues:@"inputImage",filterPreviewImage11 ,nil];
    CIImage *outputImage11 = [transferFilter outputImage];
    CGImageRef cgimg11 =
    [context createCGImage:outputImage11 fromRect:[outputImage11 extent]];
    UIImage *finalImage11 = [UIImage imageWithCGImage:cgimg11];
    [_filtro11 setBackgroundImage:finalImage11 forState:UIControlStateNormal];
    
    
    
    
    if(load!=nil)
    {
        [load removeView];
        load=nil;
    }
    

}
-(void)dibujaTextoEnLaImagen:(int)vieneDe
{
   
   
   
    CGPoint point = CGPointMake(10, 100);
    //hardcode

    int cuantos = (int)_textoADibujar.length;
    if(cuantos<154)
    {
        point = CGPointMake(20, 300);
    }
    UIImage *imagenTest = nil;
    if(vieneDe==1)//font
    {
        imagenTest=imageOriginalParaFont;
    }
    else
    {
        imagenTest = _imagen.image;
    }
    
    _imagen.image=[UIImageX drawText:_textoADibujar inImage:imagenTest atPoint:point conFecha:_fecha yFuente:_font];
    
    imageOriginalParaFont = [UIImage imageNamed:[NSString stringWithFormat:@"imagen%d.jpg",indexImagen]];
    imageOriginalParaFiltros=_imagen.image;
    
    [self hazPreviewDeLosFiltros];
}
-(void)empieza
{
    
    
    _imagen1.layer.cornerRadius=15;
    _imagen2.layer.cornerRadius=15;
    _imagen3.layer.cornerRadius=15;
    _imagen4.layer.cornerRadius=15;
    _imagen5.layer.cornerRadius=15;
    _imagen6.layer.cornerRadius=15;
    _imagen7.layer.cornerRadius=15;
    _imagen8.layer.cornerRadius=15;
    _imagen9.layer.cornerRadius=15;
    _imagen10.layer.cornerRadius=15;
    _imagen11.layer.cornerRadius=15;
    
    context = [CIContext contextWithOptions:nil];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    indexImagen=1;
    load=[LoadingView loadingViewInView:self.view];
     [self performSelector:@selector(empieza) withObject:nil afterDelay:1.5f];

  
    
    
    
    
    
   // [_verde6 addTarget:self action:@selector(verde6:) forControlEvents:UIControlEventTouchUpInside];
  //  [_scroll setFrame:CGRectMake(0, 0, 770, 110)];
    //[_scroll setContentSize:CGSizeMake(770, 110)];
}
-(IBAction)imagen1:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=1;
    [_imagen setImage:[UIImage imageNamed:@"imagen1.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
    
}
-(IBAction)imagen2:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=2;
    [_imagen setImage:[UIImage imageNamed:@"imagen2.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
-(IBAction)imagen3:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=3;
    [_imagen setImage:[UIImage imageNamed:@"imagen3.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
-(IBAction)imagen4:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=4;
    [_imagen setImage:[UIImage imageNamed:@"imagen4.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
-(IBAction)imagen5:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=5;
    [_imagen setImage:[UIImage imageNamed:@"imagen5.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
-(IBAction)imagen6:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=6;
    [_imagen setImage:[UIImage imageNamed:@"imagen6.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
-(IBAction)imagen7:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=7;
    [_imagen setImage:[UIImage imageNamed:@"imagen7.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
-(IBAction)imagen8:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=8;
    [_imagen setImage:[UIImage imageNamed:@"imagen8.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
-(IBAction)imagen9:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=9;
    [_imagen setImage:[UIImage imageNamed:@"imagen9.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
-(IBAction)imagen10:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=10;
    [_imagen setImage:[UIImage imageNamed:@"imagen10.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
}
-(IBAction)imagen11:(id)sender
{
    if(load==nil)
    {
        load = [LoadingView loadingViewInView:self.view];
    }
    indexImagen=11;
    [_imagen setImage:[UIImage imageNamed:@"imagen11.jpg"]];
    deboObtenerOriginal=1;
    [self dibujaTextoEnLaImagen:0];
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
