# netpalm-public
Public example deployment of Netpalm

## Requirements:

* Packer and Terraform both expect an AWS CLI Profile named `netpalm-public`
* Packer and Terraform both expect the AWS Account to be `100784628684` in order to find the AMIs in subsequent steps.

### Versions: 

    PS C:\projects\netpalm-public\packer\ansible-base> packer version
    Packer v1.6.5
    PS C:\projects\netpalm-public\packer\ansible-base> tf13 version
    Terraform v0.13.5 

## Basic Structure


1. Packer & Ansible 
    1. Packer builds a base AMI that includes ansible.  Ansible is required for future steps and takes forever to install.
        * ```cd packer\ansible-base
             packer build template.json```

    2. Packer builds actual actual AMI that will be used to run Netpalm.  This includes ansible roles to install Docker, etc.
        * ``` cd packer\netpalm
              packer build template.json```
        * Any special user config has to happen here
        * Also this is where we mandate 
2. Terraform
    1. Terraform creates an instance based on the AMI from step 1.2, also creates and configures any necessary:
        * Security Groups
        * Subnets
        * VPCs
        * etc.


# TODO: 
 * Fix formatting on this, probaly
 * get tbot & wg keys added to 'accepted keys' for the default user
 * actually deploy netpalm 
 * *secure* the netpalm deployment
 * make netpalm reachable by editing security group