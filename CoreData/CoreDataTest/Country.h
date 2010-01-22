// Country.h

#import <CoreData/CoreData.h>

@interface Country :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* cities;

@end


@interface Country (CoreDataGeneratedAccessors)
- (void)addCitiesObject:(NSManagedObject *)value;
- (void)removeCitiesObject:(NSManagedObject *)value;
- (void)addCities:(NSSet *)value;
- (void)removeCities:(NSSet *)value;

@end