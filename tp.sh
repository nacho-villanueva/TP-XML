#!/bin/bash

#Path to the query file
QUERY="./SOquery.xq"

XSLT="./create_page.xsl"

#Ask for the user ID
echo "Input user ID:"

read userID

#Ask for the number of comments until is valid
#---------------------------------------------
echo "Input number of comments:"

read NComments

#Use regexp to make sure its an integer 
while ! [[ "$NComments" =~ ^[0-9]+$ ]] ; do
	echo "Please input a valid number of comments (an integer greater than or equal to 0):"

	read NComments
done
#---------------------------------------------

echo "Running Query..."
java net.sf.saxon.Query userID=$userID n=$NComments $QUERY -o:intermediate.xml
echo "Running Transformation..."
java net.sf.saxon.Transform -s:intermediate.xml -xsl:$XSLT -o:output.html
echo "HTML file successfuly created!"

