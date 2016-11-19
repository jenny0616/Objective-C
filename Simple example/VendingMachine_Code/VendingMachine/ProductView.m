//
//  ItemView.m
//  VendingMachine
//
//  Created by 노정우 on 2016. 11. 19..
//  Copyright © 2016년 jenny0616. All rights reserved.
//

#import "ProductView.h"
@interface ProductView()

@property NSDictionary *data;

@end

@implementation ProductView

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.data = data;
        [self createView];
    }
    return self;
}

- (void)createView {
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setFrame:CGRectMake(0, 0, self.frame.size.width, 200-35)];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [imageView setImage:[UIImage imageNamed:[self.data objectForKey:@"imageName"]]];
    [self addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(0, 200-35, self.frame.size.width, 20)];
    [titleLabel setText:[self.data objectForKey:@"title"]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:titleLabel];
    
    UILabel *costLabel = [[UILabel alloc] init];
    [costLabel setFrame:CGRectMake(0, 200-15, self.frame.size.width, 15)];
    [costLabel setText:[self.data objectForKey:@"price"]];
    [costLabel setFont:[UIFont systemFontOfSize:15]];
    [costLabel setTextAlignment:NSTextAlignmentCenter];
    [costLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:costLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [button addTarget:self action:@selector(onTouchupInsideProduct:) forControlEvents:UIControlEventTouchUpInside];
    [button setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:button];
}

- (void)onTouchupInsideProduct:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedProductView:)]) {
        [self.delegate didSelectedProductView:self];
    }
}

- (NSInteger)getPrice {
    return [[self.data objectForKey:@"price"] integerValue];
}

- (NSString *)getTitle {
    return [self.data objectForKey:@"title"];
}

@end
