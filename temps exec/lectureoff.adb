package body lectureoff is

	fichier : Ada.Text_IO.File_Type;

	--*************************************************************************************
	--Fonction d'ouverture du fichier
	--*************************************************************************************
	procedure ouvrir(Nom : in String) is
		begin
			Open(fichier, Ada.Text_IO.In_File, Nom&".off");
	end ouvrir; 

	--*************************************************************************************
	--Fonction de chargement du nombre de sommet et du nombre de face
	--*************************************************************************************
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

	--*************************************************************************************
	--Fonction qui lit et renvoie un sommet
	--*************************************************************************************
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

	--*************************************************************************************
	--Fonction qui lit et creer un triangle
	--*************************************************************************************
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
		        
		        if (p1<TS'LENGTH) and then (p2<TS'LENGTH) and then (p3<TS'LENGTH) then
					pointeur1.all := TS(p1);
					pointeur2.all := TS(p2);
					pointeur3.all := TS(p3);
					min:=minimumZ(pointeur1.z,pointeur2.z,pointeur3.z);
					Skip_Line (fichier);
					t:= (pointeur1,pointeur2,pointeur3,min);
				else
					--PB : Le point n'existe pas
					pointeur1:=null;				
				end if;	
			else
			--PB : Ce n'est pas un triangle
			pointeur1:=null;
			end if;
		else
		--PB : Le fichier est terminé
		pointeur1:=null;
		end if;
		
		return t;
		
	end chargerTriangle;

	--*************************************************************************************
	--Fonction de calcul du z minimum
	--*************************************************************************************
	function minimumZ(z1,z2,z3 : in float) return float is

		m : float;

		begin
			if(z1<=z2)and(z1<=z3) then 
				m := z1;
			end if;
			if(z2<=z1)and(z2<=z3) then 
				m := z2;
			end if;
			if(z3<=z2)and(z3<=z1) then 
				m := z3;
			end if;
			return m;
	end minimumZ;



end lectureoff;
