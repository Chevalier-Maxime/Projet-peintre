With modele;
Use modele;
With Ada.Text_IO;
Use Ada.Text_IO;

package ecritureps is

	--Procedure permettant d'écrire les Triangles
	procedure ecritureDesTriangles( tabTDoubletTriangleTrie : in tableauDoubletTriangle);
	
	procedure creerFichier( nomFichier : in string);
	
	procedure fermerFichier;
	
	procedure ajouterUnTriangle(trian : Triangle);
	
end ecritureps;