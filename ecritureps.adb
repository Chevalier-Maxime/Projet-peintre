--Ada.Text_Io.Put( fichier3, Integer'Image(A(k)));
--Ada.Text_Io.New_Line(fichier3);
	


package body ecritureps is 
	
	fichierRes: Ada.Text_IO.File_Type;
	hauteur: float := 792.0;
	longeur: float := 612.0;
	hauteurmoit: float := 396.0;
	longeurmoit: float := 306.0;
	epaisseurTrait : float := 0.2;
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
				--~ --
					--~ Ada.Text_Io.Put("Après avancer Fin de sequence :"&Boolean'Image(not(finDeSequence)));
					--~ Ada.Text_Io.New_Line;
				--~ --
			end loop;
			--~ --
				--~ Ada.Text_Io.Put("I'AM FRUUUUUUUUUUUUUUUUUUUIT");
				--~ Ada.Text_Io.New_Line;
			--~ --
		end ecritureDesTriangles;
	
	procedure trouverCoef(cx,cy : in out float; tabTDoubletTriangleTrie : in tableauDoubletTriangle) is
		xmax,ymax,xmin,ymin : float;
		calcCoefX,calcCoefY : float;
		pointeur1,pointeur2,pointeur3 : pointeurSommet;
	begin
		init(tabTDoubletTriangleTrie'LENGTH);

		Demarrer(tabTDoubletTriangleTrie);
		
		xmax:=elementCourant.s1.x;
		xmin:=elementCourant.s1.x;
		ymax:=elementCourant.s1.y;
		ymin:=elementCourant.s1.y;
		
		while not(finDeSequence) loop
		
			pointeur1:=elementCourant.s1;
			pointeur2:=elementCourant.s2;
			pointeur3:=elementCourant.s3;
			
			--~ recherche du xmax
			if(pointeur1.x>xmax) then
				xmax:=pointeur1.x;
			end if;
			if(pointeur2.x>xmax) then
				xmax:=pointeur2.x;
			end if;
			if(pointeur3.x>xmax) then
				xmax:=pointeur3.x;
			end if;
			
			--~ recherche du xmin 
			if(pointeur1.x<xmin) then
				xmin:=pointeur1.x;
			end if;
			if(pointeur2.x<xmin) then
				xmin:=pointeur2.x;
			end if;
			if(pointeur3.x<xmin) then
				xmin:=pointeur3.x;
			end if;
			
			--~ Recherche du ymax
			if(pointeur1.y>ymax) then
				ymax:=pointeur1.y;
			end if;
			if(pointeur2.y>ymax) then
				ymax:=pointeur2.y;
			end if;
			if(pointeur3.y>ymax) then
				ymax:=pointeur3.y;
			end if;
			
			--~ Recherche du ymin
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
		
		cx:=Float'Min(calcCoefX,calcCoefY);
		cy:=Float'Min(calcCoefX,calcCoefY);
		
		
	end trouverCoef;
	
	procedure creerFichier( nomFichier : in string) is
		begin
			Create(fichierRes, Ada.Text_IO.Out_File, nomFichier&".ps");
			Ada.Text_Io.Put(fichierRes, "%!PS");
			Ada.Text_Io.New_Line(fichierRes);
			Ada.Text_Io.Put(fichierRes, Float'Image(epaisseurTrait) &" setlinewidth");
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
			--~ --
				--~ Ada.Text_Io.Put("Point1: ");
				--~ Ada.Text_Io.New_Line;
			--~ --
			--~ --
				--~ Ada.Text_Io.Put("X : "&Float'Image((pointeur.x*coefX)+longeurmoit));
				--~ Ada.Text_Io.New_Line;
			--~ --
			--~ --
				--~ Ada.Text_Io.Put("Y : "&Float'Image((pointeur.y*coefY)+hauteurmoit));
				--~ Ada.Text_Io.New_Line;
			--~ --
			pointeur := trian.s2;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coefX)+longeurmoit)& " " & Float'Image((pointeur.y*coefY)+hauteurmoit) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);
			--~ --
				--~ Ada.Text_Io.Put("Point2: ");
				--~ Ada.Text_Io.New_Line;
			--~ --
			--~ --
				--~ Ada.Text_Io.Put("X : "&Float'Image((pointeur.x*coefX)+longeurmoit));
				--~ Ada.Text_Io.New_Line;
			--~ --
			--~ --
				--~ Ada.Text_Io.Put("Y : "&Float'Image((pointeur.y*coefY)+hauteurmoit));
				--~ Ada.Text_Io.New_Line;
			--~ --
			pointeur := trian.s3;	
			Ada.Text_Io.Put(fichierRes, Float'Image((pointeur.x*coefX)+longeurmoit) & " " & Float'Image((pointeur.y*coefY)+hauteurmoit) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);
			--~ --
				--~ Ada.Text_Io.Put("Point3");
				--~ Ada.Text_Io.New_Line;
			--~ --
			--~ --
				--~ Ada.Text_Io.Put("X : "&Float'Image((pointeur.x*coefX)+longeurmoit));
				--~ Ada.Text_Io.New_Line;
			--~ --
			--~ --
				--~ Ada.Text_Io.Put("Y : "&Float'Image((pointeur.y*coefY)+hauteurmoit));
				--~ Ada.Text_Io.New_Line;
			--~ --
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
