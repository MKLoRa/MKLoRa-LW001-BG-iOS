//
//  MKBGWifiPositionDataModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGWifiPositionDataModel : NSObject

@property (nonatomic, copy)NSString *interval;

@property (nonatomic, copy)NSString *number;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
