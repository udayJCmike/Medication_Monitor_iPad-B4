//
//  AppSharedInstance.h
//  Entry
//
//  Created by CS Soon on 8/11/10.
//  Copyright 2010 Espressoft Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface AppSharedInstance : NSObject {
	sqlite3 *database;	
	NSString *databaseName;
	NSString *databasePath;	
}

- (void)insertHis:(NSDictionary *)dbDict;
- (NSMutableArray *)getHis;
- (NSMutableArray *)getAudio;
+(AppSharedInstance*)sharedInstance; 
- (void) openDB;
- (NSMutableArray *) getAssesment;
- (NSMutableArray *) getPet;
- (NSMutableArray *) getAssQue;
- (NSMutableArray *) getAssAnswer;
- (void)insertAudio:(NSDictionary *)dbDict;
- (void)insertAss:(NSDictionary *)dbDict ;
- (void)insertAnswer:(NSDictionary *)dbDict ;
- (void)insertAssesment:(NSDictionary *)dbDict ;


- (void)insertPet:(NSDictionary *)dbDict;
- (void)updatePet:(NSDictionary *)dbDict;
- (void)deletePet:(NSDictionary *)dbDict;
- (NSMutableArray *) getNotes:(int)pid;
- (void)insertNotes:(NSDictionary *)dbDict;
- (void)updateNotes:(NSDictionary *)dbDict;
- (void)deleteNotes:(NSDictionary *)dbDict;
- (NSMutableArray *)getVet:(int)pid;
- (void)insertVet:(NSDictionary *)dbDict;
- (void)updateVet:(NSDictionary *)dbDict;
- (void)deleteVet:(NSDictionary *)dbDict;
- (NSMutableArray *)getVetRecord:(int)pid;
- (void)insertVetRecord:(NSDictionary *)dbDict;
- (void)updateVetRecord:(NSDictionary *)dbDict;
- (void)deleteVetRecord:(NSDictionary *)dbDict;
- (void)deleteAllVetRecord:(NSDictionary *)dbDict;
- (NSMutableArray *)getPhoto:(int)pid;
- (int)insertPhoto:(int)pid;
- (int)getPhotoPK:(int)rowId;
-(void)deletePhoto:(int)pk;
@end
