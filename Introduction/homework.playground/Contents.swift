import XCTest

/* Return the middle
 Write a function that returns the middle element of an array. When array size is even, return the first of the two middle elements.
 */

func middle(_ array: [Int]) -> Int? {
    // TODO: - Put your code here
    
    return nil
}

/* Merge dictionaries
 Write a function that combines two dictionaries into one. If a certain key appears in both dictionaries, ignore the pair from the first dictionary.
 */

func merging(_ dict1: [String: String], with dict2: [String: String]) -> [String: String] {
    // TODO: - Put your code here
    
    return [:]
}


/* Write a function that will run a given closure a given number of times.
 */

func repeatTask(times: Int, task: () -> Void) {
    /* the function should run the task closure, times number of times. Use this function to print "Winter is coming" 10 times. */
}

/* Write a function which takes a string and returns a version of it with each individual word reversed.
 For example, if the string is â€œMy dog is called Roverâ€ then the resulting string would be "yM god si dellac revoR".
 Try to do it by iterating through the indices of the string until you find a space, and then reversing what was before it. Build up the result string by continually doing that as you iterate through the string.
 */

func reverseWords(_ string: String) -> String {
    // TODO: - Your code goes here
    
    return ""
}

/* psst ... a method exists on a string named components(separatedBy:) that will split the string into chunks, which are delimited by the given string, and return an array containing the results.
 */

class HomeworkTest: XCTestCase {
    
    // MARK: - middle(_:)
    func testMiddle_emptyArray() {
        XCTAssertNil(middle([]))
    }

    func testMiddle_arrayWithOneElement() {
        XCTAssertEqual(middle([1]), 1)
    }

    func testMiddle_evenElements() {
        XCTAssertEqual(middle([1, 2]), 1)
    }

    func testMiddle_oddElements() {
        XCTAssertEqual(middle([1, 2, 3]), 2)
    }

    func testMiddle_evenElementsAboveTen() {
        XCTAssertEqual(middle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]), 6)
    }

    func testMiddle_oddElementsAboveTen() {
        XCTAssertEqual(middle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]), 7)
    }

    func testMiddle_evenElementsAboveFifty() {
        XCTAssertEqual(middle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]), 6)
    }

    func testMiddle_oddElementsAboveFifty() {
        XCTAssertEqual(middle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]), 7)
    }
    
    // MARK: - merging(_: with:)
    func testMerging_twoEmptyDictionaries() {
        XCTAssertEqual(merging([:], with: [:]), [:])
    }

    func testMerging_firstDictionaryEmpty() {
        XCTAssertEqual(merging([:], with: ["a": "a", "b": "b", "c": "c"]), ["a": "a", "b": "b", "c": "c"])
    }

    func testMerging_secondDictionaryEmpty() {
        XCTAssertEqual(merging(["a": "a", "b": "b", "c": "c"], with: [:]), ["a": "a", "b": "b", "c": "c"])
    }

    func testMerging_twoDictionariesContainDifferentKeys() {
        XCTAssertEqual(merging(["a": "a", "b": "b", "c": "c"], with: ["d": "d", "e": "e", "f": "f"]), ["a": "a", "b": "b", "c": "c", "d": "d", "e": "e", "f": "f"])
    }

    func testMerging_twoDictionarieEqualKeysDifferentValues() {
        XCTAssertEqual(merging(["a": "a", "b": "b", "c": "c"], with: ["a": "d", "b": "e", "c": "f"]), ["a": "d", "b": "e", "c": "f"])
    }
    
    // MARK: - repeatTask(times:, task:)
    func testRepeatTask_validCount() {
        var counter = 0

        repeatTask(times: 10) {
            counter += 1
        }

        XCTAssertEqual(10, counter)
    }

    func testRepeatTask_zero() {
        var counter = 0

         repeatTask(times: 0) {
             counter += 1
         }

         XCTAssertEqual(0, counter)
    }
    
    func testRepeatTask_invalidCount() {
        var counter = 0

         repeatTask(times: -1) {
             counter += 1
         }

         XCTAssertEqual(0, counter)
    }
    
    // MARK: - reverseWords(_:)
    func testReverseWords_Empty() {
        XCTAssertEqual(reverseWords(""), "")
    }
    
    func testReverseWords_SingleWord() {
        XCTAssertEqual(reverseWords("Veronika"), "akinoreV")
    }
    
    func testReverseWords_Expression() {
        XCTAssertEqual(reverseWords("The night is dark and full of terrors!"), "ehT thgin si krad dna lluf fo !srorret")
    }
}

HomeworkTest.defaultTestSuite.run()
