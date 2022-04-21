program pr;

uses Graphabc;//подключение модуля GraphABC 

type
  Dot = record
    xTochki: integer;
    yTochki: integer;
  end;
  SetDots = array of Dot;

type
  Circle = record
    xCentra: integer;
    yCentra: integer;
    Radius: integer;
  end;
  SetCircles = array of Circle;

var
  Dots: SetDots;
  Circles: SetCircles;
  s, count_dots, count_circles: integer;

procedure plus_minus;
begin
  DrawRectangle(-600, -250, -550, -200);
  DrawRectangle(-600, -300, -550, -250);
  Line(-575, -295, -575, -255);
  Line(-595, -275, -555, -275);
  Line(-595, -225, -555, -225); 
end;

procedure increase;
var
  i: integer;
begin
  for i := 1 to (length(Dots) - 1) do
  begin
    Dots[i].xTochki := Round(Dots[i].xTochki * 1.21111111);
    Dots[i].yTochki := Round(Dots[i].yTochki * 1.21111111);
  end;
  for i := 1 to (length(Circles) - 1) do
  begin
    Circles[i].xCentra := Round(Circles[i].xCentra * 1.21111111);
    Circles[i].yCentra := Round(Circles[i].yCentra * 1.21111111);
    Circles[i].Radius := Round(Circles[i].Radius * 1.21111111);
  end;
end;

procedure decrease;
var
  i: integer;
begin
  for i := 1 to (length(Dots) - 1) do
  begin
    Dots[i].xTochki := Round(Dots[i].xTochki / 1.21111111);
    Dots[i].yTochki := Round(Dots[i].yTochki / 1.21111111);
  end;
  for i := 1 to (length(Circles) - 1) do
  begin
    Circles[i].xCentra := Round(Circles[i].xCentra / 1.21111111);
    Circles[i].yCentra := Round(Circles[i].yCentra / 1.21111111);
    Circles[i].Radius := Round(Circles[i].Radius / 1.21111111);
  end;
end;

procedure left_button(x, y: integer);
begin
  count_dots += 1;
  if (count_dots mod 100 = 99) then 
    SetLength(Dots, length(Dots) + 100); 
  Dots[count_dots].xTochki := x - 600;
  Dots[count_dots].yTochki := y - 300;
  SetPixel(x - 600, y - 300, clred);
  SetPixel(x - 599, y - 300, clred);
  SetPixel(x - 600, y - 299, clred);
  SetPixel(x - 601, y - 300, clred);
  SetPixel(x - 600, y - 301, clred);
end;

procedure right_button(x, y: integer);
begin
  count_circles += 1;
  if (count_circles mod 100 = 99) then 
    SetLength(Circles, length(Circles) + 100);  
  Circles[count_circles].xCentra := x - 600;
  Circles[count_circles].yCentra := y - 300;
  SetPixel(x, y, clgreen);
  SetPixel(x - 599, y - 300, clgreen);
  SetPixel(x - 600, y - 299, clgreen);
  SetPixel(x - 601, y - 300, clgreen);
  SetPixel(x - 600, y - 301, clgreen);
end;

procedure coordinat_system;
var
  i: integer;
begin
  SetWindowSize(1000, 1000); //задаем размер графического окна
  SetCoordinateOrigin(600, 300);
  Line(-1000, 0, 1000, 0);
  Line(0, -1000, 0, 1000);
  for i := -20 to 20 do
  begin
    Line(i * 50, -10, i * 50, 10);
    Line(-10, i * 50, 10, i * 50);
  end;
  TextOut(40, -20, '50');
  TextOut(-20, 40, '50');
end;

