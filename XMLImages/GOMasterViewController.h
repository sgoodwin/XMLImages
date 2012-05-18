//
//  GOMasterViewController.h
//  XMLImages
//
//  Created by Samuel Goodwin on 5/18/12.
//  Copyright (c) 2012 Goodwinlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GODetailViewController;

@class GOPhotoListParserDelegate;
@class GOPhotoDetailsParserDelegate;
@interface GOMasterViewController : UITableViewController
@property (nonatomic, retain) NSMutableDictionary *imageCache;
@property (nonatomic, copy) NSArray *objects;
@property (nonatomic, retain) GOPhotoListParserDelegate *photoListParserDelegate;
@property (nonatomic, retain) GOPhotoDetailsParserDelegate *photoDetailsParserDelegate;

@end
