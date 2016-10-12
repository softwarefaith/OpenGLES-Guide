##OpenGL ES

- GLKView 

  简化了通过用Core Animation层来自动创建并管理帧缓存和渲染缓存共享内存所需要做的工作。
  
- GLKBaseEffect

   为了简化OpenGL 的常用操作；内部隐藏了iOS设备支持的多个OpenGL ES 版本之间的差异，减少需要编写的代码量。
   
   
   GLKit Framework
    GLKit 框架的设计目标是为了简化基于OpenGL或者OpenGL ES的应用开发。 
    GLKit 主要的功能：
    1.  纹理加载(Texture loading)： GLKTextuerLoader Class. 
    2.  性能卓越的科学运算库，  支持矢量， 四元数，矩阵运算等。 
    3.  实现的常见的标准Shader特效。 GLKit允许你配置你所需要的特效，它会自动创建和加载对应的Shader。 
    GLKBaseEffect, GLKReflectionMapEffect, GLKSkyboxEffect Class. 
    4.  对应于GLKit的View和ViewController。  GLKView Class 和 GLKViewController Class. 