int contaminados = 1;
int curados = 0;
int mortos = 0;

int populacao = 500;
int saudaveis = 0;

int pop_inicial = populacao;
int casos_in = contaminados;

int num_c = contaminados;
int num_mortos = 0;
int num_uti = 0;
int num_hospital = 0;
int total_hospital = 0;
int num_saudaveis = pop_inicial - num_c;
int num_recuperados = 0;

PFont font;
PFont font_black;

//color contaminados_color = color(250,0,0);
//color curados_color = color(5,200,15);
//color mortos_color = color(0,0,0);
//color saudaveis_color = color(5,180,200);

ParticleSystem ps;

void setup(){
  //fullScreen();
  size(1080, 1080);
  background(244, 244, 244);
  noStroke();
  saudaveis = populacao - contaminados;
  ps = new ParticleSystem();
  font = createFont("sf_medium.otf", 12);
  font_black = createFont("sf_black.otf", 12);
  textFont(font);
  frameRate(60);
  for(int i=0;i<contaminados;i++){
    ps.addParticle(1);
  }
  for(int i=0;i<populacao-contaminados;i++){
    ps.addParticle(0);
  }
  fill(244, 244, 244);
  text("@menino.samuel", width-140, height-15);
}

void draw(){
  background(244, 244, 244);
  /*if(populacao > 0){
    if(contaminados > 0){
      ps.addParticle(1);
      contaminados--;
    }else {
      ps.addParticle(0);
    }
    populacao--;
  }*/
  ps.run();
  noStroke();
  fill(34, 34, 34);
  rect(0.7*width, 0, 0.3*width, height);
  fill(20,75,255);
  textSize(12);
  textFont(font);
  text("Caso 1: Todos circulando", 0.7*width + 15, 30);
  fill(244, 244, 244);
  text("População inicial: ", 0.7*width + 15, 80);
  text("Saudaveis: ", 0.7*width + 15, 160);
  text("Foram infectados: ", 0.7*width + 15, 240);
  textFont(font_black);
  fill(250,0,95);
  text("Infectados na UTI: ", 0.7*width + 15, 320);
  text("Infectados no hospital: ", 0.7*width + 15, 400);
  text("Mortos: ", 0.7*width + 15, 480);
  textFont(font);
  fill(244,244,244);
  text("Se recuperaram: ", 0.7*width + 15, 560);
  textSize(24);
  text(pop_inicial, 0.7*width + 15, 125);
  text((pop_inicial - num_c - num_mortos), 0.7*width + 15, 205);
  text(num_c, 0.7*width + 15, 285);
  textFont(font_black);
  textSize(24);
  fill(250,0,95);
  text(num_uti, 0.7*width + 15, 365);
  text((num_hospital+num_uti), 0.7*width + 15, 445);
  text(num_mortos, 0.7*width + 15, 525);
  textFont(font);
  textSize(24);
  fill(244,244,244);
  text(num_recuperados, 0.7*width + 15, 605);
  
  saveFrame("case1/frame-####.png");
}

class Particle {
  PVector position;
  PVector velocity;
  int categ;
  int d = 2;
  int t = 10;
  int idade;
  int morre = 0;
  int tempo = 0;
  int tempo_necessario = int(random(1800, 3000));
  int hospital = 0;
  
  Particle(PVector l, int c){
    position = l.copy();
    velocity = PVector.random2D();
    categ = c;
    idade = int(random(10, 89));
    float aleatorio = random(0, 100);
    if(idade >= 10 && idade <= 19){
      if(aleatorio <= 0.02){
        morre = 1;
      }
    }else if(idade >= 20 && idade <= 29){
      if(aleatorio <= 0.09){
        morre = 1;
      }
    }else if(idade >= 30 && idade <= 39){
      if(aleatorio <= 0.18){
        morre = 1;
      }
    }else if(idade >= 40 && idade <= 49){
      if(aleatorio <= 0.4){
        morre = 1;
      }
    }else if(idade >= 50 && idade <= 59){
      if(aleatorio <= 1.3){
        morre = 1;
      }
    }else if(idade >= 60 && idade <= 69){
      if(aleatorio <= 4.6){
        morre = 1;
      }
    }else if(idade >= 70 && idade <= 79){
      if(aleatorio <= 9.8){
        morre = 1;
      }
    }else if(idade >= 80){
      if(aleatorio <= 18){
        morre = 1;
      }
    }
    
    float prob = random(0, 100);
    
    if(prob >=0 && prob <= 5){
      hospital = 2;
    }else if(prob <= 20 && prob > 5){
      hospital = 1;
    }
    
    /*float prob_2 = random(0, 100);
    
    if(prob_2 <= 3*100/4){
      velocity.x = 0;
      velocity.y = 0;
    }*/
    
  }
  
