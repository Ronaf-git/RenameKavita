# ----------------------------------------------------
# -- Projet : RenameKavita
# -- Author: Ronaf
# -- Created : 31/08/2024
# -- Update : 31/08/2024 - v0.1 - Initial Script
# --  
# ----------------------------------------------------

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -scope currentuser

#=====================================================================================================
#========================================== Functions ================================================
#=====================================================================================================
#https://github.com/Ronaf-git/GUI_Winforms-pwsh
function New-FormLight {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [int]$Height,

        [Parameter(Mandatory=$false)]
        [int]$Width,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$BackColor = 'LightBlue'

    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
        
    $Form = New-Object Windows.Forms.Form
    $Form.Text = $Text
    $Form.BackColor=$BackColor

    if ($Width+$Height -gt 0) {
        $Form.Width = $Width
        $Form.Height = $Height
        } else {
        $Form.WindowState = 'Maximized'
        }

    #If willing to fullscreen without borders $Form.FormBorderStyle = 'None';

    return $Form


    <#
    .SYNOPSIS

    Create a Form used for GUI.

    .DESCRIPTION

    Create a Form for Windows Display. Light version with basics parameters
    Objects (Lable, Button, Combobox) should be added to this form.

    .PARAMETER Text
    Form's Text (Head of the window)

    .PARAMETER Height
    Form's Height. If Height and Width are omissed, the form will be displayed in Maximized window.

    .PARAMETER Width
    Form's Width. If Height and Width are omissed, the form will be displayed in Maximized window.

    .PARAMETER BackColor 
    Color of the Background's Form. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color

    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.Form

    .EXAMPLE

    $Form = New-FormLight -text "Made By Me" -BackColor 'Black'

    #add controls to my form
    $Form.Controls.add($MyFormObject)

    #activate/show form
    $Form.Add_Shown({$Form.Activate()})

    #To Stop script until the form is closed
    $Form.ShowDialog() 

    #To continue script even if the form is still displayed. Example : usefull for progress bar
    [void]$Form.Show()
    #<MyScriptHere>
    $Form.Close()

    .EXAMPLE

    $MyFormParam = @{
    text = "Made By Me" 
    BackColor = 'Black'
    }
    $Form = New-FormLight @MyFormParam

    #add controls to my form
    $Form.Controls.add($MyFormObject)

    #activate/show form
    $Form.Add_Shown({$Form.Activate()})

    #To Stop script until the form is closed
    $Form.ShowDialog() 

    #To continue script even if the form is still displayed. Example : usefull for progress bar
    [void]$Form.Show()
    #<MyScriptHere>
    $Form.Close()

    .LINK

    https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.form

    #>    
}

function New-FormObjectLinkLabelLight {
    param (
        [Parameter(Mandatory=$true)]
        $url,

        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'regular',

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black'

    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing


    $LinkLabel = New-Object Windows.Forms.LinkLabel

    #to pass the Variable on the add_click scope
    $LinkLabel | Add-Member -NotePropertyMembers @{ CP = $url}
    $LinkLabel.add_Click({Start-Process $this.CP})


    $LinkLabel.Text = $text
    $LinkLabel.LinkColor = "BLUE"
    $LinkLabel.ActiveLinkColor = "RED"

    $LinkLabel.Font = New-Object Drawing.Font($Font, $FontSize, [System.Drawing.FontStyle]($FontStyle))
    $LinkLabel.AutoSize = $true
    $LinkLabel.Location = New-Object Drawing.Point($LocationX,$LocationY)
    $LinkLabel.ForeColor = $ForeColor

        return $LinkLabel


    <#
    .SYNOPSIS

    Create a LinkLabel Object used for GUI.

    .DESCRIPTION

    Create a LinkLabel Object for Windows Display. Light version with basics parameters.
    Must be added to a Form (Windows.Forms.Form)

        .PARAMETER Url
        Url used when the LinkLabel is clicked ok

    .PARAMETER Text
    LinkLabel's Text

    .PARAMETER Font 
    LinkLabel's Font

    .PARAMETER FontSize 
    LinkLabel's FontSize

    .PARAMETER FontStyle 
    LinkLabel's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle
    Example : 'italic,bold'

    .PARAMETER LocationX 
    Location of the LinkLabel in the form, on the X-Axis. Top Left is 0. Positive value expected

    .PARAMETER LocationY 
    Location of the LinkLabel in the form, on the Y-Axis. Top Left is 0. Positive value expected

    .PARAMETER ForeColor 
    Color of the LinkLabel's characters. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
    Example :
    $([System.Drawing.Color]::FromArgb(200,231,100,104))
    'Red'

    .INPUTS

    None.

    .OUTPUTS

    System.Windows.Forms.LinkLabel

    .EXAMPLE

    $MyFormObject = New-FormObjectLinkLabelLight -url 'Myurl' -text 'MyText' -LocationX 15 -LocationY 150

    to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyFormObject)

    .EXAMPLE

    $MyParam = @{
        url = 'Myurl'	
        text = 'MyText'
        LocationX = 15 
        LocationY = 150
        Font = 'Arial'
        FontSize = 10
        FontStyle = 'Bold,underline'
        ForeColor = $([System.Drawing.Color]::FromArgb(255,0,128,119))
    }
    $MyFormObject = New-FormObjectLinkLabelLight @MyParam

    to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyFormObject)

    .LINK

    https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.linklabel

    #>    
}

