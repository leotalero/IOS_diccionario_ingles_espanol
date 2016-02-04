//
//  ViewController.h
//  diccionario1
//
//  Created by Leonardo Talero on 11/16/15.
//  Copyright © 2015 unir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

