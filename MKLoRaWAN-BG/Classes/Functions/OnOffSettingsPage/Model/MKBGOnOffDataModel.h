//
//  MKBGOnOffDataModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGOnOffDataModel : NSObject

/// 0:Multiple approaches   1:Continuous approach
@property (nonatomic, assign)NSInteger method;

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, assign)BOOL mode;

@property (nonatomic, assign)BOOL autoPowerOn;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
