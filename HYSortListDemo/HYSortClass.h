//
//  HYSortClass.h
//  HYSortListDemo
//
//  Created by 胡杨 on 2017/1/6.
//  Copyright © 2017年 net.fitcome.www. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HYSortType) {
    HYSortTypeBubble = 0,       //冒泡排序
    HYSortTypeSelect,           //选择排序
    HYSortTypeInsert,           //插入排序
    HYSortTypeShell,            //希尔排序
    HYSortTypeHeap,             //堆排序
    HYSortTypeMerge,            //归并排序
    HYSortTypeQuick,            //快速排序
    HYSortTypeRadix             //快速排序
};


@protocol HYSortDelegate <NSObject>

- (void)displayResult:(NSUInteger)index value:(NSNumber *)value;

@end

@interface HYSortClass : NSObject

@property (nonatomic, weak) id<HYSortDelegate> delegate;



// 冒泡排序
- (NSArray *)bubbleSortWithArray:(NSArray *)array;

// 选择排序
- (NSArray *)simpleSelectionSortWithAarray:(NSArray *)array;

// 插入排序
- (NSArray *)insertSortWithAarray:(NSArray *)array;

// 希尔排序
- (NSArray *)shellSortWithAarray:(NSArray *)array;

// 堆排序
- (NSArray *)heapSortWithAarray:(NSArray *)array;

// 归并排序
- (NSArray *)mergingSortWithAarray:(NSArray *)array;

// 快速排序
- (NSArray *)quickSortWithAarray:(NSArray *)array;

// 基数排序
- (NSArray *)radixSortWithAarray:(NSArray *)array;



@end
