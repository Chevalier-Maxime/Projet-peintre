With modele;
Use modele;
With Ada.Text_IO;
Use Ada.Text_IO;

package ecriturePS is

	--Procedure permettant d'écrire les Triangles
	procedure ecritureDesTriangles( tabTDoubletTriangleTrie : in tableauDoubletTriangle);
	
	procedure creerFichier( nomFichier : in string);
	
	procedure fermerFichier;
	
	procedure ajouterUnTriangle(triangle : Traingle);
	
end ecriturePS;
