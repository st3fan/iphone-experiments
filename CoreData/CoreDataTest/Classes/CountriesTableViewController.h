// CountriesTableViewController.h

@interface CountriesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
  @private
	NSFetchedResultsController* fetchedResultsController_;
}

@end