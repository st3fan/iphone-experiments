// CitiesTableViewController.h

#import <UIKit/UIKit.h>

@interface CitiesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
  @private
	NSFetchedResultsController* fetchedResultsController_;
	NSManagedObject* country_;
}

- (id) initWithCountry: (NSManagedObject*) country;

@end
