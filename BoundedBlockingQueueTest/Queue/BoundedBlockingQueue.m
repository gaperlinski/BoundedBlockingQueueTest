//
//  BoundedBlockingQueue.m
//  BoundedBlockingQueueTest
//
//  Created by Grzegorz Aperliński on 22.02.2017.
//  Copyright © 2017 Grzegorz Aperlinski. All rights reserved.
//

#import "BoundedBlockingQueue.h"

@interface BoundedBlockingQueue()

@property (nonatomic) NSMutableArray *queue;
@property (nonatomic, strong) NSCondition *notEmpty;
@property (nonatomic, strong) NSCondition *notFull;
@property (nonatomic) int maxSize;

@end

@implementation BoundedBlockingQueue

- (instancetype)initWithSize:(int)size {
  self = [super init];
  if (self) {
    _maxSize = size;
    _queue = [[NSMutableArray alloc] initWithCapacity: _maxSize];
    _notEmpty = [[NSCondition alloc] init];
    _notFull = [[NSCondition alloc] init];
  }
  return self;
}

- (void)dealloc {
  _queue = nil;
  _notEmpty = nil;
  _notFull = nil;
}

- (void)put:(id)data {
  NSLog(@"put about to lock");
  [_notFull lock];
  NSLog(@"put got lock");

  while (_queue.count == _maxSize) {
    NSLog(@"put waiting for not full");
    [_notFull wait];
    NSLog(@"put finished waiting");
  }
  
  NSLog(@"put adding data");
  [_queue addObject:data];
  
  NSLog(@"put signalling not empty");
  [_notEmpty signal];
  
  [_notFull unlock];
  NSLog(@"put unlocked");
}

- (id)pull {
  id data = nil;
  NSTimeInterval interval = 10;
  NSDate *timeout = [NSDate dateWithTimeIntervalSinceNow:interval];
  
  NSLog(@"pull about to lock");
  [_notEmpty lock];
  NSLog(@"pull got lock");
  
  while (_queue.count == 0) {
    NSLog(@"pull waiting for not empty");
    if (![_notEmpty waitUntilDate:timeout]) {
      NSLog(@"pull wait timeout");
      [_notEmpty unlock];
      return nil;
    }
  }
  
  NSLog(@"pull extracting data");
  data = _queue[0];
  [_queue removeObjectAtIndex:0];
  
  NSLog(@"pull signalling not full");
  [_notFull signal];
  
  [_notEmpty unlock];
  NSLog(@"pull unlocked");
  
  return data;
}

@end
