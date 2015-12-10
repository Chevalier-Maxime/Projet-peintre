With modele;
Use modele;
with lectureoff; use lectureoff;
With Ada.Text_IO;
Use Ada.Text_IO;

--~ Package permettant de trier un fichier OFF de triangle selon leur coordonnées en Z

package triobjet is

	--Procedure permettant de trouver le minimum et le maximum de y dans un tableau de sommet
	procedure trouveMinMax( tabS : in tableauSommet; min : out float; max : out float);
	
	-- Procedure permettant de trier les triangles
	procedure trierTriangle (tabDT : in out tableauDoubletTriangle; tabS : in tableauSommet; nbFace : in integer) ;
	
	procedure testPerformance (tabDT : in tableauDoubletTriangle);
	
end triobjet;
