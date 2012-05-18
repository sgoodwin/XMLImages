//
//  GOMasterViewController.m
//  XMLImages
//
//  Created by Samuel Goodwin on 5/18/12.
//  Copyright (c) 2012 Goodwinlabs. All rights reserved.
//

#import "GOMasterViewController.h"

#import "GODetailViewController.h"
#import "GOPhotoListParserDelegate.h"
#import "GOPhotoDetailsParserDelegate.h"

@interface GOMasterViewController ()
@end

@implementation GOMasterViewController
							
- (void)viewDidLoad
{
    [super viewDidLoad];    
    self.imageCache = [[NSMutableDictionary alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://work.dc.akqa.com/recruiting/services/getPhotos.php"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        self.photoListParserDelegate = [[GOPhotoListParserDelegate alloc] initWithBlock:^(NSArray *items){
            [items enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *imageKey = obj;
                NSString *urlString = [NSString stringWithFormat:@"http://work.dc.akqa.com/recruiting/services/getSizes.php?id=%@", imageKey];
                NSURLRequest *imageDetailsRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
                [NSURLConnection sendAsynchronousRequest:imageDetailsRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *imageResponse, NSData *imageInfoData, NSError *error) {
                    self.photoDetailsParserDelegate = [[GOPhotoDetailsParserDelegate alloc] initWithBlock:^(NSString *imageURLString){
                        NSURLRequest *imageDetailsRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLString]];
                        [NSURLConnection sendAsynchronousRequest:imageDetailsRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *imageDataResponse, NSData *imageData, NSError *error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.imageCache setObject:[UIImage imageWithData:imageData] forKey:imageKey];
                                [self.tableView reloadData];
                            });
                        }];
                    }];
                    
                    NSXMLParser *detailsParser = [[NSXMLParser alloc] initWithData:imageInfoData];
                    [detailsParser setDelegate:self.photoDetailsParserDelegate];
                    [detailsParser parse];
                }];
            }];
            self.objects = items;
            [self.tableView reloadData];
        }];
        [parser setDelegate:self.photoListParserDelegate];
        [parser parse];
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSString *object = [self.objects objectAtIndex:indexPath.row];
    if([self.imageCache objectForKey:object]){
        cell.imageView.image = [self.imageCache objectForKey:object];
    }
    cell.textLabel.text = object;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *photoID = [self.objects objectAtIndex:indexPath.row];
    GODetailViewController *controller = [GODetailViewController controllerWithPhotoID:photoID];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