function New-FormObjectLabelLight {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'regular',

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black'

    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$Label = New-Object Windows.Forms.Label
$Label.Text = $Text
$Label.Font = New-Object Drawing.Font($Font, $FontSize, [System.Drawing.FontStyle]($FontStyle))
$Label.AutoSize = $true
$Label.Location = New-Object Drawing.Point($LocationX,$LocationY)
$Label.ForeColor = $ForeColor

    return $Label


<#
.SYNOPSIS

Create a Lable Object used for GUI.

.DESCRIPTION

Create a Lable Object for Windows Display. Light version with basics parameters.
Must be added to a Form (Windows.Forms.Form)

.PARAMETER Text
Label's Text

.PARAMETER Font 
Label's Font

.PARAMETER FontSize 
Label's FontSize

.PARAMETER FontStyle 
Label's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle
Example : 'italic,bold'

.PARAMETER LocationX 
Location of the label in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the label in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the characters's label. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
Example :
$([System.Drawing.Color]::FromArgb(200,231,100,104))
'Red'

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.label

.EXAMPLE

$MyFormObject = New-FormObjectLabelLight -text 'MyText' -LocationX 15 -LocationY 150

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.EXAMPLE

$MyParam = @{
	text = 'MyText'
	LocationX = 15 
	LocationY = 150
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(255,0,128,119))
}
$MyFormObject = New-FormObjectLabelLight @MyParam

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.LINK

https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.label

#>    
    
    }

function New-FormObjectTextBoxLight {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [bool]$Multiline = $false,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black'

    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$TextBox = New-Object System.Windows.Forms.textbox
$TextBox.Text = $Text
$TextBox.Multiline = $Multiline
$TextBox.Size = New-Object System.Drawing.Size($Width,$Height)
$TextBox.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$TextBox.Location = New-Object Drawing.Point($LocationX,$LocationY)
$TextBox.ForeColor = $ForeColor
    
    return $TextBox


<#
.SYNOPSIS

Create a TextBox Object used for GUI.

.DESCRIPTION

Create a TextBox Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER Text
TextBox's Text

.PARAMETER Height
TextBox's Height

.PARAMETER Width
TextBox's Width

.PARAMETER Multiline
Allow/Disallow display on multiple lines

.PARAMETER Font 
TextBox's Font

.PARAMETER FontSize 
TextBox's FontSize

.PARAMETER FontStyle 
TextBox's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the TextBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the TextBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER ForeColor 
Color of the characters's TextBox. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color

None.

.OUTPUTS

System.Windows.Forms.textbox

.EXAMPLE


$MyFormObject = New-FormObjectTextBoxLight -text 'MyText' -LocationX 15 -LocationY 150

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.EXAMPLE

$MyParam = @{
	text = 'MyText'
	Height = 50
	Width = 70
	Multiline = $true
	LocationX = 15 
	LocationY = 150
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = 'Black'
	BackColor = $([System.Drawing.Color]::FromArgb(255,0,128,119))
}
$MyFormObject = New-FormObjectTextBoxLight @MyParam

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.textbox

#>    
    }

