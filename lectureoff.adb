package body lectureoff is

	fichier : Ada.Text_IO.File_Type;
	
	--*************************************************************************************
	--Fonction d'ouverture du fichier
	--*************************************************************************************
	procedure ouvrir(Nom : in String) is
		estUnFichierOFF : boolean := false;
		begin
		declare
			FICHIER_TERMINE_ERROR : exception ;
			MAUVAIS_TYPE_DE_FICHIER_ERROR : exception ;
		begin
			Open(fichier, Ada.Text_IO.In_File, Nom&".off");
			testFichierOFF(estUnFichierOFF);
			if (estUnFichierOFF) then
				Skip_Line (fichier);
			else
				raise MAUVAIS_TYPE_DE_FICHIER_ERROR ;
			end if;
			
		exception
			when MAUVAIS_TYPE_DE_FICHIER_ERROR => put_line("Je ne peux lire que des fichier OFF!") ; 
			when others    => put_line("J'ai rencontré une erreur fatale !") ;
		end ;	
	end ouvrir; 

	--*************************************************************************************
	--Fonction de chargement du nombre de sommet et du nombre de face
	--*************************************************************************************
	procedure chargerNbSommetsNbFaces(m : in out Integer; n : in out Integer) is
		begin
		declare
			FICHIER_TERMINE_ERROR : exception ;
		begin
		
		if not (End_of_file(fichier)) then
			get(fichier, m);
			get(fichier, n);
			Skip_Line (fichier);
		else
				raise FICHIER_TERMINE_ERROR ;
		end if;
		
		exception
			when FICHIER_TERMINE_ERROR => put_line("Je n'ai plus de ligne ou de caractère à lire dans ce fichier") ; 
			when others    => put_line("J'ai rencontré une erreur fatale !") ;
		end ;	
	end chargerNbSommetsNbFaces;
	--*************************************************************************************
	--Fonction qui vérifie que le fichier est bien un fichier OFF
	--*************************************************************************************
	procedure testFichierOFF(test : in out boolean) is
		carac : Character;
		nom : string(1..3);
		begin
		get(fichier, carac);
		nom(1):= carac;
		get(fichier, carac);
		nom(2):= carac;
		get(fichier, carac);
		nom(3):= carac;
		test:= (nom = "OFF");
	end;


	--*************************************************************************************
	--Fonction qui lit et renvoie un sommet
	--*************************************************************************************
	function chargerSommet(m, indice : in Integer) return Sommet is

		s : Sommet;
		x,y,z : Float;
		begin
		declare
			FICHIER_TERMINE_ERROR : exception ;
			PLUS_DE_POINTS : exception ;
		begin
		s:=(0.0,0.0,0.0);
		
		if not (End_of_file(fichier)) and m/=indice then
			Get(fichier, x);
			Get(fichier, y);
			Get(fichier, z);
			Skip_Line (fichier);
			s:= (x,y,z);
			return s;
		else
		if (End_of_file(fichier)) then
				raise FICHIER_TERMINE_ERROR ;
		else
			raise PLUS_DE_POINTS ;
		end if;
		end if;
		
		exception
			when FICHIER_TERMINE_ERROR => put_line("Je n'ai plus de ligne ou de caractère à lire dans ce fichier") ; 
			when PLUS_DE_POINTS => put_line("Je n'ai plus de point à lire!") ; 
			when others    => put_line("J'ai rencontré une erreur fatale !") ;
		end;
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
		declare
			FICHIER_TERMINE_ERROR : exception ;
			PAS_DE_POINT_ERROR : exception ;
			PAS_UN_TRIANGLE_ERROR : exception ;
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
					return t;
				else
					--PB : Le point n'existe pas
					raise PAS_DE_POINT_ERROR ;
									
				end if;	
			else
			--PB : Ce n'est pas un triangle
			raise PAS_UN_TRIANGLE_ERROR ;
			end if;
		else
		--PB : Le fichier est terminé
		raise FICHIER_TERMINE_ERROR ;
		end if;
		
		
		exception
			when FICHIER_TERMINE_ERROR => put_line("Je n'ai plus de ligne ou de caractère à lire dans ce fichier") ; 
			when PAS_DE_POINT_ERROR => put_line("Je suis désolé, mais ce point n'existe pas") ; 
			when PAS_UN_TRIANGLE_ERROR => put_line("Ce n'est pas un triangle, je ne peux, hélas, traiter que des fichiers composés de triangle") ; 
			when others    => put_line("J'ai rencontré une erreur fatale !") ;
		end ;
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
