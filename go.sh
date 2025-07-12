go mod init github.com/go/go

# GOPROXY=proxy.golang.org go list -m github.com/ZeroMarker/cnid@v0.0.2

go get github.com/go/go

go clean -modcache