function getChordLength(i, j, q: integer): real;
begin
  if ((Dots[i].xTochki = Dots[q].xTochki) and (Dots[i].yTochki = Dots[q].yTochki)) then
    getChordLength := 0
  else 
  if(Dots[i].xTochki = Dots[q].xTochki) then
    getChordLength := sqr(Circles[j].Radius) - sqr(Circles[j].xCentra - Dots[i].xTochki)
    else 
  if (Dots[i].yTochki = Dots[q].yTochki) then
    getChordLength := sqr(Circles[j].Radius) - sqr(Circles[j].yCentra - Dots[i].yTochki)
  else
    getChordLength := sqr(Circles[j].Radius) - sqr(Circles[j].xCentra - (Dots[i].yTochki - Dots[i].xTochki * (Dots[q].yTochki - Dots[i].yTochki) / (Dots[q].xTochki - Dots[i].xTochki) - (Circles[j].yCentra - Circles[j].xCentra * (Dots[i].xTochki - Dots[q].xTochki) / (Dots[q].yTochki - Dots[i].yTochki))) / ((Dots[i].xTochki - Dots[q].xTochki) / (Dots[q].yTochki - Dots[i].yTochki) - (Dots[q].yTochki - Dots[i].yTochki) / (Dots[q].xTochki - Dots[i].xTochki))) - sqr(Circles[j].yCentra - ((Dots[i].xTochki - Dots[q].xTochki) / (Dots[q].yTochki - Dots[i].yTochki) * (Dots[i].yTochki - Dots[i].xTochki * (Dots[q].yTochki - Dots[i].yTochki) / (Dots[q].xTochki - Dots[i].xTochki) - (Circles[j].yCentra - Circles[j].xCentra * (Dots[i].xTochki - Dots[q].xTochki) / (Dots[q].yTochki - Dots[i].yTochki))) / ((Dots[i].xTochki - Dots[q].xTochki) / (Dots[q].yTochki - Dots[i].yTochki) - (Dots[q].yTochki - Dots[i].yTochki) / (Dots[q].xTochki - Dots[i].xTochki)) + Circles[j].yCentra - Circles[j].xCentra * (Dots[i].xTochki - Dots[q].xTochki) / (Dots[q].yTochki - Dots[i].yTochki)));
end;

function Y_On_Line(x, x1, y1, x2, y2: integer): integer;
begin
  Y_On_Line := Round((x - x1) * (y1 - y2) / (x1 - x2) + y1);
end;

procedure Big_Line(x1, y1, x2, y2: integer);
begin
  if ((x1 <> x2) or (y1 <> y2)) then
    if (x1 = x2) then
      Line(x1, 1000, x2, 1000)
    else
    if (y1 = y2) then
      Line(y1, 1000, y2, 1000)
    else
      Line(1000, Y_On_Line(1000, x1, y1, x2, y2), -1000, Y_On_Line(-1000, x1, y1, x2, y2));
end;

procedure Perebor(var imax, jmax, qmax: integer; max_chord_length: real);
var
  i, j, q: integer;
  current_chord_length: real;
begin
  current_chord_length := 0;
  for j := 1 to (count_circles) do
    for i := 1 to (count_dots - 1) do 
      for q := i + 1 to (count_dots) do
      begin
        drawcircle(Circles[j].xCentra, Circles[j].yCentra, Circles[j].Radius);
        current_chord_length := getChordLength(i, j, q);
        if current_chord_length > max_chord_length then    
        begin
          imax := i;
          qmax := q;
          jmax := j;
          max_chord_length := current_chord_length;
        end;
        Big_Line(Dots[i].xTochki, Dots[i].yTochki, Dots[q].xTochki, Dots[q].yTochki);
      end; 
end;

procedure Rabota;
var
  imax, qmax, jmax, j, i, q: integer;
  max_chord_length: real;
begin
  Window.Clear;
  plus_minus;
  imax := 1;
  qmax := 2;
  jmax := 1;
  max_chord_length := getChordLength(imax, jmax, qmax);
  Perebor(imax, jmax, qmax, max_chord_length);
  SetPenColor(clRed);
  drawcircle(Circles[jmax].xCentra, Circles[jmax].yCentra, Circles[jmax].Radius);
  Big_Line(Dots[imax].xTochki, Dots[imax].yTochki, Dots[qmax].xTochki, Dots[qmax].yTochki);
  SetPenColor(clBlack);
end;

procedure Mashtab(x, y, mb: integer);//нажали кнопку мыши 
var
  i: integer;
begin
  if mb = 0 then
    if ((x > 0) and (x < 50) and (y > 0) and (y < 50)) then 
      increase;
  
  if ((x > 0) and (x < 50) and (y > 50) and (y < 100)) then 
    decrease;
  Rabota;
