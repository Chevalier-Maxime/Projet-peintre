--Ada.Text_Io.Put( fichier3, Integer'Image(A(k)));
--Ada.Text_Io.New_Line(fichier3);
	


package body ecriturePS is 

	fichierRes: Ada.Text_IO.File_Type;

	procedure ecritureDesTriangles( tabTDoubletTriangleTrie : in tableauDoubletTriangle) is 
	i : integer := 0;
	
	begin
	i:=1;
	
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
	
	procedure ajouterUnTriangle(triangle : Triangle) is 
			pointeur : pointeurSommet;
			remplissage : string := "0 setgray";
			contour : string := "1 setgray";
		begin
			pointeur := triangle.s1;	
			Ada.Text_Io.Put(fichierRes, pointeur.x&" "&pointeur.y&" moveto");
			Ada.Text_Io.New_Line(fichierRes);
			
			pointeur := triangle.s2;	
			Ada.Text_Io.Put(fichierRes, pointeur.x&" "&pointeur.y&" lineto");
			Ada.Text_Io.New_Line(fichierRes);
			
			pointeur := triangle.s3;	
			Ada.Text_Io.Put(fichierRes, pointeur.x&" "&pointeur.y&" lineto");
			Ada.Text_Io.New_Line(fichierRes);
			
			pointeur := triangle.s1;	
			Ada.Text_Io.Put(fichierRes, pointeur.x&" "&pointeur.y&" lineto");
			Ada.Text_Io.New_Line(fichierRes);
			
			Ada.Text_Io.Put(fichierRes, "gsave\n"&remplissage&"\nfill\ngrestore"&contour&"\nstroke");
			Ada.Text_Io.New_Line(fichierRes);	
	end ajouterUnTriangle;
	
end ecriturePS;
