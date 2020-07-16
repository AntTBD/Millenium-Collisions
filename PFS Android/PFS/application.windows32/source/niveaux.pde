int niveau;
void niveaux ()
{
  //augmentation de la vitesse des types d'astéroïdes en focntion du score
  for (int i=0; i<nbra; i++)
  {
    for (int j=0; j<nbra_indestructible; j++)
    {
      if (score<=150)
      {
        sensXa[i]=(int)random(25, 40);
        sensXa_indestructible[j]=(int)random(25, 40);
        niveau=1;
      }
      if (score > 150 && score <= 350)
      {
        sensXa[i]=(int)random(35, 50);
        sensXa_indestructible[j]=(int)random(35, 50);
        niveau=2;
      } else if (score > 350 && score <= 600)
      {
        sensXa[i]=(int)random(45,60);
        sensXa_indestructible[j]=(int)random(45, 60);
        niveau=3;
      } else if (score > 600 && score <=1000)
      {
        sensXa[i]=(int)random(55, 70);
        sensXa_indestructible[j]=(int)random(55, 70);
        niveau=4;
      } else if (score >= 1000)
      {
        sensXa[i]=(int)random(65, 80);
        sensXa_indestructible[j]=(int)random(65, 80);
        niveau=5;
      }
    }
  }
}