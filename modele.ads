with Ada.Unchecked_Deallocation;
With Ada.Text_IO;
Use Ada.Text_IO;

package modele is

type Sommet;
type Point;
type Triangle;
type DoubletTriangle;

type pointeurSommet is access Sommet;
type pointeurTriangle is access Triangle;
type pointeurListeDoubletT is access DoubletTriangle;
--Sommet 
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
	Succ:pointeurListeDoubletT;
end record;

--Type de tableau pour stocker les sommets lus
type tableauSommet is  array (integer range <>) of Sommet;

--Type de tableau pour stocker les listes chainées de triangle
type tableauDoubletTriangle is array (integer range <>) of pointeurListeDoubletT;

--Procedure permettant d'inserer un DoubletTriangle dans le tableau
procedure insererDoubletTriangle (doubleT : in out DoubletTriangle; indice : in integer; tableauDoubletT : in out tableauDoubletTriangle);

--Procedure permettant de désalouer tous les triangles du tableau
procedure desalouerTriangle ( tableauDoubletT : in tableauDoubletTriangle);


--procedure pour liberer un pointeur sur sommet
procedure FreeSommet is new Ada.Unchecked_Deallocation (Sommet, pointeurSommet);

--procedure pour liberer un pointeur sur triangle
procedure FreeTriangle is new Ada.Unchecked_Deallocation (Triangle, pointeurTriangle);

--procedure pour liberer un pointeur sur doubletTriangle
procedure FreeDT is new Ada.Unchecked_Deallocation (DoubletTriangle, pointeurListeDoubletT);

end modele;
