# Exercise 5

Exercise 5 is about creating a ruby ​​script that creates a Gist using the GitHub API.

### Exercise 5.a

This part of exercise 5 receives the parameters that the user passes to create the gist. It receives name, description, filename and public (which indicates if the gist will be public or private). 

In case of a connection error, the user can try again without closing the script.

### Exercise 5.b

This part of the exercise is similar to the previous one but instead of accepting a file name, it can also accept a path passed by the user. If the user passes a path, the script will read all the files that are in that path and their subfolders and upload them to the gist.