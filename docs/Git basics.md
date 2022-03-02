# Git basics

## Git Configuration (ESoreq)

The first order of business is to configure your git on your workspace.
I assume here that you are using the college cluster (but the same applies to your personal computer).

### Use tokens instead of a password

Instead of a password, you should be using a Personal Access Token that is more flexible and easier to secure. This is a brief walk-through of how to setup and use these tokens.

#### Get a token

The first step in using tokens is to generate a token from the GitHub website. It is advised to use different tokens for different computers, systems, services, or tasks to facilitate the management.

1. Log into GitHub
1. Click on your name / Avatar in the upper right corner and select Settings
1. On the left, click Developer settings
1. Select Personal access tokens and click Generate new token
1. Give the token a description/name and select the scope of the token
1. I selected repo only to facilitate pull, push, clone, and commit actions and delete repo
1. Click Generate token
1. Copy the token – this is your new password!

### Config code

```bash
git config --global user.name "username"
git config --global user.email email@emailServer
git config --global user.token xxxxxxxxxxxxxx
git config --global core.editor nano
```

### Storing credentials
https://stackoverflow.com/questions/35942754/how-can-i-save-username-and-password-in-git  
Attention: This method saves the credentials in plaintext on your PC's disk. Everyone on your computer can access it, e.g. malicious NPM modules.
```
git config --global credential.helper store
git pull
```


## Checkout an existing remote repository to your working directory
```
git clone username@host:/path/to/repository
```

There are three layers in the working directory. Before making changes in the remote master/main repository you need to 
1. index changes (git add)
2. commit these changes to the 'head' of local working copy (git commit)
3. Push changes to remote repo (git push)

```
git add *
git commit -m "commit message"
git push origin main
```
Changes can be made to any 'branch', main is the default in Github. A new branch can be worked on to isolate a specific feature or subproject before merging with the main branch. 

To make a new branch
```
git checkout -b feature_x
```
This will automatically change to the new branch. This will not be available in the remote repo until pushed.
To change back to master 
```
git checkout master
```

### Update and merge
It is recomended to pull the most up to date version of the remote repo before working on local changes and then to push these back when finished. To pull the remote repo run

```
git pull
```

#### Taging and logs are helpful

*Git will ignore empty folders. Make sure at least one file is present in the new folder in the Git repository, or else you are not able to add it*

*Recommended reading:*
https://rogerdudler.github.io/git-guide/