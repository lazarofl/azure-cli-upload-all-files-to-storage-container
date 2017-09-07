printf '
                                    
.d88888b    dP                                                
88.    "`   88                                                
`Y88888b. d8888P .d8888b. 88d888b. .d8888b. .d8888b. .d8888b. 
      `8b   88   88`  `88 88`  `88 88`  `88 88`  `88 88ooood8 
d8`   .8P   88   88.  .88 88       88.  .88 88.  .88 88.  ... 
 Y88888P    dP   `88888P` dP       `88888P8 `8888P88 `88888P` 
ooooooooooooooooooooooooooooooooooooooooooooo~~~~.88~ooooooooo
                                             d8888P           
d888888P                   dP 
   88                      88 
   88    .d8888b. .d8888b. 88 
   88    88`  `88 88`  `88 88 
   88    88.  .88 88.  .88 88 
   dP    `88888P` `88888P` dP 
oooooooooooooooooooooooooooooo

'

printf 'AZURE_STORAGE_ACCOUNT: (default:storaaccount1)\n'
read AZURE_STORAGE_ACCOUNT
if [ -z "$AZURE_STORAGE_ACCOUNT" ]; then
    AZURE_STORAGE_ACCOUNT=storaaccount1
    printf "AZURE_STORAGE_ACCOUNT: $AZURE_STORAGE_ACCOUNT \n"
fi

export AZURE_STORAGE_ACCOUNT

printf 'AZURE_STORAGE_KEY: *\n'
read AZURE_STORAGE_KEY
if [ -z "$AZURE_STORAGE_KEY" ]; then
    printf 'AZURE_STORAGE_KEY argument is missing\nexiting...\n'
    exit 1
fi

export AZURE_STORAGE_KEY

printf 'Container: (default:container1)\n'
read CONTAINER_NAME
if [ -z "$CONTAINER_NAME" ]; then
    CONTAINER_NAME="container1"
    printf "CONTAINER_NAME: $CONTAINER_NAME \n"
fi

printf 'Files path: *\n'
read FILES_PATH

az storage blob upload-batch -d $CONTAINER_NAME -s $FILES_PATH

if [ $? -eq 0 ]; then
    printf "\n\nAll files uploaded to '$CONTAINER_NAME' container!\n"
else
    echo FAIL
fi
