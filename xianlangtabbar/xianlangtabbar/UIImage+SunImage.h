//
//  UIImage+SunImage.h
//  MLLabel
//
//  Created by user on 17/3/23.
//  Copyright © 2017年 molon. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIImage (SunImage)
/**
 *  截图当前对象image对象rect区域内的图像
 */
+(UIImage *)subimageInRect:(UIImage *)image rect:(CGRect)rect;
/**
 *  压缩图片至指定尺寸 会变形
 */
+(UIImage *)scaleImageNotKeepingRation:(UIImage *)image targetSize:(CGSize)targetSize;
/**
 *  压缩图片至指定像素
 */
+(UIImage *)scaleImageAtPixel:(UIImage *)image pixel:(CGFloat)pixel;
/**
 *  在指定的size里面生成一个平铺的图片
 */
+(UIImage *)titleImage:(UIImage *)image targetSize:(CGSize)targetSize;
/**
 *  UIView转换为UIImage
 */
+(UIImage *)imageWithView:(UIView *)view;
/**
 *  将两个图片生成一张图片
 */
+(UIImage *)mergeImage:(UIImage *)image otherImage:(UIImage *)otnerImage;
/**
 *  不变形拉伸
 */
+(UIImage *)scaleImageKeepingRatio:(UIImage *)iamge targetSize:(CGSize)targetSize;

@end
NS_ASSUME_NONNULL_END