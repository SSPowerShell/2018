

<#=====================================================================

        Generate random 14-18 character password

======================================================================#>


function Get-RandomPassword
{
    $asci = [char[]]([char]33..[char]95) + ([char[]]([char]97..[char]126))
    $RandomASCI = (1..$(Get-Random -Min 13 -Max 17) | % {$asci | get-random}) -join “”
    $RandomPassword = ($RandomASCI -replace "(?<=^.{$(Get-Random -Min 3 -Max 11)}).","$(Get-Random -Min 0 -Max 99)")

    return $RandomPassword
}




<#=====================================================================

        Generate semi-unique password via approved phrase list

======================================================================#>


function Get-PhrasePassword
{
    $Words = Get-Content "$PSScriptRoot\Pass-List.txt" 
    $r = Get-Random -Maximum $Words.Count
    [string]$PhrasePassword = $Words[$r] + (Get-Random -Minimum 10 -Maximum 999)

    return $PhrasePassword
}