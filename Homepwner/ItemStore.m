//
//  ItemStore.m
//  Homepwner
//
//  Created by Rafal Pluskota on 02.03.2017.
//  Copyright © 2017 Rafal Pluskota. All rights reserved.
//

#import "ItemStore.h"
#import "BNRItem.h"

@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end



@implementation ItemStore

+ (instancetype)sharedStore {
    static ItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[ItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (BNRItem *)createItem {
    BNRItem * item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    NSLog(@"Stworzono poprzez createItem: %@", [item description]);
    return item;
}

- (void)groupItems {
    
}


@end
