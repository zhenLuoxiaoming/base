//
//  CityChoseView.h
//  newBase
//
//  Created by new-1020 on 2017/5/29.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityChoseViewDelegate <NSObject>

-(void)CityChoseViewSelecityCityWithString:(NSString *)str;

@end

@interface CityChoseView : UIView

@property (nonatomic,weak) id<CityChoseViewDelegate> xDelegate;

@end
