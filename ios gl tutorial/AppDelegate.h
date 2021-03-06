//
//  AppDelegate.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/2/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AdColony/AdColony.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,AdColonyDelegate>{
  
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)watchV4VCAd;

@end

