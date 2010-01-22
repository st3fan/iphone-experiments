// City.h

#import <CoreData/CoreData.h>

@class Country;

@interface City :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Country * country;

@end