//
//  UIImage+SunImage.m
//  MLLabel
//
//  Created by user on 17/3/23.
//  Copyright © 2017年 molon. All rights reserved.
//

#import "UIImage+SunImage.h"

@implementation UIImage (SunImage)

/**
 *  截图当前对象image对象rect区域内的图像
 */
+(UIImage *)subimageInRect:(UIImage *)image rect:(CGRect)rect{
    CGImageRef newImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    
    UIImage *img = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    return img;
}

/**
 *  压缩图片至指定尺寸会变形
 */
+(UIImage *)scaleImageNotKeepingRation:(UIImage *)image targetSize:(CGSize)targetSize{
    CGRect rect = (CGRect){CGPointZero ,targetSize};
    
    UIGraphicsBeginImageContext(rect.size);
    
    [image drawInRect:rect];
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
}
+ (UIImage *)scaleImageNotKeepingRatio2:(UIImage *)image targetSize2:(CGSize)targetSize {
    
    UIColor *color = [UIColor colorWithPatternImage:image];
    
    UIImage *masterImage = [UIImage imageWithColor:color];
    
    CGRect rect = (CGRect){CGPointZero, targetSize};
    
    UIGraphicsBeginImageContext(rect.size);
    
    [masterImage drawInRect:rect];
    
    [image drawInRect:CGRectMake((targetSize.width-image.size.width)/2.0,
                                 (targetSize.height-image.size.height)/2.0,
                                 image.size.width,
                                 image.size.height)];
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
}

- (CGAffineTransform)transformForOrientation:(UIImageOrientation)orientation size:(CGSize)newSize {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (orientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (orientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    return transform;
}

- (UIImage *)scaledImageToSize:(CGSize)newSize scalingMode:(ScalingMode)scalingMode interpolationQuality:(CGInterpolationQuality)quality scale:(CGFloat)scale {
    BOOL transpose;
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transpose = YES;
            break;
        default:
            transpose = NO;
            break;
    }
    int mirrorV = 1;
    int mirrorH = 1;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
            mirrorH = 1;
            mirrorV = -1;
            break;
        case UIImageOrientationRight:
            mirrorH = 1;
            mirrorV = 1;
            break;
        case UIImageOrientationDown:
            mirrorH = -1;
            mirrorV = 1;
            break;
        case UIImageOrientationLeft:
            mirrorH = -1;
            mirrorV = -1;
            break;
        case UIImageOrientationDownMirrored:
            mirrorH = 1;
            mirrorV = 1;
            break;
        case UIImageOrientationUpMirrored:
            mirrorH = -1;
            mirrorV = -1;
            break;
        case UIImageOrientationRightMirrored:
            mirrorH = -1;
            mirrorV = 1;
            break;
        case UIImageOrientationLeftMirrored:
            mirrorH = 1;
            mirrorV = -1;
            break;
        default:
            break;
    }
    
    CGSize size = CGSizeZero;
    CGRect rect = CGRectZero;
    
    if (scalingMode == ScalingModeFill) {
        size = newSize;
    }
    else if (scalingMode == ScalingModeAspectFit) {
        CGSize oldSize = self.size;
        float aspectOld = oldSize.width / oldSize.height;
        float aspectNew = newSize.width / newSize.height;
        float scale = aspectOld > aspectNew ? newSize.width / oldSize.width : newSize.height / oldSize.height;
        size = CGSizeMake(oldSize.width * scale, oldSize.height * scale);
        newSize = size;
    }
    else if (scalingMode == ScalingModeAspectFill) {
        CGSize oldSize = self.size;
        float aspectOld = oldSize.width / oldSize.height;
        float aspectNew = newSize.width / newSize.height;
        float scale = aspectOld < aspectNew ? newSize.width / oldSize.width : newSize.height / oldSize.height;
        size = CGSizeMake(oldSize.width * scale, oldSize.height * scale);
    }
    else if (scalingMode == ScalingModeAspectExtendsFit) {
        CGSize oldSize = self.size;
        float aspectOld = oldSize.width / oldSize.height;
        float aspectNew = newSize.width / newSize.height;
        float scale = aspectOld > aspectNew ? newSize.width / oldSize.width : newSize.height / oldSize.height;
        size = CGSizeMake(oldSize.width * scale, oldSize.height * scale);
    }
    else if (scalingMode == ScalingModeAspectExtendsFill) {
        CGSize oldSize = self.size;
        float aspectOld = oldSize.width / oldSize.height;
        float aspectNew = newSize.width / newSize.height;
        float scale = aspectOld < aspectNew ? newSize.width / oldSize.width : newSize.height / oldSize.height;
        size = CGSizeMake(oldSize.width * scale, oldSize.height * scale);
        newSize = size;
    }
    rect = transpose ?
    CGRectMake((newSize.height - size.height) / 2 * mirrorH, (newSize.width - size.width) / 2 * mirrorV, size.height, size.width) :
    CGRectMake((newSize.width - size.width) / 2 * mirrorH, (newSize.height - size.height) / 2 * mirrorV, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, newSize.width, newSize.height));
    
    CGContextSetInterpolationQuality(context, quality);
    CGContextConcatCTM(context, [self transformForOrientation:self.imageOrientation size:size]);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, rect, [self CGImage]);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  压缩图片至指定像素
 */
