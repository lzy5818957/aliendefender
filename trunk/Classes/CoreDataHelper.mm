//
//  CoreDataHelper.m
//  Investopedia
//
//  Created by Chad Jones on 11/21/10.
//  Copyright 2010 CollegeMobile, Inc. All rights reserved.
//

#import "CoreDataHelper.h"
#import "FileUtilities.h"

@implementation CoreDataHelper

#define kDatabaseFileExtension @"sqlite"

+(CoreDataHelper*)sharedCoreDataHelper
   {
   static CoreDataHelper* sharedCoreDataHelper = nil;

   @synchronized( self )
      {
      if ( sharedCoreDataHelper EQUALS nil )
         {
         sharedCoreDataHelper = [ [ CoreDataHelper alloc ] init ];

         [ [ NSNotificationCenter defaultCenter ] addObserver: sharedCoreDataHelper selector: @selector( cleanup ) name: UIApplicationWillTerminateNotification object: nil ];
         }
      }

   return( sharedCoreDataHelper );
   }



-(id)init
   {
   self = [ super init ];

   if ( self NOTEQUAL nil )
      {
      haveCleanedUp = NO;
      }

   return( self );
   }



-(NSManagedObjectModel*)sharedManagedObjectModel
   {
   if ( model EQUALS nil )
      {
      NSString *modelFilePath = [ [ NSBundle mainBundle ] pathForResource: kModelFilename ofType: @"momd" ];

      if ( modelFilePath NOTEQUAL nil )
         {
         NSURL *modelURL = [ NSURL fileURLWithPath: modelFilePath ];

         if ( modelURL NOTEQUAL nil )
            {
            model = [ [ NSManagedObjectModel alloc ] initWithContentsOfURL: modelURL ];
            }
         }
      }

   return( model );
   }



-(NSString*)pathToDatabaseFile
   {
   NSString* fullPathToFile;

   NSString* documentsDirectory = [ FileUtilities applicationDocumentsDirectory ];

   if ( documentsDirectory NOTEQUAL nil )
      {
      NSString* filename = [ NSString stringWithFormat: @"%@.%@", kDatabaseFilename, kDatabaseFileExtension ];

      if ( filename NOTEQUAL nil )
         {
         fullPathToFile = [ documentsDirectory stringByAppendingPathComponent: filename ];
         }
      else
         {
         fullPathToFile = nil;
         }
      }
   else
      {
      fullPathToFile = nil;
      }

   return( fullPathToFile );
   }



-(NSURL*)setupDatabaseAndReturnURL
   {
   BOOL success;

   NSString* databaseFilePath = [ self pathToDatabaseFile ];

   if ( databaseFilePath NOTEQUAL nil )
      {
      NSFileManager* fileManager = [ NSFileManager defaultManager ];

      if ( [ fileManager fileExistsAtPath: databaseFilePath ] )
         {
         success = YES;
         }
      else
         {

         //Store doesn't exist copy the default store.
         NSString* defaultStorePath = [ [ NSBundle mainBundle ] pathForResource: kDatabaseFilename ofType: kDatabaseFileExtension ];

         if ( defaultStorePath NOTEQUAL nil )
            {
            success = [ fileManager copyItemAtPath: defaultStorePath toPath: databaseFilePath error: NULL ];
            }
         else
            {

            //Return Yes to setup a new empty database
            success = YES;
            }
         }
      }
   else
      {
      success = NO;
      }

   NSURL* urlToDatabaseFile;

   if ( success )
      {
      urlToDatabaseFile = [ NSURL fileURLWithPath: databaseFilePath ];
      }
   else
      {
      urlToDatabaseFile = nil;
      }

   return( urlToDatabaseFile );
   }



