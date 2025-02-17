package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestDropEmptyElementsString(t *testing.T) {
	result := "/bin:/usr/bin:/baz"
	assert.Equal(t, result, dropEmptyElementsString(result))

	inputs := []string{
		":/bin:/usr/bin:/baz",
		"::/bin:/usr/bin:/baz",
		"/bin:/usr/bin:/baz:",
		"/bin:/usr/bin:/baz::",
		"/bin:/usr/bin::::/baz",
		"::/bin::/usr/bin::::/baz::",
	}

	for _, tt := range inputs {
		assert.Equal(t, result, dropEmptyElementsString(tt), "failed on %q", tt)
	}
}
