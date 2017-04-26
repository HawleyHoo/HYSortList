//
//  HYSortClass.m
//  HYSortListDemo
//
//  Created by 胡杨 on 2017/1/6.
//  Copyright © 2017年 net.fitcome.www. All rights reserved.
//

#import "HYSortClass.h"

@interface HYSortClass ()

@property (nonatomic, strong) NSMutableArray *tempArray;

@end

@implementation HYSortClass



- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}



- (void)hydisplayResult:(NSUInteger)index value:(NSNumber *)value {
    
    [NSThread sleepForTimeInterval:0.001];
//    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(displayResult:value:)]) {
            [self.delegate displayResult:index value:value];
        }
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.001 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
//    });
}

// 冒泡排序
- (NSArray *)bubbleSortWithArray:(NSArray *)array {
    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:array];
//    dispatch_async(dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL), ^{
        time_t time1 = clock();
        NSLog(@" 冒泡排序： 开始！clock1: %ld", time1);
        for (NSUInteger i = 0; i < mutArray.count; i++) {
            //        NSLog(@"第 %ld 冒泡排序", i + 1);
            NSUInteger j = mutArray.count - 1;
            while (j > i) {
                if ([mutArray[j - 1] floatValue] > [mutArray[j] floatValue]) {
                    NSNumber *temp = mutArray[j];
                    mutArray[j] = mutArray[j - 1];
                    mutArray[j - 1] = temp;
                    [self hydisplayResult:j value:mutArray[j]];
                    [self hydisplayResult:j - 1 value:mutArray[j - 1]];
                    NSLog(@" %@  %@",[NSThread currentThread] ,[NSThread currentThread].name);
                }
                j--;
            }
        }
        time_t time2 = clock();
        NSLog(@" 冒泡排序： 完成！clock2: %ld", time2);
        NSLog(@" 用时：%.3f 秒", ((float)(time2 - time1)) / CLOCKS_PER_SEC);
//    });
    
    
    return mutArray.copy;
}

// 选择排序
- (NSArray *)simpleSelectionSortWithAarray:(NSArray *)array {
    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:array];
    dispatch_async(dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL), ^{
        time_t time1 = clock();
        NSLog(@" 选择排序： 开始！clock1: %ld", time1);
        
        for (NSUInteger i = 0; i < mutArray.count; i++) {
            NSUInteger j = i + 1;
            float minValue = [mutArray[i] floatValue];
            NSUInteger minIndex = i;
            
            while (j < mutArray.count) {
                if (minValue > [mutArray[j] floatValue]) {
                    minValue = [mutArray[j] floatValue];
                    minIndex = j;
                }
                j++;
            }

            if (minIndex != i) {
                NSNumber *temp = mutArray[i];
                mutArray[i] = mutArray[minIndex];
                mutArray[minIndex] = temp;
                [self hydisplayResult:i value:mutArray[i]];
                [self hydisplayResult:minIndex value:mutArray[minIndex]];
            }
        }
        time_t time2 = clock();
        NSLog(@" 选择排序： 完成！clock2: %ld", time2);
        NSLog(@" 用时：%.3f 秒", ((float)(time2 - time1)) / CLOCKS_PER_SEC);
    });
    
    return mutArray.copy;
}

// 插入排序
- (NSArray *)insertSortWithAarray:(NSArray *)array {
    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:array];
    dispatch_async(dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL), ^{
        time_t time1 = clock();
        NSLog(@" 插入排序： 开始！clock1: %ld", time1);
        for (NSInteger i = 0; i < mutArray.count; i++) {
            NSInteger j = i;
            while (j > 0) {
                if ([mutArray[j] floatValue] < [mutArray[j - 1] floatValue]) {
                    NSNumber *temp = mutArray[j];
                    mutArray[j] = mutArray[j - 1];
                    mutArray[j - 1] = temp;
                    [self hydisplayResult:j value:mutArray[j]];
                    [self hydisplayResult:j - 1 value:mutArray[j - 1]];
                    j--;
                } else {
                    break;
                }
            }
            
        }
        time_t time2 = clock();
        NSLog(@" 插入排序： 完成！clock2: %ld", time2);
        NSLog(@" 用时：%.3f 秒", ((float)(time2 - time1)) / CLOCKS_PER_SEC);
    });
    
    return mutArray.copy;
}

// 希尔排序
- (NSArray *)shellSortWithAarray:(NSArray *)array {
    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:array];
    dispatch_async(dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL), ^{
        time_t time1 = clock();
        NSLog(@" 希尔排序： 开始！clock1: %ld", time1);
        NSInteger step = mutArray.count / 2;
        while (step > 0) {
            for (NSInteger i = 0; i < mutArray.count; i++) {
                NSInteger j = i + step;
                while (j >= step && j < mutArray.count) {
                    if ([mutArray[j] floatValue] < [mutArray[j - step] floatValue]) {
                        NSNumber *temp = mutArray[j];
                        mutArray[j] = mutArray[j - step];
                        mutArray[j - step] = temp;
                        
                        [self hydisplayResult:j value:mutArray[j]];
                        [self hydisplayResult:j - step value:mutArray[j - step]];
                        j = j - step;
                    } else {
                        break;
                    }
                }
            }
            step = step / 2;
        }
        time_t time2 = clock();
        NSLog(@" 希尔排序： 完成！clock2: %ld", time2);
        NSLog(@" 用时：%.3f 秒", ((float)(time2 - time1)) / CLOCKS_PER_SEC);
    });
    return mutArray.copy;
}

