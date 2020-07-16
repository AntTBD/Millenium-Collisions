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
        sensXa[i]=(int)random(5, 10);
        sensXa_indestructible[j]=(int)random(5,10);
        niveau=1;
      }
      if (score > 150 && score <= 350)
      {
        sensXa[i]=(int)random(10, 15);
        sensXa_indestructible[j]=(int)random(10, 15);
        niveau=2;
      } else if (score > 350 && score <= 600)
      {
        sensXa[i]=(int)random(15, 20);
        sensXa_indestructible[j]=(int)random(15, 20);
        niveau=3;
      } else if (score > 600 && score <=1000)
      {
        sensXa[i]=(int)random(20, 25);
        sensXa_indestructible[j]=(int)random(20, 25);
        niveau=4;
      } else if (score >= 1000)
      {
        sensXa[i]=(int)random(25, 30);
        sensXa_indestructible[j]=(int)random(25, 30);
        niveau=5;
      }
    }
  }
}