function New-FormObjectButtonLight {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text,

        [Parameter(Mandatory=$false)]
        [int]$Height = 100,

        [Parameter(Mandatory=$false)]
        [int]$Width = 100,

        [Parameter(Mandatory=$false)]
        [int]$LocationX,

        [Parameter(Mandatory=$false)]
        [int]$LocationY,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',
		
		[Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'Black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$BackColor = 'LightGray'

    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point($LocationX,$LocationY)
$Button.Size = New-Object System.Drawing.Size($Width,$Height)
$Button.Font=New-Object System.Drawing.Font($Font, $FontSize, $FontStyle)
$Button.ForeColor = $ForeColor
$Button.BackColor = $BackColor
$Button.Text = $Text

    return $Button

<#
.SYNOPSIS

Create a ButtonObject used for GUI.

.DESCRIPTION

Create a ButtonObject for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER Text
Button's Text

.PARAMETER Height
Button's Height

.PARAMETER Width
Button's Width

.PARAMETER Font 
Button's Font

.PARAMETER FontSize 
Button's FontSize

.PARAMETER FontStyle 
Button's FontStyle. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER LocationX 
Location of the Button in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the Button in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER BackColor 
Color of the Back's Button. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color

.PARAMETER ForeColor 
Color of the characters's Button. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color


.INPUTS

None.

.OUTPUTS

System.Windows.Forms.Button

.EXAMPLE

$MyParam = @{
	text = 'MyText'
	Height = 150
	Width = 10
	LocationX = 15 
	LocationY = 150
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = 'Black'
	BackColor = $([System.Drawing.Color]::FromArgb(255,0,128,119))
}
$MyFormObject = New-FormObjectButtonLight @MyParam

to add an action after clic
$MyFormObject.Add_Click({
write-host "hello world"
	})


.EXAMPLE

$MyFormObject = New-FormObjectButtonLight -text 'MyText' -LocationX 15 -LocationY 150

to add an action after clic
$MyFormObject.Add_Click({
write-host "hello world"
	})

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.button

#>    
    
    }

function New-FormObjectRadioButtonLight {
    param (
        [Parameter(Mandatory=$false)]
        [string]$Text = 'My Radiobutton',

        [Parameter(Mandatory=$false)]
        [string]$Name,

        [Parameter(Mandatory=$false)]
        [int]$Height = 50,

        [Parameter(Mandatory=$false)]
        [int]$Width = 50, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$false)]
        [bool]$Checked= $false


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$RadioButton = New-Object System.Windows.Forms.RadioButton
$RadioButton.Location = New-Object System.Drawing.Size($LocationX,$LocationY)
$RadioButton.Size = New-Object System.Drawing.Size($Width,$Height)
$RadioButton.Checked = $Checked
$RadioButton.text = $Text
$RadioButton.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$RadioButton.ForeColor = $ForeColor
$RadioButton.Name = $Name

    return $RadioButton


<#
.SYNOPSIS

Create a RadioButton used for GUI.

.DESCRIPTION

Create a RadioButton for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)

.PARAMETER Text
RadioButton's Text

.PARAMETER Height
RadioButton's Height

.PARAMETER Width
RadioButton's Width

.PARAMETER LocationX 
Location of the RadioButton in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the RadioButton in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER Font 
RadioButton's Font

.PARAMETER FontSize 
RadioButton's FontSize

.PARAMETER FontStyle 
RadioButton's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER ForeColor 
Color of the RadioButton's characters . See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.PARAMETER Checked 
Default Checked State

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.radiobutton

.EXAMPLE

$MyFormObject = New-FormObjectRadioButtonLight -text 'My Radiobutton' -LocationX 15 -LocationY 150 

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.EXAMPLE

