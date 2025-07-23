import sys
import json
import file_crawler as fc

if __name__ == "__main__":
        if len(sys.argv) < 3:
                print("Usage: python run_search.py <sketch_path> <start_path>")
                sys.exit(1)

        sketch_path = sys.argv[1]
        start_path = sys.argv[2]

        results = fc.file_iterator(sketch_path, start_path)

        for filename, score in results:
                print(f"{filename}: {score:.4f}")
