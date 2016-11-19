//
//  ViewController.m
//  VendingMachine
//
//  Created by 노정우 on 2016. 11. 19..
//  Copyright © 2016년 jenny0616. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (nonatomic) NSArray *productData;
@property (nonatomic) NSArray *moneyData;

@property (nonatomic, weak) UIView *productContainerView;   //  global variable that include productViews
@property (nonatomic) NSMutableArray *productViews;

@property (nonatomic, assign) NSInteger remainMoney;
@property (nonatomic, weak) UIView *remainMoneyView;
@property (nonatomic, weak) UILabel *remainMoneyLabel;

@property (nonatomic, weak) UIView *moeneyInputView;
@property (nonatomic) NSMutableArray *moneyInputButtons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  setting dummy data include title, price, image filename.
    self.productData = @[@{@"title":@"A코스",@"price":@"1000",@"imageName":@"island1"},
                         @{@"title":@"B코스",@"price":@"2000",@"imageName":@"island2"},
                         @{@"title":@"C코스",@"price":@"3000",@"imageName":@"island3.jpg"},
                         @{@"title":@"D코스",@"price":@"4000",@"imageName":@"island4.jpg"}];
    
    self.moneyData = @[@"10000", @"5000", @"1000"];
    
    self.productViews = [[NSMutableArray alloc] init];
    self.moneyInputButtons = [[NSMutableArray alloc] init];
    
    [self createView];
    [self updateLayout];
}

- (void)createView {
    UIView *productContainerView = [[UIView alloc] init];
    [productContainerView setBackgroundColor:[UIColor magentaColor]];
    [self.view addSubview:productContainerView];
    self.productContainerView = productContainerView;
    
    
}

- (void)updateLayout {
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    CGFloat baseViewOffsetY = 45;
    [self.productContainerView setFrame:CGRectMake(20, baseViewOffsetY, self.view.frame.size.width - 40, 400 + 10)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
