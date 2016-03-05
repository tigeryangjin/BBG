==============================
Interim Patch for Bug:17606196
==============================

Date: Oct 25, 2013
----------------------------------
Platform Patch for : Generic
Product Patched    : OBIEE
Product Version    : 11.1.1.7.0 + mandatory patch-16842070
-auto enabled      : Yes


Bugs Fixed by this patch:
-------------------------
16068402:GRAPHS NOT SHOWN ON IE WHEN OBIEE IS BEHIND A REVERSE PROXY
16667503:QA: PROMPTS: RESET TO LAST APPLIED VALUE IS NOT WORKING
16371801:QA: IE10: GAUGES VIEW OVERLAPPED WITH OTHER VIEWS
16455904:QA: IE10: SLIDER PROMPTS CANT SLIDE TO LOWEST LIMIT
16382296:QA: IE10: MAP VIEW SHOWS SERIES OF ERRORS
16402964:QA:IE10: NEW CONDITION THROWN ERROR"OBJECT DOESN'T SUPPORT PROPERTY OR METHOD '
16391455:QA:NEW AGENT PAGE IS NOT DISPLAYED IN IE10
16390205:QA: IE10: RESIZE COLUMN SELECTS ALL TEXT IN TABLE/PIVOT VIEW
16389347:QA:UNABLE TO OPEN OR CREATE A KPI WATCHLIST USING IE10 BROWSER
16389210:QA: CAN NOT CREATE OR OPEN A SCORECARD WITH IE10 BROWSER
16382198:QA: IE10: ANALYSIS PROMPT FOR HIERARCHY: VALUE TEXTBOX NOT FULL SIZE BUT WORK OK
16371672:QA: IE10: FREEZE HEADER: LONG SCROLL SHOWS TRIMBUFFER ERROR
16371553:QA: IE10: SIGN IN PANEL IS NOT AT CENTER POSITION
15935506:IE10 NOT ABLE TO CREATE OR EDIT AN ANALYSIS IN ANSWERS

Prerequisites:
--------------

1. Before applying non-mandatory patches, check whether you have the exact symptoms
described in the bug.

2. Review and download the latest version of OPatch 11.1.x via Bug 6880880.
(OPatch version 11.1.0.8.3 or higher)
Oracle recommends that all customers be on the latest version of OPatch.

  Please review the following My Oracle Support note and follow the instructions
  to update to the latest version if needed:

  Note 224346.1 - Opatch - Where Can I Find the Latest Version of Opatch?
  For FMW Opatch usage, please refer the doc at :
  http://www.oracle.com/technology/software/products/ias/files/fmw_opatch.htm

  Additional Step Needed for AUTO option:

  2.1) Starting with OPatch 11.1.0.8.2+ the -auto flag asks for the Node Manager
  username and password. To validate it, please check:
  Note 1146793.1 - How to check/verify/modify Node Manager username & password?

3. Verify the OUI Inventory.
OPatch needs access to a valid OUI inventory to apply patches.
Validate the OUI inventory with the following command:
- opatch lsinventory -jre $ORACLE_HOME/jdk/jre
If the command errors out, contact Oracle Support and work to validate
and verify the inventory setup before proceeding.

4. Confirm executables appear in your system PATH.
The patching process will use the unzip and the opatch executables. After
setting the ORACLE_HOME environment, confirm both of these exist before
continuing:
- "which opatch"
- "which unzip"
If either of these executables do not show in the PATH, correct the problem
before proceeding.

5. Create a location for storing the unzipped patch. This location
will be referred to later in the document as PATCH_TOP.

Follow Steps 6 and 7 only if you choose to use the AUTO flag:

6. Node Manager Configuration:
With the AUTO flag, the OPatch utility uses WLST with the Node Manager to
start/shutdown the required WLS server(s) - Admin server and/or Managed Server(s).

To properly configure the Node Manager follow below instructions:

  i) Create or validate the nodemanager.properties file, which by default is located at:
  [MW_HOME]/[WLS_HOME]/common/nodemanager (on UNIX operating systems) or
  [MW_HOME]\[WLS_HOME]\common\nodemanager (on Windows operating systems) directory.

  Example:
  /opt/product/fmw11g/wlserver_10.3/common/nodemanager/nodemanager.properties

  ii) Add or validate the following lines onto the nodemanager.properties file:

  StartScriptEnabled =true
  StopScriptEnabled =true

  iii) Ensure NodeManager is running by using:
  [MW_HOME]/[WLS_HOME]/server/bin/startNodeManager.sh (UNIX)
  [MW_HOME]\[WLS_HOME]\server\bin\startNodeManager.cmd (Windows)

