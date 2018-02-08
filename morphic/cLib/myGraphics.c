#include <stdint.h>
#include <stdio.h>
#include <SDL.h>
#include <unistd.h>

SDL_Window *window = NULL;
SDL_Renderer * renderer;
SDL_Texture * texture;

int winW;
int winH;

#define MOUSE_DOWN 1
#define MOUSE_UP 0
#define KEY_DOWN 1
#define KEY_UP 0


struct {
    uint32_t x, y;
    int left, middle, right;
} MouseState;

struct {
    int ctrlL, ctrlR, alt, shiftL, shiftR;
} ModifierState;

#define EVENT_TYPE_NONE     0
#define EVENT_TYPE_MOUSE    1
#define EVENT_TYPE_KEYBOARD 2

typedef struct {
    uint32_t type;
    uint32_t timeStamp;
    uint32_t x, y;
    uint32_t buttonState, modifierKeys;
    uint32_t unused[2];
} MouseEvent;

typedef struct {
    uint32_t type;
    uint32_t timeStamp;
    uint32_t characterCode;
    uint32_t pressState, modifierKeys;
    uint32_t unused[3];
} KeyEvent;

int openWindow(int x, int y, int w, int h)
{
    if(window != NULL)
        return 1;
    
    SDL_Init(SDL_INIT_VIDEO);  
    
    window = SDL_CreateWindow(
        "An SDL2 window",                  // window title
        x,           // initial x position
        y,           // initial y position
        w,                               // width, in pixels
        h,                               // height, in pixels
        0                  // flags - see below
    );
    
    winW = w;
    winH = h;
    
    renderer = SDL_CreateRenderer(window, -1, 0);
    texture = SDL_CreateTexture(renderer,
        SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STATIC, w, h);

    MouseState.left = MouseState.middle = MouseState.right = MOUSE_UP;
    
    return 0;
}

int drawBitmap(char* data, int l, int r, int t, int b)
{
    //SDL_Rect drawRect;
    //drawRect.y = l;
    //drawRect.r = r
    
    SDL_UpdateTexture(texture, NULL, data, winW * sizeof(Uint32));
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, NULL, NULL);
    SDL_RenderPresent(renderer);
    return 0;
}

void closeWindow()
{
    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
}

uint32_t mouseButtonState() {
    return MouseState.right
            | (MouseState.middle << 1)
            | (MouseState.left << 2);
}

uint32_t keyModifierState() {
    return ModifierState.shiftL
            | ModifierState.shiftR
            | (ModifierState.ctrlL << 1)
            | (ModifierState.ctrlR << 1)
            | (ModifierState.alt << 1);
}

void sendMouseState(MouseEvent *sqEv, uint32_t timestamp)
{
    sqEv->type = EVENT_TYPE_MOUSE;
    sqEv->timeStamp = timestamp;
    sqEv->x = MouseState.x;
    sqEv->y = MouseState.y;
    sqEv->buttonState = mouseButtonState();
    sqEv->modifierKeys = keyModifierState();
}

void handleButtonEvent(uint8_t button, int value)
{
    switch (button)
    {
    case SDL_BUTTON_LEFT:
        MouseState.left = value;
        break;
    case SDL_BUTTON_MIDDLE:
        MouseState.middle = value;
        break;
    case SDL_BUTTON_RIGHT:
        MouseState.right = value;
        break;
    }
}

void handleKeyEvent(KeyEvent * sqEv,
                    SDL_Keycode keycode,
                    int value,
                    int repeat,
                    uint32_t timestamp) {
    sqEv->type = EVENT_TYPE_KEYBOARD;
    sqEv->timeStamp = timestamp;
    sqEv->characterCode = keycode;
    if (repeat)
        sqEv->pressState = 0;
    else if (value == KEY_DOWN)
        sqEv->pressState = 1;
    else
        sqEv->pressState = 2;
    sqEv->modifierKeys = keyModifierState();
}

void getEvents(void *e)
{
    SDL_Event event;
    
    while (SDL_PollEvent(&event))
    {
        switch (event.type)
        {
        case SDL_MOUSEMOTION:
            MouseState.x = event.motion.x;
            MouseState.y = event.motion.y;
            sendMouseState(e, event.motion.timestamp);
            return;
        case SDL_MOUSEBUTTONUP:
        case SDL_MOUSEBUTTONDOWN:
            MouseState.x = event.button.x;
            MouseState.y = event.button.y;
            handleButtonEvent(
                    event.button.button,
                    event.type == SDL_MOUSEBUTTONUP ? MOUSE_UP : MOUSE_DOWN);
            sendMouseState(e, event.button.timestamp);
            return;
        case SDL_KEYUP:
        case SDL_KEYDOWN:
            handleKeyEvent(
                    e,
                    event.key.keysym.sym,
                    event.type == SDL_KEYUP ? KEY_UP : KEY_DOWN,
                    event.key.repeat != 0,
                    event.key.timestamp);
            return;
        }
    }

    bzero(e, 8 * sizeof(uint32_t));
}