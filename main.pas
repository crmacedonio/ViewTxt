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
  Classes, SysUtils, FileUtil, ListViewFilterEdit, Forms, Controls, Graphics,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, FileCtrl, EditBtn, ShellCtrls;

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
    ShellTreeView1: TShellTreeView;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure DirectoryEdit1Change(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    procedure FilterComboBox1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
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

// Apos mudar o folder, atualiza a lista de arquivos
procedure TForm1.DirectoryEdit1Change(Sender: TObject);
begin
  FileListBox1.Directory:=DirectoryEdit1.Directory;
  ShellTreeView1.Root:=DirectoryEdit1.Directory;
  FileListBox1.Refresh;
end;

procedure TForm1.FileListBox1Click(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(FileListBox1.FileName);

  //StatusBar1.Panels.Items[1].Text:=FileListBox1.FileName;
end;

// Após mudar a mascara, atualiza a lista de arquivos
procedure TForm1.FilterComboBox1Change(Sender: TObject);
begin
  FileListBox1.Mask:=FilterComboBox1.Mask;
  FileListBox1.Refresh;
end;

// redesenha ao ser redimensionado.
procedure TForm1.FormResize(Sender: TObject);
begin
  Form1.Repaint;
  Memo1.Repaint;
  Splitter1.Width:=6;
  Splitter1.Left:=Panel1.Width+2;
end;

procedure TForm1.ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  FileListBox1.Directory:=ShellTreeView1.Path;
end;

end.

