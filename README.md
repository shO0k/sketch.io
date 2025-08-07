# sketch.io README
Scenario: A user is looking for a specific file on their hard drive (or image on the web), but can only remember a hint of an image within the file (symbol, logo, seal of approval, award ribbon, etc). 
This model will take a (often low-fidelity) user-generated sketch and match it with imagisitc components of files on their hard drive (or images on the web). The output will be a list of the highest probability matches, helping to narrow the search space.

Progress logs:
08-06-2024: rapid prototype (sketch to rank-ordered list output) complete.

Future directions:
1) add "undo" button.
2) fix alignment of cursor and sketch line.
3) functionality to click on result and open file.
4) ability to input a .png/.jpg/.jpeg file into search bar, in addition to user-generated sketch (drag and drop feature).
5) make UI more aestheitcally pleasing.
6) bundle app securely


Components:
1) sketch-to-pdf software interface
2) file crawler: iterates through local file/directory hierarchy to scan the contents of each file
3) feature comparison model: compares the extracted imagistic features between two files (CLIP, openCV for now)

Model outline:
Converts user inputted sketch to a .pdf/.png.jpeg file > extracts features from file > iterate through file hierarcy and extract features from each file > compare features and output a list of local files rank-ordered by probability of match.

Thoughts for model outline:
- hash function to store a pair: (file_path, feature_profile) for ease of comparison for future lookups
- for output, return a pair: (file_path, probaility_score)
- make concrete the notion of a "feature profile"

Questions about security/privacy: Program needs to access user files. Must impliment features to ensure the security of such files, and give user complete control to which files the program may access (perhaps allow user to mark which specific directories the program may access). Create a local file quiery (local data base) system for hashing, do not store sensitive information in a data base with files from other users. Program needs to be completely self-contained on the user's local system.
