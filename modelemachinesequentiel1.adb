
package body modelemachinesequentiel1 is

	--sequence : tableauDoubletTriangle;
	N, pointeurTete:integer;
	ptCourant : pointeurSurPointeurDT;

	procedure Init(taille : in integer) is
	begin
		N:=taille;
		--
			Ada.Text_Io.Put("N :"&Integer'Image(N));
			Ada.Text_Io.New_Line;
		--
	end Init;

	procedure Demarrer(sequence : in tableauDoubletTriangle) is
	begin
		pointeurTete:=0;
		while not finDeSequence and then sequence(pointeurTete)=Null loop
			pointeurTete := pointeurTete+1;
		end loop;
		ptCourant := sequence(pointeurTete);
	end Demarrer;

	function elementCourant return Triangle is
	begin
		--
			Ada.Text_Io.Put("Pointeur Element courant :"&Integer'Image(pointeurTete));
			Ada.Text_Io.New_Line;
		--
		return ptCourant.Objet;
	end elementCourant;
		
	function finDeSequence return boolean is
	begin
		return pointeurTete=N;
	end finDeSequence;
	
	
	
	procedure Avancer(sequence :in tableauDoubletTriangle) is
	begin
		 ptCourant := ptCourant.Succ;
		 if (ptCourant= null) then
			pointeurTete := pointeurTete+1;
			while not(finDeSequence) and then sequence(pointeurTete)=null loop
				pointeurTete := pointeurTete+1;
			end loop;
			if not(finDeSequence) then
				ptCourant := sequence(pointeurTete);
			end if;
		 end if;
	end Avancer;

end modelemachinesequentiel1;






