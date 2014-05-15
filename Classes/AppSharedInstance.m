//
//  AppSharedInstance.m
//  Entry
//
//  Created by CS Soon on 8/11/10.
//  Copyright 2010 Espressoft Technologies. All rights reserved.
//

#import "AppSharedInstance.h"

static AppSharedInstance * appInstance;

@implementation AppSharedInstance

+(AppSharedInstance*)sharedInstance {
	if (!appInstance) {
		appInstance = [[AppSharedInstance alloc] init];
	}
	return appInstance;
}

-(id) init {
    if (self = [super init]) {
		[self openDB]; // only open the database once during init
    }
    return self;
}

- (void) openDB {
	databaseName = @"petlove1.0.db";
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	databasePath = [documentsDirectory stringByAppendingPathComponent:databaseName];
	sqlite3_open([databasePath UTF8String], &database);
}

- (NSMutableArray *) getPet
{
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk, ifnull(name,''), ifnull(fromd,''), ifnull(tod,''), ifnull(type,''), ifnull(akc,''), ifnull(notes,''),ifnull(patid,'') from pet order by name";
	
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)] forKey:@"name"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)] forKey:@"fromd"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)] forKey:@"tod"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)] forKey:@"type"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,5)] forKey:@"akc"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,6)] forKey:@"notes"];
            [recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,7)] forKey:@"patid"];
			[recordArray addObject:recordDict];
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
	return recordArray;	
}


- (void)insertAudio:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO Audios (name,date,type,patid) values (?,?,?,?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"date"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"type"] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(compiledStatement,4, [[dbDict objectForKey:@"patid"] UTF8String], -1, SQLITE_TRANSIENT);
	int success = sqlite3_step(compiledStatement);
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
    else
    {
        //NSLog(@"insert");
    }
	sqlite3_finalize(compiledStatement);
}

- (NSMutableArray *)getAudio
{
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk,ifnull(name,''), ifnull(date,''), ifnull(type,''),ifnull(patid,'') from Audios order by date";
	
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)] forKey:@"name"];
            	[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)] forKey:@"date"];
            	[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)] forKey:@"type"];
            [recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)] forKey:@"patid"];
			[recordArray addObject:recordDict];
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
    //NSLog(@"RecordArray%@",recordArray);
	return recordArray;
}



- (void)insertHis:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO history (patid,ques,ans) values (?,?,?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"patid"] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"ques"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"ans"] UTF8String], -1, SQLITE_TRANSIENT);
   
	int success = sqlite3_step(compiledStatement);
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
    else
    {
        //NSLog(@"insert");
    }
	sqlite3_finalize(compiledStatement);
}


- (NSMutableArray *)getHis
{
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk,ifnull(patid,''), ifnull(ques,''), ifnull(ans,'') from history order by patid";
	
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)] forKey:@"patid"];
            [recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)] forKey:@"ques"];
            [recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)] forKey:@"ans"];
        
			[recordArray addObject:recordDict];
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
    NSLog(@"RecordArray%@",recordArray);
	return recordArray;
}


















- (void)insertPet:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO pet (name, fromd, tod, type, akc, notes,patid) values (?,?,?,?,?,?,?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"fromd"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"tod"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,4, [[dbDict objectForKey:@"type"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,5, [[dbDict objectForKey:@"akc"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,6, [[dbDict objectForKey:@"notes"] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(compiledStatement,7, [[dbDict objectForKey:@"patid"] UTF8String], -1, SQLITE_TRANSIENT);
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}



- (void)insertAssesment:(NSDictionary *)dbDict {
    
    
    
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO assesment (id,name) values (?,?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"id"] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
	
    
	
	int success = sqlite3_step(compiledStatement);
	if (success != SQLITE_DONE)
    {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
    else
    {
       // //NSLog(@"sucess");
    }
	sqlite3_finalize(compiledStatement);
}


- (NSMutableArray *) getAssesment
{
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk, ifnull(id,''), ifnull(name,'') from assesment order by name";
	
    //NSLog(@"%i,SQLITE_OK:%i",sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL),SQLITE_OK);
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
    {
        
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
            
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)] forKey:@"id"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)] forKey:@"name"];
		
			
			[recordArray addObject:recordDict];
            
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
	return recordArray;
}


- (void)insertAss:(NSDictionary *)dbDict {
    
    
    
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO ass (assparentanswerid,assparentquestionid,assquestionid,assquestion,assid,assname) values (?,?,?,?,?,?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"assparentanswerid"] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"assparentquestionid"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"assquestionid"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,4, [[dbDict objectForKey:@"assquestion"] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(compiledStatement,5, [[dbDict objectForKey:@"assid"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,6, [[dbDict objectForKey:@"assname"] UTF8String], -1, SQLITE_TRANSIENT);

	
	int success = sqlite3_step(compiledStatement);
	if (success != SQLITE_DONE)
    {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
    else
    {
   //     //NSLog(@"sucess");
    }
	sqlite3_finalize(compiledStatement);
}



- (NSMutableArray *) getAssQue
{
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk, ifnull(assparentanswerid,''), ifnull(assparentquestionid,''), ifnull(assquestionid,''), ifnull(assquestion,''), ifnull(assid,''), ifnull(assname,'') from ass order by assname";
	
    //NSLog(@"%i,SQLITE_OK:%i",sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL),SQLITE_OK);
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
    {
          
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
         
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)] forKey:@"assparentanswerid"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)] forKey:@"assparentquestionid"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)] forKey:@"assquestionid"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)] forKey:@"assquestion"];
            [recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,5)] forKey:@"assid"];
            [recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,6)] forKey:@"assname"];
			
			[recordArray addObject:recordDict];
         
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
	return recordArray;
}


