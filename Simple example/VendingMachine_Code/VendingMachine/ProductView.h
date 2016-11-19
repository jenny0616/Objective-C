//
//  ItemView.h
//  VendingMachine
//
//  Created by 노정우 on 2016. 11. 19..
//  Copyright © 2016년 jenny0616. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductViewDelegate;

@interface ProductView : UIView

@property (nonatomic, weak) id <ProductViewDelegate> delegate;
- (instancetype)initWithData:(NSDictionary *)data;

- (NSInteger)getPrice;
- (NSString *)getTitle;

@end

@protocol ProductViewDelegate <NSObject>

- (void)didSelectedProductView:(ProductView *)productView;

@end
