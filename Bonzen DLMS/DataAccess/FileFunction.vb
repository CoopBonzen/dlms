Imports Microsoft.Win32
Imports System.Security.Permissions
Imports System.IO

Public Class FileFunction

    Public Shared Function GetMimeType(ByVal filePathArg As String) As String
        Dim registryPermission As New RegistryPermission(RegistryPermissionAccess.Read, "\\HKEY_CLASSES_ROOT")
        Dim hiveClassesRoot As RegistryKey = Registry.ClassesRoot
        Dim myFileInfo = New FileInfo(filePathArg)
        Dim fileExtension As String = LCase(myFileInfo.Extension)
        Dim keyContentType As RegistryKey = hiveClassesRoot.OpenSubKey("MIME\Database\Content Type")
        Dim keyName As String = String.Empty
        Dim Result As String = String.Empty

        For Each keyName In keyContentType.GetSubKeyNames()
            Dim currentKey As RegistryKey = hiveClassesRoot.OpenSubKey("MIME\Database\Content Type\" & keyName)
            If LCase(currentKey.GetValue("Extension")) = fileExtension Then Result = keyName
        Next
        Return IIf(Result = String.Empty, "application/x-unknown", Result)
    End Function

    Public Shared Sub DirectoryCopy( _
        ByVal sourceDirName As String, _
        ByVal destDirName As String, _
        ByVal copySubDirs As Boolean)

        ' Get the subdirectories for the specified directory. 
        Dim dir As DirectoryInfo = New DirectoryInfo(sourceDirName)
        Dim dirs As DirectoryInfo() = dir.GetDirectories()

        If Not dir.Exists Then
            Throw New DirectoryNotFoundException( _
                "Source directory does not exist or could not be found: " _
                + sourceDirName)
        End If

        ' If the destination directory doesn't exist, create it. 
        If Not Directory.Exists(destDirName) Then
            Directory.CreateDirectory(destDirName)
        End If
        ' Get the files in the directory and copy them to the new location. 
        Dim files As FileInfo() = dir.GetFiles()
        For Each file As FileInfo In files
            Dim temppath As String = Path.Combine(destDirName, file.Name)
            file.CopyTo(temppath, False)
        Next file

        ' If copying subdirectories, copy them and their contents to new location. 
        If copySubDirs Then
            For Each subdir As DirectoryInfo In dirs
                Dim temppath As String = Path.Combine(destDirName, subdir.Name)
                DirectoryCopy(subdir.FullName, temppath, copySubDirs)
            Next subdir
        End If
    End Sub

End Class