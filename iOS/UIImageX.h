//
//  UIImageX.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 15/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImageX : UIImage
+(UIImage*) drawText:(NSString*) text   inImage:(UIImage*)  image    atPoint:(CGPoint)   point conFecha:(NSString*)fechaS yFuente:(NSString*)fuente;
@end
