//
//  GOPhotoListParserDelegate.h
//  XMLImages
//
//  Created by Samuel Goodwin on 5/18/12.
//  Copyright (c) 2012 Goodwinlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GOComletionBlock)(NSArray *items);

@interface GOPhotoListParserDelegate : NSObject<NSXMLParserDelegate>
@property (nonatomic, copy) GOComletionBlock block;
@property (nonatomic, retain) NSMutableArray *items;

- (id)initWithBlock:(GOComletionBlock)block;

@end
