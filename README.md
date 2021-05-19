# Welcome to solution of DevOPS practical task №1

**Contents of the file:**

- Remarks to the points of original task.
	> Because of confidentiality principles the original task will not be added to repo. 

- Short workflow description.
- Folders content.


## Remarks to the points of original task.
**1a** - Installing Jenkins on VM with very short lifecycle is not suitable for making the job and my practice in Jenkins. So it was installed on local machine. As practice of using Ansible we install apache.

**3** - replacing the source files according to Maven's directory ideology was added.

**4** - Apache Maven was selected as a build tool.

**4a** - for my opinion this job must be done by Jenkins.

**6a** - The test reports are accessible in Jenkins dashboard and in VM web-startpage (because first I didn't find suitable and workable Jenkins plugin and made the report on web-page, after finding plugin it was very pity to delete the page:))


## Short workflow description.

Let's make 3 sections of workflow:
1. Execute codeplacing. sh - we'll receive JSudoku source code according to Maven's directory ideology and pom-file in https://github.com/Siarhei-Prakhin/Lab1.git (this is one-time job and it is already done).
2. Execute startscript. sh - as a result we'll receive VM with all SW we need. You can see different files (Vagrantfile, Playbook1.yml etc.) in the execution directory.
3. We have to run Jenkins job Lab1 (previously correct the path to SSH public-key to the startscript. sh execution directory) - as a result we receive builded jar-file, test results and so on in VM. The job is saved in examples/Lab1.xml.

**I will be happy to provide detailed demo of workflow in MS Teams.**

## Folders content.

There are 2 folders in the repo:
1. distr (2 files):

1.1  startscript. sh

1.2 codeplacing. sh

2. examples:
2.1 pom.xml

2.2 Vagrantfile

2.3 playbook1.yml

2.4 Lab1.xml

2.5 src/main/java/*.java

