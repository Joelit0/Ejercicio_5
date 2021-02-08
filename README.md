# Gist Creator
## Description
This repository is about creating a ruby script that creates a Gist using the GitHub API.

  #### Gist_by_file
  This part of script receives the parameters that the user passes to create the gist. It receives name, description, filename and public (which indicates if the     gist will be public or private). In case of a connection error, the user can try again without closing the script.

  #### Gist_by_path
  This part of the script is similar to the previous one but instead of accepting a file name, it can also accept a path passed by the user. If the user passes a     path, the script will read all the files that are in that path and their subfolders and upload them to the gist.

## Clone repository
First clone the repository:

```bash
git clone git@github.com:Joelit0/Gist.git && cd Gist
```
## Install all gems
We must install all the gems:
```ruby
bundle install
```

## Configure Authentication
To create a gist through this script, we need a token with access to create Gists. To do this, we will follow the steps provided by Github [here](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token).

**Very important**, when we create the Token we must mark the 'Gist' field in its permissions.

Then we must create the .env file to be able to authenticate in the script. Since we have 2 directories, we must create one for each one:

```bash
cd Gist_by_file
```

```bash
echo "YOUR_USERNAME=[Here put your name]
YOUR_TOKEN=[Here put your token]" > .env
```

We do the same with the other directory:

```bash
cd Gist_by_path
```

```bash
echo "YOUR_USERNAME=[Here put your name]
YOUR_TOKEN=[Here put your token]" > .env
```

## Run Scripts
  #### Gist_by_file
  To execute 'Gist_by_file' we have to move to the folder:

  ```bash
  cd Gist_by_file
  ```
  
  And then run the Main.rb file with ruby:
  
  ```ruby
  ruby Main.rb
  ```
  #### Gist_by_path
  To execute 'Gist_by_path' we have to move to the folder:

  ```bash
  cd Gist_by_path
  ```

  And then run the Main.rb file with ruby:

  ```ruby
  ruby Main.rb
  ```
