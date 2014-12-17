/**
 *
 *  RichText
 *  @author steven
 *  @date Dec 17 2014
 *
 **/

#import <CoreText/CoreText.h>
#import "RichText.h"

@implementation RichText

- (void)drawRect:(CGRect)rect {
    /*
    CGContextRef cxt = UIGraphicsGetCurrentContext();

    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
    CGContextConcatCTM(cxt, flipVertical);//将当前context的坐标系进行flip

    NSString *str = @"富文本测试富文本测试";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    //font
    UIFont *f = [UIFont systemFontOfSize:16];
    CTFontRef fRef = CTFontCreateWithName((CFStringRef)f.fontName, f.pointSize, nil);
    [attrStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fRef range:NSMakeRange(0, str.length)];
    //color
    [attrStr addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)[UIColor whiteColor].CGColor range:NSMakeRange(0, str.length)];
    //paragraph
    CTParagraphStyleSetting paraSetting;
    CTTextAlignment aligment = kCTTextAlignmentCenter;
    paraSetting.spec = kCTParagraphStyleSpecifierAlignment;
    paraSetting.value = &aligment;
    paraSetting.valueSize = sizeof(aligment);
    CTParagraphStyleRef paraRef = CTParagraphStyleCreate(&paraSetting, 1);
    [attrStr addAttribute:(NSString *)kCTParagraphStyleAttributeName value:(__bridge id)paraRef range:NSMakeRange(0, str.length)];
    //frame
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef) attrStr);
    CTFrameRef frame = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, str.length), path, nil);
    CTFrameDraw(frame, cxt);

    NSString *imageName = @"imageName";
    CTRunDelegateCallbacks imgCallback;
    imgCallback.version = kCTRunDelegateVersion1;
    imgCallback.dealloc = RunDelegateDeallocCallback;
    imgCallback.getAscent = RunDelegateGetAscentCallback;
    imgCallback.getDescent = RunDelegateGetDescentCallback;
    imgCallback.getWidth = RunDelegateGetWidthCallback;
    //run delegate
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imgCallback, (void *)imageName);
    NSMutableAttributedString *imageAttrStr = [[NSMutableAttributedString alloc] initWithString:@" "];
    [imageAttrStr addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    [attrStr insertAttributedString:imageAttrStr atIndex:1];
    CFRelease(runDelegate);

    //lines
    CFArrayRef lines = CTFrameGetLines(frame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = (CTLineRef)CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);

        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
        CGFloat runAscent;
        CGFloat runDescent;
        CGPoint lineOrigin = lineOrigins[i];

        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runs, j);
        NSDictionary *attributes = (NSDictionary *)CTRunGetAttributes(run);
        NSString *imageName = [attributes objectForKey:@"imageName"];
        //图片渲染逻辑
        if (imageName) {

        }

        CGRect runRect;
        runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, nil);
        runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
        }
    }

    CFRelease(frame);
    CFRelease(path);
    CFRelease(setterRef);*/
}



@end
