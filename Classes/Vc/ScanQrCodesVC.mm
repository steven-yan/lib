/**
 *
 *  ScanQrCodesVC
 *  @author steven
 *  @date June 9 2014
 *
 **/

#import "ScanQrCodesVC.h"
#import "LinkusAppDelegate.h"
#import "LinkusKit/SBJson.h"
#import "crypt_linktop.h"

@implementation ScanQrCodesVC
static int kScanWidth = 200;



#pragma mark -
#pragma mark ------------------------------窗体----------------------------------
/*------------------------------------------------------------------------------
 |  窗体
 |
 -----------------------------------------------------------------------------*/
//窗体创建
- (void)onCreate {
    //顶部面板-----------
    [self changeTopTitle:@"扫描设备"];
    [self changeTopRightBtnTitle:@"图库"];
    //内容面板-----------
    self.contentPanel.backgroundColor = [UIColor blackColor];
    //二维码扫描框------
    //背景----
    UIView *scanBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScanWidth, kScanWidth)];
    scanBg.centerX = self.contentPanel.width / 2;
    scanBg.centerY = self.contentPanel.height / 2;
    [self.contentPanel addSubview:scanBg];
    self.ctrlScanBg = scanBg;
    //4个角----
    //左上角--
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 3)];
    v.backgroundColor = self.topPanel.backgroundColor;
    [scanBg addSubview:v];
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 15)];
    v.backgroundColor = self.topPanel.backgroundColor;
    [scanBg addSubview:v];
    //右上角--
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 3)];
    v.backgroundColor = self.topPanel.backgroundColor;
    v.right = scanBg.width;
    [scanBg addSubview:v];
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 15)];
    v.backgroundColor = self.topPanel.backgroundColor;
    v.right = scanBg.width;
    [scanBg addSubview:v];
    //左下角--
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 3)];
    v.backgroundColor = self.topPanel.backgroundColor;
    v.bottom = scanBg.height;
    [scanBg addSubview:v];
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 15)];
    v.backgroundColor = self.topPanel.backgroundColor;
    v.bottom = scanBg.height;
    [scanBg addSubview:v];
    //右下角--
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 3)];
    v.backgroundColor = self.topPanel.backgroundColor;
    v.bottom = scanBg.height;
    v.right = scanBg.width;
    [scanBg addSubview:v];
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 15)];
    v.backgroundColor = self.topPanel.backgroundColor;
    v.bottom = scanBg.height;
    v.right = scanBg.width;
    [scanBg addSubview:v];
    //横线
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qrcode_scan_light_green"]];
    iv.width = scanBg.width;
    iv.hidden = YES;
    [scanBg addSubview:iv];
    self.ctrlIv = iv;
    
    //图片浏览vc
    UIImagePickerController *ic = [[UIImagePickerController alloc] init];
    ic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ic.allowsEditing = YES;
    ic.delegate = self;
    self.ctrlPickVc = ic;
    
    //提示
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
    label.text = @"请将二维码置于扫描框内\n或点击右上角'图库'选择二维码图片";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 2;
    label.font = [UIFont boldSystemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    label.bottom = self.contentPanel.height - 20;
    [self.contentPanel addSubview:label];
    self.ctrlLabel = label;
    
    //底部面板-----------
    //数据-----------
    self.setupCaptureTag = NO;
    //其他--------------
}

//解析导航进
- (void)onPraseNavToParams:(NSDictionary *)params {
}

//解析导航返回
- (void)onPraseNavBackParams:(NSDictionary *)params {
}

//窗体将要显示------
- (void)onWillShow {
}

