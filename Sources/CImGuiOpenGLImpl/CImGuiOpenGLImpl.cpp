//
//  CImGuiOpenGLImpl.cpp
//  Falcon
//
//  Created by Josef Zoller on 19.02.20.
//

#include "CImGuiOpenGLImpl.h"
#include "CppImGuiOpenGLImpl.h"

void CImGui_ImplOpenGL3_Init() {
    ImGui_ImplOpenGL3_Init("#version 410");
}
void     CImGui_ImplOpenGL3_Shutdown() {
    ImGui_ImplOpenGL3_Shutdown();
}
void     CImGui_ImplOpenGL3_NewFrame() {
    ImGui_ImplOpenGL3_NewFrame();
}
void     CImGui_ImplOpenGL3_RenderDrawData(ImDrawData* draw_data) {
    ImGui_ImplOpenGL3_RenderDrawData(draw_data);
}
