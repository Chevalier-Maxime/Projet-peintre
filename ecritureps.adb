--Ada.Text_Io.Put( fichier3, Integer'Image(A(k)));
--Ada.Text_Io.New_Line(fichier3);
	


package body ecritureps is 
	
	fichierRes: Ada.Text_IO.File_Type;
	hauteur: float := 792.0;
	longeur: float := 612.0;
	hauteurmoit: float := 396.0;
	longeurmoit: float := 306.0;
	coefX,coefY:float;
	
	procedure ecrire(tabTDoubletTriangleTrie : in tableauDoubletTriangle) is
	begin
	trouverCoef(coefX,coefY,tabTDoubletTriangleTrie);
	--
		Ada.Text_Io.Put("Fin de calcul des coefs: ");
		Ada.Text_Io.New_Line;
	--
	--
		Ada.Text_Io.Put("coefX : "&Float'Image(coefX));
		Ada.Text_Io.New_Line;
	--
	--
		Ada.Text_Io.Put("coefY : "&Float'Image(coefY));
		Ada.Text_Io.New_Line;
	--
	
	ecritureDesTriangles(tabTDoubletTriangleTrie);
	end ecrire;
	
	procedure ecritureDesTriangles( tabTDoubletTriangleTrie : in tableauDoubletTriangle) is 
		
		begin
			init(tabTDoubletTriangleTrie'LENGTH);

			Demarrer(tabTDoubletTriangleTrie);
			
			while not(finDeSequence) loop
				ajouterUnTriangle(elementCourant);
				Avancer(tabTDoubletTriangleTrie);
				--
					Ada.Text_Io.Put("Après avancer Fin de sequence :"&Boolean'Image(not(finDeSequence)));
					Ada.Text_Io.New_Line;
				--
			end loop;
			--
				Ada.Text_Io.Put("I'AM FRUUUUUUUUUUUUUUUUUUUIT");
				Ada.Text_Io.New_Line;
			--
		end ecritureDesTriangles;
	
	procedure trouverCoef(cx,cy : in out float; tabTDoubletTriangleTrie : in tableauDoubletTriangle) is
		x,y : float;
		pointeur1,pointeur2,pointeur3 : pointeurSommet;
	begin
		init(tabTDoubletTriangleTrie'LENGTH);

		Demarrer(tabTDoubletTriangleTrie);
		
		x:=elementCourant.s1.x;
		y:=elementCourant.s1.y;
		
		while not(finDeSequence) loop
		
			pointeur1:=elementCourant.s1;
			pointeur2:=elementCourant.s2;
			pointeur3:=elementCourant.s3;
			
			if(pointeur1.x>x) then
				x:=pointeur1.x;
			end if;
			if(pointeur2.x>x) then
				x:=pointeur2.x;
			end if;
			if(pointeur3.x>x) then
				x:=pointeur3.x;
			end if;
			if(pointeur1.y>y) then
				y:=pointeur1.y;
			end if;
			if(pointeur2.y>y) then
				y:=pointeur2.y;
			end if;
			if(pointeur3.y>y) then
				y:=pointeur3.y;
			end if;
			Avancer(tabTDoubletTriangleTrie);

		end loop;
		cx:=x/longeur;
		cy:=y/hauteur;
	end trouverCoef;
	
	
	procedure creerFichier( nomFichier : in string) is
		begin
			Create(fichierRes, Ada.Text_IO.Out_File, nomFichier&".ps");
			Ada.Text_Io.Put(fichierRes, "%!PS");
			Ada.Text_Io.New_Line(fichierRes);
	end creerFichier;
	
	procedure fermerFichier is
		begin
			Ada.Text_Io.Put(fichierRes, "showpage");
			close(fichierRes);
	end fermerFichier;
	
	procedure ajouterUnTriangle(trian : Triangle) is 
			pointeur : pointeurSommet;
			contour : string := "0 setgray";
			remplissage : string := "1 setgray";
		begin
			pointeur := trian.s1;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coefX)+longeurmoit) & " " & Float'Image((pointeur.y*coefY)+hauteurmoit) & " moveto");
			Ada.Text_Io.New_Line(fichierRes);
			--
				Ada.Text_Io.Put("Point1: ");
				Ada.Text_Io.New_Line;
			--
			--
				Ada.Text_Io.Put("X : "&Float'Image((pointeur.x*coefX)+longeurmoit));
				Ada.Text_Io.New_Line;
			--
			--
				Ada.Text_Io.Put("Y : "&Float'Image((pointeur.y*coefY)+hauteurmoit));
				Ada.Text_Io.New_Line;
			--
			pointeur := trian.s2;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coefX)+longeurmoit)& " " & Float'Image((pointeur.y*coefY)+hauteurmoit) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);
			--
				Ada.Text_Io.Put("Point2: ");
				Ada.Text_Io.New_Line;
			--
			--
				Ada.Text_Io.Put("X : "&Float'Image((pointeur.x*coefX)+longeurmoit));
				Ada.Text_Io.New_Line;
			--
			--
				Ada.Text_Io.Put("Y : "&Float'Image((pointeur.y*coefY)+hauteurmoit));
				Ada.Text_Io.New_Line;
			--
			pointeur := trian.s3;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coefX)+longeurmoit) & " " & Float'Image((pointeur.y*coefY)+hauteurmoit) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);
			--
				Ada.Text_Io.Put("Point3");
				Ada.Text_Io.New_Line;
			--
			--
				Ada.Text_Io.Put("X : "&Float'Image((pointeur.x*coefX)+longeurmoit));
				Ada.Text_Io.New_Line;
			--
			--
				Ada.Text_Io.Put("Y : "&Float'Image((pointeur.y*coefY)+hauteurmoit));
				Ada.Text_Io.New_Line;
			--
			pointeur := trian.s1;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coefX)+longeurmoit) & " " & Float'Image((pointeur.y*coefY)+hauteurmoit) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);
			
			Ada.Text_Io.Put(fichierRes, "gsave");
			Ada.Text_Io.New_Line(fichierRes);
			Ada.Text_Io.Put(fichierRes, remplissage);
			Ada.Text_Io.New_Line(fichierRes);
			Ada.Text_Io.Put(fichierRes,"fill");
			Ada.Text_Io.New_Line(fichierRes);
			Ada.Text_Io.Put(fichierRes,"grestore");
			Ada.Text_Io.New_Line(fichierRes);
			Ada.Text_Io.Put(fichierRes,contour);
			Ada.Text_Io.New_Line(fichierRes);
			Ada.Text_Io.Put(fichierRes,"stroke");
			Ada.Text_Io.New_Line(fichierRes);
	end ajouterUnTriangle;
	
end ecritureps;
