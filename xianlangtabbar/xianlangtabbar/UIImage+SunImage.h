//
//  UIImage+SunImage.h
//  MLLabel
//
//  Created by user on 17/3/23.
//  Copyright © 2017年 molon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SunImage)
/**
 *  截图当前对象image对象rect区域内的图像
 */
+(UIImage *)subimageInRect:(UIImage *)image rect:(CGRect)rect;
/**
 *  压缩图片至指定尺寸 会变形
 */

@end
