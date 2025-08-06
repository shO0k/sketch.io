import sys
import json
sys.path.append("/Users/johnshook/Unix/Projects/Sketch")
import file_crawler as fc


def format_results(sketch_path, start_path):
        results = fc.file_iterator(sketch_path, start_path)
        output_lines = [f"{path}: {score * 100:.2f}%" for path, score in results]
        return "\n".join(output_lines)


if __name__ == "__main__":
        if len(sys.argv) < 3:
                print("Usage: python run_search.py <sketch_path> <start_path>")
                sys.exit(1)

        sketch_path = sys.argv[1]
        start_path = sys.argv[2]

        print(format_results(sketch_path,start_path))
