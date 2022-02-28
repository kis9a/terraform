package handler

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"testing"
	"text/tabwriter"

	"github.com/aws/aws-lambda-go/events"
	"github.com/gobwas/glob"
)

func TestNotify(t *testing.T) {
	var data events.CloudwatchLogsData
	fs, err := os.Open("../testdata/cloudwatch_logs_message_events.json")
	if err != nil {
		t.Fatal(err)
	}
	bytefs, err := ioutil.ReadAll(fs)
	if err != nil {
		t.Fatal(err)
	}
	defer fs.Close()
	if err = json.Unmarshal(bytefs, &data); err != nil {
		t.Fatal(err)
	}
	if err = notifyCloudwatchLogsEvent(data); err != nil {
		t.Fatal(err)
	}
}

func TestGlobMatchExample(t *testing.T) {
	w := tabwriter.NewWriter(os.Stdout, 1, 1, 1, ' ', 0)
	fmt.Fprintln(w, "pattern", "\t", "path", "\t", "truth")
	displayMatch := func(match string, path string) {
		g := glob.MustCompile(match, '/')
		fmt.Fprintln(w, match, "\t", path, "\t", g.Match(path))
	}
	// true case
	displayMatch("*.js", "a.js")             // true
	displayMatch("{a,b,c}.js", "a.js")       // true
	displayMatch("[a-c].js", "a.js")         // true
	displayMatch("[!a-c].js", "d.js")        // true
	displayMatch("**.js", "a/b.js")          // true
	displayMatch("?????at.js", "12345at.js") // true
	displayMatch("*/*.js", "a/b.js")         // true
	displayMatch("a/*.js", "a/b.js")         // true
	displayMatch("a/**.js", "a/b.js")        // true
	displayMatch("*testurl*", "a/testurl")   // false

	// false case
	displayMatch("*.js", "a/b.js")      // false
	displayMatch("{a,b,c}.js", "d.js")  // false
	displayMatch("[a-c].js", "d.js")    // false
	displayMatch("[1-8].js", "9.js")    // false
	displayMatch("b/*.js", "a/b.js")    // false
	displayMatch("a/**/*.js", "a/b.js") // false
	w.Flush()
}
