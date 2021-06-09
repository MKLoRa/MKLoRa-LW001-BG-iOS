//
//  MKBGNormalAdopter.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGNormalAdopter.h"

@implementation MKBGNormalAdopter

+ (NSMutableArray <MKTableSectionLineHeaderModel *>*)loadSectionHeaderListWithNumber:(NSInteger)number {
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < number; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [dataList addObject:headerModel];
    }
    return dataList;
}

@end
