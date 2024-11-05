"""Abaqus Python scripting interface code for importing an input file as the main model.

Part of the abaqus_shell_utils package.
Github Repo: https://github.com/mkhoshbin1/abaqus_shell_utils
Website:     https://www.mkhoshbin.com
License:     The MIT License
Copyright 2022 Mohammadreza Khoshbin.
"""

import sys
import os

# Process the path.
inp_file_path = sys.argv[-1]
print "Attempting to import input file from '%s'." % inp_file_path
inp_file_name = os.path.split(inp_file_path)[1]

# Import the model from input file.
model = mdb.ModelFromInputFile(name=os.path.splitext(inp_file_name)[0],
                               inputFileName=inp_file_path)

# Delete the default model.
for model_name in mdb.models.keys():
    if model_name != model.name:
        del mdb.models[model_name]

# Set the color mapping to 'Set'.
viewport = session.viewports.values()[0]
viewport.setValues(displayedObject=model.parts.values()[0])
viewport.enableMultipleColors()
viewport.setColor(initialColor='#BDBDBD')
viewport.setColor(colorMapping=viewport.colorMappings['Set'])
viewport.disableMultipleColors()

print "Imported model '%s' from input file at '%s'." % (inp_file_name, inp_file_path)
