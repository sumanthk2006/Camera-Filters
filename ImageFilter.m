//
//  ImageFilter.m
//  Camera-Filters
//
//  Created by A1Brains Infotech on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageFilter.h"

@interface ImageFilter ()

@end

@implementation ImageFilter
@synthesize imageView = _imageView;
@synthesize glImageView;
@synthesize tileController;

@synthesize filterSettingsSlider = _filterSettingsSlider;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)imageFilter:(UIImage*)image{
    _imageView = image;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    glImageView = [[GPUImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:glImageView];
    [self addButtonsToView];
//    [self setUpMenu];
    [self setupDisplayFiltering:GPUIMAGE_SEPIA];
//    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//	doubleTapRecognizer.numberOfTapsRequired = 2;
//	doubleTapRecognizer.delegate = self;
//	[glImageView addGestureRecognizer:doubleTapRecognizer];
//	
//	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//	tapRecognizer.delegate = self;
//	[glImageView addGestureRecognizer:tapRecognizer];
    
}
-(void)setUpMenu{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed 
                                                               ContentImage:starImage 
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed 
                                                               ContentImage:starImage 
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed 
                                                               ContentImage:starImage 
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed 
                                                               ContentImage:starImage 
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed 
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem6 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed 
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem7 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed 
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem8 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed 
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem9 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed 
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, starMenuItem6, starMenuItem7,starMenuItem8,starMenuItem9, nil];
        AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.glImageView.frame menus:menus];
    menu.delegate = self;
    [self.glImageView addSubview:menu];
}
- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx{
    NSLog(@"Select the index : %d",idx);
    filter = nil;
    [sourcePicture removeTarget:filter];
    sourcePicture = nil;
        switch (idx) {
            case 0:
                [self setupDisplayFiltering:GPUIMAGE_SKETCH];
                break;
            case 1:
                [self setupDisplayFiltering:GPUIMAGE_POLARPIXELLATE];                
                break;
            case 2:
                [self setupDisplayFiltering:GPUIMAGE_SMOOTHTOON];
                break;
            case 3:
                [self setupDisplayFiltering:GPUIMAGE_BULGE];
                break;
            case 4:
                [self setupDisplayFiltering:GPUIMAGE_SWIRL];
                break;
            case 5:
                [self setupDisplayFiltering:GPUIMAGE_STRETCH];
                break;
            case 6:
                [self setupDisplayFiltering:GPUIMAGE_EROSION];
                break;
            case 7:
                [self setupDisplayFiltering:GPUIMAGE_GAUSSIAN_SELECTIVE];
                break;
            case 8:
                [self setupDisplayFiltering:GPUIMAGE_NOBLECORNERDETECTION];
                break;
            default:
                break;
    }
}
- (void)setupDisplayFiltering:(GPUImageShowcaseFilterType)value;
{
    @autoreleasepool {
        

    sourcePicture = [[GPUImagePicture alloc] initWithImage:[self scaleAndRotateImage:_imageView] smoothlyScaleOutput:YES];
    selectFilterValue = value;
    glImageView = (GPUImageView *)glImageView;

    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] init];
        BOOL needsSecondImage = NO;
    
        switch (value)
        {
            case GPUIMAGE_SEPIA:
            {
                self.title = @"Sepia Tone";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setValue:1.0];
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                
                filter = [[GPUImageSepiaFilter alloc] init];
            [pinch addTarget:self action:@selector(handlePinch:)];
            [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_PIXELLATE:
            {
                self.title = @"Pixellate";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setValue:0.05];
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.3];
                
                filter = [[GPUImagePixellateFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_POLARPIXELLATE:
            {
                self.title = @"Polar Pixellate";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setValue:0.05];
                [self.filterSettingsSlider setMinimumValue:-0.1];
                [self.filterSettingsSlider setMaximumValue:0.1];
                
                filter = [[GPUImagePolarPixellateFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_CROSSHATCH:
            {
                self.title = @"Crosshatch";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setValue:0.03];
                [self.filterSettingsSlider setMinimumValue:0.01];
                [self.filterSettingsSlider setMaximumValue:0.06];
                
                filter = [[GPUImageCrosshatchFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_COLORINVERT:
            {
                self.title = @"Color Invert";
                self.filterSettingsSlider.hidden = YES;
                
                filter = [[GPUImageColorInvertFilter alloc] init];
            }; break;
            case GPUIMAGE_GRAYSCALE:
            {
                self.title = @"Grayscale";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageGrayscaleFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_MONOCHROME:
            {
                self.title = @"Monochrome";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setValue:1.0];
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                
                filter = [[GPUImageMonochromeFilter alloc] init];
                [(GPUImageMonochromeFilter *)filter setColor:(GPUVector4){0.0f, 0.0f, 1.0f, 1.f}];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_SATURATION:
            {
                self.title = @"Saturation";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setValue:1.0];
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:2.0];
                
                filter = [[GPUImageSaturationFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_CONTRAST:
            {
                self.title = @"Contrast";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:4.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageContrastFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_BRIGHTNESS:
            {
                self.title = @"Brightness";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:-1.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:0.0];
                
                filter = [[GPUImageBrightnessFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_RGB:
            {
                self.title = @"RGB";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:2.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageRGBFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_EXPOSURE:
            {
                self.title = @"Exposure";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:-4.0];
                [self.filterSettingsSlider setMaximumValue:4.0];
                [self.filterSettingsSlider setValue:0.0];
                
                filter = [[GPUImageExposureFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_SHARPEN:
            {
                self.title = @"Sharpen";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:-1.0];
                [self.filterSettingsSlider setMaximumValue:4.0];
                [self.filterSettingsSlider setValue:0.0];
                
                filter = [[GPUImageSharpenFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_UNSHARPMASK:
            {
                self.title = @"Unsharp Mask";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:5.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageUnsharpMaskFilter alloc] init];
                
                //            [(GPUImageUnsharpMaskFilter *)filter setIntensity:3.0];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_GAMMA:
            {
                self.title = @"Gamma";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:3.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageGammaFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_TONECURVE:
            {
                self.title = @"Tone curve";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:0.5];
                
                filter = [[GPUImageToneCurveFilter alloc] init];
                [(GPUImageToneCurveFilter *)filter setBlueControlPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)], [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)], [NSValue valueWithCGPoint:CGPointMake(1.0, 0.75)], nil]];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_HAZE:
            {
                self.title = @"Haze / UV";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:-0.2];
                [self.filterSettingsSlider setMaximumValue:0.2];
                [self.filterSettingsSlider setValue:0.2];
                
                filter = [[GPUImageHazeFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_HISTOGRAM:
            {
                self.title = @"Histogram";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:4.0];
                [self.filterSettingsSlider setMaximumValue:32.0];
                [self.filterSettingsSlider setValue:16.0];
                
                filter = [[GPUImageHistogramFilter alloc] initWithHistogramType:kGPUImageHistogramRGB];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_THRESHOLD:
            {
                self.title = @"Luminance Threshold";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:0.5];
                
                filter = [[GPUImageLuminanceThresholdFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_ADAPTIVETHRESHOLD:
            {
                self.title = @"Adaptive Threshold";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:1.0];
                [self.filterSettingsSlider setMaximumValue:20.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageAdaptiveThresholdFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_CROP:
            {
                self.title = @"Crop";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.2];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:0.5];
                
                filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.25)];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_MASK:
            {
                self.title = @"Mask";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                needsSecondImage = YES;	
                
                filter = [[GPUImageMaskFilter alloc] init];
                
                [(GPUImageFilter*)filter setBackgroundColorRed:0.0 green:1.0 blue:0.0 alpha:1.0];
            }; break;
            case GPUIMAGE_TRANSFORM:
            {
                self.title = @"Transform (2-D)";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:6.28];
                [self.filterSettingsSlider setValue:2.0];
                
                filter = [[GPUImageTransformFilter alloc] init];
                [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(2.0)];
                //            [(GPUImageTransformFilter *)filter setIgnoreAspectRatio:YES];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_TRANSFORM3D:
            {
                self.title = @"Transform (3-D)";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:6.28];
                [self.filterSettingsSlider setValue:0.75];
                
                filter = [[GPUImageTransformFilter alloc] init];
                CATransform3D perspectiveTransform = CATransform3DIdentity;
                perspectiveTransform.m34 = 0.4;
                perspectiveTransform.m33 = 0.4;
                perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
                perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.75, 0.0, 1.0, 0.0);
                
                [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_SOBELEDGEDETECTION:
            {
                self.title = @"Sobel Edge Detection";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_XYGRADIENT:
            {
                self.title = @"XY Derivative";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageXYDerivativeFilter alloc] init];
                
            }; break;
            case GPUIMAGE_HARRISCORNERDETECTION:
            {
                self.title = @"Harris Corner Detection";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.01];
                [self.filterSettingsSlider setMaximumValue:0.70];
                [self.filterSettingsSlider setValue:0.20];
                
                filter = [[GPUImageHarrisCornerDetectionFilter alloc] init];
                [(GPUImageHarrisCornerDetectionFilter *)filter setThreshold:0.20];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_NOBLECORNERDETECTION:
            {
                self.title = @"Noble Corner Detection";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.01];
                [self.filterSettingsSlider setMaximumValue:0.70];
                [self.filterSettingsSlider setValue:0.20];
                
                filter = [[GPUImageNobleCornerDetectionFilter alloc] init];
                [(GPUImageNobleCornerDetectionFilter *)filter setThreshold:0.20];            
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_SHITOMASIFEATUREDETECTION:
            {
                self.title = @"Shi-Tomasi Feature Detection";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.01];
                [self.filterSettingsSlider setMaximumValue:0.70];
                [self.filterSettingsSlider setValue:0.20];
                
                filter = [[GPUImageShiTomasiFeatureDetectionFilter alloc] init];
                [(GPUImageShiTomasiFeatureDetectionFilter *)filter setThreshold:0.20];            
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_PREWITTEDGEDETECTION:
            {
                self.title = @"Prewitt Edge Detection";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImagePrewittEdgeDetectionFilter alloc] init];
            }; break;
            case GPUIMAGE_CANNYEDGEDETECTION:
            {
                self.title = @"Canny Edge Detection";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:1.0];
                
                //            [self.filterSettingsSlider setMinimumValue:0.0];
                //            [self.filterSettingsSlider setMaximumValue:0.5];
                //            [self.filterSettingsSlider setValue:0.1];
                
                filter = [[GPUImageCannyEdgeDetectionFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_BUFFER:
            {
                self.title = @"Image Buffer";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageBuffer alloc] init];
            }; break;
            case GPUIMAGE_SKETCH:
            {
                self.title = @"Sketch";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageSketchFilter alloc] init];
            }; break;
            case GPUIMAGE_TOON:
            {
                self.title = @"Toon";
                self.filterSettingsSlider.hidden = YES;
                
                filter = [[GPUImageToonFilter alloc] init];
            }; break;            
            case GPUIMAGE_SMOOTHTOON:
            {
                self.title = @"Smooth Toon";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:0.5];
                
                filter = [[GPUImageSmoothToonFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;            
            case GPUIMAGE_TILTSHIFT:
            {
                self.title = @"Tilt Shift";
                self.filterSettingsSlider.hidden  = YES;
                [self.filterSettingsSlider setMinimumValue:0.2];
                [self.filterSettingsSlider setMaximumValue:0.8];
                [self.filterSettingsSlider setValue:0.5];
                
                filter = [[GPUImageTiltShiftFilter alloc] init];
                [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.4];
                [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.6];
                [(GPUImageTiltShiftFilter *)filter setFocusFallOffRate:0.2];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_CGA:
            {
                self.title = @"CGA Colorspace";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageCGAColorspaceFilter alloc] init];
            }; break;
            case GPUIMAGE_CONVOLUTION:
            {
                self.title = @"3x3 Convolution";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImage3x3ConvolutionFilter alloc] init];
                //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
                //                {-2.0f, -1.0f, 0.0f},
                //                {-1.0f,  1.0f, 1.0f},
                //                { 0.0f,  1.0f, 2.0f}
                //            }];
                [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
                    {-1.0f,  0.0f, 1.0f},
                    {-2.0f, 0.0f, 2.0f},
                    {-1.0f,  0.0f, 1.0f}
                }];
                
                //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
                //                {1.0f,  1.0f, 1.0f},
                //                {1.0f, -8.0f, 1.0f},
                //                {1.0f,  1.0f, 1.0f}
                //            }];
                //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
                //                { 0.11f,  0.11f, 0.11f},
                //                { 0.11f,  0.11f, 0.11f},
                //                { 0.11f,  0.11f, 0.11f}
                //            }];
            }; break;
            case GPUIMAGE_EMBOSS:
            {
                self.title = @"Emboss";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:5.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageEmbossFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_POSTERIZE:
            {
                self.title = @"Posterize";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:1.0];
                [self.filterSettingsSlider setMaximumValue:20.0];
                [self.filterSettingsSlider setValue:10.0];
                
                filter = [[GPUImagePosterizeFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_SWIRL:
            {
                self.title = @"Swirl";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:2.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageSwirlFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_BULGE:
            {
                self.title = @"Bulge";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:-1.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:0.5];
                
                filter = [[GPUImageBulgeDistortionFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_SPHEREREFRACTION:
            {
                self.title = @"Sphere Refraction";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:0.5];
                
                filter = [[GPUImageSphereRefractionFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_PINCH:
            {
                self.title = @"Pinch";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:-2.0];
                [self.filterSettingsSlider setMaximumValue:2.0];
                [self.filterSettingsSlider setValue:0.5];
                
                filter = [[GPUImagePinchDistortionFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_STRETCH:
            {
                self.title = @"Stretch";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageStretchDistortionFilter alloc] init];
            }; break;
            case GPUIMAGE_DILATION:
            {
                self.title = @"Dilation";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageRGBDilationFilter alloc] initWithRadius:4];
            }; break;
            case GPUIMAGE_EROSION:
            {
                self.title = @"Erosion";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageRGBErosionFilter alloc] initWithRadius:4];
            }; break;
            case GPUIMAGE_OPENING:
            {
                self.title = @"Opening";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageRGBOpeningFilter alloc] initWithRadius:4];
            }; break;
            case GPUIMAGE_CLOSING:
            {
                self.title = @"Closing";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageRGBClosingFilter alloc] initWithRadius:4];
            }; break;
                
            case GPUIMAGE_PERLINNOISE:
            {
                self.title = @"Perlin Noise";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:1.0];
                [self.filterSettingsSlider setMaximumValue:30.0];
                [self.filterSettingsSlider setValue:8.0];
                
                filter = [[GPUImagePerlinNoiseFilter alloc] init];
                
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_VORONI: 
            {
                self.title = @"Voroni";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                GPUImageJFAVoroniFilter *jfa = [[GPUImageJFAVoroniFilter alloc] init];
                [jfa setSizeInPixels:CGSizeMake(1024.0, 1024.0)];
                
                sourcePicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"voroni_points2.png"]];
                
                [sourcePicture addTarget:jfa];
                
                filter = [[GPUImageVoroniConsumerFilter alloc] init];
                
                [jfa setSizeInPixels:CGSizeMake(1024.0, 1024.0)];
                [(GPUImageVoroniConsumerFilter *)filter setSizeInPixels:CGSizeMake(1024.0, 1024.0)];
                
                [sourcePicture addTarget:filter];
                [jfa addTarget:filter];
                [sourcePicture processImage];
            }; break;
            case GPUIMAGE_MOSAIC:
            {
                self.title = @"Mosaic";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.002];
                [self.filterSettingsSlider setMaximumValue:0.05];
                [self.filterSettingsSlider setValue:0.025];
                
                filter = [[GPUImageMosaicFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
                [(GPUImageMosaicFilter *)filter setTileSet:@"squares.png"];
                [(GPUImageMosaicFilter *)filter setColorOn:NO];
                //[(GPUImageMosaicFilter *)filter setTileSet:@"dotletterstiles.png"];
                //[(GPUImageMosaicFilter *)filter setTileSet:@"curvies.png"]; 
                
                [filter setInputRotation:kGPUImageRotateRight atIndex:0];
                
            }; break;
            case GPUIMAGE_CHROMAKEY:
            {
                self.title = @"Chroma Key (Green)";
                self.filterSettingsSlider.hidden  = YES;
                needsSecondImage = YES;	
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:0.4];
                
                filter = [[GPUImageChromaKeyBlendFilter alloc] init];
                [(GPUImageChromaKeyBlendFilter *)filter setColorToReplaceRed:0.0 green:1.0 blue:0.0];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_MULTIPLY:
            {
                self.title = @"Multiply Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                
                filter = [[GPUImageMultiplyBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_OVERLAY:
            {
                self.title = @"Overlay Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                
                filter = [[GPUImageOverlayBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_LIGHTEN:
            {
                self.title = @"Lighten Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageLightenBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_DARKEN:
            {
                self.title = @"Darken Blend";
                self.filterSettingsSlider.hidden = YES;
                
                needsSecondImage = YES;	
                filter = [[GPUImageDarkenBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_DISSOLVE:
            {
                self.title = @"Dissolve Blend";
                self.filterSettingsSlider.hidden  = YES;
                needsSecondImage = YES;	
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:1.0];
                [self.filterSettingsSlider setValue:0.5];
                
                filter = [[GPUImageDissolveBlendFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_SCREENBLEND:
            {
                self.title = @"Screen Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageScreenBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_COLORBURN:
            {
                self.title = @"Color Burn Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageColorBurnBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_COLORDODGE:
            {
                self.title = @"Color Dodge Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageColorDodgeBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_EXCLUSIONBLEND:
            {
                self.title = @"Exclusion Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageExclusionBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_DIFFERENCEBLEND:
            {
                self.title = @"Difference Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageDifferenceBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_SUBTRACTBLEND:
            {
                self.title = @"Subtract Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageSubtractBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_HARDLIGHTBLEND:
            {
                self.title = @"Hard Light Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageHardLightBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_SOFTLIGHTBLEND:
            {
                self.title = @"Soft Light Blend";
                self.filterSettingsSlider.hidden = YES;
                needsSecondImage = YES;	
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageSoftLightBlendFilter alloc] init];
            }; break;
            case GPUIMAGE_CUSTOM:
            {
                self.title = @"Custom";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"CustomFilter"];
            }; break;
            case GPUIMAGE_KUWAHARA:
            {
                self.title = @"Kuwahara";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:3.0];
                [self.filterSettingsSlider setMaximumValue:8.0];
                [self.filterSettingsSlider setValue:3.0];
                
                filter = [[GPUImageKuwaharaFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
                
            case GPUIMAGE_VIGNETTE:
            {
                self.title = @"Vignette";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.5];
                [self.filterSettingsSlider setMaximumValue:0.9];
                [self.filterSettingsSlider setValue:0.75];
                
                filter = [[GPUImageVignetteFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_GAUSSIAN:
            {
                self.title = @"Gaussian Blur";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:10.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageGaussianBlurFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_FASTBLUR:
            {
                self.title = @"Fast Blur";
                self.filterSettingsSlider.hidden  = YES;
                [self.filterSettingsSlider setMinimumValue:1.0];
                [self.filterSettingsSlider setMaximumValue:10.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageFastBlurFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_BOXBLUR:
            {
                self.title = @"Box Blur";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageBoxBlurFilter alloc] init];
            }; break;
            case GPUIMAGE_MEDIAN:
            {
                self.title = @"Median";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageMedianFilter alloc] init];
            }; break;
            case GPUIMAGE_UIELEMENT:
            {
                self.title = @"UI Element";
                self.filterSettingsSlider.hidden = YES;
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.0];
                filter = [[GPUImageSepiaFilter alloc] init];
            }; break;
            case GPUIMAGE_GAUSSIAN_SELECTIVE:
            {
                self.title = @"Selective Blur";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:.75f];
                [self.filterSettingsSlider setValue:40.0/320.0];
                
                filter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
                [(GPUImageGaussianSelectiveBlurFilter*)filter setExcludeCircleRadius:40.0/320.0];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_BILATERAL:
            {
                self.title = @"Bilateral Blur";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:10.0];
                [self.filterSettingsSlider setValue:1.0];
                
                filter = [[GPUImageBilateralFilter alloc] init];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
            case GPUIMAGE_FILTERGROUP:
            {
                self.title = @"Filter Group";
                self.filterSettingsSlider.hidden  = YES;
                
                [self.filterSettingsSlider setValue:0.05];
                [self.filterSettingsSlider setMinimumValue:0.0];
                [self.filterSettingsSlider setMaximumValue:0.3];
                
                filter = [[GPUImageFilterGroup alloc] init];
                
                GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
                [(GPUImageFilterGroup *)filter addFilter:sepiaFilter];
                
                GPUImagePixellateFilter *pixellateFilter = [[GPUImagePixellateFilter alloc] init];
                [(GPUImageFilterGroup *)filter addFilter:pixellateFilter];
                
                [sepiaFilter addTarget:pixellateFilter];
                [(GPUImageFilterGroup *)filter setInitialFilters:[NSArray arrayWithObject:sepiaFilter]];
                [(GPUImageFilterGroup *)filter setTerminalFilter:pixellateFilter];
                [pinch addTarget:self action:@selector(handlePinch:)];
                [glImageView addGestureRecognizer:pinch];
            }; break;
                
            default: filter = [[GPUImageSepiaFilter alloc] init]; break;
        }
        
        if (value == GPUIMAGE_FILECONFIG) 
        {
            self.title = @"File Configuration";
            pipeline = [[GPUImageFilterPipeline alloc] initWithConfigurationFile:[[NSBundle mainBundle] URLForResource:@"SampleConfiguration" withExtension:@"plist"]
                                                                           input:sourcePicture output:(GPUImageView*)self.view];
            
//        [pipeline addFilter:rotationFilter atIndex:0];
        } 
        else 
        {
            
            if (value != GPUIMAGE_VORONI) 
            {
                [sourcePicture addTarget:filter];
            }
            
            GPUImageView *filterView = (GPUImageView *)glImageView;
            
            if (needsSecondImage)
            {
                UIImage *inputImage;
                
                if (value == GPUIMAGE_MASK) 
                {
                    inputImage = [UIImage imageNamed:@"mask"];
                }
                /*
                 else if (filterType == GPUIMAGE_VORONI) {
                 inputImage = [UIImage imageNamed:@"voroni_points.png"];
                 }*/
                else {
                    // The picture is only used for two-image blend filters
                    inputImage = [UIImage imageNamed:@"WID-small.jpg"];
                }
                
                sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
                [sourcePicture processImage];            
                [sourcePicture addTarget:filter];
            }
            
            
            if (value == GPUIMAGE_HISTOGRAM)
            {
                // I'm adding an intermediary filter because glReadPixels() requires something to be rendered for its glReadPixels() operation to work
                [sourcePicture removeTarget:filter];
                GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc] init];
                [sourcePicture addTarget:gammaFilter];
                [gammaFilter addTarget:filter];
                
                GPUImageHistogramGenerator *histogramGraph = [[GPUImageHistogramGenerator alloc] init];
                
                [histogramGraph forceProcessingAtSize:CGSizeMake(256.0, 330.0)];
                [filter addTarget:histogramGraph];
                
                GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
                blendFilter.mix = 0.75;            
                [blendFilter forceProcessingAtSize:CGSizeMake(256.0, 330.0)];
                
                [sourcePicture addTarget:blendFilter];
                [histogramGraph addTarget:blendFilter];
                sourcePicture.targetToIgnoreForUpdates = blendFilter; // Avoid double-updating the blend
                
                [blendFilter addTarget:filterView];
            }
            else if ( (value == GPUIMAGE_HARRISCORNERDETECTION) || (value == GPUIMAGE_NOBLECORNERDETECTION) || (value == GPUIMAGE_SHITOMASIFEATUREDETECTION) )
            {
                GPUImageCrosshairGenerator *crosshairGenerator = [[GPUImageCrosshairGenerator alloc] init];
                crosshairGenerator.crosshairWidth = 15.0;
                [crosshairGenerator forceProcessingAtSize:CGSizeMake(480.0, 640.0)];
                
                [(GPUImageHarrisCornerDetectionFilter *)filter setCornersDetectedBlock:^(GLfloat* cornerArray, NSUInteger cornersDetected, CMTime frameTime) {
                    [crosshairGenerator renderCrosshairsFromArray:cornerArray count:cornersDetected frameTime:frameTime];
                }];
                
                GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
                [blendFilter forceProcessingAtSize:CGSizeMake(480.0, 640.0)];
                GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc] init];
                [sourcePicture addTarget:gammaFilter];
                [gammaFilter addTarget:blendFilter];
                gammaFilter.targetToIgnoreForUpdates = blendFilter;
                
                [crosshairGenerator addTarget:blendFilter];
                
                [blendFilter addTarget:filterView];
            }
            else if (value == GPUIMAGE_UIELEMENT)
            {
                GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
                blendFilter.mix = 1.0;
                
                NSDate *startTime = [NSDate date];
                
                UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 240.0f, 320.0f)];
                timeLabel.font = [UIFont systemFontOfSize:17.0f];
                timeLabel.text = @"Time: 0.0 s";
                timeLabel.textAlignment = UITextAlignmentCenter;
                timeLabel.backgroundColor = [UIColor clearColor];
                timeLabel.textColor = [UIColor whiteColor];
                
                uiElementInput = [[GPUImageUIElement alloc] initWithView:timeLabel];
                
                [filter addTarget:blendFilter];
                [uiElementInput addTarget:blendFilter];
                
                [blendFilter addTarget:filterView];
                
                uiElementInput.targetToIgnoreForUpdates = blendFilter;
                
                __unsafe_unretained GPUImageUIElement *weakUIElementInput = uiElementInput;
                
                [filter setFrameProcessingCompletionBlock:^(GPUImageOutput * filter, CMTime frameTime){
                    timeLabel.text = [NSString stringWithFormat:@"Time: %f s", -[startTime timeIntervalSinceNow]];
                    [weakUIElementInput update];
                }];
            }
            else if (value == GPUIMAGE_BUFFER)
            {
                
                GPUImageDifferenceBlendFilter *blendFilter = [[GPUImageDifferenceBlendFilter alloc] init];
                [blendFilter forceProcessingAtSize:CGSizeMake(480.0, 640.0)];
                
                //            [filter addTarget:filterView];            
//                [sourcePicture removeTarget:filter];
                
                GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc] init];
                [sourcePicture addTarget:gammaFilter];
                [gammaFilter addTarget:blendFilter];
                gammaFilter.targetToIgnoreForUpdates = blendFilter;
                [sourcePicture addTarget:filter];
                
                [filter addTarget:blendFilter];
                
                [blendFilter addTarget:filterView];
            }
            else 
            {
                [filter addTarget:filterView];
                
            }
        } 
        gestureValue = self.filterSettingsSlider.value;
    NSLog(@"%f , %f",self.filterSettingsSlider.maximumValue,self.filterSettingsSlider.minimumValue);
    
    gestureIncrementValue = (self.filterSettingsSlider.maximumValue-self.filterSettingsSlider.minimumValue)/50;
        [sourcePicture processImage];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)setIntensityOfFilter:(float)intensity{
    switch(selectFilterValue)
    {
        case GPUIMAGE_SEPIA: [(GPUImageSepiaFilter *)filter setIntensity:intensity]; break;
        case GPUIMAGE_PIXELLATE: [(GPUImagePixellateFilter *)filter setFractionalWidthOfAPixel:intensity]; break;
        case GPUIMAGE_POLARPIXELLATE: [(GPUImagePolarPixellateFilter *)filter setPixelSize:CGSizeMake(intensity, intensity)]; break;
        case GPUIMAGE_SATURATION: [(GPUImageSaturationFilter *)filter setSaturation:intensity]; break;
        case GPUIMAGE_CONTRAST: [(GPUImageContrastFilter *)filter setContrast:intensity]; break;
        case GPUIMAGE_BRIGHTNESS: [(GPUImageBrightnessFilter *)filter setBrightness:intensity]; break;
        case GPUIMAGE_EXPOSURE: [(GPUImageExposureFilter *)filter setExposure:intensity]; break;
        case GPUIMAGE_MONOCHROME: [(GPUImageMonochromeFilter *)filter setIntensity:intensity]; break;
        case GPUIMAGE_RGB: [(GPUImageRGBFilter *)filter setGreen:intensity]; break;
        case GPUIMAGE_SHARPEN: [(GPUImageSharpenFilter *)filter setSharpness:intensity]; break;
        case GPUIMAGE_HISTOGRAM: [(GPUImageHistogramFilter *)filter setDownsamplingFactor:round(intensity)]; break;
        case GPUIMAGE_UNSHARPMASK: [(GPUImageUnsharpMaskFilter *)filter setIntensity:intensity]; break;
            //        case GPUIMAGE_UNSHARPMASK: [(GPUImageUnsharpMaskFilter *)filter setBlurSize:intensity]; break;
        case GPUIMAGE_GAMMA: [(GPUImageGammaFilter *)filter setGamma:intensity]; break;
        case GPUIMAGE_CROSSHATCH: [(GPUImageCrosshatchFilter *)filter setCrossHatchSpacing:intensity]; break;
        case GPUIMAGE_POSTERIZE: [(GPUImagePosterizeFilter *)filter setColorLevels:round(intensity)]; break;
		case GPUIMAGE_HAZE: [(GPUImageHazeFilter *)filter setDistance:intensity]; break;
		case GPUIMAGE_THRESHOLD: [(GPUImageLuminanceThresholdFilter *)filter setThreshold:intensity]; break;
        case GPUIMAGE_ADAPTIVETHRESHOLD: [(GPUImageAdaptiveThresholdFilter *)filter setBlurSize:intensity]; break;
        case GPUIMAGE_DISSOLVE: [(GPUImageDissolveBlendFilter *)filter setMix:intensity]; break;
        case GPUIMAGE_CHROMAKEY: [(GPUImageChromaKeyBlendFilter *)filter setThresholdSensitivity:intensity]; break;
        case GPUIMAGE_KUWAHARA: [(GPUImageKuwaharaFilter *)filter setRadius:round(intensity)]; break;
        case GPUIMAGE_SWIRL: [(GPUImageSwirlFilter *)filter setAngle:intensity]; break;
        case GPUIMAGE_EMBOSS: [(GPUImageEmbossFilter *)filter setIntensity:intensity]; break;
        case GPUIMAGE_CANNYEDGEDETECTION: [(GPUImageCannyEdgeDetectionFilter *)filter setBlurSize:intensity]; break;
            //        case GPUIMAGE_CANNYEDGEDETECTION: [(GPUImageCannyEdgeDetectionFilter *)filter setLowerThreshold:intensity]; break;
        case GPUIMAGE_HARRISCORNERDETECTION: [(GPUImageHarrisCornerDetectionFilter *)filter setThreshold:intensity]; break;
        case GPUIMAGE_NOBLECORNERDETECTION: [(GPUImageNobleCornerDetectionFilter *)filter setThreshold:intensity]; break;
        case GPUIMAGE_SHITOMASIFEATUREDETECTION: [(GPUImageShiTomasiFeatureDetectionFilter *)filter setThreshold:intensity]; break;
            //        case GPUIMAGE_HARRISCORNERDETECTION: [(GPUImageHarrisCornerDetectionFilter *)filter setSensitivity:intensity]; break;
        case GPUIMAGE_SMOOTHTOON: [(GPUImageSmoothToonFilter *)filter setBlurSize:intensity]; break;
            //        case GPUIMAGE_BULGE: [(GPUImageBulgeDistortionFilter *)filter setRadius:intensity]; break;
        case GPUIMAGE_BULGE: [(GPUImageBulgeDistortionFilter *)filter setScale:intensity]; break;
        case GPUIMAGE_SPHEREREFRACTION: [(GPUImageSphereRefractionFilter *)filter setRadius:intensity]; break;
        case GPUIMAGE_TONECURVE: [(GPUImageToneCurveFilter *)filter setBlueControlPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)], [NSValue valueWithCGPoint:CGPointMake(0.5, intensity)], [NSValue valueWithCGPoint:CGPointMake(1.0, 0.75)], nil]]; break;
        case GPUIMAGE_PINCH: [(GPUImagePinchDistortionFilter *)filter setScale:intensity]; break;
        case GPUIMAGE_PERLINNOISE:  [(GPUImagePerlinNoiseFilter *)filter setScale:intensity]; break;
        case GPUIMAGE_MOSAIC:  [(GPUImageMosaicFilter *)filter setDisplayTileSize:CGSizeMake(intensity, intensity)]; break;
        case GPUIMAGE_VIGNETTE: [(GPUImageVignetteFilter *)filter setVignetteEnd:intensity]; break;
        case GPUIMAGE_GAUSSIAN: [(GPUImageGaussianBlurFilter *)filter setBlurSize:intensity]; break;
        case GPUIMAGE_BILATERAL: [(GPUImageBilateralFilter *)filter setBlurSize:intensity]; break;
        case GPUIMAGE_FASTBLUR: [(GPUImageFastBlurFilter *)filter setBlurPasses:round(intensity)]; break;
            //        case GPUIMAGE_FASTBLUR: [(GPUImageFastBlurFilter *)filter setBlurSize:intensity]; break;
        case GPUIMAGE_GAUSSIAN_SELECTIVE:
            [(GPUImageGaussianSelectiveBlurFilter *)filter setExcludeCircleRadius:intensity];
            gesture_blur = [[UIGestureRecognizer alloc]init];
            [gesture_blur addTarget:self action:@selector(gaussianSelective:)];
            [glImageView addGestureRecognizer:gesture_blur];
            
            break;
        case GPUIMAGE_FILTERGROUP: [(GPUImagePixellateFilter *)[(GPUImageFilterGroup *)filter filterAtIndex:1] setFractionalWidthOfAPixel:intensity]; break;
        case GPUIMAGE_CROP: [(GPUImageCropFilter *)filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, intensity)]; break;
        case GPUIMAGE_TRANSFORM: [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(intensity)]; break;
        case GPUIMAGE_TRANSFORM3D:
        {
            CATransform3D perspectiveTransform = CATransform3DIdentity;
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, intensity, 0.0, 1.0, 0.0);
            
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];            
        }; break;
        case GPUIMAGE_TILTSHIFT:
        {
            CGFloat midpoint = intensity;
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:midpoint - 0.1];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:midpoint + 0.1];
        }; break;
        default: break;
    }
}
-(void)callThisMethod{
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)handlePinch:(UIPinchGestureRecognizer *)recognizer{
    if (recognizer.velocity>0) {
        if( recognizer.state == UIGestureRecognizerStateChanged){
            if (gestureValue <= self.filterSettingsSlider.maximumValue && gestureIncrementValue != 0) {
                NSLog(@"Gesture Value %f",gestureValue);
                gestureValue += gestureIncrementValue;
                [self setIntensityOfFilter:gestureValue];
                [sourcePicture processImage];
            }
        }
    }
    else if (recognizer.velocity<=0) {
        if( recognizer.state == UIGestureRecognizerStateChanged){
            if (gestureValue > self.filterSettingsSlider.minimumValue && gestureIncrementValue != 0) {
                NSLog(@"Gesture Value %f",gestureValue);
                gestureValue -= gestureIncrementValue;
                [self setIntensityOfFilter:gestureValue];
                [sourcePicture processImage];
            }
        }
    }
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    if (selectFilterValue == GPUIMAGE_GAUSSIAN_SELECTIVE) {
//        NSLog(@"Touches Begin");
//    }
//}
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    if (selectFilterValue == GPUIMAGE_GAUSSIAN_SELECTIVE) {
//        NSLog(@"Touches Moved");
//        UITouch *touch= [touches anyObject];
//        CGPoint location = [touch locationInView:glImageView];
//        [(GPUImageGaussianSelectiveBlurFilter *)filter setExcludeCirclePoint:location];
//    }
//}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    if (selectFilterValue == GPUIMAGE_GAUSSIAN_SELECTIVE) {
//        NSLog(@"Touches Ended");
//    }
//}
- (UIImage*)scaleAndRotateImage:(UIImage *)image{
    int kMaxResolution = 1024; // Or whatever
    //    Taking the image reference from actual image
    CGImageRef imgRef = image.CGImage;
    CFRetain(imgRef);
    //    Taking the dimensions of the image
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    //    Initialing the transform operations
    CGAffineTransform transform = CGAffineTransformIdentity;
    //    creating the bounds of image
    CGRect bounds = CGRectMake(0, 0, width, height);
    //    If the image dimentions are more than the maximum resolutions then reduce the image resolution
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    //Scaling the taken image bounds
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    //    Getting the Orientations of the image to set them in proper order
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    //Saving the Image Context
    UIGraphicsBeginImageContext(bounds.size);
    //    Creating the Graphics Context to save image
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Setting the actual orientation
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    //    Saving the image to UIImage and have to return the image to the calling method
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    Releasing the image reference
    CFRelease(imgRef);
    return imageCopy;
}
-(void)addButtonsToView{
    sepiaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sepiaButton setTitle:@"HISTOGRAM" forState:UIControlStateNormal];
    [sepiaButton setFrame:CGRectMake(self.view.frame.origin.x+20, self.view.frame.origin.y+20, 80, 30)];
    [sepiaButton setTag:1];
    [sepiaButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    brightnessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [brightnessButton setTitle:@"TRANSFORM3D" forState:UIControlStateNormal];
    [brightnessButton setFrame:CGRectMake(self.view.frame.origin.x+120, self.view.frame.origin.y+20, 80, 30)];
    [brightnessButton setTag:2];
    [brightnessButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    sharpenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sharpenButton setTitle:@"PINCH" forState:UIControlStateNormal];
    [sharpenButton setFrame:CGRectMake(self.view.frame.origin.x+240, self.view.frame.origin.y+20, 80, 30)];
    [sharpenButton setTag:3];
    [sharpenButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    sketchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sketchButton setTitle:@"GAUSSIAN_SELECTIVE" forState:UIControlStateNormal];
    [sketchButton setFrame:CGRectMake(self.view.frame.origin.x+20, self.view.frame.origin.x+60, 80, 30)];
    [sketchButton setTag:4];
    [sketchButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    BludgeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BludgeButton setTitle:@"BULGE" forState:UIControlStateNormal];
    [BludgeButton setFrame:CGRectMake(self.view.frame.origin.x+120, self.view.frame.origin.x+60, 80, 30)];
    [BludgeButton setTag:5];
    [BludgeButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    swirlButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [swirlButton setTitle:@"SWIRL" forState:UIControlStateNormal];
    [swirlButton setFrame:CGRectMake(self.view.frame.origin.x+240, self.view.frame.origin.x+60, 80, 30)];
    [swirlButton setTag:6];
    [swirlButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    stretchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stretchButton setTitle:@"CROP" forState:UIControlStateNormal];
    [stretchButton setFrame:CGRectMake(self.view.frame.origin.x+20, self.view.frame.origin.x+120, 80, 30)];
    [stretchButton setTag:7];
    [stretchButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    erosionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [erosionButton setTitle:@"SKETCH" forState:UIControlStateNormal];
    [erosionButton setFrame:CGRectMake(self.view.frame.origin.x+120, self.view.frame.origin.x+120, 80, 30)];
    [erosionButton setTag:8];
    [erosionButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
        [self.view addSubview:sepiaButton];
        [self.view addSubview:brightnessButton];
        [self.view addSubview:sharpenButton];
        [self.view addSubview:sketchButton];
        [self.view addSubview:BludgeButton];
        [self.view addSubview:swirlButton];
        [self.view addSubview:stretchButton];
        [self.view addSubview:erosionButton];
}
-(IBAction)buttonPressed:(id)sender{
    UIButton *but = (UIButton*)sender;
    NSLog(@"%d",but.tag);
    filter = nil;
    [sourcePicture removeTarget:filter];
    sourcePicture = nil;
    if (selectFilterValue != but.tag) {
        switch (but.tag) {
            case 1:
                [self setupDisplayFiltering:GPUIMAGE_HISTOGRAM];
                break;
            case 2:
                [self setupDisplayFiltering:GPUIMAGE_TRANSFORM3D];                
                break;
            case 3:
                [self setupDisplayFiltering:GPUIMAGE_PINCH];
                break;
            case 4:
                [self setupDisplayFiltering:GPUIMAGE_GAUSSIAN_SELECTIVE];
                break;
            case 5:
                [self setupDisplayFiltering:GPUIMAGE_BULGE];
                break;
            case 6:
                [self setupDisplayFiltering:GPUIMAGE_SWIRL];                
                break;
            case 7:
                [self setupDisplayFiltering:GPUIMAGE_CROP];
                break;
            case 8:
                [self setupDisplayFiltering:GPUIMAGE_SKETCH];
                break;
            default:
                break;
        }
    }
}
- (NSInteger)numberOfTilesInMenu:(MGTileMenuController *)tileMenu
{
    return 9;
}
- (NSString *)labelForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
{
	NSArray *labels = [NSArray arrayWithObjects:
					   @"Saturation", 
					   @"Contrast", 
					   @"Brightness", 
					   @"Exposure", 
					   @"RGB", 
					   @"Sharpen", 
					   @"COLORINVERT", 
					   @"SKETCH", 
					   @"GAUSSIAN_SELECTIVE", 
					   nil];
	if (tileNumber >= 0 && tileNumber < labels.count) {
		return [labels objectAtIndex:tileNumber];
	}
	
	return @"Tile";
}- (NSString *)descriptionForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
{
	NSArray *hints = [NSArray arrayWithObjects:
                      @"Gives Saturation", 
                      @"Gives Contrast", 
                      @"Gives Brightness", 
                      @"Gives Exposure", 
                      @"Gives RGB", 
                      @"Gives Sharpen", 
                      @"Gives ColorInvert", 
                      @"Gives Sketch", 
                      @"Gives Gaussive", 
                      nil];
	if (tileNumber >= 0 && tileNumber < hints.count) {
		return [hints objectAtIndex:tileNumber];
	}
	
	return @"It's a tile button!";
}
- (UIImage *)backgroundImageForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
{
	if (tileNumber == 1) {
		return [UIImage imageNamed:@"purple_gradient"];
	} else if (tileNumber == 4) {
		return [UIImage imageNamed:@"orange_gradient"];
	} else if (tileNumber == 7) {
		return [UIImage imageNamed:@"red_gradient"];
	} else if (tileNumber == 5) {
		return [UIImage imageNamed:@"yellow_gradient"];
	} else if (tileNumber == 8) {
		return [UIImage imageNamed:@"green_gradient"];
	} else if (tileNumber == -1) {
		return [UIImage imageNamed:@"grey_gradient"];
	}
	
	return [UIImage imageNamed:@"blue_gradient"];
}
- (UIImage *)imageForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
{
	NSArray *images = [NSArray arrayWithObjects:
					   @"twitter", 
					   @"key", 
					   @"speech", 
					   @"magnifier", 
					   @"scissors", 
					   @"actions", 
					   @"Text", 
					   @"heart", 
					   @"gear", 
					   nil];
	if (tileNumber >= 0 && tileNumber < images.count) {
		return [UIImage imageNamed:[images objectAtIndex:tileNumber]];
	}
	
	return [UIImage imageNamed:@"Text"];
}
- (BOOL)isTileEnabled:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu
{
	if (tileNumber == 2 || tileNumber == 6) {
		return NO;
	}
	
	return YES;
}
- (void)tileMenu:(MGTileMenuController *)tileMenu didActivateTile:(NSInteger)tileNumber
{
	NSLog(@"Tile %d activated (%@)", tileNumber, [self labelForTile:tileNumber inMenu:tileController]);
}
- (void)tileMenuDidDismiss:(MGTileMenuController *)tileMenu
{
	tileController = nil;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	// Ensure that only touches on our own view are sent to the gesture recognisers.
	if (touch.view == glImageView) {
		return YES;
	}
	
	return NO;
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
	// Find out where the gesture took place.
	CGPoint loc = [gestureRecognizer locationInView:glImageView];
	if ([gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]] && ((UITapGestureRecognizer *)gestureRecognizer).numberOfTapsRequired == 2) {
		// This was a double-tap.
		// If there isn't already a visible TileMenu, we should create one if necessary, and show it.
		if (!tileController || tileController.isVisible == NO) {
			if (!tileController) {
				// Create a tileController.
				tileController = [[MGTileMenuController alloc] initWithDelegate:self];
				tileController.dismissAfterTileActivated = NO; // to make it easier to play with in the demo app.
			}
			// Display the TileMenu.
			[tileController displayMenuCenteredOnPoint:loc inView:glImageView];
		}
		
	} else {
		// This wasn't a double-tap, so we should hide the TileMenu if it exists and is visible.
		if (tileController && tileController.isVisible == YES) {
			// Only dismiss if the tap wasn't inside the tile menu itself.
			if (!CGRectContainsPoint(tileController.view.frame, loc)) {
				[tileController dismissMenu];
			}
		}
        if ([gestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]]) {
            [self handlePinch:nil];
        }
	}
}
@end
