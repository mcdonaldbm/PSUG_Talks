# Prerequisites
Install-Module -scope currentuser AWSPowershell
# OR
Install-Module -scope currentuser AWSPowershell.NETCore

# Create a group
New-IAMGroup -Path "/scotland/groups/" -GroupName "scotlandEngineers"

# Create a User
New-IAMUser -Path "/scotland/users/" -UserName "scotlandEng02"

    #region Getting users by Path
$users = Get-IAMUserList
$userprops = ForEach ($user in $users) {
    Get-IAMUser $user.UserName
}
$userprops | Where-Object -Property Path -Like "/scotland/users*"
    #endregion

# Add User to a Group
Add-IAMUsertoGroup -UserName "scotlandEng02" -GroupName "scotlandEngineers"

# Get users from a group
(Get-IAMGroup -GroupName "scotlandEngineers").Users

# Stage the policy in the AWS Management Console
# Create a policy
Write-IAMGroupPolicy -GroupName "scotlandEngineers" `
        -PolicyName "scotland-psug-2018-08-22" `
        -PolicyDocument (Get-Content -Raw policy.json)

# Alternatively, use a pre-built policy
Register-IAMGroupPolicy -GroupName "scotlandEngineers" `
        -PolicyArn "arn:aws:iam::aws:policy/AmazonS3FullAccess"

# After setting a groups policies
Get-IAMGroupPolicies -GroupName "scotlandEngineers"

    #region Coupon Time!
    https://leanpub.com/awspowershell/c/scotPSUG
    #endregion