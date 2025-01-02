# Interview Notes
## History (a little bit about myself)

#### Covid and collaboration
First cloud oriented stuff started in covid with needing to get MS Teams going. We were on exchange 2013 at the time and needed to upgrade to Exchange 2016 for modern auth and integrations for teams.

#### Exchange 2013 to 2016
Did a migration in under 2 months from exchange 2013 to 2016. I rearchitected it so that we had a better resilience and had some better load balancing with health checks and automated server maintenance.

#### Exchange Online and Onedrive Migrations
Led the exchange online migration, quarter backed the timing and communications as well as did the technical work for the migration. We used softlanding for setting up some of the unfamiliar things that we complex because of our shared tenant, like the routing and transport rules etc to get mailflow working.

Was the rep from core infra team on the onedrive migration. Created the scripts / automations so that the team wasn't needing to check in all weekend for progress.

#### Azure Migration
-- Now I've been the tech lead / architect on our azure adoption. The buildout started in Nov 2023. We were able to get up and running pretty quickly as I had taken an interest to some devops style methods previously and had done some learning on my own time using the enterprise skills initiative portal and buying some courses to do on my own time.


#### Challenges
-- I had to design a networking segmentation strategy given the confines of the /16 that we were given, and unfortunately to make it work i've had to go antipattern to how microsoft recommends networking in azure. (still a hub and spoke, just not using large vnets and segmented subnets with NSG/ASG. Security and network team insisted all traffic go through a central firewall)

``` 
It's recommended you have fewer large virtual networks rather than multiple small virtual networks to prevent management overhead.

Secure your virtual networks by assigning Network Security Groups (NSGs) to the subnets beneath them. 
For more information about network security concepts, see Azure network security overview.
``` 

#### What have I built:
##### Enterprise scale landing zone
Did the Enterprise Scale Landing zone. The big bicep/powershell/json monstrosity. -elaborate on the layout with the regular platform and app zones
- Hub and spoke with vwan. 
- using palo alto ngfw router in the vhub. 
- a network segment for our migration landing zone that mimics the vlan structure we have on prem in Kamloops Data Center

##### Operations
- Backups - Set up a simple set of Azure backup policies for our virtual machines. Hourly for a day. Daily for a month.
- Updates - Set up a set of maintenance configs that mirror the update deployment schedules on prem in MECM
- Monitoring - Set up some simple monitoring for vm insights on the virtual machines. Working towards setting up alerting for things like a CPU being pinned or memory being maxed out for prolonged period etc. 
- Policy - Set up some policy to ensure things are being built well, vm's should be a part of a backup rule and a maintenance config.

#####  Projects

##### Azure virtual desktop
Built out the production instance of Azure virtual desktop. Everything except for the images / application packages. Worked with Device Integration team to get their requirements and how we could align on a naming standard. 
- creating a github action for them so they can quickly deploy a new session host when needed.

##### F5 Load balancer
NH wanted to do a central load balancer for the time being so that rules could easily be copied from our KDC F5 to Azure to ensure a smoother transition. Built out a prod and nonprod instance for them.
- uses azure load balancer in front of a couple vm scale sets for the backend
- has public IP's for externally available sites though i want to set up an azure front door in front of our palo alto for public access so we can have web app firewall and ddos protection
- i think this is terraform because they have a provider for it so it made deployment quite a bit easier

##### DNS - Public and Private
- set up the private dns using azure dns private resolver, inbound/outbound endpoint etc to blend in with our DNS. NHA.LOCAL and Northernhealth.ca.
- Core owns NHA.LOCAL - servers here
- Network team owns Northernhealth.ca - sites and public. 
- i set up dns in azure for NH's public DNS

##### Subscription Repo (Monolithic)
- created workflow to bootstrap a subscription to be ready to hand off to a team
- includes the PHSA required tags, basic roles, role assignments
- CI/CD to target the subscription/resource group/workload that has the changes so that it's not running it on the whole subscription like the MS provided landing zone codebase. 

##### Subscription vending
phsa hasn't had time to work on it but we need more subscriptions in a self serve way. 
1. basic flow will be 
2. form fill and submit (which health authoprity, cost center, environment)
3. API POST Request to Azure Function
4. Function ingests JSON payload from form. Requests JWT from github with OIDC provider
5. Triggers Github Action to deploy subscription using the JWT in the auth header


##### Configuration Management
- ansible. open source not the enterprise version.
- single control VM on ubuntu with WINRM connection to deploy software to windows and ssh for linux
- not production (and may not be, but put together POC to use this in place of the MECM software deployments)  

#### Personal
##### Website / Resume
- resume on website.
- registered my own domain
- created my own azure tenant
- created a static webpage with HTML and CSS for the front end. 

- azure function - HTTPTrigger (so when someone views), it reaches out to the Cosmos DB, gets the value in the table for a visitor counter, increments it by one, sends the new info to the database and returns the value to the website for a visitor counter

- front end and back end have separate CI/CD workflows.
- infrastructure is done with IaC
-- created cosmos DB account, database and container
-app service plan