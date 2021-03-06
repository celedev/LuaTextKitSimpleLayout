// Lua to C bindings for /Volumes/Brume/Celedev CodeFlow/CodeFlow Sample Applications/TextKitSimpleLayout/TextKitSimpleLayout/ViewController.h
// Generated by Celedev® LuaBindingsGenerator on 2015-09-16 12:27:44 +0000
// Target Architecture: armv7

#import "CIMLua/CIMLuaBindings.h"

#import "ViewController.h"

// Register Objective C methods extended signatures

@implementation ViewController (LuaModule_TextKitSimpleLayout_ViewController)

+ (void) load
{

    CIMLuaObjcMethodAttributes instanceMethodsAttributes [] = {
        { @selector(firstColumnSizeSlider), "z@\"UISlider\"8@0:4" },
        { @selector(setFirstColumnSizeSlider:), "v12@0:4z@\"UISlider\"8" },
        { @selector(column1View), "z@\"UIView\"8@0:4" },
        { @selector(setColumn1View:), "v12@0:4z@\"UIView\"8" },
        { @selector(column2View), "z@\"UIView\"8@0:4" },
        { @selector(setColumn2View:), "v12@0:4z@\"UIView\"8" },
        { @selector(panImageView), "@\"PathImageView\"8@0:4" },
        { @selector(setPanImageView:), "v12@0:4@\"PathImageView\"8" }
    };
    [CIMLuaContext registerObjcInstanceMethodsAttributes:instanceMethodsAttributes withCount:8 forClass:[ViewController class]];
}

@end