-(NSPersistentStoreCoordinator*)setupPersistentStoreWithLiveDatabaseURL:(NSURL*)urlToDatabaseFile
   {
   assert( urlToDatabaseFile NOTEQUAL nil );

   NSPersistentStoreCoordinator* persistentStoreToReturn = nil;

   NSManagedObjectModel* managedObjectModel = [ self sharedManagedObjectModel ];

   if ( managedObjectModel NOTEQUAL nil )
      {
      persistentStoreToReturn = [ [ NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: managedObjectModel ];

      if ( persistentStoreToReturn NOTEQUAL nil )
         {
         NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

         NSError *error = nil;
         NSPersistentStore* storeReturned = [ persistentStoreToReturn addPersistentStoreWithType: NSSQLiteStoreType configuration: nil URL: urlToDatabaseFile options: options error: &error ];

         if ( storeReturned NOTEQUAL nil )
            {

            //do nothing
            }
         else
            {
            [ persistentStoreToReturn release ];
            persistentStoreToReturn = nil;
            }
         }
      }
   else
      {
      persistentStoreToReturn = nil;
      }

   return( persistentStoreToReturn );
   }



-(NSPersistentStoreCoordinator*)sharedPersistentStoreCoordinator
   {
   if ( persistentStoreCoordinator EQUALS nil )
      {
      NSURL* databaseFileURL = [ self setupDatabaseAndReturnURL ];

      if ( databaseFileURL NOTEQUAL nil )
         {
         persistentStoreCoordinator = [ self setupPersistentStoreWithLiveDatabaseURL: databaseFileURL ];
         }
      }

   return( persistentStoreCoordinator );
   }



-(NSManagedObjectContext*)sharedManagedObjectContext
   {
   if ( managedObjectContext EQUALS nil )
      {
      NSPersistentStoreCoordinator* coordinator = [ self sharedPersistentStoreCoordinator ];

      if ( coordinator NOTEQUAL nil )
         {
         managedObjectContext = [ [ NSManagedObjectContext alloc ] init ];

         [ managedObjectContext setPersistentStoreCoordinator: coordinator ];
         }
      }

   return( managedObjectContext );
   }



-(NSManagedObject*)createObjectOfType:(NSString*)objectType
   {
   NSManagedObject* objectToReturn;

   NSManagedObjectContext* context = [ self sharedManagedObjectContext ];

   if ( context NOTEQUAL nil )
      {
      objectToReturn = (NSManagedObject*) [ NSEntityDescription insertNewObjectForEntityForName: objectType inManagedObjectContext: context ];
      }
   else
      {
      objectToReturn = nil;
      }

   return( objectToReturn );
   }



-(NSFetchRequest*)fetchRequestForEntity:(NSEntityDescription*)entity predicateString:(NSString*)predicateString
   {

   // Create a fetch request and specify the type of entity to search for.
   NSFetchRequest* requestToReturn = [ [ [ NSFetchRequest alloc ] init ] autorelease ];

   if ( requestToReturn NOTEQUAL nil )
      {
      [ requestToReturn setEntity: entity ];

      // If there was a predicate string specified, attach a predicate
      if ( predicateString NOTEQUAL nil )
         {
         NSPredicate* predicate = [ NSPredicate predicateWithFormat: predicateString ];

         if ( predicate NOTEQUAL nil )
            {
            [ requestToReturn setPredicate: predicate ];
            }
         else
            {
            [ requestToReturn release ];
            requestToReturn = nil;
            }
         }
      else
         {

         //do nothing.  Predicate isn't set so don't need to do anything.
         }
      }

   return( requestToReturn );
   }



-(NSFetchRequest*)fetchRequestToSearchForAllObjectsOfType:(NSString*)objectType predicateString:(NSString*)predicateString
   {
   NSFetchRequest* requestToReturn;

   NSManagedObjectContext* context = [ self sharedManagedObjectContext ];

   if ( context NOTEQUAL nil )
      {
      NSEntityDescription* entity = [ NSEntityDescription entityForName: objectType inManagedObjectContext: context ];

      if ( entity NOTEQUAL nil )
         {
         requestToReturn = [ self fetchRequestForEntity: entity predicateString: predicateString ];
         }
      else
         {
         requestToReturn = nil;
         }
      }
   else
      {
      requestToReturn = nil;
      }

   return( requestToReturn );
   }



-(NSMutableArray*)getAllObjectsOfType:(NSString*)objectType predicateString:(NSString*)predicateString
   {
   NSMutableArray* objectArray;

   NSFetchRequest* requestToSend = [ self fetchRequestToSearchForAllObjectsOfType: objectType predicateString: predicateString ];

   if ( requestToSend NOTEQUAL nil )
      {
      NSError *error = nil;
      NSArray *arrayResult = [ [ self sharedManagedObjectContext ] executeFetchRequest: requestToSend error: &error ];

      objectArray = [ [ arrayResult mutableCopy ] autorelease ];
      }
   else
      {
      objectArray = nil;
      }

   return( objectArray );
   }



-(void)deleteObject:(NSManagedObject*)objectToDelete
   {
   [ [ self sharedManagedObjectContext ] deleteObject: objectToDelete ];
   }



-(BOOL)save
   {
   BOOL success;

   NSManagedObjectContext* context = [ self sharedManagedObjectContext ];

   if ( context NOTEQUAL nil )
      {
      if ( [ context hasChanges ] )
         {
         NSError *error = nil;
         success = [ context save: &error ];

         if ( NOT success )
            {
            NSLog(@"Core data write error %@", [ error description ]);
            }
         }
      else
         {
         success = YES;
         }
      }
   else
      {
      success = NO;
      }

   return( success );
   }



-(void)cleanup
   {
   @synchronized( self )
      {
      if ( NOT haveCleanedUp )
         {
         haveCleanedUp = YES;

         [ [ NSNotificationCenter defaultCenter ] removeObserver: self ];

         [ self save ];

         [ managedObjectContext release ];
         managedObjectContext = nil;

         [ persistentStoreCoordinator release ];
         persistentStoreCoordinator = nil;

         [ model release ];
         model = nil;
         }
      }
   }



-(void)dealloc
   {
   [ self cleanup ];

   [ super dealloc ];
   }



@end
