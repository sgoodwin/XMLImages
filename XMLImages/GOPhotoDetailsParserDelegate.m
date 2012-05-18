//
//  GOPhotoDetailsParserDelegate.m
//  XMLImages
//
//  Created by Samuel Goodwin on 5/18/12.
//  Copyright (c) 2012 Goodwinlabs. All rights reserved.
//

#import "GOPhotoDetailsParserDelegate.h"

@implementation GOPhotoDetailsParserDelegate

- (id)initWithBlock:(GOImageCompletionBlock)block
{
    if(self = [super init]){
        _block = [block copy];
    }
    return self;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.imageURLString = nil;
    if(!self.targetImageSize){
        self.targetImageSize = @"thumbnail";
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"size"]){
        NSString *label = [attributeDict objectForKey:@"label"];
        if([label isEqualToString:self.targetImageSize]){
            self.imageURLString = [attributeDict objectForKey:@"source"];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.block(self.imageURLString);
}

@end
