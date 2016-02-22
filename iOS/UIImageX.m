//
//  UIImageX.m
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 15/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import "UIImageX.h"
@implementation UIImageX
+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image    atPoint:(CGPoint)   point  conFecha:(NSString*)fechaS yFuente:(NSString*)fuenteS
{
    int cuantos = (int)text.length;
    int fuente=46;
    if(cuantos <50)
    {
        fuente=100;
    }
    else
    {
        if(cuantos <154)
        {
            fuente=60;
        }
        else
        {
            if(cuantos <300)
            {
                fuente=45;
            }
        }
    }
    
    
    UIFont *font = [UIFont fontWithName:fuenteS size:fuente];
   UIFont *font2 = [UIFont boldSystemFontOfSize:25.0f];

    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width-20, image.size.height);
    
    //para 1024 x 1024
    CGRect rectFecha = CGRectMake((image.size.width/2)-200, 9*(image.size.height/10), 400, (image.size.height/10));
    
    [[UIColor whiteColor] set];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment=NSTextAlignmentJustified;

    
    NSDictionary *attributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName:[UIColor whiteColor] };

    
    CGSize size = [text sizeWithAttributes:attributes];
    if (size.width < rect.size.width)
    {
        CGRect r = CGRectMake(rect.origin.x,
                              rect.origin.y + (rect.size.height - size.height)/2,
                              rect.size.width,
                              (rect.size.height - size.height)/2);
        [text drawInRect:CGRectIntegral(r) withAttributes:attributes];
        
    }
    else{
        [text drawInRect:CGRectIntegral(rect) withAttributes:attributes];
        
    }
    
    NSDictionary *attributes2 = @{NSFontAttributeName: font2, NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName:[UIColor whiteColor] };

    [fechaS drawInRect:CGRectIntegral(rectFecha) withAttributes:attributes2];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
