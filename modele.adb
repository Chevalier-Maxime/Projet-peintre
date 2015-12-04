
package body modele is

--Procedure permettant d'inserer un DoubletTriangle dans le tableau
procedure insererDoubletTriangle (ptdoubleT : in out pointeurSurPointeurDT; indice : in integer; tableauDoubletT : in out tableauDoubletTriangle) is
	ptTemp : pointeurSurPointeurDT;
begin
		--~ --
	--~ Ada.Text_Io.Put("On est entre dans inserer DT");
	--~ Ada.Text_Io.New_Line;
	--~ --
	--~ Ada.Text_Io.Put(" Triangle a inserer");
	--~ Ada.Text_Io.New_Line;
	--~ Ada.Text_Io.Put( "x: " & Float'Image(ptdoubleT.Objet.s1.x) & " y: " & Float'Image(ptdoubleT.Objet.s1.y) & " z: " & Float'Image(ptdoubleT.Objet.s1.z));
	--~ Ada.Text_Io.New_Line;
	--~ Ada.Text_Io.Put( "x: " & Float'Image(ptdoubleT.Objet.s2.x) & " y: " & Float'Image(ptdoubleT.Objet.s2.y) & " z: " & Float'Image(ptdoubleT.Objet.s2.z));
	--~ Ada.Text_Io.New_Line;
	--~ Ada.Text_Io.Put( "x: " & Float'Image(ptdoubleT.Objet.s3.x) & " y: " & Float'Image(ptdoubleT.Objet.s3.y) & " z: " & Float'Image(ptdoubleT.Objet.s3.z));
	--~ Ada.Text_Io.New_Line;

	if tableauDoubletT(indice) = null then
		--~ --
		--~ Ada.Text_Io.Put("if pt = NULL");
		--~ Ada.Text_Io.New_Line;
		--~ --
		tableauDoubletT(indice) := ptdoubleT;
	else
		
		--~ --
		--~ Ada.Text_Io.Put("if pt ! = NULL");
		--~ Ada.Text_Io.New_Line;
		--~ --
		--insertion en tete de liste non vide
		--On sauvegarde l'objet pointe par la tete de liste dans un pointeur temporaire
		ptTemp :=tableauDoubletT(indice);
		
		--On fait pointer la tete de liste sur le nouvel element
		tableauDoubletT(indice) := ptdoubleT;
		
		--On racroche la liste a la suie de l'element insere
		ptdoubleT.succ := ptTemp;
		
		--#TODO Faut-il alouer le ptTemp ? et donc le liberer a la fin ?
		
	end if;
	--~ --
	--~ Ada.Text_Io.Put("On est sorti de inserer");
	--~ Ada.Text_Io.New_Line;
	--~ --
end insererDoubletTriangle;




--Procedure permettant de désalouer tous les triangles du tableau
procedure desalouerTriangle ( tableauDoubletT : in tableauDoubletTriangle) is
	ptTemp1, ptTemp2 :pointeurSurPointeurDT;
begin
	
	for i in 0..(tableauDoubletT'LENGTH-1) loop
		ptTemp1 := tableauDoubletT(i);
		if (ptTemp1 /= null) then
			ptTemp2 := tableauDoubletT(i).Succ;
		end if;
		while (ptTemp1 /= null) loop
			FreePSDT(ptTemp1);
			
			if ptTemp2 /= null then
				ptTemp1 := ptTemp2.Succ;
				FreePSDT(ptTemp2);
			end if;
			if ptTemp1 /= null then 
				ptTemp2 := ptTemp1.Succ;
			end if;
			
		end loop;
	end loop;
end desalouerTriangle;

end modele;
