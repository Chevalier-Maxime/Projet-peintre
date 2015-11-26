
package body modelemachinesequentiel1 is

	--sequence : tableauDoubletTriangle;
	N, pointeur:integer;
	ptCourant : pointeurSurPointeurDT;

	procedure Init(taille : in integer) is
	begin
		N:=taille;
	end Init;

	procedure Demarrer(sequence : in tableauDoubletTriangle) is
	begin
		pointeur:=0;
		ptCourant := sequence(pointeur);
	end Demarrer;

	function elementCourant return Triangle is
	begin
		return ptCourant.Objet;
	end elementCourant;
		
	function finDeSequence return boolean is
	begin
		return pointeur=N;
	end finDeSequence;
	
	
	
	procedure Avancer(sequence :in tableauDoubletTriangle) is
	begin
		if (ptCourant /= NULL) and then (ptCourant.Objet.s1 /= NULL) then
			ptCourant := ptCourant.Succ; 
		else
		pointeur:=pointeur+1;
		ptCourant := sequence(pointeur);
		end if;
	end Avancer;

end modelemachinesequentiel1;

