import processing.sound.*;

SoundFile venceuEfeito;

public class Bolinha
{
  public float x;
  public float y;
  public color cor;
  public boolean estaNoLugarCorreto;
  
  Bolinha(float x, float y, color cor)
  {
    this.x = x;
    this.y = y;
    this.cor = cor;
    this.estaNoLugarCorreto = false;
  }
}

float xCestaVermelha;
float yCestaVermelha;

float xCestaCentral;
float yCestaCentral;

float xCestaAzul;
float yCestaAzul;

float larguraCesta;
float alturaCesta;

ArrayList<Bolinha> bolinhas;
color cores[];

int qtdeBolinhas;
float diametroBolinhas;

boolean todasBolinhasCorretas;
boolean somDeVitoriaJaFoiTocado;

void setup()
{
  size(800, 600);
  textSize(20);
  frameRate(60);

  venceuEfeito = new SoundFile(this, "tada-fanfare.mp3");
  
  xCestaVermelha = 0 * width/3 + 140;
  yCestaVermelha = 400;
  
  xCestaCentral = 1 * width/3 + 140;
  yCestaCentral = 400;
  
  xCestaAzul = 2 * width/3 + 140;
  yCestaAzul = 400;
  
  larguraCesta = 200;
  alturaCesta = 200;
  
  qtdeBolinhas = 5;
  diametroBolinhas = 50;
  
  bolinhas = new ArrayList<Bolinha>();
  cores = new color[] {#FF0000, #0000FF};
  
  for (int i = 0; i < qtdeBolinhas; i++)
  {
    bolinhas.add(new Bolinha(
                        xCestaCentral + random(-diametroBolinhas,
                        diametroBolinhas), yCestaCentral + random(-diametroBolinhas, diametroBolinhas),
                        cores[(int) Math.round(random(0, 1))]
                      ));
  }
  
  todasBolinhasCorretas = false;
  somDeVitoriaJaFoiTocado = false;
}

void draw()
{
  background(255);
  
  desenhaCesta(xCestaVermelha, yCestaVermelha, larguraCesta, alturaCesta, #FF0000);
  desenhaCesta(xCestaCentral, yCestaCentral, larguraCesta, alturaCesta, #000000);
  desenhaCesta(xCestaAzul, yCestaAzul, larguraCesta, alturaCesta, #0000FF);
  
  desenhaBolinhas();
  verificaSeMouseDentroDeAlgumaBolinha();
  
  verificaSeTodasBolinhasCorretas();
  
  todasBolinhasCorretas = true;
  bolinhas.forEach((bolinha) -> {
    if (!bolinha.estaNoLugarCorreto)
    {
      todasBolinhasCorretas = false;
    }
  });
  
  if (todasBolinhasCorretas)
  {
    fill(0);
    String texto = "Parabéns, todas as bolinhas estão nos devidos lugares!";
    
    text(texto, width/2 - textWidth(texto) / 2, height/2);
    
    if (!venceuEfeito.isPlaying() && !somDeVitoriaJaFoiTocado)
    {
      venceuEfeito.play();
      somDeVitoriaJaFoiTocado = true;
    }
  }
  else
  {
   somDeVitoriaJaFoiTocado = false; 
  }
}

void desenhaCesta(float x, float y, float largura, float altura, color cor)
{
  stroke(cor);
  noFill();
  strokeWeight(2);
  arc(x, y, largura, altura, 0, PI);
}

void desenhaBolinhas()
{ 
   bolinhas.forEach((bolinha) -> {
     fill(bolinha.cor);
     stroke(0);
     circle(bolinha.x, bolinha.y, diametroBolinhas); 
 });
}

void verificaSeMouseDentroDeAlgumaBolinha()
{
  for (int i = 0; i < bolinhas.size(); i++)
  { 
    Bolinha bolinha = bolinhas.get(i);
   
    if (dist(bolinha.x, bolinha.y, mouseX, mouseY) < diametroBolinhas / 2)
    {
      if (mousePressed)
      {
        bolinha.x = mouseX;
        bolinha.y = mouseY;
        break;
      }
    }
  }; 
}

void verificaSeTodasBolinhasCorretas()
{
  bolinhas.forEach((bolinha) -> {
    if (dist(bolinha.x, bolinha.y, xCestaVermelha, yCestaVermelha) < larguraCesta / 2)
    {
      if (bolinha.cor == #FF0000)
      {
         bolinha.estaNoLugarCorreto = true;
      }
      else
      {
        bolinha.estaNoLugarCorreto = false;
      }
    }
    else if (dist(bolinha.x, bolinha.y, xCestaAzul, yCestaAzul) < larguraCesta / 2)
    {
      if (bolinha.cor == #0000FF)
      {
         bolinha.estaNoLugarCorreto = true;
      }
      else
      {
        bolinha.estaNoLugarCorreto = false;
      }
    }
    else
    {
      bolinha.estaNoLugarCorreto = false;
    }
  });
}