$MyParam = @{
    Text = 'My Radiobutton'
	Height = 150
	Width = 200
	LocationX = 15 
	LocationY = 150
	Font = 'Arial'
	FontSize = 10
	FontStyle = 'Bold,underline'
	ForeColor = $([System.Drawing.Color]::FromArgb(200,200,200,200))
	Checked = $false
}
$MyFormObject = New-FormObjectRadioButtonLight @MyParam

to add to a form (Windows.Forms.Form) : 
$Form.Controls.add($MyFormObject)

.LINK

https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.radiobutton

#>    
    
    }

function New-FormObjectGroupBoxLight {
    param (
        [Parameter(Mandatory=$false)]
        [string]$Text = 'My GroupBox Title',

        [Parameter(Mandatory=$false)]
        [int]$Height = 500,

        [Parameter(Mandatory=$false)]
        [int]$Width = 500, 

        [Parameter(Mandatory=$false)]
        [int]$LocationX=1,

        [Parameter(Mandatory=$false)]
        [int]$LocationY=1,

        [Parameter(Mandatory=$false)]
        [string]$Font = 'Arial',

        [Parameter(Mandatory=$false)]
        [int]$FontSize = 12,

        [Parameter(Mandatory=$false)]
        [Drawing.FontStyle]$FontStyle = 'Regular',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$ForeColor = 'black',

        [Parameter(Mandatory=$false)]
        [System.Drawing.Color]$BackColor = 'LightBlue'


    )
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
    
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Point($LocationX,$LocationY)
$groupBox.text = $Text
$groupBox.Size = New-Object System.Drawing.Size($Width,$Height)
$groupBox.Font = New-Object Drawing.Font($Font, $FontSize, $FontStyle)
$groupBox.BackColor = $BackColor
$groupBox.forecolor = $Forecolor
    
    return $groupBox


<#
.SYNOPSIS

Create a GroupBox Object used for GUI.

.DESCRIPTION

Create a GroupBox Object for Windows Display. Light version with basics parameters
Must be added to a Form (Windows.Forms.Form)
Usefull for
 - Grouping together radiobuttons
 - Creating a group of objects and move/duplicate them easily - also see Panel
Note that object add to the GroupBox have a new X/Y Axis, where top left of the groupbox is 0,0

.PARAMETER Text
GroupBox's Text

.PARAMETER Height
GroupBox's Height

.PARAMETER Width
GroupBox's Width

.PARAMETER LocationX 
Location of the GroupBox in the form, on the X-Axis. Top Left is 0. Positive value expected

.PARAMETER LocationY 
Location of the GroupBox in the form, on the Y-Axis. Top Left is 0. Positive value expected

.PARAMETER Font 
GroupBox's Font

.PARAMETER FontSize 
GroupBox's FontSize

.PARAMETER FontStyle 
GroupBox's FontStyle. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.fontstyle

.PARAMETER ForeColor 
Color of the GroupBox's title characters. 
See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.PARAMETER BackColor 
Color of the GroupBox's backgroud. See https://learn.microsoft.com/en-us/dotnet/api/system.drawing.color
$([System.Drawing.Color]::FromArgb(200,200,200,200))
'Red'

.INPUTS

None.

.OUTPUTS

System.Windows.Forms.groupbox

.EXAMPLE

$MyFormObject = New-FormObjectGroupBoxLight -text 'My GroupBox' -LocationX 15 -LocationY 150 
to add an object to the groupbox
    $MyGroupBox.Controls.add($MyFormObject)
to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyGroupBox)

.EXAMPLE

$MyParam = @{
    text ='My GroupBox'
    Height = 150
    Width = 400
    LocationX=20
    LocationY=750
    BackColor = 'LightBlue'
	ForeColor = $([System.Drawing.Color]::FromArgb(200,200,200,200))
    Font = 'Arial'
	FontSize = 26
	FontStyle = 'underline'
}
$MyFormObject = New-FormObjectGroupBoxLight @MyParam

to add an object to the groupbox
    $MyGroupBox.Controls.add($MyFormObject)
to add to a form (Windows.Forms.Form) : 
    $Form.Controls.add($MyGroupBox)

.LINK

https://learn.microsoft.com/fr-fr/dotnet/api/system.windows.forms.groupbox

#>    
    
    }

