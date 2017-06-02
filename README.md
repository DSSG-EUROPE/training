# Installing:
Install Git with Homebrew
For OS X, you can follow these instructions to install Git:
$ brew install git
For Linux users:
$ sudo apt-get install git

# Create your own github account

# Forking a repo
Forking a GitHub Repository
The first step is to fork the GitHub repository with which you’d like to work. For example, if you were interested in helping contribute to some project, you would first fork it. Forking it is basically making a copy of the repository, but with a link back to the original.
Log-in into GitHub with your account.
Find the GitHub repository with which you’d like to work.
Click the Fork button on the upper right-hand side of the repository’s page.

## Clone the repo 
 Clone the repository down to your local system using:
 
 $ git clone https://github.com/username/training.git

Git will copy down the repository, both contents and commit history, to your system. Git will also add a Git remote called origin that points back to the forked repository in your GitHub account.
If you were only interested in making a fork of the project and not contributing back to the original project, you could stop here. 
but if you want to contribute ...

# Add a remote
Git already added a Git remote named origin to the clone of the Git repository on your system, and this will allow you to push changes back up to the forked repository in your GitHub account using git commit (to add commits locally) and git push.

$ git remote add upstream https://github.com/username/training.git

Now create a file called hello_world and commit it:

$ git add hello_world.txt

$ git commit -m 'describe the commit...' hello_world.txt

# Push your changes
Now, you could try pushing changes to the original repository using git push at this point, but it would probably fail because you probably don’t have permission to push changes directly to the repository. Besides, it really wouldn’t be a good idea. That’s because other people might be working on the project as well, and how in the world would we keep track of everyone’s changes? 

git push <remote> <branch>

$ git push upstream master

# Working in a branch
The purpose of a branch is to help facilitate multiple users making changes to a repository at the same time.

So, assuming that your goal is to issue a pull request to change your changes merged back into the original project, you’ll need to use a branch. Often you’ll see this referred to as a feature branch, because you’ll typically be implementing a new feature in the project.

The basic flow looks something like this (all this is happening on your local Git repository):

Create and checkout a feature branch.
Make changes to the files.
Commit your changes to the branch.
Because of the way that Git works, it’s incredibly fast and easy for developers to create multiple branches. 

To create a new branch and check it out (meaning tell Git you will be making changes to the branch), use this command:

git checkout -b <new branch name>

$ git checkout -b new-feature

As a general rule of thumb, you should limit a branch to one logical change. The definition of one logical change will vary from project to project and developer to developer, but the basic idea is that you should only make the necessary changes to implement one specific feature or enhancement.
As you make changes to the files in the branch, you’ll want to commit those changes, building your changeset with git add and committing the changes using git commit. 

Create another file and commit to this new branch :

$ git add  <filename>

$ git commit -m 'your commit message' <filename> 

# Pushing Changes to GitHub
So let’s say you’ve made the changes necessary to implement the specific feature or enhancement (the one “logical change”), and you’ve committed the changes to your local repository. The next step is to push those changes back up to GitHub.

If you were working in a branch called new-feature, then pushing the changes you made in that branch back to GitHub would look like this:

git push <remote> <branch>

$ git push origin new-feature

# Opening a Pull Request
GitHub makes this part incredibly easy. Once you push a new branch up to your repository, GitHub will prompt you to create a pull request (I’m assuming you’re using your browser and not the GitHub native apps). The maintainers of the original project can use this pull request to pull your changes across to their repository and, if they approve of the changes, merge them into the main repository.

Make someone on your team accept your pull request.

# Cleaning up After a Merged Pull Request
If the maintainers accept your changes and merge them into the main repository, then there is a little bit of clean-up for you to do. First, you should update your local clone by using:

$ git pull upstream master

This pulls the changes from the original repository’s (indicated by upstream) master branch (indicated by master in that command) to your local cloned repository. One of the commits in the commit history will be the commit that merged your feature branch, so after you git pull your local repository’s master branch will have your feature branch’s changes committed. This means you can delete the feature branch (because the changes are already in the master branch):

git branch -d <branch name>

$ git branch -d new-feature

Then you can update the master branch in your forked repository:
$ git push origin master
And push the deletion of the feature branch to your GitHub repository 

git push --delete origin <branch name>

$ git push --delete origin new-feature

And that’s it! You’ve just successfully created a feature branch, made some changes, committed those changes to your repository, pushed them to GitHub, opened a pull request, had your changes merged by the maintainers, and then cleaned up. 

# Keeping Your Fork in Sync
By the way, your forked repository doesn’t automatically stay in sync with the original repository; you need to take care of this yourself. 
By the way, your forked repository doesn’t automatically stay in sync with the original repository; you need to take care of this yourself. After all, in a healthy open source project, multiple contributors are forking the repository, cloning it, creating feature branches, committing changes, and submitting pull requests.

To keep your fork in sync with the original repository, use these commands:

$ git pull upstream master

$ git push origin master

This pulls the changes from the original repository (the one pointed to by the upstream Git remote) and pushes them to your forked repository (the one pointed to by the origin remote).
