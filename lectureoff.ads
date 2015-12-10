with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with modele;
use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Ada.Float_Text_IO;
use modele;

package lectureoff is

	procedure ouvrir(Nom : in String);

	procedure chargerNbSommetsNbFaces(m : in out Integer; n : in out Integer);

	function chargerSommet(m, indice : in Integer) return Sommet;

	function chargerTriangle(TS : in tableauSommet) return Triangle;

	function minimumZ(z1,z2,z3 : in float) return float;
	
	procedure testFichierOFF(test : in out boolean);

end lectureoff;
