package body ecritureps is 
	
	--Fichier resultat : 
	fichierRes: Ada.Text_IO.File_Type;
	
	-- Constante
	hauteur: float := 792.0;
	longeur: float := 612.0;
	hauteurmoit: float := 396.0;
	longeurmoit: float := 306.0;
	epaisseurTrait : float := 0.2;
	
	--Coeficient de translation
	coef:float;
	
	--*************************************************************************************
	--Fonction principale du module écriture: calcul du coeficient + écriture des triangles
	--*************************************************************************************
	procedure ecrire(tabTDoubletTriangleTrie : in tableauDoubletTriangle) is
		begin
		trouverCoef(coef,coef,tabTDoubletTriangleTrie);		
		ecritureDesTriangles(tabTDoubletTriangleTrie);
	end ecrire;
	
	--*************************************************************************************
	--Fonction d'écriture des triangles
	--*************************************************************************************
	procedure ecritureDesTriangles( tabTDoubletTriangleTrie : in tableauDoubletTriangle) is 
		begin
			init(tabTDoubletTriangleTrie'LENGTH);
			Demarrer(tabTDoubletTriangleTrie);
			while not(finDeSequence) loop
				ajouterUnTriangle(elementCourant);
				Avancer(tabTDoubletTriangleTrie);
			end loop;
	end ecritureDesTriangles;
	
	--*************************************************************************************
	--Fonction de calcul du coeficient
	--*************************************************************************************
	procedure trouverCoef(c : in out float; tabTDoubletTriangleTrie : in tableauDoubletTriangle) is
		
		xmax,ymax,xmin,ymin : float;
		calcCoefX,calcCoefY : float;
		pointeur1,pointeur2,pointeur3 : pointeurSommet;
		
	begin
		init(tabTDoubletTriangleTrie'LENGTH);

		Demarrer(tabTDoubletTriangleTrie);
		
		--initialisation
		xmax:=elementCourant.s1.x;
		xmin:=elementCourant.s1.x;
		ymax:=elementCourant.s1.y;
		ymin:=elementCourant.s1.y;
		
		while not(finDeSequence) loop
		
			pointeur1:=elementCourant.s1;
			pointeur2:=elementCourant.s2;
			pointeur3:=elementCourant.s3;
			
			-- recherche du xmax
			if(pointeur1.x>xmax) then
				xmax:=pointeur1.x;
			end if;
			if(pointeur2.x>xmax) then
				xmax:=pointeur2.x;
			end if;
			if(pointeur3.x>xmax) then
				xmax:=pointeur3.x;
			end if;
			
			-- recherche du xmin 
			if(pointeur1.x<xmin) then
				xmin:=pointeur1.x;
			end if;
			if(pointeur2.x<xmin) then
				xmin:=pointeur2.x;
			end if;
			if(pointeur3.x<xmin) then
				xmin:=pointeur3.x;
			end if;
			
			-- Recherche du ymax
			if(pointeur1.y>ymax) then
				ymax:=pointeur1.y;
			end if;
			if(pointeur2.y>ymax) then
				ymax:=pointeur2.y;
			end if;
			if(pointeur3.y>ymax) then
				ymax:=pointeur3.y;
			end if;
			
			-- Recherche du ymin
			if(pointeur1.y<ymin) then
				ymin:=pointeur1.y;
			end if;
			if(pointeur2.y<ymin) then
				ymin:=pointeur2.y;
			end if;
			if(pointeur3.y<ymin) then
				ymin:=pointeur3.y;
			end if;
			
			Avancer(tabTDoubletTriangleTrie);

		end loop;
		
		if xmax<0.0 then
			xmax := xmax * (-1.0);
		end if;
		if xmin<0.0 then
			xmin := xmin * (-1.0);
		end if;
		if ymax<0.0 then
			ymax := ymax * (-1.0);
		end if;
		if ymin<0.0 then
			ymin := ymin * (-1.0);
		end if;
		
		calcCoefX := Float'Min((longeurmoit/xmax),(longeurmoit/(xmin)));
		calcCoefY := Float'Min((hauteurmoit/ymax),(hauteurmoit/(ymin)));
		c:=Float'Min(calcCoefY,calcCoefX);
		
	end trouverCoef;
	
	--*************************************************************************************
	--Fonction de création du fichier résultat
	--*************************************************************************************
	procedure creerFichier( nomFichier : in string) is
		begin
			Create(fichierRes, Ada.Text_IO.Out_File, nomFichier&".ps");
			Ada.Text_Io.Put(fichierRes, "%!PS");
			Ada.Text_Io.New_Line(fichierRes);
			Ada.Text_Io.Put(fichierRes, Float'Image(epaisseurTrait) &" setlinewidth");
			Ada.Text_Io.New_Line(fichierRes);
	end creerFichier;
	
	--*************************************************************************************
	--Fonction de fermeture du fichier resultat
	--*************************************************************************************
	procedure fermerFichier is
		begin
			Ada.Text_Io.Put(fichierRes, "showpage");
			close(fichierRes);
	end fermerFichier;
	
	--*************************************************************************************
	--Fonction d'ajout d'un triangle
	--*************************************************************************************
	procedure ajouterUnTriangle(trian : Triangle) is 
			
			pointeur : pointeurSommet;
			contour : string := "0 setgray";
			remplissage : string := "1 setgray";
			
		begin
			--positionnement du pointeur
			pointeur := trian.s1;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coef)+longeurmoit) & " " & Float'Image((pointeur.y*coef)+hauteurmoit) & " moveto");
			Ada.Text_Io.New_Line(fichierRes);

			--Tracé du premier segment
			pointeur := trian.s2;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coef)+longeurmoit)& " " & Float'Image((pointeur.y*coef)+hauteurmoit) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);

			--Tracé du deuxième segment
			pointeur := trian.s3;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coef)+longeurmoit) & " " & Float'Image((pointeur.y*coef)+hauteurmoit) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);

			--Tracé du troisième segment
			pointeur := trian.s1;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coef)+longeurmoit) & " " & Float'Image((pointeur.y*coef)+hauteurmoit) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);
			
			--Paramètre pour l'affichage d'un triangle
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
