//import com.hamoid.*;
import arb.soundcipher.*;
import processing.serial.*;
import processing.sound.*;

SoundCipher sc = new SoundCipher(this);


Serial myPort0;  // The serial port

BufferedReader reader;
int span = 21;
float radius_min = span*0.03;
float radius_max = span*0.65;
int count = 0;
int interval = 0;
String line1;
String line2;
int last_y_pos = 0;
int totalNum = 360;
float incremental = 360/totalNum;
int gap = int(5300/totalNum);
PGraphics background;
PGraphics points;
PGraphics paper;
PGraphics sides;
PGraphics sides2;
PGraphics dots;
//int screen_width = 3840*2;
//int screen_height=2160*2;

int screen_width = 1920;
int screen_height=1080;
int side_width = 300;
//int skipLine = 0;

int red_comp=0;
int green_comp=0;
int blue_comp=0;

float longterm_avg = 200;
int current_scale_factor = 3;


float rotation_deg_per_frame = 0.5;
boolean drawLines = true;

//VideoExport videoExport;
final String sketchname = getClass().getName();

int left_dist = 0;
int right_dist = 0;
int persistFactor = 1;

int dist_ss;
int dist_ss2;
int dist_avg_formula;
int dist_twr;

boolean drawLine = false;
boolean drawCircle = true;
boolean skipfew = true;
boolean savethis = false;

void setup() {
  //size(1920,1080);
  fullScreen();
  //size(7680, 4320);
  
  background = createGraphics(screen_width,screen_height);
  points = createGraphics(screen_width,screen_height);
  paper = createGraphics(screen_width,screen_height);
  dots = createGraphics(screen_width,screen_height);
  //sides = createGraphics(side_width,screen_height);
  //sides2 = createGraphics(side_width,screen_height);
  frameRate(120);
  //reader = createReader("../realtime_left.txt");
  last_y_pos = int(span*0.5) + int((height/2)/span)*span;
  println(gap);
  myPort0 = new Serial(this, Serial.list()[0], 9600);

 
  
}

void keyPressed() {
  print("Key pressed: --------");
  print(key);
  if (key>='0' && key<='9')
  {
    persistFactor = key-'0';
    if (persistFactor==0) {persistFactor=20;}
  }
  if (key=='l' || key =='L')
  {
    drawLine = true;
    drawCircle = false;
  }
  if (key=='c' || key =='C')
  {
    drawLine = false;
    drawCircle = true;
  }
  if (key=='s')
  {
    skipfew=true;
  }
  if (key=='p')
  {
    savethis=true;
  }
}

