# sketch.io README
Scenario: A user is looking for a specific file on their hard drive (or image on the web), but can only remember a hint of an image within the file (symbol, logo, seal of approval, award ribbon, etc). 
This model will take a (often low-fidelity) user-generated sketch and match it with imagisitc components of files on their hard drive (or images on the web). The output will be a list of the highest probability matches, helping to narrow the search space.

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
