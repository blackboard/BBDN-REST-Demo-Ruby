# BBDN-REST-Demo-Ruby
This project contains sample code for interacting with the Blackboard Learn REST Web Services in Ruby. This sample was built with Ruby 2.0.0p645. It uses the rest-client gem for HTTP processing.

###Project at a glance:
- Target: Blackboard Learn SaaS 2015.12.0 and above
- Source Release: v1.0
- Release Date  2016-03-15
- Author: shurrey
- Tested on Blackboard Learn SaaS Release 2015.12.0-ci.16+149e9d4

###Requirements:
- Ruby - This sample was built with Ruby 2.0.0p645
- Requires the following libraries:
-- rest-client, installed with <i>sudo gem install rest-client</i>

### Configuring the Code Sample
The connection information is located at the top of the restdemo ruby file. You must change three values:
- $HOSTNAME: must be set equal to your test environment's URL with https.
- $KEY: replace <insert your key> with your key.
- $SECRET: replace <insert your secret> with your secret.

### Using the Code Sample
This is a console app. You can run from the command prompt. The sample code allows you to perform the full Create, Read, Update, and Delete options on the following five objects:
- Datasource
- Term
- Course
- User
- Membership

To run the code, ensure you have followed the steps to configure the sample code, then simply navigate to the directory you cloned the project to and run <i>ruby restdemo.rb</i>. The code will run and print out all of the resulting objects from each call. It will

1. Create the Datasource
2. Create, Read, and Update the Term
3. Create, Read, and Update the Course
4. Create, Read, and Update the User
5. Create, Read, and Update the Membership
6. Read the Datasource
7. Read the Term
8. Read the Course
8. Read the User
10. Read the Membership
11. Update the Datasource
12. Update the Term
13. Update the Course
14. Update the User
15. Update the Membership
16. Delete the Membership
17. Delete the User
18. Delete the Course
19. Delete the Term
20. Delete the Datasource

	
### Conclusion
This code will give you the base knowledge you need to interact with the Blackboard Learn REST services using Ruby. For a thorough walkthrough of this code, visit the corresponding Community page <a href="https://community.blackboard.com/community/developers/rest" target="_blank">here</a>.