end;

procedure vvodsklaviatury;
var
  i, j: integer;
  s1, s2 : string;
begin
  DrawTextCentered(-300,-300,-50,-200,'Введите количество окружностей и количество точек');
  readln(count_circles, count_dots);
  FillRectangle(-300,-300,-50,-200); 
  SetLength(Dots, count_dots + 1);
  SetLength(Circles, count_circles + 1);
  for i := 1 to (length(Dots) - 1) do
  begin
    str(i,s1);
    s2 := 'Введите x,y- координаты ' + s1 + ' точки';
    DrawTextCentered(-300, -300, -50, -200, s2);
    readln(Dots[i].xTochki, Dots[i].yTochki);
    FillRectangle(-300,-300,-50,-200); 
  end;
  for j := 1 to (length(Circles) - 1) do
  begin
    str(j,s1);
    s2 := 'Введите x,y- координаты центра ' + s1 + ' окружности и ее радиус';
    DrawTextCentered(-300, -300, -50, -200, s2);
    readln(Circles[j].xCentra, Circles[j].yCentra, Circles[j].Radius);
    FillRectangle(-300,-300,-50,-200); 
  end;
end;

procedure MouseDown(x, y, mb: integer);//нажали кнопку мыши
begin
  if mb = 1 then begin
    left_button(x, y);
  end;
  if mb = 2 then begin
    s += 1;  
    if (s mod 2) = 1 then//кликнем первый раз, запомним координаты 1 вершины
    begin
      right_button(x, y);
    end
    else begin//кликнем второй раз, 
      Circles[count_circles].Radius := Round(sqrt(sqr(Circles[count_circles].xCentra - x + 600) + sqr(Circles[count_circles].yCentra - y + 300)));
      drawCircle(Circles[count_circles].xCentra, Circles[count_circles].yCentra, Circles[count_circles].Radius);
    end;    
  end; 
  if (mb = 0) then
    if ((x < 0) or (x > 50) or (y < 0) or (y > 100)) then
      Rabota
    else begin
      Mashtab(x, y, mb); 
    end;
end;

procedure zapoln_file(var i, t, k, l, code: integer; var str: string; var f: text);
begin
  if k = 0 then begin
    if (count_dots mod 100 = 99) then
      SetLength(Dots, length(Dots) + 100);
    count_dots += 1;       
    Val(str, Dots[t].xTochki, code); 
  end;
  if k = 1 then      
    Val(str, Dots[t - l].yTochki, code); 
  if k = 2 then begin
    if (count_circles mod 100 = 99) then
      SetLength(Circles, length(Circles) + 100);
    count_circles += 1;       
    Val(str, Circles[t - l].xCentra, code);
  end;
  if k = 3 then       
    Val(str, Circles[t - l].yCentra, code); 
  if k = 4 then        
    Val(str, Circles[t - l].Radius, code);  
end;

procedure read_from_file;
var
  f: text;
  str, file_name: string;
  i, t, k, l, code: integer;
begin
  writeln('Введите путь к файлу');
  readln(file_name);
  assign(f, file_name);
  reset(f);
  while (k < 5) do
  begin
    t += 1;
    str := ReadString(f);
    if str = '#' then begin
      k += 1;
      l := t;
    end
    else 
      zapoln_file(i, t, k, l, code, str, f);
  end;  
end;

procedure Menu;
var
  Vybor: integer;
begin
  DrawTextCentered(-300,-300,-50,-200,'Выберите способ задания данных (1 - ввод с консоли, 2 - графический ввод, иначе чтение данных из файла)'); 
  readln(Vybor);
  FillRectangle(-300,-300,-50,-200);
  if Vybor = 1 then begin
    vvodsklaviatury;
    Rabota
  end else
  if Vybor = 2 then
    OnMouseDown := MouseDown
  else begin
    read_from_file;
    Rabota;
  end; 
end;

begin
  SetLength(Dots, 100);
  SetLength(Circles, 100);
  OnMouseDown := Mashtab;
  coordinat_system;
  plus_minus;
  Menu;
end.