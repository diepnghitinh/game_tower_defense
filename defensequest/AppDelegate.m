//
//  AppDelegate.m
//  defensequest
//
//  Created by dntmaster on 4/22/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "RootViewController.h"
#import "SceneMain.h"
#import "SimpleAudioEngine.h"

@implementation AppDelegate

@synthesize window;

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	//[director setDisplayFPS:YES];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	// Removes the startup flicker
	[self removeStartupFlicker];
	
    //load content
    [self LoadContent];
    
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [SceneMain scene]];
}

-(void)LoadContent
{
    //LOAD SOUND
    [[SimpleAudioEngine sharedEngine] preloadEffect: @"skill-1.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect: @"skill-2.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect: @"skill-3.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect: @"skill-4.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect: @"female-1.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect: @"female-2.mp3"];    
    
    NSMutableArray *frames = [NSMutableArray array];
    
    //LOAD EFFECT
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"effect.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"station-effect.plist"];
    //cung ten
    frames = [NSMutableArray array];
    for(int i = 1; i <= 3; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"arrow-image%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEffect:frames key:@"ice-arrow"];
    [frames release];
    //no ra bang sat
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"ice-image%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEffect:frames key:@"ice-effect"];
    [frames release];
    //skill 2 cua archer
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"3238-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEffect:frames key:@"archer-skill2-effect"];
    //no ra blood
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"blood-image%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEffect:frames key:@"blood-effect"];
    
    //SET SKILL
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"skill-1.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"skill-2.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"skill-3.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"skill-4.plist"];
    
    //skill 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"682-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetSkill: frames key:@"skill1"];
    [frames release];
    
    //skill 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 11; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"3022-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetSkill: frames key:@"skill2"];
    [frames release];
    
    //skill 3
    frames = [NSMutableArray array];
    for(int i = 1; i <= 11; i++) {
        CCSpriteFrame *frame1 = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"3149-%d.png",i]];
        [frames addObject:frame1];
    }
    [CGlobalAnimation SetSkill: frames key:@"skill3-1"];
    [frames release];
    
    frames = [NSMutableArray array];
    for(int i = 1; i <= 11; i++) {
        CCSpriteFrame *frame1 = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"3150-%d.png",i]];
        [frames addObject:frame1];
    }
    [CGlobalAnimation SetSkill: frames key:@"skill3-2"];
    [frames release];
    
    //skill 4
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"3213-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetSkill: frames key:@"skill4"];
    [frames release];
    
    //SET ENEMY
    //enemy 1
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"enemy-1.plist"];
    //move 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8142-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1: frames key:@"move1"];
    [frames release];
    //move 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8141-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1:frames key:@"move2"];
    [frames release];
    //move 3
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8140-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1: frames key:@"move3"];
    [frames release];
    //move 4
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8135-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1: frames key:@"move4"];
    [frames release];
    //move 5
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8139-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1: frames key:@"move5"];
    [frames release];
    //move 6
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8136-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1: frames key:@"move6"];
    [frames release];
    //move 7
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8137-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1: frames key:@"move7"];
    [frames release];
    //move 8
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8138-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1: frames key:@"move8"];
    [frames release];
    //die 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 10; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8149-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1: frames key:@"die1"];
    [frames release];
    //die 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 10; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_8150-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy1: frames key:@"die2"];
    [frames release];
    
    
    //SET ENEMY 2
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"enemy-2.plist"];
    //move 1 
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc1_1008-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy2: frames key:@"move1"];
    [frames release];
    //move 2
    
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc1_1007-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy2: frames key:@"move2"];
    [frames release];
    
    //move 3
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc1_1006-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy2: frames key:@"move3"];
    [frames release];
    //move 4
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc1_1001-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy2: frames key:@"move4"];
    [frames release];
    
    //move 5
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc1_1005-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy2: frames key:@"move5"];
    [frames release];
    
    //move 6
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc1_1002-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy2: frames key:@"move6"];
    [frames release];
    
    //move 7
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc1_1003-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy2: frames key:@"move7"];
    [frames release];
    
    //move 8
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc1_1004-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy2: frames key:@"move8"];  
    [frames release];
    
    //SET ENEMY 3
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"enemy-3.plist"];
    //move 1 cheo len trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1310-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy3: frames key:@"move1"];
    [frames release];
    
    //move 2 len
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1309-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy3:frames key:@"move2"];
    [frames release];
    
    //move 3 cheo len phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1308-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy3: frames key:@"move3"];
    [frames release];
    
    //move 4 qua trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1303-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy3: frames key:@"move4"];
    [frames release];
    
    //move 5 qua phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1307-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy3: frames key:@"move5"];
    [frames release];
    
    //move 6 cheo xuong trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1304-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy3: frames key:@"move6"];
    [frames release];
    
    //move 7 xuong
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1305-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy3: frames key:@"move7"];
    [frames release];
    
    //move 8 cheo xuong phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1306-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy3: frames key:@"move8"];
    [frames release];
    
    
    //SET ENEMY 4
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"enemy-4.plist"];
    //move 1 cheo len trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1022-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy4: frames key:@"move1"];
    [frames release];
    
    //move 2 len
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1021-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy4:frames key:@"move2"];
    [frames release];
    
    //move 3 cheo len phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1020-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy4: frames key:@"move3"];
    [frames release];
    
    //move 4 qua trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1015-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy4: frames key:@"move4"];
    [frames release];
    
    //move 5 qua phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1019-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy4: frames key:@"move5"];
    [frames release];
    
    //move 6 cheo xuong trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1016-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy4: frames key:@"move6"];
    [frames release];
    
    //move 7 xuong
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1017-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy4: frames key:@"move7"];
    [frames release];
    
    //move 8 cheo xuong phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_1018-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy4: frames key:@"move8"];
    [frames release];
    
    
    // SET ENEMY 5
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"enemy-5.plist"];
    //move 1 cheo len trai
    
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7022-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy5: frames key:@"move1"];
    [frames release];
    
    //move 2 len
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7021-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy5:frames key:@"move2"];
    [frames release];
    
    //move 3 cheo len phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7020-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy5: frames key:@"move3"];
    [frames release];
    
    //move 4 qua trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7015-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy5: frames key:@"move4"];
    [frames release];
    
    //move 5 qua phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7019-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy5: frames key:@"move5"];
    [frames release];
    
    //move 6 cheo xuong trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7016-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy5: frames key:@"move6"];
    [frames release];
    
    //move 7 xuong
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7017-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy5: frames key:@"move7"];
    [frames release];
    
    //move 8 cheo xuong phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7018-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy5: frames key:@"move8"];
    [frames release];

    //SET ENEMY 6
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"enemy-6.plist"];
    //move 1 cheo len trai
    
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7594-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy6: frames key:@"move1"];
    [frames release];
    
    //move 2 len
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7593-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy6:frames key:@"move2"];
    [frames release];
    
    //move 3 cheo len phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7592-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy6: frames key:@"move3"];
    [frames release];
    
    //move 4 qua trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7587-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy6: frames key:@"move4"];
    [frames release];
    
    //move 5 qua phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7591-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy6: frames key:@"move5"];
    [frames release];
    
    //move 6 cheo xuong trai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7588-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy6: frames key:@"move6"];
    [frames release];
    
    //move 7 xuong
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7589-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy6: frames key:@"move7"];
    [frames release];
    
    //move 8 cheo xuong phai
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"npc_7590-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetEnemy6: frames key:@"move8"];
    [frames release];
    
    //SET STATION
    //station 1
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"station-1.plist"];
    
    //normal 1
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"424-6.png"]];
    [CGlobalAnimation SetStation1: frames key:@"normal1"];
    [frames release];
    //normal 2
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"424-7.png"]];
    [CGlobalAnimation SetStation1: frames key:@"normal2"];
    [frames release];
    //normal 3
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"424-8.png"]];
    [CGlobalAnimation SetStation1: frames key:@"normal3"];
    [frames release];
    //normal 4
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"424-5.png"]];
    [CGlobalAnimation SetStation1: frames key:@"normal4"];
    [frames release];
    //normal 5
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"424-1.png"]];
    [CGlobalAnimation SetStation1: frames key:@"normal5"];
    [frames release];
    //normal 6
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"424-4.png"]];
    [CGlobalAnimation SetStation1: frames key:@"normal6"];
    [frames release];
    //normal 7
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"424-3.png"]];
    [CGlobalAnimation SetStation1: frames key:@"normal7"];
    [frames release];
    //normal 8
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"424-2.png"]];
    [CGlobalAnimation SetStation1: frames key:@"normal8"];
    [frames release];
    //attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 9; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1314-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation1: frames key:@"attack1"];
    [frames release];
    //attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 9; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1321-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation1: frames key:@"attack2"];
    [frames release];
    //s1-attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 10; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1312-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation1: frames key:@"s1-attack1"];
    [frames release];
    //s1-attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 10; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1319-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation1: frames key:@"s1-attack2"];
    [frames release];
    
    //station 2
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"station-2.plist"];
    
    //normal 1
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"591-6.png"]];
    [CGlobalAnimation SetStation2: frames key:@"normal1"];
    [frames release];
    //normal 2
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"591-7.png"]];
    [CGlobalAnimation SetStation2: frames key:@"normal2"];
    [frames release];
    //normal 3
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"591-8.png"]];
    [CGlobalAnimation SetStation2: frames key:@"normal3"];
    [frames release];
    //normal 4
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"591-5.png"]];
    [CGlobalAnimation SetStation2: frames key:@"normal4"];
    [frames release];
    //normal 5
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"591-1.png"]];
    [CGlobalAnimation SetStation2: frames key:@"normal5"];
    [frames release];
    //normal 6
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"591-4.png"]];
    [CGlobalAnimation SetStation2: frames key:@"normal6"];
    [frames release];
    //normal 7
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"591-3.png"]];
    [CGlobalAnimation SetStation2: frames key:@"normal7"];
    [frames release];
    //normal 8
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"591-2.png"]];
    [CGlobalAnimation SetStation2: frames key:@"normal8"];
    [frames release];
    //attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 7; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1851-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation2: frames key:@"attack1"];
    [frames release];
    //attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 7; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1858-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation2: frames key:@"attack2"];
    [frames release];
    //s1-attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 6; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1853-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation2: frames key:@"s1-attack1"];
    [frames release];
    //s1-attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 6; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1859-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation2: frames key:@"s1-attack2"];
    [frames release];
    
    
    //station 3
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"station-3.plist"];
    
    //normal 1
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"179-6.png"]];
    [CGlobalAnimation SetStation3: frames key:@"normal1"];
    [frames release];
    //normal 2
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"179-7.png"]];
    [CGlobalAnimation SetStation3: frames key:@"normal2"];
    [frames release];
    //normal 3
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"179-8.png"]];
    [CGlobalAnimation SetStation3: frames key:@"normal3"];
    [frames release];
    //normal 4
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"179-5.png"]];
    [CGlobalAnimation SetStation3: frames key:@"normal4"];
    [frames release];
    //normal 5
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"179-1.png"]];
    [CGlobalAnimation SetStation3: frames key:@"normal5"];
    [frames release];
    //normal 6
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"179-4.png"]];
    [CGlobalAnimation SetStation3: frames key:@"normal6"];
    [frames release];
    //normal 7
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"179-3.png"]];
    [CGlobalAnimation SetStation3: frames key:@"normal7"];
    [frames release];
    //normal 8
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"179-2.png"]];
    [CGlobalAnimation SetStation3: frames key:@"normal8"];
    [frames release];
    //attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 11; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"612-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation3: frames key:@"attack1"];
    [frames release];
    //attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 11; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"618-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation3: frames key:@"attack2"];
    [frames release];
    //s1-attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 10; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"610-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation3: frames key:@"s1-attack1"];
    [frames release];
    //s1-attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 10; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"616-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation3: frames key:@"s1-attack2"];
    [frames release];
    
    //station 4
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"station-4.plist"];
    
    //normal 1
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"221-6.png"]];
    [CGlobalAnimation SetStation4: frames key:@"normal1"];
    [frames release];
    //normal 2
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"221-7.png"]];
    [CGlobalAnimation SetStation4: frames key:@"normal2"];
    [frames release];
    //normal 3
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"221-8.png"]];
    [CGlobalAnimation SetStation4: frames key:@"normal3"];
    [frames release];
    //normal 4
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"221-5.png"]];
    [CGlobalAnimation SetStation4: frames key:@"normal4"];
    [frames release];
    //normal 5
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"221-1.png"]];
    [CGlobalAnimation SetStation4: frames key:@"normal5"];
    [frames release];
    //normal 6
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"221-4.png"]];
    [CGlobalAnimation SetStation4: frames key:@"normal6"];
    [frames release];
    //normal 7
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"221-3.png"]];
    [CGlobalAnimation SetStation4: frames key:@"normal7"];
    [frames release];
    //normal 8
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"221-2.png"]];
    [CGlobalAnimation SetStation4: frames key:@"normal8"];
    [frames release];
    //attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"508-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation4: frames key:@"attack1"];
    [frames release];
    //attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"44-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation4: frames key:@"attack2"];
    [frames release];
    //s1-attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"504-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation4: frames key:@"s1-attack1"];
    [frames release];
    //s1-attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 8; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"41-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation4: frames key:@"s1-attack2"];
    //s2-attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 14; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"509-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation4: frames key:@"s2-attack1"];
    [frames release];
    //s2-attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 14; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"45-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation4: frames key:@"s2-attack2"];
    
    
    //station 5
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"station-5.plist"];
    
    //normal 1
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"206-6.png"]];
    [CGlobalAnimation SetStation5: frames key:@"normal1"];
    [frames release];
    //normal 2
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"206-7.png"]];
    [CGlobalAnimation SetStation5: frames key:@"normal2"];
    [frames release];
    //normal 3
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"206-8.png"]];
    [CGlobalAnimation SetStation5: frames key:@"normal3"];
    [frames release];
    //normal 4
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"206-5.png"]];
    [CGlobalAnimation SetStation5: frames key:@"normal4"];
    [frames release];
    //normal 5
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"206-1.png"]];
    [CGlobalAnimation SetStation5: frames key:@"normal5"];
    [frames release];
    //normal 6
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"206-4.png"]];
    [CGlobalAnimation SetStation5: frames key:@"normal6"];
    [frames release];
    //normal 7
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"206-3.png"]];
    [CGlobalAnimation SetStation5: frames key:@"normal7"];
    [frames release];
    //normal 8
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"206-2.png"]];
    [CGlobalAnimation SetStation5: frames key:@"normal8"];
    [frames release];
    //attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"749-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation5: frames key:@"attack1"];
    [frames release];
    //attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"755-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation5: frames key:@"attack2"];
    [frames release];
    //s1-attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"751-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation5: frames key:@"s1-attack1"];
    [frames release];
    //s1-attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 12; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"756-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation5: frames key:@"s1-attack2"];
    [frames release];
    
    //station 6
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"station-6.plist"];
    
    //normal 1
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"370-6.png"]];
    [CGlobalAnimation SetStation6: frames key:@"normal1"];
    [frames release];
    //normal 2
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"370-7.png"]];
    [CGlobalAnimation SetStation6: frames key:@"normal2"];
    [frames release];
    //normal 3
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"370-8.png"]];
    [CGlobalAnimation SetStation6: frames key:@"normal3"];
    [frames release];
    //normal 4
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"370-5.png"]];
    [CGlobalAnimation SetStation6: frames key:@"normal4"];
    [frames release];
    //normal 5
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"370-1.png"]];
    [CGlobalAnimation SetStation6: frames key:@"normal5"];
    [frames release];
    //normal 6
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"370-4.png"]];
    [CGlobalAnimation SetStation6: frames key:@"normal6"];
    [frames release];
    //normal 7
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"370-3.png"]];
    [CGlobalAnimation SetStation6: frames key:@"normal7"];
    [frames release];
    //normal 8
    frames = [NSMutableArray array];
    [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"370-2.png"]];
    [CGlobalAnimation SetStation6: frames key:@"normal8"];
    [frames release];
    //attack 1
    frames = [NSMutableArray array];
    for(int i = 71; i <= 84; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"416-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"attack1"];
    [frames release];
    //attack 2
    frames = [NSMutableArray array];
    for(int i = 85; i <= 97; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"416-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"attack2"];
    [frames release];
    //attack 3
    frames = [NSMutableArray array];
    for(int i = 99; i <= 112; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"416-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"attack3"];
    [frames release];
    //attack 4
    frames = [NSMutableArray array];
    for(int i = 57; i <= 70; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"416-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"attack4"];
    [frames release];
    //attack 5
    frames = [NSMutableArray array];
    for(int i = 1; i <= 14; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"416-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"attack5"];
    [frames release];
    //attack 6
    frames = [NSMutableArray array];
    for(int i = 43; i <= 56; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"416-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"attack6"];
    [frames release];
    //attack 7
    frames = [NSMutableArray array];
    for(int i = 29; i <= 42; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"416-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"attack7"];
    [frames release];
    //attack 8
    frames = [NSMutableArray array];
    for(int i = 15; i <= 28; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"416-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"attack8"];
    [frames release];
    //s1-attack 1
    frames = [NSMutableArray array];
    for(int i = 1; i <= 16; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1903-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"s1-attack1"];
    [frames release];
    //s1-attack 2
    frames = [NSMutableArray array];
    for(int i = 1; i <= 16; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"1904-%d.png",i]];
        [frames addObject:frame];
    }
    [CGlobalAnimation SetStation6: frames key:@"s1-attack2"];
    [frames release];
    
    
    [[CCTextureCache sharedTextureCache] dumpCachedTextureInfo];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

@end
