with Ada.Text_IO; use Ada.Text_IO;
with SDA_Exceptions; use SDA_Exceptions;
-- with Ada.Unchecked_Deallocation;

package body TH is

    -- Fonction inaccesible par l'utilisateur
    -- Renvoi l'indice associé à une cle dans la TH 
    function Indice (Cle : T_Cle) return Integer 
    with Post => Indice'Result > 0 and Indice'Result <= Taille_TH
    is
    begin
        return (fonction_hachage(Cle) mod Taille_TH +1);
    end Indice;

    procedure Initialiser (Sda: out T_TH) is
    begin
        for i in 1..Taille_TH loop
            Initialiser(Sda(i)); -- On appelle la fonction du module lca sur chaque lca de la TH
        end loop;
    end Initialiser;

    function Est_Vide (Sda : T_TH) return Boolean is
        tableau_vide : Boolean := True;
    begin
        -- Si une case du tableau n'est pas vide alors le tableau n'est pas vide
        for i in 1..Taille_TH loop
            if not Est_vide(Sda(i)) then
                tableau_vide := False;
            end if;
        end loop;

        return tableau_vide;
    end Est_Vide;

    function Taille (Sda : in T_TH) return Integer is
        resultat : Integer := 0; -- Permet de compter la somme des differentes tailles des lca
    begin
        for i in 1..Taille_TH loop
            resultat := resultat + Taille(Sda(i));
        end loop;

        return resultat; 
    end Taille;

    procedure Enregistrer (Sda : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) is
    begin
        Enregistrer(Sda(Indice(Cle)), Cle, Donnee); -- Appel a la fonction du module lca dans la case indiqué par Indice(cle)
    end Enregistrer;

    procedure Supprimer (Sda : in out T_TH ; Cle : in T_Cle) is
    begin
        Supprimer(Sda(Indice(Cle)) , Cle); -- Appel a la fonction du module lca dans la case indiqué par Indice(cle)
    end Supprimer;

    function Cle_Presente (Sda : in T_TH ; Cle : in T_Cle) return Boolean is
    begin
       return Cle_Presente(Sda(Indice(Cle)), Cle); -- Appel a la fonction du module lca dans la case indiqué par Indice(cle)
    end Cle_Presente;

    function La_Donnee (Sda : in T_TH ; Cle : in T_Cle) return T_Donnee is
    begin
        return La_Donnee(Sda(Indice(Cle)), Cle); -- Appel a la fonction du module lca dans la case indiqué par Indice(cle)
    end La_Donnee;

    procedure Vider (Sda : in out T_TH) is
    begin
        for i in 1..Taille_TH loop
            Vider(Sda(i));
        end loop;
    end Vider;

    procedure Pour_Chaque (Sda : in T_TH ) is

    -- Instanciation de la procedure générique avec le parametre de généricité Traiter.
    procedure Pour_Chaque_LCA is new ma_T_LCA.Pour_Chaque(Traiter => Traiter);

    begin
        for i in 1..Taille_TH loop
            Pour_Chaque_LCA(Sda(i));
        end loop;
    end Pour_Chaque;    

end TH;