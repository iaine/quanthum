#Unit tests for SNA
library(RUnit)

source('~/git/quanthum/network_ids.R')

test.find_numbers <- function () {
  testDataA <- "Adrian;Alonso;Antonio;Ariel;Boatswain;Caliban"
  testDataB <- "Falstaff;Foo;Bar;Caliban"
  testDataC <- "Foo;Bar;Dave"
  checkEquals(find_numbers(testDataA, testDataB), 1)
  checkEquals(find_numbers(testDataA, testDataC), 0)
}


testsuite.network <- defineTestSuite("network_id",
                              dirs = file.path("~/git/quanthum/tests"),
                              testFileRegexp = '^\\w+\\.R')

testResult <- runTestSuite(testsuite.network )

printTextProtocol(testResult)

track <- tracker();
track$init();

dataA <- "Adrian;Alonso;Antonio;Ariel;Boatswain;Caliban"
dataB <- "Falstaff;Foo;Bar;Caliban"
resFind <- inspect(find_numbers(dataA, dataB), track=track);
resTrack <- track$getTrackInfo();
printHTML.trackInfo(resTrack);