function Show-MessageBox { 
#source : https://stackoverflow.com/questions/59371640/powershell-popup-in-form
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $true, Position = 0)]
        [string]$Message,

        [parameter(Mandatory = $false)]
        [string]$Title = 'MessageBox in PowerShell',

        [ValidateSet("OKOnly", "OKCancel", "AbortRetryIgnore", "YesNoCancel", "YesNo", "RetryCancel")]
        [string]$Buttons = "OKCancel",

        [ValidateSet("Critical", "Question", "Exclamation", "Information")]
        [string]$Icon = "Information"
    )
    Add-Type -AssemblyName Microsoft.VisualBasic

    [Microsoft.VisualBasic.Interaction]::MsgBox($Message, "$Buttons,SystemModal,$Icon", $Title)
}

#=====================================================================================================
#============================================ Script =================================================
#=====================================================================================================
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


# ----------------- Create Form and objects -------------------------
#----- Form
$MyFormParam = @{
text = "RenameKavita - v0.1"
}
$Form = New-FormLight @MyFormParam

#----- Title
$LabelTitleParam = @{
	text = "Rename Manga Files to fit with Kavita's scanner"
	LocationX = 20 
	LocationY = 5
	Font = 'Arial'
	FontSize = 45
	FontStyle = 'bold,underline'
}
$LabelTitle = New-FormObjectLabelLight @LabelTitleParam
$Form.Controls.add($LabelTitle)

$LinklabelScanParam = @{
    url = 'https://wiki.kavitareader.com/guides/scanner'
	text = "See Kavita's scanner documentation"
	LocationX = 20 
	LocationY = 90
	Font = 'Arial'
	FontSize = 15
	FontStyle = 'italic'
}
$LinklabelScan = New-FormObjectLinkLabelLight @LinklabelScanParam
$Form.Controls.add($LinklabelScan)

#----- Textbox Path
$LabelPathParam = @{
	text = 'Folder Path. Will perform renaming on all subfolders too.'
	LocationX = 20 
	LocationY = 150
	Font = 'Arial'
	FontSize = 26
	FontStyle = 'underline'
}
$LabelPath = New-FormObjectLabelLight @LabelPathParam
$Form.Controls.add($LabelPath)

$TextBoxPathParam = @{
	text = 'D:\Users\MyUser\MyManga'
	Height = 200
	Width = 1000
	Multiline = $false
	LocationX = 20 
	LocationY = 200
	Font = 'Arial'
	FontSize = 18
}
$TextBoxPath = New-FormObjectTextBoxLight @TextBoxPathParam
$Form.Controls.add($TextBoxPath)

#----- Textbox fileType
$LabelfileTypeParam = @{
	text = 'Add Checked Extension. Use comma to add a new extension'
	LocationX = 20 
	LocationY = 270
	Font = 'Arial'
	FontSize = 26
	FontStyle = 'underline'
}
$LabelfileType = New-FormObjectLabelLight @LabelfileTypeParam
$Form.Controls.add($LabelfileType)

$TextBoxfileTypeParam = @{
	text = 'cbz,cbr,pdf'
	Height = 200
	Width = 1000
	Multiline = $false
	LocationX = 20 
	LocationY = 340
	Font = 'Arial'
	FontSize = 18
}
$TextBoxfileType = New-FormObjectTextBoxLight @TextBoxfileTypeParam
$Form.Controls.add($TextBoxfileType)

#------ GroupBox CustomName
#GroupBox
$MyParam_GroupBox = @{
    text ='Is the path filled with Volumes or Chapters ?'
    Height = 150
    Width = 800
    LocationX=20
    LocationY=400
    BackColor = 'LightBlue'
	ForeColor = 'Black'
    Font = 'Arial'
	FontSize = 26
	FontStyle = 'underline'
}
$MyGroupBox = New-FormObjectGroupBoxLight @MyParam_GroupBox

#RadioButtons
$MyParam_RadioButtonVol = @{
    Name = 'rbVol'
    Text = 'Volumes'
	Height = 50
	Width = 250
	LocationX = 20 
	LocationY = 80
	Font = 'Arial'
	FontSize = 20
	Checked = $true
}
$MyRadioButtonVol = New-FormObjectRadioButtonLight @MyParam_RadioButtonVol
$MyGroupBox.Controls.add($MyRadioButtonVol)

