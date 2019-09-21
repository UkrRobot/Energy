unit New_Energie; // error! all the concentrations
//were taken from the left part of the diagram!!
// 4 conc. must be input
// or conc. under 2 T;

interface

uses
  Windows, {Messages,} SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Mask, Menus, ExtCtrls, Buttons;
 const
  R=8.31;
  Na=6.022e+23;


type
  TfmEnergies = class(TForm)
    Panel1: TPanel;
    btnClose: TButton;
    btnClr: TButton;
    btnStart: TButton;
    Panel3: TPanel;
    lbTpl2: TLabel;
    lbTpl1: TLabel;
    lbH1: TLabel;
    lbKoord: TLabel;
    lbH2: TLabel;
    edr2: TEdit;
    edH1: TEdit;
    edTpl1: TEdit;
    edTpl2: TEdit;
    edH2: TEdit;
    bbPusk: TBitBtn;
    edKoord: TEdit;
    lbr1: TLabel;
    lbr2: TLabel;
    edr1: TEdit;
    edT1: TEdit;
    lbTpl12: TLabel;
    edC1s: TEdit;
    edC1L: TEdit;

    mmOutput: TMemo;
    btnBi_Sn: TBitBtn;
    BtnAl_Ga: TButton;
    edT2: TEdit;
    Label1: TLabel;
    edC2s: TEdit;
    edC2L: TEdit;
    Label2: TLabel;
    Label3: TLabel;


    procedure btnCloseClick(Sender: TObject);
    procedure bbPuskClick(Sender: TObject);
    procedure btnClrClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnBi_SnClick(Sender: TObject);
    procedure btnBi_InClick(Sender: TObject);
    procedure BtnAl_GaClick(Sender: TObject);


     private
    { Private declarations }
  public

    { Public declarations }
  end;


  var
  fmEnergies: TfmEnergies;
  var
  Vss11,Vll11,Vss22,Vll22,Vss12,Vll12,Vsl11,Vsl22,Vsl12:real;
  Wss12,Wll12,Wsl11,Wsl22,Wsl12,delta_E:real;
  N,H1,H2,rl1,rl2,Tpl1,Tpl2,T1,T2,Cs1,Cl1,Cs2,Cl2,Cl_1, Cl_2,Cs_1, cs_2,xs1,xl1,xs2,xl2:real;
  Ha,Hb,dGa1,dGb1,dGa2,dGb2,rs1,rs2,ln1,ln2:real;
implementation

{$R *.DFM}

Procedure TfmEnergies.btnCloseClick(Sender: TObject);
  begin
    Close;
    end;

 procedure TfmEnergies.bbPuskClick(Sender: TObject);
  procedure TakeData;{Read data from the TEdit}

  begin
   try
      H1:=StrToFloat(Trim(edH1.Text));
    except
      ShowMessage('Error writing number:'+edH1.Text);
      edH1.SetFocus;
      Exit;
      end;
   try
      H2:=StrToFloat(Trim(edH2.Text));
    except
      ShowMessage('Error writing number:'+edH2.Text);
      edH2.SetFocus;
      Exit;
      end;
   try
      rl1:=StrToFloat(Trim(edr1.Text));
    except
      ShowMessage('Error writing number:'+edr1.Text);
      edr1.SetFocus;
      Exit;
      end;
   try
      rl2:=StrToFloat(Trim(edr2.Text));
    except
      ShowMessage('Error writing number:'+edr2.Text);
      edr2.SetFocus;
      Exit;
      end;
   try
      N:=StrToFloat(Trim(edKoord.Text));
    except
      ShowMessage('Error writing number:'+edKoord.Text);
      edKoord.SetFocus;
      Exit;
      end;
      try
      Tpl1:=StrToFloat(Trim(edTpl1.Text));
    except
      ShowMessage('Error writing number:'+edTpl1.Text);
      edTpl1.SetFocus;
      Exit;
      end;
      try
      Tpl2:=StrToFloat(Trim(edTpl2.Text));
    except
      ShowMessage('Error writing number:'+edTpl2.Text);
      edTpl2.SetFocus;
      Exit;
      end;

      try
      T1:=StrToFloat(Trim(edT1.Text));
    except
      ShowMessage('Error writing number:'+edT1.Text);
      edT1.SetFocus;
      Exit;
      end;

       try
      T2:=StrToFloat(Trim(edT2.Text));
    except
      ShowMessage('Error writing number:'+edT2.Text);
      edT2.SetFocus;
      Exit;
      end;

        try
      Cs1:=StrToFloat(Trim(edC1s.Text));
    except
      ShowMessage('Error writing number:'+edC1s.Text);
      edC1s.SetFocus;
      Exit;
      end;

      try
      Cs2:=StrToFloat(Trim(edC2s.Text));
    except
      ShowMessage('Error writing number:'+edC2s.Text);
      edC2s.SetFocus;
      Exit;
      end;

     try
      Cl1:=StrToFloat(Trim(edC1l.Text));
    except
      ShowMessage('Error writing number:'+edC1l.Text);
      edC1l.SetFocus;
      Exit;
      end;

      try
      Cl2:=StrToFloat(Trim(edC2l.Text));
    except
      ShowMessage('Error writing number:'+edC2l.Text);
      edC2l.SetFocus;
      Exit;
      end;
  end;

 procedure Energ;
   var
   un1,un2,za,zb:real;

   begin

