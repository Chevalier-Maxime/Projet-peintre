-- Git : Heloise-fernandes
-- Pwd : féeNovembre

package body lectureoff is

	fichier : Ada.Text_IO.File_Type;

	procedure ouvrir(Nom : in String) is
		begin
			Open(fichier, Ada.Text_IO.In_File, Nom&".off");
	end ouvrir; 

-- sudo apt-get install git 
-- get clone add du repo
-- git pull
-- git push
-- git add .
-- git commit -m "blop" 


-- lire le nb de sommet m et le nobre de face n
-- Creer un tableau de sommets de taille m

	procedure chargerNbSommetsNbFaces(m : in out Integer; n : in out Integer) is

		carac : string :="";
		
		begin
		if not (End_of_file(fichier)) then
			--On ne lit pas la première ligne
			Skip_Line (fichier);
			get(fichier, m);
			get(fichier, n);
			Skip_Line (fichier);
		end if;
	end chargerNbSommetsNbFaces;

	function chargerSommet(m, indice : in Integer) return Sommet is

		s : Sommet;
		x,y,z : Float;
		begin
		s:=(0.0,0.0,0.0);
		if not (End_of_file(fichier)) and m/=indice then
			
			Get(fichier, x);
			Get(fichier, y);
			Get(fichier, z);
			Skip_Line (fichier);
			s:= (x,y,z);
			
		end if;
		return s;
		
	end chargerSommet;

	function chargerTriangle(TS : in tableauSommet) return Triangle is

			t : Triangle;
			nbPoint,p1,p2,p3 : integer := 0;
			pointeur1,pointeur2,pointeur3 : pointeurSommet;
			min: float;
		begin
		nbPoint:=0;

		if not (End_of_file(fichier))then
			Get(fichier, nbPoint);
			
			if (nbPoint=3)then
				Get(fichier, p1);
				Get(fichier, p2);
				Get(fichier, p3);
				--On recupere les donnees
				pointeur1 := new Sommet;
		        pointeur2 := new Sommet;
		        pointeur3 := new Sommet;
				pointeur1.all := TS(p1);
		        pointeur2.all := TS(p2);
		        pointeur3.all := TS(p3);
				min:=minimumZ(pointeur1.z,pointeur2.z,pointeur3.z);
				
			end if;
			--Creation du triangle
			Skip_Line (fichier);
			t:= (pointeur1,pointeur2,pointeur3,min);
			
		end if;
		
		return t;
		
	end chargerTriangle;

	function minimumZ(z1,z2,z3 : in float) return float is

			m : float;

		begin
			if(z1<=z2)and(z1<=z3) then 
				m := z1
			end if;
			if(z2<=z1)and(z2<=z3) then 
				m := z2
			end if;
			if(z3<=z2)and(z3<=z1) then 
				m := z3
			end if;
	end minimumZ;



end lectureoff;
