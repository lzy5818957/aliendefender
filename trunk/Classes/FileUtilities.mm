//
//  FileUtilities.m
//  Investopedia
//
//  Created by Chad Jones on 11/21/10.
//  Copyright 2010 CollegeMobile, Inc. All rights reserved.
//

#import "FileUtilities.h"

@implementation FileUtilities

+(NSString*)applicationDocumentsDirectory
   {
   NSString* fullPathToReturn;

   NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );

   if ( paths NOTEQUAL nil )
      {
      fullPathToReturn = [ [ [ paths objectAtIndex:0 ] retain ] autorelease ];
      }
   else
      {
      fullPathToReturn = nil;
      }

   return( fullPathToReturn );
   }



@end
