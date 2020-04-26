import XCTest

let suite = XCTestSuite.default
for test in suite.tests {
	print("TEST SUITE")
	test.run()
}
