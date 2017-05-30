unit main;
{
/*
[----------------------------------------------------------
Program: ViewTxt
Function: Browse by folders and shows text files.
Language: Pascal - Lazarus
Author: CarlosRobertoMacedonio - crmacedo@gmail.com
Created:
Updated: 29/Mai/2017
----------------------------------------------------------]
*/
}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ListViewFilterEdit, Forms, Controls, Graphics,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, FileCtrl, EditBtn, ShellCtrls,Strings;

type

  { TForm1 }

  TForm1 = class(TForm)
    DirectoryEdit1: TDirectoryEdit;
    FileListBox1: TFileListBox;
    FilterComboBox1: TFilterComboBox;
    FontDialog1: TFontDialog;
    ImageList1: TImageList;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    TBExit: TToolButton;
    TBFont: TToolButton;
    TBSave: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure DirectoryEdit1Change(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    procedure FilterComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
//    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TBExitClick(Sender: TObject);
    procedure TBFontClick(Sender: TObject);
    procedure TBSaveClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation
uses about;

{$R *.lfm}

{ TForm1 }

procedure TForm1.TBExitClick(Sender: TObject);
begin
  Application.Terminate; // ends the application
end;

// Altera a fonte do Memo
procedure TForm1.TBFontClick(Sender: TObject);
begin
  FontDialog1.Options := FontDialog1.Options;
  if (FontDialog1.Execute) then Memo1.Font.Assign(FontDialog1.Font);
end;

// Salva arquivo
procedure TForm1.TBSaveClick(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(FileListBox1.FileName);
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
     FileListBox1.Sorted:=NOT (FileListBox1.Sorted);
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  SaveDialog1.FileName:=FileListBox1.FileName; // initial file name
  if SaveDialog1.Execute then
    Memo1.Lines.SaveToFile( SaveDialog1.Filename );
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

// Apos mudar o folder, atualiza a lista de arquivos
procedure TForm1.DirectoryEdit1Change(Sender: TObject);
begin
//  ShellTreeView1.Root:=DirectoryEdit1.Directory;
//  ShellTreeView1.Refresh;
  FileListBox1.Directory:=DirectoryEdit1.Directory;
  FileListBox1.Refresh;
end;

procedure TForm1.FileListBox1Change(Sender: TObject);
begin

end;

// Carrega o arquivo psra o Memo
procedure TForm1.FileListBox1Click(Sender: TObject);
var
  p : integer;
  buff : string;
  //p2 : integer;
begin
     p:=Length(FileListBox1.FileName); // comprimento da string
     // RightStr('abcdefghijklmnopqrstuvwxyz',20)
     // p2:=LastDelimiter('\.:','c:\filename.ext');

     //ShowMessage('Comprimento p ='+IntToStr(p)+' ultimo: '+Copy(FileListBox1.FileName,p,1));

     { olhar este código, usar para navegar
     With FileListBox1 do begin
     FileType:=[ftNormal,ftReadOnly];
     Mask:='*.*';
     MultiSelect:=True;

     Directory:='C:\Tmp\Dir1\';
   end;

      }
     buff:=Copy(FileListBox1.FileName,p,1);
     if (FileListBox1.FileType <> [ftdirectory] ) then begin

        if ((Copy(FileListBox1.FileName,p,1) <> '\') or (Copy(FileListBox1.FileName,p,1) <> '/') or (Copy(FileListBox1.FileName,p,1) <> '.')) then begin
           Memo1.Lines.Clear;
           Memo1.Lines.LoadFromFile(FileListBox1.FileName);
           StatusBar1.Panels.Items[0].Alignment:=taLeftJustify;
           StatusBar1.Panels.Items[0].Width:=Form1.Width;
           StatusBar1.Panels.Items[0].Text:=FileListBox1.FileName;
           end;
     end;
end;

// Após mudar a mascara, atualiza a lista de arquivos
procedure TForm1.FilterComboBox1Change(Sender: TObject);
begin
  FileListBox1.Mask:=FilterComboBox1.Mask;
  FileListBox1.Refresh;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear; // Clear memo1 content
  FileListBox1.Directory:=DirectoryEdit1.Directory;
  FileListBox1.Mask:=FilterComboBox1.Mask;
  StatusBar1.Panels.Items[0].Text:=FileListBox1.Directory;
  FileListBox1.Refresh;
end;

// redesenha ao ser redimensionado.
procedure TForm1.FormResize(Sender: TObject);
begin
  Form1.Repaint;
  Memo1.Repaint;
  Splitter1.Width:=6;
  Splitter1.Left:=Panel1.Width+2;
  StatusBar1.Panels.Items[0].Alignment:=taLeftJustify;
  StatusBar1.Panels.Items[0].Width:=Form1.Width;
  if (FileListBox1.FileName <> '') then  StatusBar1.Panels.Items[0].Text:=FileListBox1.FileName;
end;

//procedure TForm1.ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
//begin
//  FileListBox1.Directory:=ShellTreeView1.Path;
//end;

end.

