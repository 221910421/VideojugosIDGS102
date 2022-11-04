//Módulo PantGame 
//elaborado por: Rubén Dario Hernandez Mendo
//fecha de creación: 30 de septiembre de 2022
//fecha de ultima modificación: 31 de octubre de 2022
//comentario: Implementa la clase PantGame, la cual controla las acciones del 
//juego.
class PantGame{
  Punto2D bg[];
  Punto2D fg[];
  int fbg[];
  int ffg[];
  SpriteSet ssbg;
  SpriteSet ssfg;
  SpriteSet sspr;
  PImage imghud;
  Punto2D per;
  Dado dbg;
  Dado dfg;
  Reloj rlj;
  boolean dir;
  
  PantGame(){
    dbg=new Dado(cf.nbg);
    bg=new Punto2D[cf.nbg];
    fbg=new int[cf.nbg];
    creaP2DArray(bg,fbg,dbg,400,400,800,0);
    dfg=new Dado(cf.nfg);
    fg=new Punto2D[cf.nfg];
    ffg=new int[cf.nfg];
    creaP2DArray(fg,ffg,dfg,100,675,200,0);
    ssbg=new SpriteSet("sprites/bg/","bg",".png",cf.nbg,6,false,0);
    ssfg=new SpriteSet("sprites/fg/","fg",".png",cf.nfg,6,false,0);
    per=new Punto2D(150,700);
    sspr=new SpriteSet("sprites/per/","per",".png",cf.nprc,cf.prfc,true,0);
    imghud=loadImage("sprites/HUD/hud.png");
    rlj=new Reloj();
    rlj.iniciaReloj();
    dir=true;
  }
  
  void display(){
    planoFondo();
    planoNivel();
    planoFrente();
    planoHUD();
    gameProgress();
  }
  
  void planoFondo(){
    rectMode(CENTER);
    imageMode(CENTER);
    stroke(0);
    fill(128,128,0);
    graficaPlano(bg,ssbg,fbg,800,800,false);
  }
  
  void planoNivel(){
    ellipseMode(RADIUS);
    imageMode(CENTER);
    if(cf.gmode)
      sspr.display(per.getX(),per.getY(),200,200);
    else{
      stroke(0,120,0);
      fill(0,200,0);
      circle(per.getX(),per.getY(),75);
    }  
  }
  
  void planoFrente(){
    rectMode(CENTER);
    imageMode(CENTER);
    stroke(0);
    fill(200,200,0);
    graficaPlano(fg,ssfg,ffg,200,250,true);
  }
  
  void planoHUD(){
    rectMode(CENTER);
    imageMode(CENTER);
    if(cf.gmode){
      tint(255,128);
      image(imghud,400,60);
      noTint();
    }
    else{
      stroke(0);
      fill(220,220,220);
      rect(400,60,800,120);
    }  
    fill(0);
    rlj.display(650,60);
  }
  
  void gameProgress(){
    muevePlano(bg,fbg,dbg,cf.bgdx,cf.bgdy,cf.bgli,cf.bgld);  
    muevePlano(fg,ffg,dfg,cf.fgdx,cf.fgdy,cf.fgli,cf.fgld); 
    rlj.controlReloj();
    //per.move(((dir)?cf.prdxu:cf.prdxd),((dir)?cf.prdyu:cf.prdyd));
    //if(per.getY()==500 || per.getY()==700) dir=!dir;  
  }
  
  void creaP2DArray(Punto2D p[],int f[],Dado d,int xi,int yi,int dx,int dy){
    for(int i=0;i<p.length;i++){
      p[i]=new Punto2D(xi+i*dx,yi+i*dy);
      f[i]=d.tirar()-1;
    }  
  }
  
  void muevePlano(Punto2D p[],int f[],Dado d,int dx,int dy,int li,int ld){
    for(int i=0;i<p.length;i++){
      p[i].move(dx,dy);
      if(p[i].getX()<li){
        p[i].setX(ld);
        f[i]=d.tirar()-1;
      }  
    }
  }
  
  void graficaPlano(Punto2D p[],SpriteSet s,int f[],int x,int y,boolean t){
    for(int i=0;i<p.length;i++)
      if(cf.gmode){
        //if(t && p[i].getX()<=300 && p[i].getY()>=0) tint(255,128);
        image(s.getSprite(f[i]),p[i].getX(),p[i].getY());
        //if(t && p[i].getX()<=300 && p[i].getY()>=0) noTint();
      }  
      else
        rect(p[i].getX(),p[i].getY(),x,y);  
  }
}
