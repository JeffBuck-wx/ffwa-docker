var express = require('express');
var router = express.Router();
const pool = require('./database.js');


router.get('/', (req, res) => {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.write('<h1>Fly Fishing FTW</h1>');
  res.end();
  console.log('hitting the route')
});


// Routes
// Create - POST
// Fishing tables
router.post('/fishing/outings', async(req, res) => {
  try {
    const { date, location, weather, description } = req.body;
    const newItem = await pool.query(
      "INSERT INTO outings (date, location, weather, description) VALUES ($1, $2, $3, $4) RETURNING *",
      [date, location, weather, description]
    );

    res.json(newItem.rows[0]);
  } catch (err) {
    console.log('ERROR:', err.message);
  }
});

router.post('/fishing/species', async(req, res) => {
  try {
    const { species, description } = req.body;
    const newItem = await pool.query(
      "INSERT INTO species (species, description) VALUES ($1, $2) RETURNING *",
      [species, description]
    );

    res.json(newItem.rows[0]);
  } catch (err) {
    console.log('ERROR:', err.message);
  }
});

router.post('/fishing/fish', async(req, res) => {
  try {
    const { outing, species, length, fly } = req.body;
    const newItem = await pool.query(
      "INSERT INTO fish (outing, species, length, fly) VALUES ($1, $2, $3, $4) RETURNING *",
      [outing, species, length, fly]
    );

    res.json(newItem.rows[0]);
  } catch (err) {
    console.log('ERROR:', err.message);
  }
});

// Products tables
// Brands
router.post('/products/brands', async(req, res) => {
    try {
      const { value, description } = req.body;
      const newItem = await pool.query(
        "INSERT INTO brands (brand, description) VALUES ($1, $2) RETURNING *",
        [value, description]
      );
  
      res.json(newItem.rows[0]);
    } catch (err) {
      console.log('ERROR:', err.message);
    }
  });

  // Colors
router.post('/products/colors', async(req, res) => {
  try {
    const { value, description} = req.body;
    const newItem = await pool.query(
      "INSERT INTO colors (color, description) VALUES ($1, $2) RETURNING *",
      [value, description]
    );

    res.json(newItem.rows[0]);
  } catch (err) {
    console.log('ERROR:', err.message);
  }
});

// Hooks
router.post('/products/hooks', async(req, res) => {
  try {
    const { brand, model, size, type, length, weight, eye, shank, shape, gape, barbless } = req.body;
    const newItem = await pool.query(
      "INSERT INTO hooks (brand, model, size, type, length, weight, eye, shank, shape, gape, barbless) \
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING *",
      [brand, model, size, type, length, weight, eye, shank, shape, gape, barbless]
    );

    res.json(newItem.rows[0]);
  } catch (err) {
    console.log('ERROR:', err.message);
  }
});

// Beads
router.post('/product/beads', async(req, res) => {
  try {
    const { brand, model, size, material, color, matte, faceted, hole, shape } = req.body;
    const newItem = await pool.query(
      "INSERT INTO beads (brand, model, size, material, color, matte, faceted, hole, shapen) VALUES \
        ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *",
      [value, description ]
    );

    res.json(newItem.rows[0]);
  } catch (err) {
    console.log('ERROR:', err.message);
  }
});


// Inventory
router.post('/inventory/metadata', async(req, res) => {
  try {
    const { category, value, description } = req.body;
    const newItem = await pool.query(
      `INSERT INTO ${category} (value, description) VALUES ($1, $2) RETURNING *`,
      [value, description]
    );

    res.json(newItem.rows[0]);
  } catch (err) {
    console.log('ERROR:', err.message);
    res.json({'ERROR':err.message});
  }
});



// Get all inventory
router.get('/products/hooks', async(req, res) => {
  try {
    const allInventory = await pool.query("SELECT * FROM hooks");
    res.json(allInventory.rows)
  } catch (err) {
    console.log('ERROR:', err)
  }
});

// Get an item
router.get('/products/beads', async(req, res) => {
  try {
    const { id } = req.params;
    console.log(id);
    const item = await pool.query(
      "SELECT * FROM inventory WHERE id = $1", 
      [id]
    );
    res.json(item.rows[0])
  } catch (err) {
    console.log('ERROR:', err)
  }
});

// Metadata
// All metadata for a category
router.get('/metadata/:category', async(req, res) => {
  try {
    const { category } = req.params;
    const allInventory = await pool.query(`SELECT * FROM ${category}`);
    res.json(allInventory.rows)
  } catch (err) {
    console.log('ERROR:', err)
  }
});

// Individual metatdata for a category
router.get('/metadata/:category/:id', async(req, res) => {
  try { 
    const { category, id } = req.params;
    const allInventory = await pool.query(`SELECT * FROM ${category} WHERE id = $1`,
    [id]);
    res.json(allInventory.rows)
  } catch (err) {
    console.log('ERROR:', err)
  }
});



// Update an item
router.put('/inventory/:id', async(req, res) => {
  try {
    const { id } = req.params;
    const { count } = req.body; 
    const updateItem = await pool.query(
      "UPDATE inventory SET count = $1 WHERE id = $2", 
      [count, id]
    );
    res.json(updateItem.rows[0])
  } catch (err) {
    console.log('ERROR:', err)
  }
});

// Delete an item
router.delete('/inventory/:id', async(req, res) => {
  try {
    const { id } = req.params;
    const deletedItem = await pool.query(
      "DELETE FROM inventory WHERE id = $1", 
      [id]
    );
    res.json(deletedItem.rows[0])
  } catch (err) {
    console.log('ERROR:', err)
  }
});

module.exports = router;