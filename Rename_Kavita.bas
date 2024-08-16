Attribute VB_Name = "Rename_Kavita"
Sub Rename_Kavita()

Folder = InputBox("Folder") & "\"
tbName = Split(Folder, "\")
strName = tbName(UBound(tbName) - 1)

Dim StrFile As String
StrFile = Dir(Folder)
Do While Len(StrFile) > 0
    oldName = Folder & "\" & StrFile
    Extension = Right(oldName, 4)
    
    Dim i As Byte, Nb As Byte
    Dim Target As String, Output As String
    Dim Number As Double
    
    Target = StrFile
    'Change Comma to Dot, so we can find value
    Target = Replace(Target, ",", ".")
    'to manage two following numbers : replace space by another character
    Target = Replace(Target, " ", "x")
    cc = 0
    
    For i = 1 To Len(Target)
        If IsNumeric(Mid(Target, i, 1)) Then
            If cc = 0 Then
            Number = Val(Mid(Target, i, Len(Target) - i + 1))
            Exit For
            Else
            cc = cc + 1
            End If
        End If
    
    Next
            
    Select Case Number
        Case Is < 10
        strNamebre = "00" & Number
        Case Is < 100
        strNamebre = "0" & Number
        Case Else
        strNamebre = Number
    
    End Select
    
'        newName = Replace(oldName, strDel, "")
    newName = Folder & "\" & strName & " Vol." & strNamebre & Extension  'Vol.TBD Ch. '
    Name oldName As newName ' Rename file.
    StrFile = Dir
Loop
End Sub
