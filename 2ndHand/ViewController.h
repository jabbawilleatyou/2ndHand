//
//  ViewController.h
//  2ndHand
//
//  Created by Yuval on 6/16/16.
//  Copyright © 2016 itmatters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

 
@end

