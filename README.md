# Gist Creator
## Description
This repository is about creating a ruby script that creates a Gist using the GitHub API.

  ### Gist_by_file
  This part of script receives the parameters that the user passes to create the gist. It receives name, description, filename and public (which indicates if the     gist will be public or private). In case of a connection error, the user can try again without closing the script.

  ### Gist_by_path
  This part of the script is similar to the previous one but instead of accepting a file name, it can also accept a path passed by the user. If the user passes a     path, the script will read all the files that are in that path and their subfolders and upload them to the gist.

## Clone repository
First clone the repository:

```bash
git clone git@github.com:Joelit0/Gist.git && cd Gist
```

## Run Scripts
  ### Gist_by_file
  To execute 'Gist_by_file' we have to move to the folder:

  ```bash
  cd Gist_by_file
  ```
  
  And then run the Main.rb file with ruby:
  
  ```ruby
  ruby Main.rb
  ```
  ### Gist_by_path
  To execute 'Gist_by_path' we have to move to the folder:

    ```bash
    cd Gist_by_path
    ```

    And then run the Main.rb file with ruby:

    ```ruby
    ruby Main.rb
    ```
