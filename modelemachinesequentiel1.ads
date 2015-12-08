With modele;Use modele;
With Ada.Text_IO;
Use Ada.Text_IO;

package modelemachinesequentiel1 is

	function elementCourant return Triangle;
	
	function finDeSequence  return boolean;
	
	procedure Demarrer(sequence :in tableauDoubletTriangle);
	
	procedure Avancer(sequence :in tableauDoubletTriangle);
	
	procedure Init(taille : in integer);
	
end modelemachinesequentiel1;
