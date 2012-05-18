//
//  GODetailViewController.h
//  XMLImages
//
//  Created by Samuel Goodwin on 5/18/12.
//  Copyright (c) 2012 Goodwinlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GOPhotoDetailsParserDelegate;
@interface GODetailViewController : UIViewController
@property (nonatomic, retain) IBOutlet UIImageView *photoView;
@property (nonatomic, retain) GOPhotoDetailsParserDelegate *photoDetailsDelegate;
@property (nonatomic, copy) NSString *photoID;

+ (id)controllerWithPhotoID:(NSString *)photoID;

@end
