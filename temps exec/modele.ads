with Ada.Unchecked_Deallocation;
With Ada.Text_IO;
Use Ada.Text_IO;

package modele is
--~ Structure comportant 3 flotant, x, y, z pour représenter les coordonnées d'un point
type Sommet;

--~ Structure comportant 3 sommet, et un flotant (le minimum z des trois sommets) pour representer un Triangle
type Triangle;

--~ Structure permetant de représenter une liste chainé de triangle
type DoubletTriangle;

--~ Pointeur sur un sommet
type pointeurSommet is access Sommet;

--~ Pointeur sur un triangle
type pointeurTriangle is access Triangle;

--~ Pointeur sur un élement d'une liste de triangle
type pointeurListeDoubletT is access DoubletTriangle;

--~ Pointeur sur n'importe quel element de la liste de triangle
type pointeurSurPointeurDT is access all DoubletTriangle;

--Corps de la structure Sommet 
type Sommet is 
record 
	x:Float;
	y:Float;
	z:Float;
end record;

--Corps de la structure Point
type Point is 
record 
	x:Float;
	y:Float;
end record;

--Corps de la structure Triangle
type Triangle is 
record 
	s1:pointeurSommet;
	s2:pointeurSommet;
	s3:pointeurSommet;
	minZ: Float;
end record;

--Corps de la structure DoubletTriangle
type DoubletTriangle is 
record 
	Objet:Triangle;
	Succ:pointeurSurPointeurDT;
end record;

--Type de tableau pour stocker les sommets lus
type tableauSommet is  array (integer range <>) of Sommet;

--Type de tableau pour stocker les listes chainées de triangle
type tableauDoubletTriangle is array (integer range <>) of pointeurSurPointeurDT;

--Procedure permettant d'inserer un DoubletTriangle dans le tableau
procedure insererDoubletTriangle (ptdoubleT : in out pointeurSurPointeurDT; indice : in integer; tableauDoubletT : in out tableauDoubletTriangle);

--Procedure permettant de désalouer tous les triangles du tableau
procedure desalouerTriangle ( tableauDoubletT : in tableauDoubletTriangle);


--procedure pour liberer un pointeur sur sommet
procedure FreeSommet is new Ada.Unchecked_Deallocation (Sommet, pointeurSommet);

--procedure pour liberer un pointeur sur triangle
procedure FreeTriangle is new Ada.Unchecked_Deallocation (Triangle, pointeurTriangle);

--procedure pour liberer un pointeur sur doubletTriangle
procedure FreeDT is new Ada.Unchecked_Deallocation (DoubletTriangle, pointeurListeDoubletT);

--procedure pour liberer un pointeur sur n'importe quel doubletTriangle
procedure FreePSDT is new Ada.Unchecked_Deallocation (DoubletTriangle, pointeurSurPointeurDT);


end modele;
