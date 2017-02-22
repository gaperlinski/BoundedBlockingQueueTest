//
//  BoundedBlockingQueue.h
//  BoundedBlockingQueueTest
//
//  Created by Grzegorz Aperliński on 22.02.2017.
//  Copyright © 2017 Grzegorz Aperlinski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoundedBlockingQueue : NSObject

- (instancetype)initWithSize:(int)size;
- (void)put:(id)data;
- (id)pull;

@end