$MyParam_RadioButtonCh = @{
    Name = 'rbCh'
    Text = 'Chapters'
	Height = 50
	Width = 250
	LocationX = 400 
	LocationY = 80
	Font = 'Arial'
	FontSize = 20
	Checked = $false
}
$MyRadioButtonCh = New-FormObjectRadioButtonLight @MyParam_RadioButtonCh
$MyGroupBox.Controls.add($MyRadioButtonCh)

$Form.Controls.Add($MyGroupBox)  


#----- Button start script
$ButtonInitScriptParam = @{
	text = 'Rename my files'
	Height = 150
	Width = 150
	LocationX = 20 
	LocationY = 600
	Font = 'Arial'
	FontSize = 18
	FontStyle = 'Bold,underline'
	ForeColor = 'Black'
}
$ButtonInitScript = New-FormObjectButtonLight @ButtonInitScriptParam
$Form.Controls.add($ButtonInitScript)

$ButtonInitScript.Add_Click({
    # ----------------- Init variables -------------------------
    $Path = $TextBoxPath.text 
    $fileType = $TextBoxfileType.text -split ',' | %{"*.$_"} #('*.cbz','*.cbr','*.pdf') 
    switch ($($MyGroupBox.Controls | Where-Object -FilterScript {$_.Checked}).name) {
        'rbVol' {$CustomName = 'Vol.' }
        'rbCh' {$CustomName = 'Vol.TBD Ch.' }

    }
    # ----------------- Check if the output path exists -------------------------
    if (!(Test-Path -LiteralPath $Path)){
        $Path
        Show-MessageBox -Message "Please fill with a valid path" -Buttons OKOnly -Title "Invalid Path" -Icon Information
            } 
        else {
            # ----------------- Init variable for search -------------------------
            $FilesNotRenamed = @()
            $files = Get-ChildItem -File $Path -include $fileType -ErrorAction SilentlyContinue -Recurse
            foreach ($File in $files) {
            	$FileDir= [System.IO.Path]::GetDirectoryName($File) 
	            $FileDirName= Split-Path -Leaf $FileDir
                $FileName = [System.IO.Path]::GetFileNameWithoutExtension($File)
                $FileExtension = [System.IO.Path]::GetExtension($File)

                #Get the last set of number. Need this because filename can be : 'Love2Much T18 (Ohkubo) (2021) [Digital-2366] [Manga FR] (TONER-PapriKa+)' and we just need 18
                    #Step 1 : replace every non-number ([^0-9]), cheracters between () ([(]([^)]*)) and [] (\[(.*?)\]) by a space : -replace "MyRegex" , ' '
                    #Step 2 : split my ReplacedText by group of space : -split '\s+'
                    #Step 3 : if my array's lenght is not odd, take the last item. if odd, take the penulatimate
                    #Step 4 : set my format to aways have 4 number : 12 becomes 0012 and 1 becomes 0001
                #Step 1   
                $TempArray = ($FileName -replace "[(]([^)]*)|\[(.*?)\]|[^0-9]" , ' ')
                #Step 2
                $TempArray = $TempArray -split '\s+'
                #Step 3
                if ($TempArray.length % 2 -eq 0) {$Index = $TempArray.length -1 } else {$Index = $TempArray.length -2}
                [int]$Number = $TempArray[$Index] 
                #Step 4
                [string]$Number = $Number | % tostring 0000

                #Rename
                $NewFile = "$FileDir\$FileDirName $CustomName$Number$FileExtension"
                try {Rename-Item -LiteralPath $File -NewName $NewFile}
                    catch {$FilesNotRenamed += "$File`r`n"}
                
            }
        if ($FilesNotRenamed.Length -gt 0) {$FilesNotRenamed = ,"Note that these files couldn't be renamed : " + $FilesNotRenamed}    
        Show-MessageBox -Message "Completed Script.`r`n$FilesNotRenamed" -Buttons OKOnly -Title "Script Result"          
        }
})

$Form.ShowDialog() | Out-Null








