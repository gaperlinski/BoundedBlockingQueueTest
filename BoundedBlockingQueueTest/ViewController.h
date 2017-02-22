//
//  ViewController.h
//  BoundedBlockingQueueTest
//
//  Created by Grzegorz Aperliński on 22.02.2017.
//  Copyright © 2017 Grzegorz Aperlinski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *iterationLabel;

- (IBAction)putButtonTapped:(id)sender;
- (IBAction)pullButtonTapped:(id)sender;

@end