+(UIImage *)scaleImageAtPixel:(UIImage *)image pixel:(CGFloat)pixel{
    
    CGSize size = image.size;
    if (size.width <= pixel && size.height <= pixel) {
        return  image;
    }
    
    CGFloat scale = size.width / size.height;
    
    if (size.width > size.height) {
        size.width = pixel;
        size.height = size.width / scale;
    }else{
        size.height = pixel;
        size.width = size.height * scale;
    }
    
    return [UIImage scaleImageKeepingRatio:image targetSize:size];
}
/**
 *  在指定的size里面生成一个平铺的图片
 */
+(UIImage *)titleImage:(UIImage *)image targetSize:(CGSize)targetSize{
    UIView *tempView = [[UIView alloc]init];
    
    tempView.bounds = (CGRect){CGPointZero,targetSize};
    
    tempView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIGraphicsBeginImageContext(targetSize);
    
    [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}
/**
 *  UIView转换为UIImage
 */
+(UIImage *)imageWithView:(UIView *)view{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return  image;
}
/**
 *  将两个图片生成一张图片
 */
+(UIImage *)mergeImage:(UIImage *)image otherImage:(UIImage *)otherImage{
    CGFloat width = image.size.width;
    
    CGFloat height = image.size.height;
    
    CGFloat otherWidth = otherImage.size.width;
    
    CGFloat otnerHeight = otherImage.size.height;
    
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0, 0, width, height)];
    
    [otherImage drawInRect:CGRectMake(0, 0, otherWidth, otnerHeight)];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return  img;
}
/**
 *  不变形拉伸
 */
+(UIImage *)scaleImageKeepingRatio:(UIImage *)image targetSize:(CGSize)targetSize{
    //原图和目标图片相同
    if (CGSizeEqualToSize(image.size, targetSize)) {
        return image;
    }
    
    //原图和目标尺寸不同
    CGFloat imageWidth = image.size.width;//图片宽度
    CGFloat imageHeight = image.size.height;// 图片高度
    
    //声明一个判断属性
    DiscardImageType discardType = DiscardImageUnknown;
    CGFloat targetWidth = 0.0f;
    CGFloat targetHeight = 0.0f;
    
    targetWidth = targetSize.width;//获取最终的目标宽度尺寸
    targetHeight = targetSize.height;//获取最终目标高度尺寸
    
    //先声明拉伸的系数
    CGFloat scaleFactor = 0.0f;
    CGFloat scaleWidth = 0.0f;
    CGFloat scaleHeight = 0.0f;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);//这个是图片剪切的起点位置
    
    CGFloat widthFactor = targetWidth / imageWidth;
    CGFloat heightFactor = targetHeight / imageHeight;
    
    //========分四种情况====
    //第一种 widthFactor  heightFactor 都小于1 要缩小
    //第一种 需要判断要缩小那一个尺寸
    if (widthFactor < 1 && heightFactor < 1) {
        if (widthFactor > heightFactor) {
            //右部分空白
            discardType = DiscardImageRightSide;
            scaleFactor = heightFactor;
        }//scale to fit height
        else{
            //下部分空白
            discardType = DiscardImageBottomSide;
            scaleFactor = widthFactor;//scale to fit width
        }
    }
    //第二种 宽度不够比例 高度缩小一点点
    else if(widthFactor > 1 && heightFactor < 1){
        //右边空白
        discardType = DiscardImageRightSide;
        //采用高度拉伸比例
        scaleFactor = imageWidth / targetWidth ;// scale to fit width
    }
    //第三种 高度不够比例 宽度缩小一点点
    else if (heightFactor > 1 && widthFactor < 1){
        //下边空白
        discardType = DiscardImageBottomSide;
        
        //采用高度拉伸比例
        scaleFactor = imageHeight / targetHeight;
    }
    //第四种 处理放大
    else{
        if (widthFactor > heightFactor) {
            //右部分空白
            discardType = DiscardImageRightSide;
            
            scaleFactor = heightFactor;//scale to fit height
        }else{
            //下部分空白
            discardType = DiscardImageBottomSide;
            
            scaleFactor = widthFactor;//scale to fit wdth
        }
    }
    scaleWidth = imageWidth * scaleFactor;
    scaleHeight = imageHeight * scaleFactor;
    
    switch (discardType) {
        case DiscardImageTopSide:{
            break;
        }
        case DiscardImageRightSide:{
            //右部分空白
            targetSize.width = scaleWidth;
            
            break;
        }
        case DiscardImageBottomSide:{
            
            //下部分空白
            targetSize.height = scaleHeight;
            
            break;
        }
        case DiscardImageLeftSide:{
            break;
        }
        case DiscardImageUnknown:{
            break;
        }
            
            
        default:
        {
            break;
        }
            
    }
    UIGraphicsBeginImageContext(targetSize);//开始剪切
    CGRect thunbnailRect = CGRectZero;
    thunbnailRect.origin = thumbnailPoint;
    thunbnailRect.size.width = scaleWidth;
    thunbnailRect.size.height = scaleHeight;
    [image drawInRect:thunbnailRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//截图拿到图片
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}



@end
