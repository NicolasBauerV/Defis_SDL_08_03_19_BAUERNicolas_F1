program defis;

uses SDL2, SDL2_image;

var
  sdlWindow1: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlSurface1: PSDL_Surface;
  sdlTexture1: PSDL_Texture;
  sdlTexture2: PSDL_Texture;
  sdlHelico: TSDL_Rect;
  sdlRect1: TSDL_Rect;
  exit : BOOLEAN = false;
  sdlKeyboardState: PUInt8;

begin
  //initilization of video subsystem
  if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;


    // full set up
    sdlWindow1 := SDL_CreateWindow('Window1', 50, 50, 500, 500, SDL_WINDOW_SHOWN);
    if sdlWindow1 = nil then Halt;

    sdlRenderer := SDL_CreateRenderer(sdlWindow1, 1, SDL_RENDERER_ACCELERATED);
    if(sdlRenderer=nil) then halt;

    //Affichage rider bitmap

    //creer une surface … partir d'un fichier bitmap
    sdlSurface1:= SDL_LoadBMP('rider.bmp');
    if sdlSurface1 = nil then
        halt;

    //creer une texture … partir d'une surface
    sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
    if sdlTexture1 = nil then
        halt;
 	

    //render texture
    if SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil) <> 0 then
        halt;

    // Qualité du rendu

    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, 'nearest');

    // affichage h‚lico

    sdlTexture2 := IMG_LoadTexture( sdlRenderer, 'helicopter.png' );
    if sdlTexture2 = nil then HALT;

    //1ere frame
    sdlHelico.x := 0;
    sdlHelico.y := 0;
    sdlHelico.w := 128;
    sdlHelico.h := 55;
    sdlRect1.x := 0;
    sdlRect1.y := 0;
    sdlRect1.w := 128;
    sdlRect1.h := 55;

    While exit = false do 
    begin
    	SDL_PumpEvents;
    	sdlKeyboardState := SDL_GetKeyboardState(nil);

    	// sortie du programme
    	if sdlKeyboardState[SDL_SCANCODE_ESCAPE] = 1 then
    	exit := true;

    	//Mise en place des mouvements par ZQSD
    	if sdlKeyboardState[SDL_SCANCODE_W] = 1 then
    		sdlHelico.y := sdlHelico.y -1;
    	if sdlKeyboardState[SDL_SCANCODE_A] = 1 then
    		sdlHelico.x := sdlHelico.x -1;
     	if sdlKeyboardState[SDL_SCANCODE_S] = 1 then
    		sdlHelico.y := sdlHelico.y +1;  
    	if sdlKeyboardState[SDL_SCANCODE_D] = 1 then
    		sdlHelico.x := sdlHelico.x +1;


		sdlRect1.x := sdlRect1.x +128; //Déplacement du rectangle "scanner" sur l'image afin d'animer les images
    	if sdlRect1.x > 512 then
    	begin
   			sdlRect1.x := 0;
   		end;

    	SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil);
    	SDL_RenderCopy(sdlRenderer, sdlTexture2, @sdlRect1, @sdlHelico);
    	SDL_RenderPresent(sdlRenderer);
    	SDL_Delay(10);
    	SDL_RenderClear(sdlRenderer);
    end;

      // rendu window pour 5 secondes
   //   SDL_RenderPresent(sdlRenderer);
      // SDL_Delay(5000);

      // Nettoyage memoire
      SDL_DestroyTexture(sdlTexture2);
      SDL_DestroyTexture(sdlTexture1);
      SDL_FreeSurface(sdlSurface1);
      SDL_DestroyRenderer(sdlRenderer);
      SDL_DestroyWindow (sdlWindow1);

      //Closing SDL2
      SDL_Quit;

end.
