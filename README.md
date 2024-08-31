# RenameKavita
Rename Manga Files to fit Kavita's scanner : https://wiki.kavitareader.com/guides/scanner

The Powershell script will take folder name and deducted Volume/Chapter number to rename each file
Example : 
MyManga4Ever\MyManga4Ever vol1 (Year2024) [Type].cbz → MyManga4Ever\MyManga4Ever Vol.0001.cbz

Notes :
- Will erase all data in brackets
- Folder should be named proprely
- The deducted Volume/Chapter Number is the last set of numbers of the file name, excluding brackets  
- Specials are not proprely renamed


How To Use :
- Download file 'RenameKavita.ps1' available in Powershell folder
- Right clic : Execute with Powershell
- Fill the parameters in the form
    Parameters 
    - Path : Folder where are the files you want to rename. Will Check subfolders too.
    Example : D:\Users\MyUser\MyManga

    - Extension : Only files with these extensions will be renamed. This is done to exclude covers (jpg,png), ...
    You can add extensions by adding them, separated by a comma
    Example : pdf,cbr,cbz,epub

    - File Type : Are all the files in (sub)folders set in Path Volumes or Chapters ?
    Volume : will use the naming like 'Vol.0001'
    Chapters : will use the naming like 'Vol.TBD Ch.0001'
- Press the button to run the renaming script


Legacy VBA script available.



Learn more about Kavita :
- https://github.com/Kareadita/Kavita
- https://www.kavitareader.com/