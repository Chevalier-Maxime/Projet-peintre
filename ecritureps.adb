--Ada.Text_Io.Put( fichier3, Integer'Image(A(k)));
--Ada.Text_Io.New_Line(fichier3);
	


package body ecritureps is 
	fichierRes: Ada.Text_IO.File_Type;

	procedure ecritureDesTriangles( tabTDoubletTriangleTrie : in tableauDoubletTriangle) is 
	ptCourant : pointeurSurPointeurDT;
	i : integer :=0;
	
	begin
	
	while i <= tabTDoubletTriangleTrie'LENGTH loop
	
			ptCourant := tabTDoubletTriangleTrie(i);
			while (ptCourant /= NULL) and then (ptCourant.Objet.s1 /= NULL) loop
			
				ajouterUnTriangle(ptCourant.Objet);
				ptCourant := ptCourant.Succ; 
			end loop;
			
			i:=i+1;
		end loop;
	
	end ecritureDesTriangles;
	
	procedure creerFichier( nomFichier : in string) is
		begin
			Create(fichierRes, Ada.Text_IO.Out_File, nomFichier);
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
			
			Ada.Text_Io.Put(fichierRes, "gsave\n"&remplissage&"\nfill\ngrestore"&contour&"\nstroke");
			Ada.Text_Io.New_Line(fichierRes);	
	end ajouterUnTriangle;
	
end ecritureps;
