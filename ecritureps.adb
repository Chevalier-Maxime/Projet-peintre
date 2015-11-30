--Ada.Text_Io.Put( fichier3, Integer'Image(A(k)));
--Ada.Text_Io.New_Line(fichier3);
	


package body ecritureps is 
	
	fichierRes: Ada.Text_IO.File_Type;
	
	procedure ecritureDesTriangles( tabTDoubletTriangleTrie : in tableauDoubletTriangle) is 
	
	begin

	init(tabTDoubletTriangleTrie'LENGTH);

	Demarrer(tabTDoubletTriangleTrie);
	
	while not(finDeSequence) loop
		--
			Ada.Text_Io.Put("Donc j'ajoute mon triangle");
			Ada.Text_Io.New_Line;
		--
		ajouterUnTriangle(elementCourant);
		--
			Ada.Text_Io.Put("J'avance");
			Ada.Text_Io.New_Line;
		--
		Avancer(tabTDoubletTriangleTrie);
	end loop;
	
	end ecritureDesTriangles;
	
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
			remplissage : string := "0 setgray";
			contour : string := "1 setgray";
		begin
			pointeur := trian.s1;	
			Ada.Text_Io.Put(fichierRes, Float'Image(pointeur.x) & " " & Float'Image(pointeur.y) & " moveto");
			Ada.Text_Io.New_Line(fichierRes);
			
			pointeur := trian.s2;	
			Ada.Text_Io.Put(fichierRes, Float'Image(pointeur.x )& " " & Float'Image(pointeur.y) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);
			
			pointeur := trian.s3;	
			Ada.Text_Io.Put(fichierRes, Float'Image(pointeur.x) & " " & Float'Image(pointeur.y) & " lineto");
			Ada.Text_Io.New_Line(fichierRes);
			
			pointeur := trian.s1;	
			Ada.Text_Io.Put(fichierRes, Float'Image(pointeur.x) & " " & Float'Image(pointeur.y) & " lineto");
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