7. Setting the Machine Name and Listen Address:

  Machine Name and Listen Address can be blank on a default installation. So for the AUTO option:
  The Machine Name for each WebLogic Server (including the Administration Server) must be
  set to a valid value. It cannot be set to blank or None.
  The Listen Address of the Administration and Managed Servers must be set to the real physical
  host's address (hostname, FQDN, or IP address). It cannot be set to blank or localhost.

  (a) Configure the Managed Server(s):

  Within the WLS Admin Console, proceed as below:
  1. In the Domain Structure navigate to:
  -> [DOMAIN_NAME] > Environments > Machines
  2. Click the 'Lock & Edit' button on the left hand side (if WLS in Production mode)
  3. Create a new machine, by clicking the 'NEW' button - give it a name
  and choose Unix, for example, if you are in an unix env. (at 'Machine OS').
  4. Select the Machine you've just created and go to the:
  Configuration > Node Manager and change the 'Listen Address' to [HOST_NAME]
  (eg, the host which the Node Manager is listening) and then click the 'Save' button.
  5. In the Domain Structure navigate to:
  -> [DOMAIN_NAME] > Environments > Servers
  6. Click on each Managed Server (bi_server1 in OBIEE),
  assign the Machine you've created in step 3. Additionaly type in within the 'Listen Address'
  the name of the host where the NodeManager is running. Click the 'Save' button.
  7. Click the 'Activate Changes' button on the left hand side (if WLS in Production mode)

  NOTE: If the WLS is in Development mode steps 2 & 7 will not be needed.

  (b) Configure the Admin Server:

  Within the WLS Admin Console, proceed as below:

  1. Stop the Admin Server (and all the Managed Servers).

  Only if WLS in Production mode:

  2.Take a backup of the existing config.xml file of the WLS domain.
  The default one is at:
  [MW_HOME]/user_projects/domains/[DOMAIN_NAME]/config/config.xml
  Modify the config.xml to:
  Search for "<name>AdminServer</name>" entry and add the below entries under it:
  ------------------------------------------------
  <machine>[HOST_NAME]</machine>
  <listen-address>[HOST_NAME]</listen-address>
  ------------------------------------------------
  Save the file.

  Only if WLS in Development mode:

  2. Assign the Machine you've created previously and click the 'Save' button.
  Additionaly type in within the 'Listen Address' the name of the host where
  the NodeManager is running.
  (c) Change the Hostname Verification for the Admin Server:

  Additionally, WLS Admin Console, proceed as below:

  1. Click the 'Lock & Edit' button on the left hand side (if in Production mode).
  2. In the Domain Structure navigate to:
  -> [DOMAIN_NAME] > Environments > Servers
  3. Click on the AdminServer and then within the Configuration tab and over the SSL subtab.
  4. Click within the Advanced link and then change the 'Hostname Verification' from
  'BEA Hostname Verifier' to 'None'.
  5. Click the 'Save' button.
  6. Click the 'Activate Changes' button on the left hand side (if WLS in Production mode)
  7. Restart the Admin Server.

  NOTE:
  =====
  1. If the WLS is in Development mode steps 1 & 6 will not be needed.
  2. If the WLS won't start, please revert back the config.xml and contact the Oracle Support.


Pre Install Instructions:
-------------------------

NOTE: Please ensure you have applied patch for bug: 16842070 before you proceed.

- Set the ORACLE_HOME environment variable,
for example "[MW_HOME]/Oracle_BI1" directory.

Patch Apply Modes:
------------------

With AUTO flag : The Admin Server and NodeManager have to be running for 'opatch -auto' operations.
The Managed Servers may or may not be in a running state.
OPatch will bounce all the local servers (and the servers sharing the Middleware Home)
affected by the patch. If the patch affects an application deployed on the Admin server,
the Admin server will also be bounced. If the Managed Servers are not running, OPatch
won't restart the affected servers.
It is users' responsibility to start those servers in order to uptake the patch.

Without AUTO flag : No servers need to be started.
At the end of the patch apply all servers must (re-)started to uptake the patch.


Install Instructions:
---------------------