// 堆排序
- (NSArray *)heapSortWithAarray:(NSArray *)array {
    __block NSMutableArray *mutArray = [NSMutableArray arrayWithArray:array];
    dispatch_async(dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL), ^{
        time_t time1 = clock();
        NSLog(@" 堆排序： 开始！clock1: %ld", time1);
        NSInteger endIndex = mutArray.count - 1;
        mutArray = [self heapCreate:mutArray];
        while (endIndex >= 0) {
//            NSLog(@"将list[0]:\%@与list[\(endIndex)]:\%@交换", mutArray[0], mutArray[endIndex]);
            NSNumber *temp = mutArray[0];
            mutArray[0] = mutArray[endIndex];
            mutArray[endIndex] = temp;
            [self hydisplayResult:0 value:mutArray[0]];
            [self hydisplayResult:endIndex value:mutArray[endIndex]];
            endIndex -= 1;
            mutArray = [self heapAdjast:mutArray withStartIndex:0 withEndIndex:endIndex + 1];
        }
        
        
        time_t time2 = clock();
        NSLog(@" 堆排序： 完成！clock2: %ld", time2);
        NSLog(@" 用时：%.3f 秒", ((float)(time2 - time1)) / CLOCKS_PER_SEC);
    });
    return mutArray.copy;
}

- (NSMutableArray *)heapCreate:(NSMutableArray *)array {
    NSInteger i = array.count;
    while (i > 0) {
        array = [self heapAdjast:array withStartIndex:i - 1 withEndIndex:array.count];
        i -= 1;
    }
    return array;
}

- (NSMutableArray *)heapAdjast:(NSMutableArray *)items withStartIndex:(NSInteger)startIndex withEndIndex:(NSInteger)endIndex {
    NSNumber *temp = items[startIndex];
    NSInteger fatherIndex = startIndex + 1;
    NSInteger maxChildIndex = 2 * fatherIndex;
    
    while (maxChildIndex <= endIndex) {
        if (maxChildIndex < endIndex && [items[maxChildIndex - 1] floatValue] < [items[maxChildIndex] floatValue]) {
            maxChildIndex++;
        }
        if ([temp floatValue] < [items[maxChildIndex - 1] floatValue]) {
            items[fatherIndex - 1] = items[maxChildIndex - 1];
            [self hydisplayResult:fatherIndex - 1 value:items[fatherIndex - 1]];
        } else {
            break;
        }
        fatherIndex = maxChildIndex;
        maxChildIndex = fatherIndex * 2;
    }
    items[fatherIndex - 1] = temp;
    [self hydisplayResult:fatherIndex - 1 value:items[fatherIndex - 1]];
    return items;
}

// 归并排序
- (NSArray *)mergingSortWithAarray:(NSArray *)array {
//    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:array];
    self.tempArray = [NSMutableArray array];
    dispatch_async(dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL), ^{
        time_t time1 = clock();
        NSLog(@" 归并排序： 开始！clock1: %ld", time1);
        
        for (NSNumber *num in array) {
            NSMutableArray *subArray = [NSMutableArray array];
            [subArray addObject:num];
            [self.tempArray addObject:subArray];
        }
        
        while (self.tempArray.count != 1) {
            NSInteger i = 0;
            while (i < self.tempArray.count - 1) {
                self.tempArray[i] = [self mergeArrayFirstList:self.tempArray[i] secondList:self.tempArray[i + 1]];
                [self.tempArray removeObjectAtIndex:i + 1];
                for (int subIndex = 0; subIndex < ((NSArray *)self.tempArray[i]).count; subIndex++) {
                    NSInteger index = [self countSubItemIndex:i subItemIndex:subIndex];
                    [self hydisplayResult:index value:self.tempArray[i][subIndex]];
                }
                i++;
            }
            
        }
        
        
        time_t time2 = clock();
        NSLog(@" 归并排序： 完成！clock2: %ld", time2);
        NSLog(@" 用时：%.3f 秒", ((float)(time2 - time1)) / CLOCKS_PER_SEC);
    });
    return self.tempArray.copy;
}

- (NSArray *)mergeArrayFirstList:(NSArray *)array1 secondList:(NSArray *)array2 {
    NSMutableArray *resultArray = [NSMutableArray array];
    NSInteger firstIndex = 0, secondIndex = 0;
    while (firstIndex < array1.count && secondIndex < array2.count) {
        if ([array1[firstIndex] floatValue] < [array2[secondIndex] floatValue]) {
            [resultArray addObject:array1[firstIndex]];
            firstIndex++;
        } else {
            [resultArray addObject:array2[secondIndex]];
            secondIndex++;
        }
    }
    
    while (firstIndex < array1.count) {
        [resultArray addObject:array1[firstIndex]];
        firstIndex++;
    }
    
    while (secondIndex < array2.count) {
        [resultArray addObject:array2[secondIndex]];
        secondIndex++;
    }
    
    return resultArray.copy;
}

