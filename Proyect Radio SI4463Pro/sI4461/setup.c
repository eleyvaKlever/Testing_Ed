#include <stdio.h>
#include <string.h>

int main(int argc, char** argv)
{
   FILE* f;
   if (!(f = fopen(argv[1], "r")))		// open file given in comm. line
   {
     printf("Cannot open file\n");
     return(1);
   }   

   char line[200];			// storage for file line
   char linecp[200];			// copy for read line
   while (fgets(line, 200, f))		// skip file header
     if (!strcmp(line, "// CONFIGURATION COMMANDS\n"))
       break;

   int linesCnt = 0;			// config. lines counter
   while(fgets(line, 200, f))
   {	
     if (!strcmp(line, "// AUTOMATICALLY GENERATED CODE! \n"))
       break;
     strcpy(linecp, line);              // copy that line
     char* token = strtok(line, " ");	// get 1st line token
     if (strcmp(token, "#define"))	// leave line starting w. #define
       continue; 

     linesCnt++;
     token = strtok(NULL, " ");		// get 2nd line token
     int tokenCnt = 0;			// tokens count
     while(token = strtok(NULL, " "))	// loop over all tokens
       tokenCnt++;			// and count # of tokens

     printf("\tDCB\t0x%02X,", tokenCnt);// print token count
     token = strtok(linecp, " ");    	// now tokenize the line again
     token = strtok(NULL, " ");
     while(token = strtok(NULL, " "))
       printf(" %s", token);
   }
   printf("\tDCB\t0x%02X\t; config data size\n", linesCnt);  
   fclose(f);				// close input file
}