  void run(){
    update();
    display();
  }
  
  void update(){
    position.add(velocity);
    if(categ==1){
      tempo++;
    }
    if(tempo > tempo_necessario){
      num_recuperados++;
      categ = 2;
      velocity = PVector.random2D();
      /*if(hospital == 1){
        num_hospital--;
      }else if(hospital == 2){
        num_uti--;
      }*/
      //hospital = 0;
      tempo = 0;
    }
    total_hospital = num_hospital + num_uti;
  }
  
  void display(){
    
    if(categ == 1 && hospital == 1){
        strokeWeight(1);
        stroke(255,180,0);
    }else if(categ == 1 && hospital == 2){
        strokeWeight(1);
        stroke(34,34,34);
    }else{
        noStroke();
    }
    
    switch(categ){
      case(0):
        fill(20,75,255);
        break;
      case(1):
        fill(250,0,95);
        break;
      case(2):
        fill(206,240,0);
        break;
      case(3):
        fill(34,34,34);
        break;
      default:
        fill(20,75,255);
        break;
    }
    
    ellipse(position.x, position.y, t, t);
    
  } 
  
  void checkBoundaryCollision(){
    if(position.x > 0.7*width-(d/2)){
      position.x = 0.7*width-(d/2);
      velocity.x *= -1;
    } else if(position.x < (d/2)){
      position.x = d/2;
      velocity.x *= -1;
    } else if (position.y > height - (d/2)){
      position.y = height - (d/2);
      velocity.y *= -1;
    } else if (position.y < (d/2)){
      position.y = d/2;
      velocity.y *= -1;
    }
  }
  
  void checkCollision(Particle other){
    
    PVector distanceVect = PVector.sub(other.position, position);
    
    float distanceVectMag = distanceVect.mag();
    
    float minDistance = (d/2) + (other.d/2);
    
    if(distanceVectMag < minDistance) {
      if(categ == 1 && other.categ == 0){
        if(other.morre == 1){
          other.categ = 3;
          //num_c++;
          num_mortos++;
          /*if(other.hospital == 1){
            num_hospital--;
          }else if(other.hospital == 2){
            num_uti--;
          }*/
          //println(num_mortos);
        }else{
          other.categ = 1;
          num_c++;
          /*if(hospital == 2){
            num_uti++;
          }else if(hospital == 1){
            num_hospital++;
          }*/
        }
      }else if (other.categ == 1 && categ == 0){
        if(morre == 1){
          categ = 3;
          //num_c++;
          num_mortos++;
          /*if(hospital == 1){
            num_hospital--;
          }else if(hospital == 2){
            num_uti--;
          }*/
          //println(num_mortos);
        }else{
          categ = 1;
          num_c++;
          /*if(hospital == 2){
            num_uti++;
          }else if(hospital == 1){
            num_hospital++;
          }*/
        }
      }
      
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);
      
      PVector[] vTemp = {
        new PVector(), new PVector()
      };
      
      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;
      
      other.velocity.x = vTemp[1].x;
      other.velocity.y = vTemp[1].y;
      
      velocity = vTemp[0];
    }
    
  }
  
  boolean isDead() {
    if(categ == 3){
      return true;
    }else {
      return false;
    }
  }
  
  boolean inHospital(){
    if(categ == 1 && (hospital==1 || hospital==2)){
      return true;
    }else {
      return false;
    }
  }
  
}

class ParticleSystem {
  
  ArrayList <Particle> particles;
  PVector origin;
  
  ParticleSystem(){
    //origin = position.copy();
    particles = new ArrayList<Particle>();
  }
  
  void addParticle(int categ) {
    origin = new PVector(random(0.7*width), random(height));
    particles.add(new Particle(origin, categ));
  }
  
  void run(){
    num_hospital = 0;
    num_uti = 0;
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      p.checkBoundaryCollision();
      for(int j = particles.size()-1; j >= 0; j--) {
        if(j != i && !p.isDead()){
          Particle c = particles.get(j);
          if(!c.isDead()){
            p.checkCollision(c);
          }
        }
      }
      if (p.isDead() || p.inHospital()){
        p.velocity.x = 0;
        p.velocity.y = 0;
      }
      if(p.categ == 1 && p.hospital == 1){
        num_hospital++;
      }else if(p.categ == 1 && p.hospital == 2){
        num_uti++;
      }
    }
  }
  
}
