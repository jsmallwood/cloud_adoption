# Azure Resource Graph quickstart queries

This repo contains all currently available Azure Resource Graph queries contributed by ShareGate and the community.

## About source code in this repository
* Query code goes under the the right `queries` folder.
* Create a folder for the service it concerns (i.g.: storageAccounts, cdn, virtualNetworks).
* Create a folder for your query (all lower case with dases instead of spaces).
* The query goes in a `query.txt` file.
* Create a README.md file to provide a title/description of what the query does.
* (On Windows) Run `Test-ResourceGraphQueries.ps1` to test the queries before creating a PR.
* You can place your query code in this repository by creating a PR.

## Requirements for CI of queries
* PowerShell v5+
* Azure CLI
* Azure CLI Resource Graph extension (`resource-graph`)

## Setup for CI
* [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
* Install Azure Resource Graph extension (`az extension add --name resource-graph`)
* az login

## Execute CI tests
In a PowerShell session, run `.\Test-ResourceGraphQueries.ps1` for all queries

or `.\Test-ResourceGraphQueries.ps1 -FolderToTest 'queries\generic\count-azure-resources'` for one in particular

## License

Copyright © 2019, Groupe Sharegate inc. This code is licensed under the Apache License, Version 2.0. You may obtain a copy of this license at https://github.com/gsoft-inc/gsoft-license/blob/master/LICENSE.



# Azure Resource Graph Collection

## Description
This repository contains my Collection of Azure Resource Graph related resources such as sample scripts and Resource Graph Queries.

## How-To
The following pages demonstrate how to invoke Azure Resource graph queries via different methods.
#### Command-line Interfaces (CLI)
The following code samples demonstrates how to invoke Azure Resource Graph queries using using CLI:
* [PowerShell](How-To/PowerShell.md)
* [Azure CLI](How-To/AzureCLI.md)

#### Azure Resource Manager (ARM) REST API
The following page demonstrate how to invoke Azure Resource Graph queries using Azure Resource Manager (ARM) REST API:
* [ARM REST API](How-To/ARM-REST-API.md)

#### Azure Resource Graph Explorer
The following page demonstrate how to use the Azure Resource Graph Explorer within the Azure portal:
* [Azure Resource Graph Explorer](How-To/Resource-Graph-Explorer.md)

#### Sample Scripts
Collection of PowerShell scripts around Azure Resource Graph:
* [PowerShell Script](How-To/PS-Scripts.md)

#### Postman
The following page demonstrate how to invoke the Resource Graph REST API via Postman
* [Postman](How-To/Postman.md)

## Sample Queries
The sample queries are grouped into the following categories:
* [General](Queries/General.md)
* [Compute](Queries/Compute.md)
* [Monitoring](Queries/Monitoring.md)
* [Storage](Queries/Storage.md)



## References
#### Inside Azure Management book
![Inside Azure Management Book](images/inside-azure-mgmt-cover.jpg)

Azure Resource Graph is explained in details in chapter 2 of the Inside Azure Management book. This book can be downloaded at:
* [Download Inside Azure Management book](https://bit.ly/InsideAzureMgmt)

#### Microsoft documentation site
Official documentation can be found at: [https://docs.microsoft.com/en-us/azure/governance/resource-graph/](https://docs.microsoft.com/en-us/azure/governance/resource-graph/)