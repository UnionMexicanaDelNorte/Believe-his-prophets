//
//  FavoritosTableViewController.h
//  Creed a sus profetas
//
//  Created by Fernando Alonso on 06/01/16.
//  Copyright © 2016 UMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LoadingView.h"
@interface FavoritosTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>
{
    int cuantosTotal, cuantosAhora;
    LoadingView *load;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
-(IBAction)refresh:(id)sender;
@end
