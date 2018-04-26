//
//  Photo.h
//  W3D4 Cats
//
//  Created by Colin on 2018-04-26.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
@property (nonatomic, strong)NSDictionary *photoDictionary;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *url;
- (instancetype)initWithPhotoDictionary:(NSDictionary *)dictionary;
@end
