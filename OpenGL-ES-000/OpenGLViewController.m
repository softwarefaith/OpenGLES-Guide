//
//  OpenGLViewController.m
//  OpenGL-ES-000
//
//  Created by 蔡杰Alan on 16/10/9.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "OpenGLViewController.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <GLKit/GLKit.h>


typedef struct  {
    
    GLKVector3 positionCoords;
    
} SceneVertex;

static const SceneVertex vertices[] = {
    
    {{-0.5f, -0.5f, 0.0}}, // lower left corner
    {{ 0.5f, -0.5f, 0.0}}, // lower right corner
    {{-0.5f,  0.5f, 0.0}}  // upper left corner
};

@interface OpenGLViewController ()<GLKViewDelegate>{
    
    GLuint vertexBufferID;
}

@property (nonatomic,strong) GLKBaseEffect *baseEffect;

@end

@implementation OpenGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    EAGLContext *context =  [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.view = [[GLKView alloc]initWithFrame:self.view.bounds context:context];
    GLKView *view  = (GLKView *)self.view;
    view.delegate = self;
    

    //  创建OpenGL ES 2.0  环境
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
    
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1, 1, 1, 1);
    
    //设置背景颜色
    glClearColor(0, 0, 0, 1);
    
    //缓存
    glGenBuffers(1, &vertexBufferID);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
    [self.baseEffect prepareToDraw];
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL);
    
    glDrawArrays(GL_TRIANGLES, 0, 3);

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