void draw() {
  if (count==0){
      paper.beginDraw();
      //paper.background(#212738);
      //paper.background(#21295c);
      paper.background(#000000);
      /*paper.pushMatrix();
      paper.translate(paper.width/2, paper.height/2);
      paper.rotate(radians(count*rotation_deg_per_frame-90));
      //background.colorMode(RGB);
      paper.strokeWeight(screen_height/200);
      paper.stroke(180,220);
      //paper.stroke(0,20);
      paper.noFill();
      for (int i = screen_height/10;i<=screen_height/2;i+=screen_height/10){
        //paper.circle(0,0,i*2);
        for( int j = 0 ; j<30;j++){
          paper.point(i*cos(radians(j*12)),i*sin(radians(j*12)));
        }
      }

      paper.popMatrix();*/
      paper.endDraw();
  }
  println(count);
  
  String port0Str="";
  String port1Str="";
  while (myPort0.available() > 0) {
    int inByte = myPort0.read();
    port0Str = port0Str + (char)inByte;
    
  }
  draw_graphics(port0Str);
  
  /*try {
    if(reader.ready()) {
      //println("Skipped", skipLine++);
      if (skipfew == true ) //||count==0 || count%2==0
      {
        long skipLine = reader.skip(1000L);
        println(skipLine);
        count++;
        skipfew = false;
      }
      
      line1 = reader.readLine();
      //print(line1);
      //line2 = reader.readLine();
    }
  } catch (IOException e) {
    e.printStackTrace();
    line1 = null;
    //line2 = null;
  }*/
  //skipLine = 0;
  //println(line1);
  
  //if (count>1) {
    //if (count%1==0) {
      image(paper,0,0);
      image(background,0,0);    
      image(points,0,0);
      image(dots,0,0);
      //rec();
    //}  
 // }
  //image(sides,0,0);
  //image(sides2,screen_width-side_width,0);
  interval++;
  //println("here5");
  if (savethis==true) {
    rec();
    savethis = false;
  }

}

void draw_graphics(String line1) {
  if(line1!=null ){
    if(count%6==0) {
      //framefader(points, 1);
      //filter(BLUR,5);
    }
    
    
    
    //points.colorMode(HSB,360,100,100);
    String[] idx = split(line1, ',');
    String pckt="";
    try{
    if (idx[0].startsWith("Packet")) {
      println(line1);
      dist_ss = int(idx[1]);
      dist_ss2 = int(idx[2]);
      dist_avg_formula = int(idx[3]);
      dist_twr = int(idx[4]);
      println(dist_ss);
      println(dist_avg_formula);
      println(dist_twr);
      
      
      count++;
    } 
    } catch(Exception ex) {
      
    }
    
    //int center_loc = left_dist - right_dist;
    //int avg_dist = abs(left_dist + right_dist)/2;
    points.colorMode(RGB, 255,255,255,100);
    points.beginDraw();
    
    
    ///////////////////////
    
    
    
    
    
    if (drawCircle==true) {
      //points.filter(BLUR,6);
      //points.noStroke();
      //points.fill(red_comp, green_comp, blue_comp, 5);
      //points.circle((screen_width/2)-(center_loc/3), screen_height/2, max(0,(avg_dist/current_scale_factor)+40));
      points.noStroke();
      points.fill(0,0,0,20);
      red_comp = 255;
      green_comp = 0;
      blue_comp = 0;
      points.fill(red_comp, green_comp, blue_comp, 100);
      points.circle((screen_width/2)+dist_ss/5, count % (screen_height), 20);
      
      red_comp = 255;
      green_comp = 100;
      blue_comp = 100;
      points.fill(red_comp, green_comp, blue_comp, 100);
      points.circle((screen_width/2)+dist_ss2/5, count % (screen_height), 20);
      
      red_comp = 0;
      green_comp = 0;
      blue_comp = 255;
      points.fill(red_comp, green_comp, blue_comp, 100);
      points.circle((screen_width/2)+dist_avg_formula/5, count % (screen_height), 30);
      
      red_comp = 0;
      green_comp = 255;
      blue_comp = 0;
      points.fill(red_comp, green_comp, blue_comp, 100);
      points.circle((screen_width/2)+dist_twr/5, count % (screen_height), 20);
      
      red_comp = 100;
      green_comp = 100;
      blue_comp = 100;
      points.fill(red_comp, green_comp, blue_comp, 100);
      points.circle((screen_width/2), count % (screen_height), 5);
      
      
      //points.strokeWeight(2);
      //points.stroke(red_comp, green_comp, blue_comp, 100);
      //points.circle((screen_width/2)-(center_loc/3), screen_height/2, avg_dist/current_scale_factor);
      
      
     
      //  
    } 
    
    points.endDraw();
    
    /*noiseDetail(8,0.65);
    
    dots.beginDraw();
    if (drawCircle==true) {
      for (int theta=0;theta<360;theta+=2) {
        dots.pushMatrix();
        dots.translate((screen_width/2)-(center_loc/3), screen_height/2);
        dots.rotate(radians(theta));
        dots.colorMode(RGB);
        dots.strokeWeight(2);
        dots.stroke(red_comp, green_comp, blue_comp);
        //paper.stroke(0,20);
        for(int manydots=0;manydots<10;manydots++) {
          dots.point((avg_dist/current_scale_factor)/2+20*(random(2,20)/random(2,20)),random(-10,10));
        }
        dots.popMatrix();
      }
    }
    else if (drawLine==true) {
      dots.pushMatrix();
      dots.colorMode(RGB);
      dots.strokeWeight(2);
      dots.stroke(red_comp, green_comp, blue_comp);
      for(int manydots=0;manydots<100;manydots++) {
        dots.point((screen_width/2)-(center_loc/3)+20*(random(2,20)/random(2,20)),random((screen_height/2)-(avg_dist/(current_scale_factor*2)),(screen_height/2)+(avg_dist/(current_scale_factor*2))));
        dots.point((screen_width/2)-(center_loc/3)-20*(random(2,20)/random(2,20)),random((screen_height/2)-(avg_dist/(current_scale_factor*2)),(screen_height/2)+(avg_dist/(current_scale_factor*2))));
      }
      dots.popMatrix();
    }
    dots.endDraw();
    */
    if (count%persistFactor==0)
    {
      framefader(points,5);
      framefader(dots,10);
      
    }
    
    
    
    
    //count++;
  }  
}

void rec() {
  /*if (frameCount==1) {
    videoExport = new VideoExport(this, "../" + sketchname + ".mp4");
    videoExport.setFrameRate(120);
    videoExport.startMovie();
  }
  videoExport.saveFrame();*/
  saveFrame("frames01/####.png");
}

void paper(int in_val, PGraphics p) {
  p.colorMode(HSB, 100, 100, 100);
  p.noStroke();
  int base = 85;
  for (int i = 0; i<width-1; i+=2) {
    for (int j = 0; j<height-1; j+=2) {
      p.fill(random(base-10, base+10), in_val);
      p.rect(i, j, 2, 2);
    }
  }

  for (int i = 0; i<30; i++) {
    p.fill(random(40, 60), random(in_val*2.5, in_val*3));
    p.rect(random(0, width-2), random(0, height-2), random(1, 3), random(1, 3));
  }
}

void framefader(PGraphics gr, int amt) {
  /*GraphicsContext ctx = ((Canvas) surface.getNative()).getGraphicsContext2D();
  GaussianBlur blur = new GaussianBlur();
  blur.setRadius(10);
  ctx.setEffect(blur);*/
  
  gr.beginDraw();
  gr.loadPixels();
  
  for (int i=0;i<gr.pixels.length;i++) {
    int alpha = (gr.pixels[i]>>24)& 0xFF;
    alpha = max(0, alpha-amt);
    gr.pixels[i]=alpha<<24 | ((gr.pixels[i])&0x00FFFFFF);
  }
  
  
  //Attempted to blur, but too much work. So given up.
  /*
  long [][] pixelBuff = new long[points.pixelWidth][points.pixelHeight];
  int v = 1;
  int kernelsize = 3;
  int k_off = (kernelsize/2)-1;
  int [][] BlurMatrix ={{v, v, v}, {v, v, v}, {v, v, v}};
  for (int i=k_off;i<points.pixelWidth-k_off;i++) {
    for (int j=k_off;j<points.pixelHeight-k_off;j++) {
      //pixelBuff[i][j] = points.pixel[(j*points.pixelHeight)+i];
      for (int iMat=0;iMat<kernelsize;iMat++) {
        for(int jMat=0;jMat<kernelsize;jMat++) {
          sum += points.pixel[((j-(jMat+k_off)*points.pixelWidth)+i-(iMat+k_off)]*
  
  */
  gr.updatePixels();
  gr.endDraw();
  // do some drawing, anything drawn from here on will be blured
  // to disable the effect, do:
  //ctx.setEffect(null);
  
  
}

void clock_render(String line) {
  //println(line);
  points.beginDraw();
    points.colorMode(HSB,360,100,100);
    //points.blendMode(ADD);
    //points.colorMode(RGB,255,255,255);
    //points.stroke(230);
    points.pushMatrix();
    points.translate(points.width/2,points.height/2);
    points.rotate(radians(count*rotation_deg_per_frame-90));
    //points.rotate(radians(current_angle));
    
    String[] idx = split(line, ';');
    //long[] valueKeyPairs = new long[idx.length];
    float[] strengths = new float[idx.length];
    float[] orig_strengths = new float[idx.length];
    int[] dists = new int[idx.length];
    sc.playNote(60, 100, 1.0);
    //println(line);
    /*
    if(idx.length > 1){
      for (int i=0; i<idx.length-1;i++) {
        
        String [] tuple = split(idx[i], ',');
        int dist=int(tuple[0]);
        float strength=float(tuple[1]);
        dist = (dist-730)/2;
        float factor_dist = max(1,dist/100);
        strength = factor_dist*strength;
        strengths[i] = strength;
        orig_strengths[i] = strength;
        dists[i] = dist;
        //println("here1");
        //println(dist);
        
         
        //valueKeyPairs[i] = (((long) Float.floatToIntBits(strength)) << 32) | (dist & 0xffffffffL);
      }
      
      sort(strengths);
      for (int i=0;i<idx.length-1;i++) {
        float strength = strengths[i];
        int index_this_strength = -1;
        for (int j=0;j<idx.length-1;j++) {
          if (orig_strengths[j] == strength) {index_this_strength = j; break;}
        }
        //println("here2");
        if (index_this_strength>=0)
        {
          int dist = dists[index_this_strength];
                
          if (dist<700) {
            float hue = map(i*40, 0, 360,0,360);
            float weight = map(dist/5,0,400,4,12);
            points.strokeWeight(weight);
            points.stroke(hue,75,70,800*strength);
            points.line(dist,0,(dist+200*strength),0);
            //println("here3");
          }
          //println("here3.1");
        }
        //println("here3.2");
      }
      //println("here3.3");
    }
    
    */
    
    
    
    if(idx.length > 1){
      for (int i=0; i<idx.length-1;i++) {
        
        String [] tuple = split(idx[i], ',');
        float dist=float(tuple[0]);
        float strength=float(tuple[1]);
        dist = abs(dist-730)/2;
        
        float factor_dist = max(2,dist/100);
        if (dist<750) {
          float hue = map(dist/2, 0, 360,0,360);
          float weight = map(dist/5,0,400,4,20);
          //points.strokeWeight(weight);
          if (count%10==0 && drawLines==true) {
            points.strokeWeight(weight);
            points.stroke(hue,75,70*strength*100,800*strength*factor_dist);
            //points.stroke(hue,75,70*strength*100,800*strength);
            points.fill(hue,120,120*strength*100,800*strength*factor_dist);
            //points.fill(hue,120,120*strength*100,500*strength*factor_dist);
            points.line((dist-100*strength*(dist/100)),0,(screen_height/1080)*(dist+200*strength*(dist/50)),0);
            //points.circle(dist, 0, 100*strength*factor_dist);
          } else {
            points.strokeWeight(0);
            //points.stroke(hue,75,70*strength*100,800*strength*factor_dist);
            points.stroke(hue,75,70*strength*100,800*strength);
            //points.fill(hue,120,120*strength*100,800*strength*factor_dist);
            points.fill(hue,120,120*strength*100,100);
            //points.line((dist-100*strength*(dist/100)),0,(screen_height/1080)*(dist+200*strength*(dist/50)),0);
            points.circle((screen_height/1080)*dist, 0, min((screen_height/10)*strength*factor_dist,screen_height/20));
          }
        }
      }
    }
    
      /*
      //float dis =  (int(idx[1]) - 40)*380/160;
      float dis =  (int(idx[1])-500)/3;
      if(dis > 0){
        for ( int i =idx.length - 1;i>=1;i--){
        //dis =  (int(idx[i]) - 40)*380/160;
        dis =  (int(idx[i])-700)/3;
        int begin = int(idx[1]);
        int end = int(idx[idx.length-1])+1;
        int val = int(idx[i]);
        float hue = map(val,begin,end,0,80);
        float r = map(val,begin,end,39,180);
        float g = map(val,begin,end,2,186);
        float b = map(val,begin,end,8,9);
        float weight = map(dis,0,400,4,8);
        points.strokeWeight(weight);
        if(i==1){
        points.stroke(hue,75,70,180);
        }
        else{
        points.stroke(hue,75,70,150);
        }

        //points.stroke(r,g,b,200);
        if (i==1)
        {
          points.line(dis,0,(dis+20),0);
        }
        else {
          points.line(dis,0,(dis+40),0);
        }
        
      }
      
      
        //points.line(0,0,dis,0);
        // if(i==1){
        // points.strokeWeight(15);
        // points.stroke(39,255);
        // points.point(dis,0);
        //points.line(dis,0,dis+20,0);
        //}

        //points.point(dis,0);
      }
    }
    else{
    }*/

    points.popMatrix();
    points.endDraw();
}


void sides_render(String line) {
  framefader(sides, 10);
  framefader(sides2, 10);
  sides.beginDraw();
  sides.colorMode(HSB,360,100,100);
  //sides.clear();
  
  //println(line);
  String[] idx = split(line,',');
  for (int i=0;i<idx.length;i++)
  {
    sides.strokeWeight(1);
    sides.stroke(360,0,float(idx[i])*1000,130);
    sides.line(0,i,float(idx[i])*1800,i);
  }
  
  
  sides.endDraw();
  
  sides2.beginDraw();
  sides2.colorMode(HSB,360,100,100);
  //sides.clear();
  
  //println(line);
  for (int i=0;i<idx.length;i++)
  {
    sides2.strokeWeight(1);
    sides2.stroke(360,0,float(idx[i])*1000,130);
    sides2.line(side_width,i,side_width - float(idx[i])*1800,i);
  }
  sides2.endDraw();
  
  /*sides.loadPixels();
  sides2.loadPixels();
  
  
  arrayCopy(sides.pixels, sides2.pixels);
  sides2.updatePixels();
  sides2.endDraw();
  
  sides2.beginDraw();
  sides2.pushMatrix();
  sides2.translate(sides2.width/2,sides2.height/2);
  sides2.rotate(radians(180));
  //sides2.pushMatrix();
  //sides2.translate(sides2.width/2,sides2.height/2);
  //sides2.rotate(radians(90));
  sides2.popMatrix();*/

  
  
}
