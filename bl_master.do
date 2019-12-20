	/*****************************************************************
	PROJECT: 		TUP_AFG, Targeting Ultra Poor in Afghanistan
					
	TITLE:			bl_master.do
				
	AUTHOR: 		Seungmin Lee (slee31@worldbank.org, eatorange@gmail.com)

	DATE CREATED:	Aug 24, 2016

	LAST EDITED:	Sep 1, 2016, by Seungmin Lee (slee31@worldbank.org)

	DESCRIPTION: 	Prepares common environment and runs all necessary do-files to generate desired outputs from baseline survey.
		
	ORGANIZATION:	1 - Macro setup
						1.1 - User-directory setup	
						1.2 - Working-directory setup
						1.3 - Secondary do-file setup
					2 - Environment setup
					3 - Running secondary do-files
						3.1 - Cleaning
						3.2 - Construction
						3.3 - Analysis
						3.4 - Others
					
	INPUTS: 		Refer to each secondary do-files

	OUTPUTS: 		Refer to each secondary do-files

	NOTE:			This do-file is designed to generate all desired outputs.
	******************************************************************/

	/****************************************************************
		SECTION 1: Macro setup				 									
	****************************************************************/

	/* SECTION 1.1: User-directory setup */		 			 									

	* Add username of each collaborator and directory

	if "`c(username)'" == "WB505457"{		// Seungmin Lee, WB PC
		global TUP_AFG "C:/Users/WB505457/Dropbox/TUP_Afghanistan_April2016/New Structure (Test)"
	}
	*
	if "`c(username)'" == "..."{
		global TUP_AFG "..."
	}
	*

	* Error message if username is NOT specified

	loc error_TUP_AFG "set a global -TUP_AFG- as the filepath to your folder where 'TUP_Afghanistan_April2016' folder is located."

	if "${TUP_AFG}" == "" { 
		di as error "`error_TUP_AFG'"
		exit
	}
	*


	/* SECTION 1.2: Working-directory setup */
	
	* Declar working directories
	include	"${TUP_AFG}/Data and Analysis/Master Files/TUP_globals.do"
				
	cd "${bl}"

	/* SECTION 1.3: Secondary do-file setup */	

	* Determine which do-files to be executed
	global	cleaningrun		0
	global	constructionrun	0
	global	analysisrun		0
	global	othersrun		0
	
	/****************************************************************
		SECTION 2: Environment setup			 									
	****************************************************************/

	* Clear all stored values in memory from previous projects
	clear			all

	* Set version number
	version			14

	* Set basic memory limits
	set maxvar 		32767
	set matsize		11000

	* Set default options
	set more		off
	pause			on
	set varabbrev	off


	/****************************************************************
		SECTION 3: Running secondary do-files	 									
	****************************************************************/

	* Data cleaning
	if (${cleaningrun}==1) {
		do	"${bl_dofiles}/bl_cleaning_master.do"			// Data cleaning
	}
	*

	* Data construction
	if (${constructionrun}==1) {
		do	"${bl_dofiles}/bl_construction_master.do"		// Data construction
	}
	*
	
	* Data analysis
	if (${analysisrun}==1) {
		do	"${bl_dofiles}/bl_analysis_master.do"			// Data Analysis
	}
	*
	
	* Other do-files
	if (${othersrun}==1) {
		do	"${bl_dofiles}/bl_others_master.do"				// Other do-files
	}