Ha:=(2*H1)/(N*Na)/1.6e-19;//T1;{Heat of fusion per one bond for component A}
Hb:=(2*H2)/(N*Na)/1.6e-19;//T1; {Heat of fusion per one bond for component B}
rs1:=(H1+rl1)/(1.6e-19*Na);//T1;{Heat of vaporization per one bond for component A}
rs2:=(H2+rl2)/(1.6e-19*Na);//T1;{Heat of vaporization per one bond for component A}
rl1:=rl1/(1.6e-19*Na);//T1;  in
rl2:=rl2/(1.6e-19*Na);//T1;

Vss11:=-2*rs1/N;{energy of interaction between two solid atoms (А-А)}
Vss22:=-2*rs2/N;{energy of interaction between two solid atoms (В-В)}
Vll11:=-2*rl1/N;{energy of interaction between two liquid atoms (А-А)}
Vll22:=-2*rl2/N;{energy of interaction between two liquid atoms (В-В)}



  Cs1:=(1-Cs2); {solid phase B concentration}
  Cl1:=(1-Cl2);  {liquid phase B concentration}

  dGa1:=Ha*(Tpl1-T1)/T1;
  dGb1:=Hb*(Tpl2-T1)/T1;
  dGa2:=Ha*(Tpl1-T2)/T2;
  dGb1:=Hb*(Tpl2-T2)/T2;

  za:=N;
  zb:=N;

  un1:=(za*sqr(Cs2)/2*(ln(Cs2/Cl2)-dGb1))-(za*sqr(Cs1)/2*(ln(Cs1/Cl1)-dGa1));
  un2:=za*zb/4*(sqr(Cl2)*sqr(Cs1)-sqr(Cs2)*sqr(Cl1));
  Wll12:=un1/un2;
  Wss12:=(ln(Cs1/Cl1)-dGa1+zb*Wll12/2*sqr(Cl2))*2/za/sqr(Cs2);

  Vss12:=(-Wss12+Vss11+Vss22)/2;
  Vll12:=(-Wll12+Vll11+Vll22)/2;

  Vsl11:=Vll11;
  Vsl22:=Vll22;
  Vsl12:=Vll12;
  Wsl11:=(Vss11+Vll11)-2*Vsl11;
  Wsl22:=(Vss22+Vll22)-2*Vsl22;
  Wsl12:=(Vss11+Vll22)-2*Vsl12;

   {Проверка}

  Cl_1:=Cs1/(exp(dGa1+za*Wss12/2*sqr(Cs2)-zb*Wll12/2*sqr(Cl2)));
  Cl_2:=Cs2/(exp(dGb2+za*Wss12/2*sqr(Cs1)-zb*Wll12/2*sqr(Cl1)));
  Cs_1:=(exp(dGa1+za*Wss12/2*sqr(Cs2)-zb*Wll12/2*sqr(Cl2)))*Cl1;
  Cs_2:=(exp(dGb2+za*Wss12/2*sqr(Cs1)-zb*Wll12/2*sqr(Cl1)))*Cl2;






  end;

 begin
 TakeData;
   Energ;
        mmOutput.Lines.Add('  1');//          energy conversion into dimensionless quantities');
        mmOutput.Lines.Add('                    Ha = '+FloatToStr(Ha));
        mmOutput.Lines.Add('                    Hb = '+FloatToStr(Hb));
        mmOutput.Lines.Add('                    rl1 = '+FloatToStr(rl1));
        mmOutput.Lines.Add('                    rl2 = '+FloatToStr(rl2));
        mmOutput.Lines.Add('                    rs1 = '+FloatToStr(rs1));
        mmOutput.Lines.Add('                    rs2 = '+FloatToStr(rs2));
        mmOutput.Lines.Add('                    dGa1 = '+FloatToStr(dGa1));
        mmOutput.Lines.Add('                    dGb1 = '+FloatToStr(dGb1));
        mmOutput.Lines.Add('');
        mmOutput.Lines.Add('  The following energy valies are obtained for this system in eV:');
        mmOutput.Lines.Add('                    Vss11 = '+FloatToStr(Vss11));
        mmOutput.Lines.Add('                    Vss22 = '+FloatToStr(Vss22));
        mmOutput.Lines.Add('                    Vss12 = '+FloatToStr(Vss12));
        mmOutput.Lines.Add('                    Wss12 = '+FloatToStr(Wss12));
        mmOutput.Lines.Add('');
        mmOutput.Lines.Add('                    Vll11 = '+FloatToStr(Vll11));
        mmOutput.Lines.Add('                    Vll22 = '+FloatToStr(Vll22));
        mmOutput.Lines.Add('                    Vll12 = '+FloatToStr(Vll12));
        mmOutput.Lines.Add('                    Wll12 = '+FloatToStr(Wll12));
        mmOutput.Lines.Add('');
        mmOutput.Lines.Add('                    Vsl11 = '+FloatToStr(Vsl11));
        mmOutput.Lines.Add('                    Vsl22 = '+FloatToStr(Vsl22));
        mmOutput.Lines.Add('                    Vsl12 = '+FloatToStr(Vsl12));
        mmOutput.Lines.Add('                    Wsl11 = '+FloatToStr(Wsl11));
        mmOutput.Lines.Add('                    Wsl22 = '+FloatToStr(Wsl22));
        mmOutput.Lines.Add('                    Wsl12 = '+FloatToStr(Wsl12));
        mmOutput.Lines.Add('');
        mmOutput.Lines.Add('                                      check:');
        mmOutput.Lines.Add('                    Cl_1 = '+FloatToStr(Cl_1));
        mmOutput.Lines.Add('                    Cl_2 = '+FloatToStr(Cl_2));
        mmOutput.Lines.Add('                    Cs_1 = '+FloatToStr(Cs_1));
        mmOutput.Lines.Add('                    Cs_2 = '+FloatToStr(Cs_2));



 end;
 procedure TfmEnergies.btnClrClick(Sender: TObject);
