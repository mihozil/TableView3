//
//  Person.m
//  UITableView3
//
//  Created by Apple on 1/10/16.
//  Copyright (c) 2016 AMOSC. All rights reserved.
//

#import "Person.h"

@implementation Person{
    NSArray *firstname;
    NSArray *lastname;
}
- (id) init{
    firstname = @[@"Lionel",@"Cristiano",@"Rafael",@"Novak",@"Roger",@"Luis",@"Theo"];
    lastname = @[@"Messi",@"Ronaldo",@"Nadal",@"Djokovic",@"Federrer",@"Suarez",@"Walcott"];
    if (self==[super init]){
        self.name = [NSString stringWithFormat:@"%@ %@",firstname[arc4random_uniform((int)firstname.count)],
                     lastname[arc4random_uniform((int)lastname.count)]];
        self.age = arc4random_uniform(30) + 15;
    }
    return self;
}

@end
