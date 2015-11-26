
package body modele is

--Procedure permettant d'inserer un DoubletTriangle dans le tableau
procedure insererDoubletTriangle (doubleT : in out DoubletTriangle; indice : in integer; tableauDoubletT : in out tableauDoubletTriangle) is
	ptTemp : pointeurListeDoubletT;
begin
	
	--
	Ada.Text_Io.Put("On est entre dans inserer min max");
	Ada.Text_Io.New_Line;
	--
	
	if tableauDoubletT(indice) = NULL then
		
		--
		Ada.Text_Io.Put("if pt = NULL");
		Ada.Text_Io.New_Line;
		--
		tableauDoubletT(indice).all := doubleT;
	else
		--
		Ada.Text_Io.Put("if pt ! = NULL");
		Ada.Text_Io.New_Line;
		--
		
		--insertion en tete de liste non vide
		--On sauvegarde l'objet pointe par la tete de liste dans un pointeur temporaire
		ptTemp :=tableauDoubletT(indice);
		
		--On fait pointer la tete de liste sur le nouvel element
		tableauDoubletT(indice).all := doubleT;
		
		--On racroche la liste a la suie de l'element insere
		doubleT.succ := ptTemp;
		
		--#TODO Faut-il alouer le ptTemp ? et donc le liberer a la fin ?
		
	end if;
	
	--
	Ada.Text_Io.Put("On est sorti de inserer min max");
	Ada.Text_Io.New_Line;
	--
end insererDoubletTriangle;




--Procedure permettant de désalouer tous les triangles du tableau
procedure desalouerTriangle ( tableauDoubletT : in tableauDoubletTriangle) is
	x : integer;
begin
	--#TODO
	x:=0;
end desalouerTriangle;



end modele;
