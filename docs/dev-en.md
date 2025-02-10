## **Join Us in Tool Development**
[English](dev-en.md) [中文](dev.md)
Welcome, everyone! We invite you to participate in tool development. As I'm just about to enter my third year of junior high school, I won't have much time to maintain this code.

### **Steps to Contribute:**
1. Fork the Repository:
Fork the repository to your personal account and then clone it to your local machine.  
Create a new branch for your work.
2. Set Up Your Tool Directory:
Inside the `tools` directory, create a new folder. This will be your main development directory for the tool.  
The name of this folder will determine the tool's ID within the framework. For example, if you name the folder `zhmzy`, then the tool's ID in the framework will be `zhmzy`.
3. Create Essential Files. Inside the newly created folder, create two files:
 - `main.sh` **(Required)**: This is the first script that runs when the tool is invoked via the command line.
 - `info.ini` **(Recommended)**: This file contains basic information about your tool. When a user enters `help` in the framework, this information will be displayed.
4. Current Folder Structure:
Your folder structure should look like this:
   ```bash
   tPaxs root directory
   └── tools
       └── <your_folder_name>
           ├── info.ini
           └── main.sh
   ```

5. Fill Out `info.ini`:
Write the basic information about your tool in the `info.ini` file. Here's a template you can use:  
**Note:** If you don't fill in a particular value, it will appear blank when users use the `show` or `ls/list` commands to query the tool information.
     ```conf
     [tpaxs]
     name=hello
     desc=This tool simply outputs "helloworld"
     ver=v11.45
     author=toad114514
     ```

6. Develop `main.sh`:
This is the main file for your tool. When the tool is launched using its ID, this file is executed first.  
 - At the very beginning of your script, you must declare the terminal to be used. It must be `bash`, like this:
   ```bash
   #!/data/data/com.termux/files/usr/bin/bash
   ```
 - You can call the predefined global scripts in `tPaxs` to utilize the variables and commands defined within them. To do this, add the following line at the beginning of your script:
   ```bash
   source $PREFIX/lib/tpaxs/global
   ```
   If you need to know what `global` defines, you can check the repository.

7. Commit and Push Your Changes:
After writing your script, commit your changes and push them to the new branch in your personal repository.  
Once your changes are pushed, submit a PR. Once the PR is approved, your tool will be available for others to use!