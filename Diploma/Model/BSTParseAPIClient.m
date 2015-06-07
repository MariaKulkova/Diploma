//
//  BSTParseAPIClient.m

//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTParseAPIClient.h"
#import "BSTWebCore.h"
#import "BSTURLComposer.h"

@interface BSTParseAPIClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation BSTParseAPIClient

- (RACSignal *)addObject:(BSTManagedObject *) object {
	if (!object) {
		NSLog(@"There is no object to add");
		return [RACSignal empty];
	}
	
//	NSMutableArray *genreIDs  = [NSMutableArray array];
//	NSMutableArray *artistIDs = [NSMutableArray array];
//	
//	for (FWSubscription *entity in subscriptions) {
//		if ([entity isKindOfClass:[FWGenreSubscription class]]) {
//			[genreIDs addObject:@(((FWGenreSubscription *)entity).object.id)];
//		}
//		else if ([entity isKindOfClass:[FWArtistSubscription class]]) {
//			[artistIDs addObject:@(((FWArtistSubscription *)entity).object.id)];
//		}
//	}
	
	NSDictionary *data = [object representInfo];
	
	return [RACSignal empty];
	
//	return [[[BSTWebCore parseSession]
//			rac_postData:data atUrl:[NSURL fw_service:kServiceSubscriptions]]
//			map:^id(NSDictionary *json) {
//				NSArray *genres  = [self saveWithClass:FWGenreSubscription.class attribute:[Key(FWSubscription, object) stringByAppendingString:@".id"] jsonKey:kWebKeyGenreId deprecate:NO](NULLIFY(json[kWebKeyFanGenres]));
//				NSArray *artists = [self saveWithClass:FWArtistSubscription.class attribute:[Key(FWSubscription, object) stringByAppendingString:@".id"] jsonKey:kWebKeyArtistId deprecate:NO](NULLIFY(json[kWebKeyFanArtists]));
//				return [genres arrayByAddingObjectsFromArray:artists];
//			}];
}

@end
