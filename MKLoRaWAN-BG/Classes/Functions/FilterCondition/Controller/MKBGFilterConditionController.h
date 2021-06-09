//
//  MKBGFilterConditionController.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/6/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_bg_conditionType) {
    mk_bg_conditionType_A,
    mk_bg_conditionType_B,
};

@interface MKBGFilterConditionController : MKBaseViewController

@property (nonatomic, assign)mk_bg_conditionType conditionType;

@end

NS_ASSUME_NONNULL_END
