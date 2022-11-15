//	Created by Leopold Lemmermann on 15.11.22.

@testable import Concurrency
import XCTest

class CollectionsTests: XCTestCase {
  func testAsyncMapping() async throws {
    let items = [1, 2, 3]

    let newItems = await items.map { item in
      await sleep(for: 0.1)
      return item + 1
    }

    XCTAssertEqual(
      items.map { $0 + 1 }, newItems,
      "The async map returns something other than the sync map."
    )
  }

  func testAsyncCompactMapping() async throws {
    let items = [1, 2, 3, nil]

    let newItems = await items.compactMap { item in
      await sleep(for: 0.1)
      return item
    }

    XCTAssertEqual(
      items.compactMap { $0 }, newItems,
      "The async compact map returns something other than the sync compact map."
    )
  }

  func testAsyncForEach() async throws {
    let items = [1, 2, 3]

    var count = 0
    
    await items.forEach { item in
      await sleep(for: 0.1)
      count += 1
    }

    XCTAssertEqual(
      items.count, count,
      "The async for each executes an unexpected number of times."
    )
  }
}
