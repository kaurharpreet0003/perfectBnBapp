//
//  DBHelper.swift
//  PerfectBnB
//
//  Created by Syed Nooruddin Fahad on 22/02/21.
//

import Foundation
import SQLite3

class DBHelper  {
    var db: OpaquePointer?
    var path: String = "PerfectBnB.sqlite"
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is an Error in creating Database")
            return nil
        } else {
            print("Database Created Succesfully with path \(path)")
            return db
        }
    }
    
    func createTable() {
        let query = "CREATE TABLE IF NOT EXISTS Location(latitude TEXT, longitude TEXT);"
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("Table Created Succesfully")
            } else {
                print("Unable to Create Table")
            }
        } else {
            print("Unable to Create A Table")
        }
    }
    
    struct Location {
        let latitude : String!
        let longitude : String!
    }
    
    func insert(latitude: String, longitude: String ) {
        let query = "INSERT INTO Location(latitude, longitude) VALUES( ?, ?)"
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (latitude as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (longitude as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data Inserted Successfully")
            } else {
                print("Error in Inserting Data")
            }
        } else {
            print("Query is Not As per Requirement")
        }
    }
    
    func query(){
        let queryStatementString = "SELECT * FROM Location ORDER BY latitude DESC limit 1 ;"
        var queryStatement: OpaquePointer? = nil
      // 1
      if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
          SQLITE_OK {
        // 2
        if sqlite3_step(queryStatement) == SQLITE_ROW {
         let latitude = sqlite3_column_text(queryStatement, 0)
         let longitude = sqlite3_column_text(queryStatement, 1)
          let lat = String(cString: latitude!)
          let long = String(cString: longitude!)
          // 5
          print("\nQuery Result:")
          print("Latitude: \(lat) | Longitude: \(long)")
      } else {
          print("\nQuery returned no results.")
        }
      } else {
          // 6
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("\nQuery is not prepared \(errorMessage)")
      }
      // 7
      sqlite3_finalize(queryStatement)
    }
}
