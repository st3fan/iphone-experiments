// FetchedResultsTableViewController.m

#import "FetchedResultsTableViewController.h"

/*

Typical usage of this class:

Subclass and implement:

- (void) created

Then create and push on a navigation controller:

MyFetchedResultsTableViewController* viewController = [[MyFetchedResultsTableViewController new] autorelease];
if (viewController != nil) {
   [self.navigationController pushViewController: viewController animated: YES];
}

*/

@implementation FetchedResultsTableViewController

#pragma mark -
#pragma mark Memory Management

- (id) init
{
	if ((self = [super initWithNibName: [[self class] name] bundle: nil]) != nil) {
	}
	return self;
}

- (id) initWithCoder: (NSCoder*) coder
{
	if ((self = [super initWithCoder: coder]) != nil)
	{
	}
	
	return self;
}

- (void) dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark View lifecycle


- (void) viewDidLoad
{
	// Make sure we have a data repository

	NSAssert(dataRepository_ != nil, @"FetchedResultsTableViewController requires a DataRepository");

	// Set up the fetched results controller.
	
	[[DataRepository sharedInstance] open];
	
	NSManagedObjectContext* managedObjectContext = [[DataRepository sharedInstance] managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	if (fetchRequest != nil)
	{
		NSEntityDescription *entityDescription = [NSEntityDescription entityForName: @"Country" inManagedObjectContext: managedObjectContext];
		if (entityDescription != nil)
		{
			[fetchRequest setEntity: entityDescription];
			[fetchRequest setFetchBatchSize: 20];
			
			// Edit the sort key as appropriate.
			NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES] autorelease];
			if (sortDescriptor != nil)
			{
				NSArray *sortDescriptors = [NSArray arrayWithObject: sortDescriptor];
				if (sortDescriptors != nil)
				{				
					[fetchRequest setSortDescriptors: sortDescriptors];
					fetchedResultsController_ = [[NSFetchedResultsController alloc] initWithFetchRequest: fetchRequest
						managedObjectContext: managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
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

#pragma mark -
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
    static NSString *CellIdentifier = @"CountryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	NSManagedObject* managedObject = [fetchedResultsController_ objectAtIndexPath: indexPath];
	cell.textLabel.text = [[managedObject valueForKey: @"name"] description];
		
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSManagedObject* country = [fetchedResultsController_ objectAtIndexPath: indexPath];
	if (country != nil)
	{
		CitiesTableViewController* viewController = [[CitiesTableViewController alloc] initWithCountry: country];
		if (viewController != nil) {
			[self.navigationController pushViewController: viewController animated: YES];
			[viewController release];
		}
	}
}

@end