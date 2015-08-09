//
//  GameGuiProtectedMethods.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/7/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#ifndef GameGuiProtectedMethods_h
#define GameGuiProtectedMethods_h
//
//  GameEntityProtectedMethods.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

@protocol GameGuiProtectedMethods <NSObject>
-(void)loadToBuffers:(const Vertex*)vertices vSize:(size_t)vsize indices:(const GLushort*)indices iSize:(size_t)isize objectName:(NSString*)objectName;
-(void)loadToTexture:(NSString*)fileName;
@end
@interface GameGui (ProtectedMethods) <GameGuiProtectedMethods>

@end

#endif /* GameGuiProtectedMethods_h */
