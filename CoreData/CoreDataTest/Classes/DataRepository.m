//  DataRepository.m

#import "DataRepository.h"

static DataRepository* gSharedDataRepository = nil;

@implementation DataRepository

@synthesize managedObjectModel = managedObjectModel_;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize persistentStoreCoordinator = persistentStoreCoordinator_;

+ (id) sharedInstance
{
	@synchronized (self) {
		if (gSharedDataRepository == nil) {
			gSharedDataRepository = [DataRepository new];
		}
	}
	return gSharedDataRepository;
}

- (id) init
{
	if ((self = [super init]) != nil) {
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

#pragma mark -

- (void) open
{
	// Setup the managed object model

	managedObjectModel_ = [[NSManagedObjectModel mergedModelFromBundles: nil] retain];

	// Setup the persistent store coordinator

	NSString* applicationDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSURL* url = [NSURL fileURLWithPath: [applicationDocumentsDirectory stringByAppendingPathComponent: @"Countries2.sqlite"]];

	NSError *error = nil;
	persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: managedObjectModel_];
	if (![persistentStoreCoordinator_ addPersistentStoreWithType: NSSQLiteStoreType configuration: nil URL: url options:nil error: &error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}

	// Setup the managed object context

	managedObjectContext_ = [[NSManagedObjectContext alloc] init];
	if (managedObjectModel_ != nil) {
		[managedObjectContext_ setPersistentStoreCoordinator: persistentStoreCoordinator_];
	}
}

- (void) close
{
    NSError *error = nil;
    if (managedObjectContext_ != nil) {
        if ([managedObjectContext_ hasChanges] && ![managedObjectContext_ save: &error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}

#pragma mark -

- (void) fetchCitiesForCountry: (Country*) country
{
	NSFetchRequest* fetchRequest = [[NSFetchRequest new] autorelease];
	if (fetchRequest != nil)
	{
		NSEntityDescription *entity = [NSEntityDescription entityForName: @"City" inManagedObjectContext: managedObjectContext_];
		[fetchRequest setEntity: entity];
		[fetchRequest setPredicate: [NSPredicate predicateWithFormat: @"country == %@", country]];
		
		NSError* error = nil;
		NSArray* fetchedObjects = [managedObjectContext_ executeFetchRequest: fetchRequest error:&error];
		
		if (fetchedObjects != nil)
		{
			for (City* city in fetchedObjects)
			{
				NSLog(@" City = %@",city.name);
			}
		}
	}
}


- (void) populate
{
	// Create a fetch request to find out if the database is empty
	
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	if (fetchRequest != nil)
	{
		NSEntityDescription *entityDescription = [NSEntityDescription entityForName: @"City" inManagedObjectContext: managedObjectContext_];
		if (entityDescription != nil)
		{
			[fetchRequest setEntity: entityDescription];
		
			NSError* error = nil;
			NSArray* fetchedObjects = [managedObjectContext_ executeFetchRequest: fetchRequest error:&error];
		
			if (fetchedObjects != nil && [fetchedObjects count] == 0)
			{
				NSDictionary* data = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"Countries" ofType: @"plist"]];
				for (NSString* countryName in [data allKeys])
				{
					Country* country = [NSEntityDescription insertNewObjectForEntityForName: @"Country" inManagedObjectContext: managedObjectContext_];
					if (country != nil)
					{
						country.name = countryName;
						
						for (NSString* cityName in [data objectForKey: countryName])
						{
							City* city = [NSEntityDescription insertNewObjectForEntityForName: @"City" inManagedObjectContext: managedObjectContext_];
							city.name = cityName;
							
							[country addCitiesObject: city]; // TODO: Why is cities not mutable?
						}
					}
				}
				
				NSError *error = nil;
				if (![managedObjectContext_ save:&error]) {
					NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
					abort();
				}
			}
		}
	}
	
	// Just to test predicates
	
	if (1)
	{
		NSFetchRequest* fetchRequest = [[NSFetchRequest new] autorelease];
		if (fetchRequest != nil)
		{
			NSEntityDescription *entity = [NSEntityDescription entityForName: @"Country" inManagedObjectContext: managedObjectContext_];
			[fetchRequest setEntity: entity];
			
			NSError* error = nil;
			NSArray* fetchedObjects = [managedObjectContext_ executeFetchRequest: fetchRequest error:&error];
		
			if (fetchedObjects != nil)
			{
				for (Country* country in fetchedObjects)
				{
					NSLog(@"Country = %@", country.name);
					[self fetchCitiesForCountry: country];
				}
			}			
		}
	}
}

@end