//窗体显示
- (void)onShow {
    if (self.setupCaptureTag == NO) {
        //初始化capture
        [self setupCapture];
        self.setupCaptureTag = YES;
    }
    
    //开始扫描
    [self.captureSession startRunning];
    if (self.timer == nil) {
        //动画 timer 比 动画小0.1秒减小延时感
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.40 target:self selector:@selector(moveLine:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        self.timer = timer;
        [self.timer fire];
    }
}

//隐藏------
- (void)onWillHide {
    //停止扫描
    [self.captureSession stopRunning];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)onDidHide {
    self.ctrlIv.hidden = YES;
}

//导航栏------
- (void)topLeftBtnClicked {
    [self navBack];
}

- (void)topRightBtnClicked {
    [self presentViewController:self.ctrlPickVc animated:YES completion:nil];
}

- (void)dealloc {
}



#pragma mark -
#pragma mark ---------------AVCaptureMetadataOutputObjectsDelegate--------------
/*------------------------------------------------------------------------------
 |  AVCaptureMetadataOutputObjectsDelegate
 |
 -----------------------------------------------------------------------------*/
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    /*Lock the image buffer*/
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    /*Get information about the image*/
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    uint8_t* baseAddress = (uint8_t*)CVPixelBufferGetBaseAddress(imageBuffer);
    void* free_me = 0;
    if (true) { // iOS bug?
        uint8_t* tmp = baseAddress;
        NSUInteger bytes = bytesPerRow*height;
        free_me = baseAddress = (uint8_t*)malloc(bytes);
        baseAddress[0] = 0xdb;
        memcpy(baseAddress,tmp,bytes);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst);
    CGImageRef cgimg = CGBitmapContextCreateImage(newContext);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(newContext);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    free(free_me);
    
    UIImage* scrn = [[UIImage alloc] initWithCGImage:cgimg];
    scrn = [[UIImage alloc] initWithCGImage:scrn.CGImage
                                           scale:1.0
                                     orientation:UIImageOrientationLeft];
    CGImageRelease(cgimg);
    
    [self.ctrlDecoder decodeImage:scrn];
}

- (void)decoder:(Decoder *)decoder didDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset withResult:(TwoDDecoderResult *)result {
    NSString *str = result.text;
    if ([ChkUtil isEmptyStr:str]) {
        return;
    }
    
    [self handleScanResult:str];
}

- (void)decoder:(Decoder *)decoder failedToDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset reason:(NSString *)reason {
    if (decoder != self.ctrlDecoder) {
        [self showHudWithBottomHint:@"读取二维码信息失败"];
    }
}



#pragma mark -
#pragma mark ---------------AVCaptureMetadataOutputObjectsDelegate--------------
/*------------------------------------------------------------------------------
 |  AVCaptureMetadataOutputObjectsDelegate
 |
 -----------------------------------------------------------------------------*/
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result = [metadataObj stringValue];
        
        if ([ChkUtil isEmptyStr:result]) {
            return;
        }
        
        [self handleScanResult:result];
    }
}