- (NSInteger)countSubItemIndex:(NSInteger)endIndex subItemIndex:(NSInteger)subItemIndex {
    NSInteger sum = 0;
    for (int index = 0; index < endIndex; index++) {
        sum += ((NSArray *)self.tempArray[index]).count;
    }
    return sum + subItemIndex;
}

// 快速排序
- (NSArray *)quickSortWithAarray:(NSArray *)array {
    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:array];
    dispatch_async(dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL), ^{
        time_t time1 = clock();
        NSLog(@" 快速排序： 开始！clock1: %ld", time1);
        
        [self quickSort:mutArray low:0 high:mutArray.count - 1];
        
        time_t time2 = clock();
        NSLog(@" 快速排序： 完成！clock2: %ld", time2);
        NSLog(@" 用时：%.3f 秒", ((float)(time2 - time1)) / CLOCKS_PER_SEC);
    });
    return mutArray.copy;
}

- (void)quickSort:(NSMutableArray *)list low:(NSInteger)low high:(NSInteger)high {
    if (low < high) {
        NSInteger mid = [self partition:list low:low high:high];
        [self quickSort:list low:low high:mid - 1];
        [self quickSort:list low:mid + 1 high:high];
    }
}

- (NSInteger)partition:(NSMutableArray *)list low:(NSInteger)low high:(NSInteger)high {
    NSNumber *temp = list[low];
    while (low < high) {
        while (low < high && [list[high] floatValue] >= [temp floatValue]) {
            high--;
        }
        list[low] = list[high];
        [self hydisplayResult:low value:list[low]];
        
        while (low < high && [list[low] floatValue] <= [temp floatValue]) {
            low++;
        }
        list[high] = list[low];
        [self hydisplayResult:high value:list[high]];
    }
    list[low] = temp;
    [self hydisplayResult:low value:list[low]];
    return low;
}

// 基数排序
- (NSArray *)radixSortWithAarray:(NSArray *)array {
    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:array];
    dispatch_async(dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL), ^{
        time_t time1 = clock();
        NSLog(@" 基数排序： 开始！clock1: %ld", time1);
        
        if (mutArray.count > 0) {
            [self radixSort:mutArray];
        }
        
        time_t time2 = clock();
        NSLog(@" 基数排序： 完成！clock2: %ld", time2);
        NSLog(@" 用时：%.3f 秒", ((float)(time2 - time1)) / CLOCKS_PER_SEC);
    });
    return mutArray.copy;
}

- (void)radixSort:(NSMutableArray *)list {
    NSMutableArray *buckt = [self createBucket];
    NSNumber *maxnumber = [self listMaxItem:list];
    NSInteger maxLength = numberLength(maxnumber);
    
    for (int digit = 1; digit <= maxLength; digit++) {
        // 入桶
        for (NSNumber *item in list) {
            NSInteger baseNumber = [self fetchBaseNumber:item digit:digit];
            NSMutableArray *mutArray = buckt[baseNumber];
            [mutArray addObject:item];
        }
        
        
         NSInteger index = 0;
        for (int i = 0; i < buckt.count; i++) {
            NSMutableArray *array = buckt[i];
            while (array.count != 0) {
                NSNumber *number = [array objectAtIndex:0];
                list[index] = number;
                [array removeObjectAtIndex:0];
                [self hydisplayResult:index value:list[index]];
                index++;
            }
        }
        
    }
}

- (NSMutableArray *)createBucket {
    NSMutableArray *bucket = [NSMutableArray array];
    for (int index = 0; index < 10; index++) {
        NSMutableArray *array = [NSMutableArray array];
        [bucket addObject:array];
    }
    return bucket;
}

- (NSNumber *)listMaxItem:(NSArray *)list {
    NSNumber *maxNumber = list[0];
    for (NSNumber *number in list) {
        if ([maxNumber integerValue] < [number integerValue]) {
            maxNumber = number;
        }
    }
    return maxNumber;
}

NSInteger numberLength(NSNumber *number) {
    NSString *string = [NSString stringWithFormat:@"%ld", (long)[number integerValue]];
    return string.length;
}

- (NSInteger)fetchBaseNumber:(NSNumber *)number digit:(NSInteger)digit {
    if (digit > 0 && digit <= numberLength(number)) {
        NSMutableArray *numbersArray = [NSMutableArray array];
        NSString *string = [NSString stringWithFormat:@"%ld", [number integerValue]];
        for (int index = 0; index < numberLength(number); index++) {
            [numbersArray addObject:[string substringWithRange:NSMakeRange(index, 1)]];
        }
        NSString *str = numbersArray[numbersArray.count - digit];
        return [str integerValue];
    }
    return 0;
}


@end
