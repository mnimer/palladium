------------------------------------------------
    __  ___           __          ________
   /  |/  /___ ______/ /_        /  _/  _/
  / /|_/ / __ `/ ___/ __ \______ / / / /  
 / /  / / /_/ / /__/ / / /_____// /_/ /   
/_/  /_/\__,_/\___/_/ /_/     /___/___/  

$Id: README 1231 2009-01-09 06:51:17Z peterfarrell $
------------------------------------------------

* The official unit testing framework of Mach-II is MXUnit.
* MXUnit is available at http://www.mxunit.org

HOW TO RUN TESTS
------------------------------------------------
MXUnit must be installed on your local development environment.

Test Runners:
* Use MXUnit's Eclipse based plugin
* Use MXUnit's html test runner to run individual test cases
* Use our ANT task 'test' in build.xml to run the test suite
	You must have the MXUnit jars in your ANT class path.
* Use our ANT task 'testRepor' build.xml to run the test suit
	and get a JUnit report of test suite results