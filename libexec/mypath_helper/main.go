package main

import (
	"fmt"
	"io"
	"os"
	"slices"
	"strings"

	"github.com/google/go-cmp/cmp"
	flag "github.com/spf13/pflag"
)

var (
	nixPath      string
	homebrewPath string

	debug bool
	diff  bool
	stdin bool
)

func dropEmptyElementsString(s string) string {
	b := []byte(s)

	start := 0
	for start < len(b)-1 {
		if b[start] != ':' {
			break
		}
		start++
	}
	b = b[start:]

	var i, j = 1, 1
	for ; i <= len(b)-1; i++ {
		if b[i-1] == ':' && b[i] == ':' {
			// We're in a round of dupes, just increment i
			continue
		}

		if i > j {
			// Copy chars backwards
			b[j] = b[i]
		}

		j++
	}

	// Truncate the slice if we had to copy stuff around
	if i > j {
		b = b[0:j]
	}

	// We set empty strings for paths to drop. So just work backwards until we
	// find a real path
	end := len(b)
	if b[end-1] == ':' {
		// Drop our trailing colons
		for ; end > 0; end-- {
			if b[end-1] != ':' {
				break
			}
		}
	}

	return string(b[0:end])
}

func init() {
	flag.BoolVarP(&debug, "debug", "d", false, "Print path elements for debugging instead of shell evaluation")
	flag.BoolVarP(&diff, "diff", "D", false, "Prints a diff of the changes made to the path. Implies --debug")
	flag.BoolVarP(&stdin, "stdin", "s", false, "Read in PATH value from stdin instead of the $PATH environment variable")
	flag.StringVar(&nixPath, "nix-user-path", fmt.Sprintf("/etc/profiles/per-user/%s/bin", os.Getenv("HOME")), "Path for per-user Nix binaries")
	flag.StringVar(&homebrewPath, "homebrew-path", "/opt/homebrew/bin", "Path for Homebrew binaries")
}

func main() {
	flag.Parse()

	path := os.Getenv("PATH")
	if stdin {
		b, err := io.ReadAll(os.Stdin)
		if err != nil {
			panic(err)
		}

		path = string(b)
	}

	elems := strings.Split(path, ":")
	pathSet := make(map[string]int)

	// Drop our dupes
	for i, p := range elems {
		p = strings.TrimSuffix(p, "/")
		if _, found := pathSet[p]; found {
			elems[i] = ""
			continue
		}

		pathSet[p] = i
	}

	// Make sure our nix path is ahead of Homebrew. However, we dont want Homebrew
	// at the end of our path either. The simplest thing to do is just swap
	// their positions. I can make this better later if I care enough
	hbIdx, found := pathSet[homebrewPath]
	if found {
		if nixIdx, found := pathSet[nixPath]; found {
			elems[nixIdx], elems[hbIdx] = elems[hbIdx], elems[nixIdx]
		}
	}

	// Now drop the empties
	elems = slices.DeleteFunc(elems, func(s string) bool { return s == "" })

	if debug || diff {
		if diff {
			orig := strings.Split(path, ":")
			fmt.Println(cmp.Diff(orig, elems))
		} else {
			fmt.Printf("%s\n", strings.Join(elems, "\n"))
		}

		return
	}

	// Finally, spit out the result
	var sb strings.Builder
	for _, p := range elems {
		sb.WriteString(p)
		sb.WriteByte(':')
	}
	fmt.Printf("PATH=%q; export PATH;\n", strings.TrimSuffix(sb.String(), ":"))
}
