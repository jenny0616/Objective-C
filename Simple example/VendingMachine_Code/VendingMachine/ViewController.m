//
//  ViewController.m
//  VendingMachine
//
//  Created by 노정우 on 2016. 11. 19..
//  Copyright © 2016년 jenny0616. All rights reserved.
//

#import "ViewController.h"
#import "ProductView.h"
@interface ViewController ()<ProductViewDelegate>


@property (nonatomic) NSArray *productData;
@property (nonatomic) NSArray *moneyData;

@property (nonatomic, weak) UIView *productContainerView;   //  global variable that include productViews
@property (nonatomic) NSMutableArray *productViews;

@property (nonatomic, assign) NSInteger remainMoney;
@property (nonatomic, weak) UIView *remainMoneyView;
@property (nonatomic, weak) UILabel *remainMoneyLabel;

@property (nonatomic, weak) UIView *moneyInputView;
@property (nonatomic) NSMutableArray *moneyInputButtons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  setting dummy data include title, price, image filename.
    self.productData = @[@{@"title":@"제니",@"price":@"4000",@"imageName":@"bpjenny.jpeg"},
                         @{@"title":@"지수",@"price":@"4000",@"imageName":@"bpjisoo.jpeg"},
                         @{@"title":@"로제",@"price":@"1000",@"imageName":@"bprose.jpeg"},
                         @{@"title":@"리사",@"price":@"2000",@"imageName":@"bplisa.jpeg"}];
    
    self.moneyData = @[@"10000", @"5000", @"1000"];
    
    self.productViews = [[NSMutableArray alloc] init];
    self.moneyInputButtons = [[NSMutableArray alloc] init];
    
    [self createView];
    [self updateLayout];
}

#pragma mark - create views
- (void)createView {
    UIView *productContainerView = [[UIView alloc] init];
    [productContainerView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:productContainerView];
    self.productContainerView = productContainerView;
    
    for (NSInteger i = 0; i < 4; i++) {
        ProductView *productView = [[ProductView alloc] initWithData:self.productData[i]];
        [productView setBackgroundColor:[UIColor colorWithRed:1.0f green:0.83f blue:0.88f alpha:1.0f]];
        [productView setTag:i];
        [productView setDelegate:self];
        [self.productContainerView addSubview:productView];
        [self.productViews addObject:productView];
    }
    
    UIView *remainMoneyView = [[UIView alloc] init];
    [remainMoneyView setBackgroundColor:[UIColor colorWithRed:1.0f green:0.83f blue:0.88f alpha:1.0]];
    [self.view addSubview:remainMoneyView];
    self.remainMoneyView = remainMoneyView;
    
    UILabel *remainMoneyLabel = [[UILabel alloc] init];
    [remainMoneyLabel setText:@"0"];
    [remainMoneyLabel setFont:[UIFont systemFontOfSize:38]];
    [remainMoneyLabel setTextAlignment:NSTextAlignmentRight];
    [remainMoneyView addSubview:remainMoneyLabel];
    self.remainMoneyLabel = remainMoneyLabel;
    
    UIView *moneyInputView = [[UIView alloc] init];
    [moneyInputView setBackgroundColor:[UIColor colorWithRed:1.0f green:0.83f blue:0.88f alpha:1.0f]];
    [self.view addSubview:moneyInputView];
    self.moneyInputView = moneyInputView;
    
    for (NSInteger i = 0; i < [self.moneyData count]; i++) {
        UIButton *moneyInputButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [moneyInputButton addTarget:self action:@selector(onTouchupInsideMoney:) forControlEvents:UIControlEventTouchUpInside];
        [moneyInputButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight];
        [moneyInputButton setTitle:[self.moneyData objectAtIndex:i] forState:UIControlStateNormal];
        [moneyInputButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [moneyInputButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [moneyInputButton setTag:i];
        [moneyInputView addSubview:moneyInputButton];
        [self.moneyInputButtons addObject:moneyInputButton];
    }
    
}

#pragma mark - adjust layout
- (void)updateLayout {
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    CGFloat baseViewOffsetY = 45;
    [self.productContainerView setFrame:CGRectMake(20, baseViewOffsetY, self.view.frame.size.width - 40, 400 + 10)];
    baseViewOffsetY += self.productContainerView.frame.size.height + 30;
    
    const NSInteger baseViewSpace = 10;
    for (UIView *productView in self.productViews) {
        NSInteger row = productView.tag/2;
        NSInteger cal = productView.tag%2;
        CGFloat productViewWidth = (self.productContainerView.frame.size.width - 10) / 2;
        CGFloat productViewHeight = (self.productContainerView.frame.size.height - 10) / 2;
        [productView setFrame:CGRectMake((productViewWidth + baseViewSpace)*cal, (productViewHeight + baseViewSpace)*row, productViewWidth, productViewHeight)];
    }
    
    [self.remainMoneyView setFrame:CGRectMake(20, baseViewOffsetY, self.view.frame.size.width-40, (self.view.frame.size.height-baseViewOffsetY)*0.60)];
    [self.remainMoneyLabel setFrame:CGRectMake(0, 0, self.remainMoneyView.frame.size.width, self.remainMoneyView.frame.size.height)];
    baseViewOffsetY += self.remainMoneyView.frame.size.height + 15;
    
    [self.moneyInputView setFrame:CGRectMake(20, baseViewOffsetY, self.view.frame.size.width - 40, (self.view.frame.size.height-baseViewOffsetY)-10)];
    NSInteger moneyInputButtonWidth = self.moneyInputView.frame.size.width/[self.moneyInputButtons count] - 10;
    for (UIView *moneyInputButtonView in self.moneyInputButtons) {
        [moneyInputButtonView setFrame:CGRectMake((moneyInputButtonWidth+10)*moneyInputButtonView.tag, 0, moneyInputButtonWidth, self.moneyInputView.frame.size.height)];
    }
}

#pragma mark - alert
-(void)didSelectedProductView:(ProductView *)product {
    NSString *title = [product getTitle];
    NSInteger price = [product getPrice];
    
    if (self.remainMoney >= price) {
        self.remainMoney -= price;
        [self.remainMoneyLabel setText:[NSString stringWithFormat:@"%ld",_remainMoney]];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"선택완료!" message:[NSString stringWithFormat:@"%@가 나왔습니다",title] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirmButton = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:confirmButton];
        [self presentViewController:alertController animated:YES completion:nil];
    }else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"잔액부족!" message:@"잔액을 확인해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmButton = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:confirmButton];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

#pragma mark - button method
- (void)onTouchupInsideMoney:(UIButton *)sender {
    NSInteger selectedTag = sender.tag;
    NSString *insertedMoney = [self.moneyData objectAtIndex:selectedTag];
    
    self.remainMoney += [insertedMoney integerValue];
    [self.remainMoneyLabel setText:[NSString stringWithFormat:@"%ld", self.remainMoney]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
