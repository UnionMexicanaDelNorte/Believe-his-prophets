//
//  Favoritos+CoreDataProperties.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Favoritos.h"

NS_ASSUME_NONNULL_BEGIN

@interface Favoritos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *fecha;
@property (nullable, nonatomic, retain) NSNumber *timestamp;
@property (nullable, nonatomic, retain) NSString *texto;

@end

NS_ASSUME_NONNULL_END
