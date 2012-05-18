//
//  GOPhotoListParserDelegate.m
//  XMLImages
//
//  Created by Samuel Goodwin on 5/18/12.
//  Copyright (c) 2012 Goodwinlabs. All rights reserved.
//

#import "GOPhotoListParserDelegate.h"

@implementation GOPhotoListParserDelegate

- (id)initWithBlock:(GOComletionBlock)block
{
    if(self = [super init]){
        _block = [block copy];
    }
    return self;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.items = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"photo"]){
        [self.items addObject:[attributeDict valueForKey:@"id"]];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.block(self.items);
}

@end
