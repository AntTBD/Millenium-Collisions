void collision_missiles ()
{
  for (int i=0; i<nbra; i++)
  {
    if ((tabXm+tailleXm>tabXa[i]) && (tabXm<tabXa[i]+tailleXa) && (tabYm)<(tabYa[i]+tailleYa) && ((tabYm+tailleYm)>tabYa[i])) 
    {
      //remise à zero du tir
      tir=0;
      
      //lancement du son
      missile_tir.play();

      //image explosion
      image(explosion, tabXa[i]-50, tabYa[i], 200, 200);

      collision_missiles=false;
      
      //remise du missile au point de départ
      tabXm=tailleXf+fuseeX;
      tabYm=mouseY-10;

      //remise des asteroides au point de depart
      tabXa[i]=(int)random(width, 2*width);
      tabYa[i]=(int)random(0, height-tailleYa);

      //incrementation du nombre d'astéroides détruits
      compteur_asteroide+=1;
    }
  }
}