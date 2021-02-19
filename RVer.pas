{######################################################}
{### (c) Computer Stars Software, 2012              ###}
{###        RVer  v2.0a                             ###}
{###        Unit version 2.0a                       ###}
{###        Version info utility                    ###}
{######################################################}
{### Developer: Andrew Kambaroff aka Raven aka RaJa ###}
{######################################################}
unit RVer;

interface

type
  TVersion=packed record
    V1,
    V2,
    V3,
    V4: UInt32;
  end;

function GetVersion: string;
function GetVersionRecord: TVersion;

implementation
uses Windows, SysUtils;

function GetVersion: string;
 var
   VerInfoSize: LongWord;
   VerInfo: Pointer;
   VerValueSize: LongWORD;
   VerValue: PVSFixedFileInfo;
   Dummy: LongWORD;
   exe: String;
 begin
   exe:=ParamStr(0);
   VerInfoSize := GetFileVersionInfoSize(PWideChar(exe), Dummy);
   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
   VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
   with VerValue^ do
   begin
     Result := IntToStr(dwFileVersionMS shr 16);
     Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
     Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
     Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
   end;
   FreeMem(VerInfo, VerInfoSize);
 end;

function GetVersionRecord: TVersion;
 var
   VerInfoSize: LongWord;
   VerInfo: Pointer;
   VerValueSize: LongWORD;
   VerValue: PVSFixedFileInfo;
   Dummy: LongWORD;
   exe: String;
 begin
   exe:=ParamStr(0);
   VerInfoSize := GetFileVersionInfoSize(PWideChar(exe), Dummy);
   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
   VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
   with VerValue^ do
   begin
     Result.V1 := dwFileVersionMS shr 16;
     Result.V2 := dwFileVersionMS and $FFFF;
     Result.V3 := dwFileVersionLS shr 16;
     Result.V4 := dwFileVersionLS and $FFFF;
   end;
   FreeMem(VerInfo, VerInfoSize);
 end;

 end.