////////ANSWER INSERT/////////
- (void)insertAnswer:(NSDictionary *)dbDict {
    
    
    
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO ans (ansid,answer,assquestionid,assid) values (?,?,?,?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"ansid"] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"answer"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"assquestionid"] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(compiledStatement,4, [[dbDict objectForKey:@"assid"] UTF8String], -1, SQLITE_TRANSIENT);
    int success = sqlite3_step(compiledStatement);
	if (success != SQLITE_DONE)
    {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
    else
    {
     //   //NSLog(@"sucess");
    }
	sqlite3_finalize(compiledStatement);
}


- (NSMutableArray *) getAssAnswer
{
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk, ifnull(ansid,''), ifnull(answer,''), ifnull(assquestionid,''),ifnull(assid,'') from ans order by assid";
	
    //NSLog(@"%i,SQLITE_OK:%i",sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL),SQLITE_OK);
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
    {
    
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
            
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)] forKey:@"ansid"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)] forKey:@"answer"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)] forKey:@"assquestionid"];
		    [recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)] forKey:@"assid"];
			
			[recordArray addObject:recordDict];
        
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
	return recordArray;
}
/////////////////ANSER ENDDDD////////////







- (void)updatePet:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "UPDATE pet set name=?, fromd=?, tod=?, type=?, akc=?, notes=? where pk=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"fromd"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"tod"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,4, [[dbDict objectForKey:@"type"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,5, [[dbDict objectForKey:@"akc"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,6, [[dbDict objectForKey:@"notes"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(compiledStatement, 7, [[dbDict objectForKey:@"pk"] intValue]);	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

- (void)deletePet:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "DELETE FROM pet where pk=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_int(compiledStatement, 1, [[dbDict objectForKey:@"pk"] intValue]);	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

// ******* NOTES ******* //

- (NSMutableArray *) getNotes:(int)pid {
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk, ifnull(notes,''), ifnull(date,'') from notes where pid=? order by date desc,pk";
	
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		sqlite3_bind_int(compiledStatement, 1, pid);
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)] forKey:@"notes"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)] forKey:@"date"];
			[recordArray addObject:recordDict];
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
	return recordArray;	
}

- (void)insertNotes:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO notes (pid, notes, date) values (?,?,?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_int(compiledStatement, 1, [[dbDict objectForKey:@"pid"] intValue]);	
	sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"notes"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"date"] UTF8String], -1, SQLITE_TRANSIENT);
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

- (void)updateNotes:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "UPDATE notes set notes=?, date=? where pk=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"notes"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"date"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(compiledStatement, 3, [[dbDict objectForKey:@"pk"] intValue]);	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

- (void)deleteNotes:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "DELETE from notes where pk=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_int(compiledStatement, 1, [[dbDict objectForKey:@"pk"] intValue]);	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}


// ******* VET ******* //

- (NSMutableArray *)getVet:(int)pid {
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk, ifnull(date,''), ifnull(clinic,''), ifnull(phone,''), ifnull(address,''), ifnull(address2,''), ifnull(pid,'') from vet where pid=? order by date desc";
	
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		sqlite3_bind_int(compiledStatement, 1, pid);
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)] forKey:@"date"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)] forKey:@"clinic"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)] forKey:@"phone"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)] forKey:@"address"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,5)] forKey:@"address2"];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,6)] forKey:@"pid"];
			[recordArray addObject:recordDict];
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
	return recordArray;	
}

