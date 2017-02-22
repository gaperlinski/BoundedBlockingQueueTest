//
//  ViewController.m
//  BoundedBlockingQueueTest
//
//  Created by Grzegorz Aperliński on 22.02.2017.
//  Copyright © 2017 Grzegorz Aperlinski. All rights reserved.
//

#import "ViewController.h"
#import "BoundedBlockingQueue.h"

@interface ViewController ()

@property (nonatomic, strong) BoundedBlockingQueue *queue;
@property (nonatomic) int putIteration;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.queue = [[BoundedBlockingQueue alloc] initWithSize:5];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (IBAction)putButtonTapped:(id)sender {
  [NSThread detachNewThreadSelector:@selector(doPut) toTarget:self withObject:nil];
}

- (IBAction)pullButtonTapped:(id)sender {
  [NSThread detachNewThreadSelector:@selector(doPull) toTarget:self withObject:nil];
}

- (void)doPut {
  for (int i = 0; i < 5; i++) {
    @autoreleasepool {
      self.putIteration++;
      NSNumber *data = [[NSNumber alloc] initWithInt:self.putIteration];
      NSLog(@"Putting %@", data);
      [self.queue put:data];
    }
  }
}

- (void)doPull {
  while (YES) {
    @autoreleasepool {
      NSNumber *data = [self.queue pull];
      if (nil == data) {
        NSLog(@"Queue is empty");
      } else {
        [NSThread sleepForTimeInterval: 1];
        NSLog(@"Got %@", data);
        [self performSelectorOnMainThread:@selector(updateLabelWithNumber:) withObject:data waitUntilDone:NO];
      }
    }
  }
}

- (void)updateLabelWithNumber:(NSNumber *)number {
  self.iterationLabel.text = [NSString stringWithFormat:@"pulled count: %@", number];
}

@end
