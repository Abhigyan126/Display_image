#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@implementation AppDelegate {
    NSWindow *_window;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSRect frame = NSMakeRect(0, 0, 300, 300);
    _window = [[NSWindow alloc] initWithContentRect:frame
                                           styleMask:(NSWindowStyleMaskTitled |
                                                      NSWindowStyleMaskClosable |
                                                      NSWindowStyleMaskResizable)
                                             backing:NSBackingStoreBuffered
                                               defer:NO];
    [_window setTitle:@"Image Display"];
    [_window makeKeyAndOrderFront:nil];

    // Image data: 3x3 image with 9 different colors
    const int width = 3;
    const int height = 3;
    unsigned char image[width * height * 3] = {
        255, 0, 0,   // Red
        0, 255, 0,   // Green
        0, 0, 255,   // Blue
        255, 255, 0,   // Yellow
        0, 255, 255,   // Cyan
        255, 0, 255,   // Magenta
        192, 192, 192, // Silver
        128, 128, 128, // Gray
        0, 0, 0      // Black
    };

    // Create a bitmap image rep from the raw data
    NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                                       pixelsWide:width
                                                                       pixelsHigh:height
                                                                    bitsPerSample:8
                                                                  samplesPerPixel:3
                                                                         hasAlpha:NO
                                                                         isPlanar:NO
                                                                   colorSpaceName:NSCalibratedRGBColorSpace
                                                                     bitmapFormat:0
                                                                      bytesPerRow:width * 3
                                                                     bitsPerPixel:24];

    memcpy([bitmap bitmapData], image, width * height * 3);

    // Create an NSImage and add the bitmap rep to it
    NSImage *nsImage = [[NSImage alloc] initWithSize:NSMakeSize(width, height)];
    [nsImage addRepresentation:bitmap];

    // Create an NSImageView to display the image
    NSImageView *imageView = [[NSImageView alloc] initWithFrame:frame];
    [imageView setImage:nsImage];
    [imageView setImageScaling:NSImageScaleAxesIndependently];

    // Add the image view to the window's content view
    [[_window contentView] addSubview:imageView];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        AppDelegate *delegate = [[AppDelegate alloc] init];
        [app setDelegate:delegate];
        [app run];
    }
    return 0;
}
