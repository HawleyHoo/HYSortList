//
//  ViewController.m
//  HYSortListDemo
//
//  Created by 胡杨 on 17/1/5.
//  Copyright © 2017年 net.fitcome.www. All rights reserved.
//

#import "ViewController.h"
#import "HYSortClass.h"
#import "HYSortView.h"



@interface ViewController ()<UITextFieldDelegate, HYSortDelegate>

@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIView *displayView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortSegmentControl;

@property (nonatomic, assign) int sortCount;

@property (nonatomic, assign) CGFloat sortViewWidth;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) HYSortClass *sortClass;

@property (nonatomic, assign) NSUInteger selectedIndex;

@end

@implementation ViewController

- (IBAction)buttonClicked:(UIButton *)sender {
//    NSLog(@" data array %@", self.dataArray);
    
    switch (self.selectedIndex) {
        case HYSortTypeBubble: {
            self.dataArray = [self.sortClass bubbleSortWithArray:self.dataArray];
        } break;
            
        case HYSortTypeSelect: {
            self.dataArray = [self.sortClass simpleSelectionSortWithAarray:self.dataArray];
        } break;
            
        case HYSortTypeInsert: {
            self.dataArray = [self.sortClass insertSortWithAarray:self.dataArray];
        } break;
            
        case HYSortTypeShell: {
            self.dataArray = [self.sortClass shellSortWithAarray:self.dataArray];
        } break;
            
        case HYSortTypeHeap: {
            self.dataArray = [self.sortClass heapSortWithAarray:self.dataArray];
        } break;
            
        case HYSortTypeMerge: {
            self.dataArray = [self.sortClass mergingSortWithAarray:self.dataArray];
        } break;
            
        case HYSortTypeQuick: {
            self.dataArray = [self.sortClass quickSortWithAarray:self.dataArray];
        } break;
            
        case HYSortTypeRadix: {
            self.dataArray = [self.sortClass radixSortWithAarray:self.dataArray];
        } break;
            
        default:
            break;
    }
//    NSLog(@" data array %@", self.dataArray);
    
}


- (IBAction)segmentedControlDidValueChanged:(UISegmentedControl *)sender {
    self.selectedIndex = sender.selectedSegmentIndex;
    
    [self addSortView];
}

- (CGFloat)sortViewWidth {
    return self.displayView.frame.size.width / (CGFloat)self.sortCount;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.sortClass = [[HYSortClass alloc] init];
    self.sortClass.delegate = self;
    
    
    self.displayView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    [self addSortView];
}

- (void)addSortView {
    [self.displayView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.sortCount = [self.numberTextField.text intValue];
    if (self.sortCount < 3) return;
    
    CGFloat hh = self.displayView.frame.size.height;
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int index = 0; index < self.sortCount; index++) {
//        [mutArray addObject:@((arc4random() % RAND_MAX / (float)RAND_MAX) * hh)];
        [mutArray addObject:@((arc4random() % RAND_MAX))];
    }
//    NSArray *array = @[@(62), @(88), @(58), @(47), @(62), @(35), @(73), @(51), @(99), @(37), @(93)];
    self.dataArray = mutArray.copy;
    
    for (int index = 0; index < self.sortCount; index++) {
        CGFloat height = [self.dataArray[index] floatValue];
        CGRect frame = CGRectMake(index * self.sortViewWidth, 0, self.sortViewWidth, height);
        HYSortView *sortView = [[HYSortView alloc] init];
        sortView.frame = frame;
        [sortView updateHeight:height / (float)RAND_MAX * hh];
        [self.displayView addSubview:sortView];
    }
}


- (void)displayResult:(NSUInteger)index value:(NSNumber *)value {
//    NSLog(@" %s %@", __FUNCTION__ , [NSThread currentThread]);
    CGFloat hh = self.displayView.frame.size.height;
    HYSortView *view = self.displayView.subviews[index];
    [view updateHeight:[value floatValue] / (float)RAND_MAX * hh];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.confirmButton.enabled = NO;
    self.sortSegmentControl.enabled = NO;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldEndEditing %@", textField.text);
    [self addSortView];
    self.confirmButton.enabled = YES;
    self.sortSegmentControl.enabled = YES;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    
    NSMutableString *futureStr = [NSMutableString stringWithString:textField.text];
    [futureStr insertString:string atIndex:range.location];
    NSLog(@" %@ -%@- %@", textField.text, string, NSStringFromRange(range));
    if (futureStr.length > 3) {
        return NO;
    }
    BOOL flag = [string isEqualToString:filtered];
    return flag;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
