//
//  GOPhotoDetailsParserDelegate.h
//  XMLImages
//
//  Created by Samuel Goodwin on 5/18/12.
//  Copyright (c) 2012 Goodwinlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GOImageCompletionBlock)(NSString *imageURLString);

@interface GOPhotoDetailsParserDelegate : NSObject<NSXMLParserDelegate>
@property (nonatomic, copy) GOImageCompletionBlock block;
@property (nonatomic, copy) NSString *imageURLString;
@property (nonatomic, copy) NSString *targetImageSize;

- (id)initWithBlock:(GOImageCompletionBlock)block;


@end
