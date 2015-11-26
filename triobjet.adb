

package body triobjet is 


--Fonction permettant de renvoyer un doublet Triangle lu dans un fichier
procedure creerDoubletTriangle ( ptDT : in out pointeurListeDoubletT; tabS : in tableauSommet) is 
	ptTriangle : pointeurTriangle;
begin
	ptTriangle := new Triangle;
	ptTriangle.all := lectureoff.chargerTriangle(tabS);
	ptDT.Objet := ptTriangle.all; --Je pense qu'il faut pas faire ca, mais changer la structure doubletTriangle en metant un pointeur sur triangle ?
	ptDT.Succ := NULL;
	
	FreeTriangle(ptTriangle); --#TODO a verifier
	
end creerDoubletTriangle;

--Procedure permettant de trouver le minimum et le maximum de y dans un tableau de sommet
procedure trouveMinMax( tabS : in tableauSommet; min : out float; max : out float) is
	i, tailleTableauSommet : integer;
	zLu : float;
begin
	
	--
	Ada.Text_Io.Put("On est entre dans min max");
	Ada.Text_Io.New_Line;
	--
	
	tailleTableauSommet := tabS'LENGTH;
	zLu := tabS(0).z ;
	min := zLu;
	max := zLu;
	
	i:=1;
	while i < tailleTableauSommet-1 loop
		
		zLu := tabS(i).z;
		--
		Ada.Text_Io.Put("z : " & Float'Image(zLu));
		Ada.Text_Io.New_Line;
		--
		if zLu > max then
			max := zLu;
		end if;
		
		if zLu < min then
			min := zLu;
		end if;
		
		i:=i+1;
		
	end loop;
	
	--
	Ada.Text_Io.Put("On est sorti de la boucle");
	Ada.Text_Io.New_Line;
	--
	
	
end trouveMinMax;

-- Procedure permettant de trier les triangles
procedure trierTriangle (tabDT : in out tableauDoubletTriangle; tabS : in tableauSommet; nbFace : in integer) is
	min, max : float;
	ptCourant : pointeurListeDoubletT;
	c : float;
	i,indice : integer;
begin
	
	--
	Ada.Text_Io.Put("On est entre dans trier Triangle");
	Ada.Text_Io.New_Line;
	--
	
	trouveMinMax(tabS, min, max);
	
	--
	Ada.Text_Io.Put("On a trouve min max" & Float'Image(min) & " " & Float'Image(max));
	Ada.Text_Io.New_Line;
	--
	
	i:=0;
	while i < nbFace loop
		ptCourant := new DoubletTriangle; --Nouvelle allocation en mémoire pour chaque double triangle ------------------------------------#TODO
		creerDoubletTriangle (ptCourant, tabS); --Le ptCourant pointe sur un nouveau Doublet Triangle
		c := ptCourant.Objet.minZ; 		  --On récupère le z minimum de la structure
		
		
		
		indice := integer(Float(nbFace)*((c-min)/(max-min))); --On calcule l'indice ou placer le doublet triangle
		
		--
		Ada.Text_Io.Put("c : " & Float'Image(c));
		Ada.Text_Io.New_Line;
		--
		
		--
		Ada.Text_Io.Put("indice : " & Integer'Image(indice));
		Ada.Text_Io.New_Line;
		--
		
		insererDoubletTriangle (ptCourant.all, indice, tabDT); --On place le doublet triangle dans le tableau au bon endroit
		i:=i+1;
	end loop;
end trierTriangle;



end triobjet;
