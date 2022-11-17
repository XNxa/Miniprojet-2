with Ada.Text_IO; use Ada.Text_IO;
with SDA_Exceptions; use SDA_Exceptions;
--with Ada.Unchecked_Deallocation;

package body TH is

    procedure Initialiser(Sda: out T_TH) is
    begin
        for i in 1..Taille_TH loop
            Sda(i) := null;
        end loop;
    end Initialiser;

    function Est_Vide(Sda : T_TH) is
        tableau_vide : Boolean := True;
    begin
        for i in 1..Taille_TH loop
            if Sda(i)/=null then
                tableau_vide := False;
            end if;
        end loop;
        return tableau_vide;
    end Est_Vide;

    function Taille(Sda : in T_TH) return Integer is
        resultat : Integer := 0;
    begin
        for i in 1..Taille_TH loop
            resultat := resultat + Taille(Sda(i));
        end loop;
        return resultat; 
    end Taille;

    procedure Enregistrer(Sda : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) is
    begin
        null;
    end Enregistrer;

    procedure Supprimer(Sda : in out T_TH ; Cle : in T_Cle) is
    begin
        null;
    end Supprimer;

    function Cle_Presente(Sda : in T_TH ; Cle : in T_Cle) return Boolean is
    begin
        return False;
    end Cle_Presente;

    function La_Donnee(Sda : in T_TH ; Cle : in T_Cle) return T_Donnee is
    begin
        return null;
    end La_Donnee;

    procedure Pour_Chaque (Sda : in T_TH ) is
    begin
        null;
    end Pour_Chaque;    

end TH;