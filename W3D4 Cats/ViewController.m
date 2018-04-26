//
//  ViewController.m
//  W3D4 Cats
//
//  Created by Colin on 2018-04-26.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL *flickrCatUrl = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=178d9e3064aa836a8bac2c18eea8957e&tags=cat"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:flickrCatUrl];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *flickrDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *photoDict = flickrDict[@"photos"][@"photo"];
     
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
//        for(NSString *key in [photoDict2 allKeys]) {
//            NSLog(@"%@",[photoDict2 objectForKey:key]);
       // }
        for (NSDictionary *dict in photoDict) {
            NSString *photoName = dict[@"title"];
            NSLog(@"image name: %@", photoName);
            
        }
        
        
    }];
    
    [dataTask resume];
    

}

- (void)constructURL {
    
}



@end
