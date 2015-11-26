package modele is

type Sommet;
type Point;
type Triangle;
type DoubletTriangle;


type pointeurDoubletT is access Triangle;


--Sommet 
type pointeurSommet is access Sommet;

type Sommet is 
record 
	x:Float;
	y:Float;
	z:Float;
end record;

--Point
type Point is 
record 
	x:Float;
	y:Float;
end record;

--Triangle
type Triangle is 
record 
	s1:pointeurSommet;
	s2:pointeurSommet;
	s3:pointeurSommet;
	minZ: Float;
end record;

--DoubletTriangle
type DoubletTriangle is 
record 
	Objet:Triangle;
	Succ:pointeurDoubletT;
end record;

type tableauSommet is array (integer range <>) of Sommet;
type tableauTriangle is array (integer range <>) of Triangle;
type tableauDoubletTriangle is array (integer range <>) of DoubletTriangle; 

end modele;
