mint bootstrap -m ./Mintfile
mint run carthage bootstrap --platform iOS --no-use-binaries
mint run XcodeGen generate
