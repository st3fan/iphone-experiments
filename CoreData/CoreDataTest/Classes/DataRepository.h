// DataRepository.h

#import <Foundation/Foundation.h>

#import "Country.h"
#import "City.h"

@interface DataRepository : NSObject {
  @private
	NSManagedObjectModel* managedObjectModel_;
	NSManagedObjectContext* managedObjectContext_;	    
	NSPersistentStoreCoordinator* persistentStoreCoordinator_;
}

@property (nonatomic, readonly) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator* persistentStoreCoordinator;

+ (id) sharedInstance;

- (void) open;
- (void) close;

- (void) populate;

@end