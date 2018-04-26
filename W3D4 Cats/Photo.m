//
//  Photo.m
//  W3D4 Cats
//
//  Created by Colin on 2018-04-26.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "Photo.h"
@interface Photo()
@property (nonatomic, strong)NSDictionary *photoDictionary;
@property (nonatomic, strong)NSString *server;
@property (assign)NSNumber *farm;
@property (nonatomic, strong)NSString *photoId;
@property (nonatomic, strong)NSString *secret;
@end

@implementation Photo

- (instancetype)initWithPhotoDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _photoDictionary = dictionary;
        _name = [dictionary objectForKey:@"title"];
        _server = [dictionary objectForKey:@"server"];
        _farm = [dictionary objectForKey:@"farm"];
        _photoId = [dictionary objectForKey:@"id"];
        _secret = [dictionary objectForKey:@"secret"];
        _url = [self createUrl];
        [self createImage];
    }
    return self;
}

- (NSString *)createUrl {
    return [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", self.farm, self.server, self.photoId, self.secret];
}

- (void)createImage {
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.url]]];
}
@end