#pragma mark -
#pragma mark -----------------------UIImagePickerControllerDelegate--------------------
/*-------------------------------------------------------------------------------------
 |  UIImagePickerControllerDelegate
 |
 -------------------------------------------------------------------------------------*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSLog(@"UIImagePickerControllerEditedImage size = %f*%f", image.size.width, image.size.height);
    
    [picker dismissViewControllerAnimated:YES completion:^{
        Decoder* decoder = [[Decoder alloc] init];
        QRCodeReader *reader = [[QRCodeReader alloc] init];
        NSSet *readers = [[NSSet alloc] initWithObjects:reader, nil];
        decoder.readers = readers;
        decoder.delegate = self;
        [decoder decodeImage:[[UIImage alloc] initWithCGImage:image.CGImage
                                                                 scale:1.0
                                                           orientation:UIImageOrientationLeft]];
    }];
}



#pragma mark -
#pragma mark -------------------------------其他---------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)moveLine:(NSTimer *)timer {
    self.ctrlIv.hidden = NO;
    self.ctrlIv.centerY = 0;
    [UIView animateWithDuration:1.5 animations:^{
        self.ctrlIv.centerY = self.ctrlScanBg.height;
    }];
}

- (void)setupCapture {
    //设置decoder (图片读取都用zxing)
    Decoder* decoder = [[Decoder alloc] init];
    QRCodeReader *reader = [[QRCodeReader alloc] init];
    NSSet *readers = [[NSSet alloc] initWithObjects:reader, nil];
    decoder.readers = readers;
    decoder.delegate = self;
    self.ctrlDecoder = decoder;
    
    //session
    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
    captureSession.sessionPreset = AVCaptureSessionPresetMedium;
    self.captureSession = captureSession;
    //dev
    AVCaptureDevice *capDev = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //添加input
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:capDev error:nil];
    if (!input) {
        return;
    }
    [captureSession addInput:input];
    
    if (SysInfo.instance.isIos6Tag) {     //ios6 使用zxing
        //output
        AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
		captureOutput.alwaysDiscardsLateVideoFrames = YES;
		[captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
		NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
		NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
		NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
		[captureOutput setVideoSettings:videoSettings];
		[captureSession addOutput:captureOutput];
    } else {                             //ios7以上用apple自带二维码扫描 效率更高
        //output
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [captureSession addOutput:output];
        //设置类型
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    }
    
    //添加layer
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    layer.frame = self.contentPanel.bounds;
    [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //添加蒙版
    CALayer *layer1 = [[CALayer alloc] init];
    layer1.frame = CGRectMake(0, 0, self.contentPanel.width, self.ctrlScanBg.top);
    layer1.opacity = 0.3;
    layer1.backgroundColor = [UIColor blackColor].CGColor;
    [layer addSublayer:layer1];
    CALayer *layer2 = [[CALayer alloc] init];
    layer2.frame = CGRectMake(0, self.ctrlScanBg.bottom, self.contentPanel.width, self.ctrlScanBg.top);
    layer2.opacity = 0.3;
    layer2.backgroundColor = [UIColor blackColor].CGColor;
    [layer addSublayer:layer2];
    CALayer *layer3 = [[CALayer alloc] init];
    layer3.frame = CGRectMake(0, self.ctrlScanBg.top, self.ctrlScanBg.left, self.ctrlScanBg.height);
    layer3.opacity = 0.3;
    layer3.backgroundColor = [UIColor blackColor].CGColor;
    [layer addSublayer:layer3];
    CALayer *layer4 = [[CALayer alloc] init];
    layer4.frame = CGRectMake(self.ctrlScanBg.right, self.ctrlScanBg.top, self.ctrlScanBg.left, self.ctrlScanBg.height);
    layer4.opacity = 0.3;
    layer4.backgroundColor = [UIColor blackColor].CGColor;
    [layer addSublayer:layer4];
    
    [self.contentPanel.layer insertSublayer:layer below:self.ctrlScanBg.layer];
}

- (void)handleScanResult:(NSString *)scanResult {    
	NSData* des = [[scanResult dataUsingEncoding:NSUTF8StringEncoding] linkus_base64Decoded];
	if (des && [des length] != 0) {
		NSData* data = [des linkus_desDecodedWithKey:ENCRYPT_KEY_BARCODE];
		if (data && [data length] != 0) {
			NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			if (result && [result length] != 0) {
				//{"devjid":"9889@linktop.com", "devuuid":"9889", "devpass":"123456"}
				NSLog(@"Barcode scan result =  %@", result);
				NSDictionary* dic = [[[SBJsonParser alloc]init] objectWithString:result];
                if (dic) {
                    //页面返回
                    [self navBackWithParams:[NSMutableDictionary dictionaryWithObjects:@[NSStringFromClass([self class]), dic] forKeys:@[@"fromPage", @"qrDecodeInfo"]]];
                } else {
                    [self showHudWithBottomHint:@"二维码格式不正确"];
                }
			}
		} else {
            [self showHudWithBottomHint:@"二维码格式不正确"];
        }
	} else {
        [self showHudWithBottomHint:@"二维码格式不正确"];
    }
}



@end
