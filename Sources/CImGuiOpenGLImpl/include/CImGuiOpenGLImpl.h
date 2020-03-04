//
//  CImGuiOpenGLImpl.hpp
//  Falcon
//
//  Created by Josef Zoller on 19.02.20.
//

#ifndef CImGuiOpenGLImpl_hpp
#define CImGuiOpenGLImpl_hpp

#include <stdio.h>

#ifdef __cplusplus
extern "C"  {
#endif

typedef struct ImDrawData ImDrawData;

void     CImGui_ImplOpenGL3_Init();
void     CImGui_ImplOpenGL3_Shutdown();
void     CImGui_ImplOpenGL3_NewFrame();
void     CImGui_ImplOpenGL3_RenderDrawData(ImDrawData* draw_data);

#ifdef __cplusplus
}
#endif

#endif /* CImGuiOpenGLImpl_hpp */
