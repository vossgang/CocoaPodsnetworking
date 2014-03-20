//
//  Song.h
//  CocoaPods-Networking
//
//  Created by Matthew Voss on 3/19/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

- (id)initWithJSON:(NSDictionary *)json;

@property (nonatomic, strong) NSURL *html_url;
@property (nonatomic, strong) NSString *name;


@end
