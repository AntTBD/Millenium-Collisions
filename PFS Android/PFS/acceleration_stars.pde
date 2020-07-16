int tempsacc;
void acceleration_stars ()
{
  tempsacc++;
  if (tempsacc>0 && tempsacc<=150)
  {
    speed=speed+2;
    stars_fin();
  }
  else{
    speed=3;
    accestars=false;
    tempsacc=0;
  } 
}