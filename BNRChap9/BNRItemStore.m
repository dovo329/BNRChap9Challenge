//
//  BNRItemStore.m
//  BNRChap8
//
//  Created by Douglas Voss on 4/15/15.
//  Copyright (c) 2015 Doug. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (void)removeItem:(BNRItem *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}

- (instancetype)init
{
    [NSException raise:@"Singleton"
                format:@"Use +[BNRItemStore sharedStore]"];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return [self.privateItems copy];
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    
    [self.privateItems addObject:item];
    
    return item;
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    
    BNRItem *item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
