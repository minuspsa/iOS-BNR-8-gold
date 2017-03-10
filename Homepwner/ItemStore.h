//
//  ItemStore.h
//  Homepwner
//
//  Created by Rafal Pluskota on 02.03.2017.
//  Copyright © 2017 Rafal Pluskota. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface ItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)groupItems;

@end
