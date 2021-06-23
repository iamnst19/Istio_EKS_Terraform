# Install Terraform 

Download terraform depending on your system. Installation is very simple. Download the terraform zip archive and unzip it in a suitable location. Once we have unzipped the terraform, update PATH environment variable pointing to terraform. Since the folder /usr/local/bin is already set to PATH environment variable, we don't need to set it again. If you are using any other location, then specify it in the PATH environment variable either in .bash_profile or in /etc/profile.

```
# cd /usr/local/src
# wget https://releases.hashicorp.com/terraform/0.12.22/terraform_0.12.22_linux_386.zip
# unzipterraform_0.12.22_linux_386.zip
# echo $PATH
# mv terraform /usr/local/bin/ (add the binary to a path that is executable )

```
# Terraform Setup Inside Jenkins as Tool
## Install Terraform plugin

Go to Manage Jenkins > Manage Plugins >Available > search Terraform.

[Terraform Plugin](https://miro.medium.com/max/700/1*2xtQ7PH-p5qtoeviEg4IQw.png)

If you are already installed Terraform Plugin on your Jenkins It will display in the Installed section.
Now we can see the Terraform option in the Build Environment section but we need to configure Terraform for Jenkins.

## Configure Terraform
Go to Manage Jenkins > Global Tool Configuration > It will display Terraform on the list.

[Terraform plugin setup](https://miro.medium.com/max/700/1*qQ-_mzkBOtR8qa_am13A3Q.png)