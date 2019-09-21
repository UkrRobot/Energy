program Energie_prj;

uses
  Forms,
    New_Energie in 'New_Energie.pas' {fmEnergies};
    (*Adsorptiom in 'C:\Pascal\Adsorption\Adsorptiom.pas' {fmGeneral};*)

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmEnergies, fmEnergies);
  {Application.CreateForm(TfmGeneral, fmGeneral);}
  Application.Run;
end.
