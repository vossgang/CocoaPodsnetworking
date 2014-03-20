//
//  Song.m
//  CocoaPods-Networking
//
//  Created by Matthew Voss on 3/19/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import "Song.h"

@implementation Song

- (id)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        self.name = [json objectForKey:@"trackName"];
        self.html_url = [NSURL URLWithString:[json objectForKey:@"previewUrl"]];
        
    }
    
    return self;
}

@end