1. Unzip the patch zip file into the PATCH_TOP.

       unzip -d PATCH_TOP p17606196_111171_Generic.zip

2. Set your current directory to the directory where the patch is located.

       cd PATCH_TOP/17606196

3. Run OPatch to apply the patch.

  NOTE: Though this patch is AUTO flag enabled, the user still has the choice to apply it without the AUTO option.
  However doing so involves manual restarting of the affected servers.

  (a) If applying without AUTO:

      Run following command:
      - opatch apply -jre $ORACLE_HOME/jdk/jre

  (b) If applying with AUTO:

      Run following command:
      - opatch apply -auto -jre $ORACLE_HOME/jdk/jre

  NOTE:
  -----
  i. The user would be prompted for the following inputs by OPatch
  to complete the auto patch application process.

  AdminUser : Please enter the WebLogic Admin Server username
  AdminPassword : Please enter the WebLogic Admin Server password
  AdminServerURL : Please enter the WebLogic Admin Server URL
  DomainHome : Please enter the WebLogic domain directory location
  ApplicationsDir : Please enter the WebLogic applications directory location
  default location is : [MW_HOME]/user_projects/applications/[DOMAIN_NAME]
  NodeManagerUser : Please enter the NodeManager username
  NodeManagerPassword : Please enter the NodeManager password
  Please ensure input values are exact & correct to avoid undesired patch failures.

  ii. At the end of "opatch apply -auto" command, if you see the WARNING message below,

  The following warnings have occurred during OPatch execution:

  1) OUI-67851: All the applications affected by this patch are deployed in 'No Stage' mode.
  Redeploy operation will not be performed for the affected applications.
  Please refer to the log file for more details.

  It may be just cause the OPatch expects secure connections.
  Please kindly review the log file to be sure.

When OPatch starts, it will validate the patch and make sure there
are no conflicts with the software already installed in the ORACLE_HOME.

OPatch categorizes two types of conflicts:
(a) Conflicts with a patch already applied to the ORACLE_HOME
In this case, please stop the patch installation and contact
Oracle Support Services.
(b) Conflicts with subset patch already applied to the ORACLE_HOME

In this case, please continue the install, as the new patch
contains all the fixes from the existing patch in the ORACLE_HOME.
The subset patch will automatically be rolled back prior to the
installation of the new patch.

4. If any of the J2EE server files (*.ear, *.jar, *.war etc) were updated during
the previous step, you would need to deploy these files into your web server,
by consulting your specific Web Server documentation.

NOTE: when the OPatch was applied with -auto option, step 4 is not needed.


Post Install Instructions:
--------------------------

1. In case, you have opted to apply without AUTO:

- Restart all servers (AdminServer and all Managed server(s))

2. In case, you have opted to apply with AUTO:

- No Action Needed.


Deinstallation Instructions:
----------------------------

If you experience any problems after installing this patch, remove the patch as follows:

1. Make sure to follow the same Prerequisites or pre-install steps (if any) when deinstalling a patch.
This includes setting up any environment variables like ORACLE_HOME and verifying the OUI inventory
before deinstalling.

2. Change to the directory where the patch was unzipped.
       cd PATCH_TOP/17606196

3. Run OPatch to deinstall the patch.

  (a) If rolling back without AUTO :

  Run following command:
  - opatch rollback -id 17606196 -jre $ORACLE_HOME/jdk/jre

  (b) If rolling back with AUTO :

  Run following command:
  - opatch rollback -id 17606196 -jre $ORACLE_HOME/jdk/jre -auto


Post Deinstallation Instructions:
---------------------------------
1. In case, you have opted to apply without AUTO:

- Restart all servers (AdminServer and all Managed server(s))

2. In case, you have opted to apply with AUTO:

- No Action Needed.


DISCLAIMER:
===========
This one-off patch has undergone only basic unit testing. It has not been through the complete
test cycle that is generally followed for a production patch set. Though the fix in this one-off
patch rectifies the bug, Oracle Corporation will not be responsible for other issues that may arise
due to this fix. Oracle Corporation recommends that you upgrade to the next production patch set,
when it is available. Applying this one-off patch could overwrite other one-off patches applied
since the last patch set. Customers need to request Oracle Support for a patch that includes those
fixes as well as inform Oracle Support about all the PSE installed when an SR is opened.
Please download, test, and provide feedback as soon as possible to assist in the timely resolution
of this problem.

