//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Rafal Pluskota on 01.03.2017.
//  Copyright © 2017 Rafal Pluskota. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemStore.h"
#import "BNRItem.h"

@implementation ItemsViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 5; i++) {
            [[ItemStore sharedStore] createItem];
        }
    }
    return self;
}

//This will ensure that all instances of BNRItemsViewController use the UITableViewStylePlain style,
//no matter what initialization message is sent to them.
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int below50 = 0, above50 = 0;
    
    for (BNRItem* item in [[ItemStore sharedStore]allItems]) {
        if (item.valueInDollars > 50)
            above50++;
        else
            below50++;
    }
    
    if (section == 0) {
        return below50;
    }
    else if (section == 1) {
        return above50+1; //added 1 to write "No more items!" in the last section
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *allItems = [[ItemStore sharedStore] allItems];
    NSMutableArray *itemsBelow50Bucks = [[NSMutableArray alloc] init];
    NSMutableArray *itemsAbove50Bucks = [[NSMutableArray alloc] init];
    
    for (BNRItem *item in allItems) {
        if (item.valueInDollars < 50) {
            [itemsBelow50Bucks addObject:item];
        }
        else
            [itemsAbove50Bucks addObject:item];
    }
    
    BNRItem *outItem = [[BNRItem alloc] init];
    if (indexPath.section == 0) {
        outItem = itemsBelow50Bucks[indexPath.row];
        cell.textLabel.text = outItem.description;
    }
    else if (indexPath.section == 1) {
        if (indexPath.row != itemsAbove50Bucks.count) {
            outItem = itemsAbove50Bucks[indexPath.row];
            cell.textLabel.text = outItem.description;
        }
        else {
            cell.textLabel.text = @"No more items!";
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"Below $50";
    }
    else if (section == 1) {
        return @"Above $50";
    }
    return 0;
}

//                                      Nie o to chodziło
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    if (section == 1) {
//        return @"No more items!";
//    }
//    return 0;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

@end
