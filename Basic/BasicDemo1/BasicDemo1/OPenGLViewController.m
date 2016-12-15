//
//  OPenGLViewController.m
//  BasicDemo1
//
//  Created by 蔡杰Alan on 16/12/14.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "OPenGLViewController.h"
#import <OpenGLES/EAGL.h>

@interface OPenGLViewController ()<GLKViewDelegate>

@property (nonatomic,strong)EAGLContext *mContext;

@property (nonatomic , assign) int mCount;

@property (nonatomic , strong) GLKBaseEffect* mEffect;



@end

@implementation OPenGLViewController

-(GLKView *)fetchView{
    
    return (GLKView *)self.view;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //新建OpenGLES 上下文
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]; //2.0，还有1.0和3.0
    GLKView* view = (GLKView *)self.view; //storyboard记得添加
    view.context = self.mContext;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;  //颜色缓冲区格式
    [EAGLContext setCurrentContext:self.mContext];
    
    
    /*
     
     EBO开始索引绘图
     索引绘制能够节省存储空间，共享顶点属性数据，但存在的限制时共享的数据的属性时相同的。当我们需要为同一个顶点指定不同的属性，例如颜色和法向量时，索引绘制无法满足需求，这时候需要使用顶点数组为同一个顶点指定不同属性。
     <http://blog.csdn.net/wangdingqiaoit/article/details/51324516>
     */
    //顶点数据，前三个是顶点坐标，后面两个是纹理坐标
    GLfloat squareVertexData[] =
    {
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
    };
    
    //顶点索引
    GLuint indices[] =
    {
        2,1, 0,
        0, 1, 3
    };
    self.mCount = sizeof(indices) / sizeof(GLuint);
    
    /*
     glGenBuffers申请一个标识符
     glBindBuffer把标识符绑定到GL_ARRAY_BUFFER上
     glBufferData把顶点数据从cpu内存复制到gpu内存
     glEnableVertexAttribArray 是开启对应的顶点属性
     glVertexAttribPointer设置合适的格式从buffer里面读取数据
     */
    //顶点数据缓存
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);
    
    GLuint index;
    glGenBuffers(1, &index);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, index);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition); //顶点数据缓存
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
    
    
    //纹理贴图
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"screenshot" ofType:@"png"];
    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];//GLKTextureLoaderOriginBottomLeft 纹理坐标系是相反的
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    //着色器
    /*
     GLKTextureLoader读取图片，创建纹理GLKTextureInfo
     创建着色器GLKBaseEffect，把纹理赋值给着色器
     
     */
    self.mEffect = [[GLKBaseEffect alloc] init];
    self.mEffect.texture2d0.enabled = GL_TRUE;
    self.mEffect.texture2d0.name = textureInfo.name;
    
    
    
}

/**
 *  渲染场景代码
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //启动着色器
        [self.mEffect prepareToDraw];
        glDrawElements(GL_TRIANGLES, self.mCount, GL_UNSIGNED_INT, 0);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