- (void)insertVet:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO vet (date, clinic, phone, address, address2, pid) values (?,?,?,?,?,?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"date"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"clinic"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"phone"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,4, [[dbDict objectForKey:@"address"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,5, [[dbDict objectForKey:@"address2"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(compiledStatement, 6, [[dbDict objectForKey:@"pid"] intValue]);	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

- (void)updateVet:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "UPDATE vet set date=?, clinic=?, phone=?, address=?, address2=?, pid=? where pk=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_text(compiledStatement,1, [[dbDict objectForKey:@"date"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"clinic"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"phone"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,4, [[dbDict objectForKey:@"address"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,5, [[dbDict objectForKey:@"address2"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(compiledStatement, 6, [[dbDict objectForKey:@"pid"] intValue]);
	sqlite3_bind_int(compiledStatement, 7, [[dbDict objectForKey:@"pk"] intValue]);	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

- (void)deleteVet:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "DELETE from vet where pk=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_int(compiledStatement, 1, [[dbDict objectForKey:@"pk"] intValue]);	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

// ******* VET record******* //

- (NSMutableArray *)getVetRecord:(int)pid {
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk, ifnull(pid,''), ifnull(name,''), ifnull(detail,''), ifnull(schedule,'') from vet_record where pid=?";
	
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		sqlite3_bind_int(compiledStatement, 1, pid);
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,1)] forKey:@"pid"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)] forKey:@"name"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)] forKey:@"detail"];
			[recordDict setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)] forKey:@"schedule"];
			[recordArray addObject:recordDict];
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
	return recordArray;	
}

- (void)insertVetRecord:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO vet_record (pid, name, detail, schedule) values (?,?,?,?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_int(compiledStatement, 1, [[dbDict objectForKey:@"pid"] intValue]);	
	sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"detail"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,4, [[dbDict objectForKey:@"schedule"] UTF8String], -1, SQLITE_TRANSIENT);
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

- (void)updateVetRecord:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "UPDATE vet_record set pid=?, name=?, detail=?, schedule=? where pk=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_int(compiledStatement, 1, [[dbDict objectForKey:@"pid"] intValue]);	
	sqlite3_bind_text(compiledStatement,2, [[dbDict objectForKey:@"name"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,3, [[dbDict objectForKey:@"detail"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(compiledStatement,4, [[dbDict objectForKey:@"schedule"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(compiledStatement, 5, [[dbDict objectForKey:@"pk"] intValue]);	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

- (void)deleteVetRecord:(NSDictionary *)dbDict {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "DELETE from vet_record where pk=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_int(compiledStatement, 1, [[dbDict objectForKey:@"pk"] intValue]);	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

- (void)deleteAllVetRecord:(NSDictionary *)dbDict{
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "DELETE from vet_record where pid=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_int(compiledStatement, 1, [[dbDict objectForKey:@"pk"] intValue]);
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	sqlite3_finalize(compiledStatement);
}

// ******* Photo ******* //

- (NSMutableArray *)getPhoto:(int)pid {
	NSMutableArray *recordArray = [[NSMutableArray alloc] init];
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk, ifnull(pid,'') from photo where pid=?";
	
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		sqlite3_bind_int(compiledStatement, 1, pid);
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			NSMutableDictionary *recordDict = [[NSMutableDictionary alloc] init];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] forKey:@"pk"];
			[recordDict setObject:[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,1)] forKey:@"pid"];
			[recordArray addObject:recordDict];
			[recordDict release];
		}
		sqlite3_finalize(compiledStatement);
	}
	return recordArray;	
}

- (int)insertPhoto:(int)pid {
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "INSERT INTO photo (pid) values (?)";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		sqlite3_bind_int(compiledStatement, 1, pid);
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			sqlite3_bind_int(compiledStatement, 1, pid);	
			//int success = sqlite3_step(compiledStatement);	
		}
	}	
	sqlite3_finalize(compiledStatement);
	
	return sqlite3_last_insert_rowid(database);
}

- (int)getPhotoPK:(int)rowId {
	sqlite3_stmt *compiledStatement;
	
	const char *sqlStatement = "select pk, ifnull(pid,'') from photo where rowId=?";
	
	int temp;
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
		sqlite3_bind_int(compiledStatement, 1, rowId);
		while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
			temp = [[NSNumber numberWithInt:sqlite3_column_int(compiledStatement,0)] intValue];
		}
		sqlite3_finalize(compiledStatement);
	}
	return temp;	
}

-(void)deletePhoto:(int)pk{
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = "DELETE FROM photo WHERE pk=?";
	if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
	}	
	sqlite3_bind_int(compiledStatement, 1, pk);	
	
	int success = sqlite3_step(compiledStatement);	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to update data with message '%s'.", sqlite3_errmsg(database));
	}
	else {
		NSString *filename = [NSString stringWithFormat:@"photo_%d.png",pk];
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *myFilePath = [documentsDirectory stringByAppendingPathComponent:filename];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		[fileManager removeItemAtPath:myFilePath error:NULL];
	}
	sqlite3_finalize(compiledStatement);
}


@end
