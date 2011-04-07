//
//  CoreDataHelper.h
//  Investopedia
//
//  Created by Chad Jones on 11/21/10.
//  Copyright 2010 CollegeMobile, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define kDatabaseFilename      @"MyCoreDataApp"

//Must always be changed based on what you are running
#define kModelFilename         @"UserData"
//#define kModelFilename         @"InvestopediaXMLReader"

@interface CoreDataHelper : NSObject
   {
   NSManagedObjectContext* managedObjectContext;
   NSPersistentStoreCoordinator* persistentStoreCoordinator;
   NSManagedObjectModel* model;

   BOOL haveCleanedUp;
   }



+(CoreDataHelper*)sharedCoreDataHelper;

-(NSString*)pathToDatabaseFile;

-(NSManagedObject*)createObjectOfType:(NSString*)objectType;
-(NSMutableArray*)getAllObjectsOfType:(NSString*)objectType predicateString:(NSString*)predicateString;

-(BOOL)save;

@end
