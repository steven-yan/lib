/**
 *
 *  ScanQrCodesVC
 *  @author steven
 *  @date June 9 2014
 *
 **/

#import "BaseVC.h"
#import "Decoder.h"
#import "TwoDDecoderResult.h"
#import "QRCodeReader.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>

@interface ScanQrCodesVC : BaseVC <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate, DecoderDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//scanBg
@property (nonatomic, strong) UIView *ctrlScanBg;
//session
@property (nonatomic, strong) AVCaptureSession *captureSession;
//scan
@property (nonatomic, strong) UIImageView  *ctrlIv;
//iv
@property (nonatomic, strong) UIImagePickerController *ctrlPickVc;
//label
@property (nonatomic, strong) UILabel *ctrlLabel;

//timer
@property (weak) NSTimer *timer;
@property (nonatomic, strong) Decoder *ctrlDecoder;

//capture Tag
@property (nonatomic) BOOL setupCaptureTag;



@end
