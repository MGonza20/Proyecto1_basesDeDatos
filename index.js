// Libraries
const fs = require('fs');
const path = require('path');

const csv = require('fast-csv');
const colors = require('colors');
const { Pool } = require('pg');
const { createDraftCombineQuery, createDraftQuery, createPlayerQuery, createPlayerBiosQuery, createGameInactivePlayersQuery, createGameQuery } = require('./queries');
// Constants
const credentials = {
    user: 'postgres',
    host: 'localhost',
    database: 'flights',
    password: '2302',
    port: 5432
}

// Function to read a csv file

/**
 * Reads a CSV file
 * @param {string} fileName Name of file to read
 * @param {string} tableName Name of the table to insert the data
 */
const crateTableFromFile = (fileName, tableName) => {
    const parsedData = [];
    fs.createReadStream(path.resolve(__dirname, 'files', `${fileName}.csv`))
        .pipe(csv.parse({ headers: true }))
        .on('error', error => console.log(error))
        .on('data', async (row) => {
            parsedData.push(row);
        })
        .on('end', async (count) => {
            for (const row of parsedData) {
                const pool = new Pool(credentials);
                const values = Object.values(row).map(val => `'${val.replace(/'/g, "''")}'`);
                console.log(`INSERT INTO ${tableName} VALUES(
                        ${values.join(",")}
                    )`);
                await pool.query(`
                    INSERT INTO ${tableName} VALUES(
                        ${values.join(",")}                    
                    )
                `);
                pool.end();
            }
            console.log(`Inserted a total of ${count} rows into ${tableName}`.blue);
        });

}

// Functions to create the tables

const createTable = async (query) => {
    try {
        const pool = new Pool(credentials);
        await pool.query(query);
        pool.end();
        console.log(`Created table`.blue);

    } catch (error) {
        console.log(`Error Creating: `.red, error);
    }

}



// Insert Into Tables

(async () => {
    // Create Tables
    // await createTable(createDraftCombineQuery);
    // crateTableFromFile('Draft_Combine', 'draft_combine');

    // await createTable(createDraftQuery);
    // crateTableFromFile('Draft', 'draft');

    // await createTable(createPlayerQuery);
    // crateTableFromFile('Player', 'player');

    // await createTable(createPlayerBiosQuery);
    // crateTableFromFile('Player_Bios', 'player_bios');


    await createTable(createGameInactivePlayersQuery);
    crateTableFromFile('Game_Inactive_Players', 'game_inactive_players');


    // await createTable(createGameQuery);
    // crateTableFromFile('Game', 'game');


})();


