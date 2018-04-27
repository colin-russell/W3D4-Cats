//
//  Photo.h
//  W3D4 Cats
//
//  Created by Colin on 2018-04-26.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Photo : NSObject
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *url;
//@property (nonatomic, weak)UIImage *image;
- (instancetype)initWithPhotoDictionary:(NSDictionary *)dictionary;
@end
