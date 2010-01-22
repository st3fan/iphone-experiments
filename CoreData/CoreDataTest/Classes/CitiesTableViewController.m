//  CitiesTableViewController.m

#import "CitiesTableViewController.h"
#import "DataRepository.h"

@implementation CitiesTableViewController

- (id) initWithCountry: (NSManagedObject*) country
{
	if ((self = [super initWithNibName: @"CitiesTableViewController" bundle: nil]) != nil) {
		country_ = [country retain];
	}
	return self;
}

- (void) dealloc
{
	[country_ release];
    [super dealloc];
}

#pragma mark -

- (void) viewDidLoad
{
	self.title = [country_ valueForKey: @"name"];

	// Set up the fetched results controller.
	
	[[DataRepository sharedInstance] open];
	
	NSManagedObjectContext* managedObjectContext = [[DataRepository sharedInstance] managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	if (fetchRequest != nil)
	{
		NSEntityDescription *entityDescription = [NSEntityDescription entityForName: @"City" inManagedObjectContext: managedObjectContext];
		if (entityDescription != nil)
		{
			[fetchRequest setEntity: entityDescription];
			//[fetchRequest setFetchBatchSize: 20];

			// Works fine
			//[fetchRequest setPredicate: [NSPredicate predicateWithFormat: @"country.name == %@", [country_ valueForKey: @"name"]]];
			
			// Does not work - But should!
			[fetchRequest setPredicate: [NSPredicate predicateWithFormat: @"(country == %@)", country_]];
	
//			NSPredicate *predicate = [NSComparisonPredicate predicateWithLeftExpression:
//				[NSExpression expressionForKeyPath: @"country"]
//					rightExpression: [NSExpression expressionForConstantValue: country_]
//						modifier: NSDirectPredicateModifier type: NSEqualToPredicateOperatorType options: 0];
//			[fetchRequest setPredicate: predicate];

//			NSPredicate *predicate = [NSComparisonPredicate predicateWithLeftExpression:
//				[NSExpression expressionForKeyPath: @"country"]
//					rightExpression: [NSExpression expressionForConstantValue: [NSArray arrayWithObject: country_]]
//						modifier: NSDirectPredicateModifier type: NSInPredicateOperatorType options: 0];
//			[fetchRequest setPredicate: predicate];
			
			// Edit the sort key as appropriate.
			NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES] autorelease];
			if (sortDescriptor != nil)
			{
				NSArray *sortDescriptors = [NSArray arrayWithObject: sortDescriptor];
				if (sortDescriptors != nil)
				{				
					[fetchRequest setSortDescriptors: sortDescriptors];
					
					fetchedResultsController_ = [[NSFetchedResultsController alloc] initWithFetchRequest: fetchRequest
						managedObjectContext: managedObjectContext sectionNameKeyPath:nil cacheName: @"Woot"];
				}
			}
		}
	}
	
	NSError *error = nil;
	if ([fetchedResultsController_ performFetch: &error] == NO) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	[fetchedResultsController_ release];
}

#pragma mark Table view methods

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return [[fetchedResultsController_ sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController_ sections] objectAtIndex: section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    static NSString *CellIdentifier = @"CityCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSManagedObject* managedObject = [fetchedResultsController_ objectAtIndexPath: indexPath];
	cell.textLabel.text = [[managedObject valueForKey: @"name"] description];
		
    return cell;
}

@end