begin
    edH1.Text:='';
    edH2.Text:='';
    edr1.Text:='';
    edr2.Text:='';
    edTpl1.Text:='';
    edTpl2.Text:='';
    edT1.Text:='';
    edT2.Text:='';
    edKoord.Text:='';
    edC2s.Text:='';
    edC1s.Text:='';
    edC2l.Text:='';
    edC1l.Text:='';
    mmOutput.Clear;

end;

procedure TfmEnergies.btnStartClick(Sender: TObject);
begin
    edH1.Text:='17800';
    edH2.Text:='8950';
    edr1.Text:='380600';
    edr2.Text:='131800';
    edTpl1.Text:='1726';
    edTpl2.Text:='923';
    edT1.Text:='1395';
    edT2.Text:='1385';
    edKoord.Text:='12';
    edC2s.Text:='0,0024';
    edC2l.Text:='0,2';
    edC1s.Text:='0,002';
    edC1l.Text:='0,15';
    mmOutput.Clear;

end;

procedure TfmEnergies.btnBi_SnClick(Sender: TObject);
begin
edH1.Text:='10900';
    edH2.Text:='7700';
    edr1.Text:='151500';
    edr2.Text:='290000';
    edTpl1.Text:='544,3';
    edTpl2.Text:='505';
    edT1.Text:='530';
    edT2.Text:='520';
    edKoord.Text:='6';
    edC2s.Text:='0,002';
    edC2l.Text:='0,1';
    edC1s.Text:='0,001';
    edC1l.Text:='0,05';
    mmOutput.Clear;

end;

procedure TfmEnergies.btnBi_InClick(Sender: TObject);
begin
    edH1.Text:='10900';
    edH2.Text:='3270';
    edr1.Text:='151500';
    edr2.Text:='226000';
    edTpl1.Text:='544,3';
    edTpl2.Text:='156';
    edT1.Text:='520';
    edT2.Text:='500';
    edKoord.Text:='6';

    edC2s.Text:='0,002';
    edC2l.Text:='0,1';
    edC1s.Text:='0,001';
    edC1l.Text:='0,05';
    mmOutput.Clear;
end;

procedure TfmEnergies.BtnAl_GaClick(Sender: TObject);
begin
    edH1.Text:='10868';
    edH2.Text:='5141,4';
    edr1.Text:='283822';
    edr2.Text:='266684';
    edTpl1.Text:='933,2';
    edTpl2.Text:='275,5';
    edT1.Text:='920';
    edT2.Text:='910';
    edKoord.Text:='12';

    edC2s.Text:='0,002';
    edC2l.Text:='0,3';
    edC1s.Text:='0,001';
    edC1l.Text:='0,15';
    mmOutput.Clear;
end;

end.

