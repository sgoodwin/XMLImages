//
//  GODetailViewController.m
//  XMLImages
//
//  Created by Samuel Goodwin on 5/18/12.
//  Copyright (c) 2012 Goodwinlabs. All rights reserved.
//

#import "GODetailViewController.h"
#import "GOPhotoDetailsParserDelegate.h"

@interface GODetailViewController ()
@end

@implementation GODetailViewController
@synthesize photoID = _photoID;
@synthesize photoDetailsDelegate = _photoDetailsDelegate;

+ (id)controllerWithPhotoID:(NSString *)photoID
{
    GODetailViewController *controller = [[self alloc] initWithNibName:@"GODetailViewController" bundle:nil];
    controller.photoID = photoID;
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photoDetailsDelegate = [[GOPhotoDetailsParserDelegate alloc] initWithBlock:^(NSString *imageURLString){
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLString]];
        [NSURLConnection sendAsynchronousRequest:imageRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *imageResponse, NSData *imageData, NSError *imageError) {
            self.photoView.image = [UIImage imageWithData:imageData];
        }];
    }];
    
    NSString *urlString = [NSString stringWithFormat:@"http://work.dc.akqa.com/recruiting/services/getSizes.php?id=%@", self.photoID];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        [parser setDelegate:self.photoDetailsDelegate];
        [parser parse];
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
							
@end
