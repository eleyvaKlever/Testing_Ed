/***********************************************************************************
FILE NAME  		resetprg.c
DESCRIPTION  	Reset Initialisation.
		The user application will start in this file.

Copyright   : 2006 Renesas Technology Europe Ltd.
Copyright   : 2006 Renesas Technology Corporation.
All Rights Reserved
***********************************************************************************/

/***********************************************************************************
Revision History
DD.MM.YYYY OSO-UID Description
07.04.2006 RTE-VNA First Release
***********************************************************************************/

/***********************************************************************************
User Includes
***********************************************************************************/
/*	Following header file provides a structure to access on-chip I/O registers. */
#include "sfr_r81b.h"
/*	Following header file provides common defines for widely used items.	*/
#include "main.h"
/*	Following header file provides prototypes for hardware initialisation function.*/

/***********************************************************************************
User Program Code
***********************************************************************************/

/**********************************************************************************
Function Name :	Initialise
Description	  :	Reset initialisation function.
				Initialise the RSK and call main application.
Parameters	  :	none
Return value  :	none
***********************************************************************************/
void Initialise(void)
{ 
	/*	main function including users code.	*/
	main();

	/*	This function must never exit.	*/
	while (1);
}
/**********************************************************************************
End of function Initialise
***********************************************************************************/   
