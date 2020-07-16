int tempsacc;
int flou;


void acceleration_stars ()
{
  //lancement décompte
  tempsacc++;
  
  if (tempsacc>0 && tempsacc<=180)//pendant environs 2s
  {
    fill(255);
    speed=sqrt(speed)*4;//accélération des stars
    stars_fin();
    fill(0,4);
    noStroke();
    rect(0,0,width,height);
    
    
  }else if (tempsacc>180 && tempsacc<=200){
    flou++;
    speed=speed/speed;
    if (speed<3){
      speed=3;
    }
    stroke(0,flou);
    stars_fin();
    fill(0,20);
    noStroke();
    rect(0,0,width,height);
    
  }
    
    
  else{
    speed=3;
    accestars=false;
    tempsacc=0;
  } 
}
