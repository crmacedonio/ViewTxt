unit main;
{
/*
[----------------------------------------------------------
Program: ViewTxt
Function: Browse by folders and shows text files.
Language: Pascal
Author: CarlosRobertoMacedonio - crmacedo@gmail.com
Created:
Updated:
----------------------------------------------------------]
*/
}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, FileCtrl, EditBtn, ShellCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    FilterComboBox1: TFilterComboBox;
    FontDialog1: TFontDialog;
    ImageList1: TImageList;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    SaveDialog1: TSaveDialog;
    ShellTreeView1: TShellTreeView;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure FilterComboBox1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure ShellTreeView1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  Application.Terminate; // ends the application
end;

// Altera a fonte do Memo
procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  FontDialog1.Options := FontDialog1.Options;
  if (FontDialog1.Execute) then Memo1.Font.Assign(FontDialog1.Font);
end;

// Após mudar a mascara, atualiza a lista de arquivos
procedure TForm1.FilterComboBox1Change(Sender: TObject);
begin
end;

// redesenha ao ser redimensionado.
procedure TForm1.FormResize(Sender: TObject);
begin
  Splitter1.Width:=6; // Define uma largura para o Splitter não sobrepor outros elementos
  Splitter1.Left:=Panel1.Width+Panel1.BorderSpacing.Left; // evita que o Splitter cubra o Panel e o Memo
end;

procedure TForm1.ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  //FileListBox1.Directory:=ShellTreeView1.Path;
  StatusBar1.SimpleText := ShellTreeView1.Path;
end;

procedure TForm1.ShellTreeView1Click(Sender: TObject);
begin
     Memo1.Lines.LoadFromFile(ShellTreeView1.Path);
     StatusBar1.SimpleText := ShellTreeView1.Path;
     //Form1.Caption:=ShellTreeView1.Path;
end;

end.

