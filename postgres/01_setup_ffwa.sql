-- Fly Fishing SQL

-- Tables
CREATE TABLE IF NOT EXISTS outings (
    id SERIAL NOT NULL,
    outing VARCHAR(64) DEFAULT CONCAT('Outing', ' ', CURRVAL('outings_id_seq')) NOT NULL, 
    date DATE NOT NULL,
    location VARCHAR(512) NOT NULL,
    weather VARCHAR(64) NOT NULL,
    description VARCHAR(512),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS species (
    id SERIAL NOT NULL,
    species VARCHAR(64) NOT NULL,
    description VARCHAR(256),
    PRIMARY KEY (id),
    UNIQUE (species)
);

CREATE TABLE IF NOT EXISTS fish (
    id SERIAL NOT NULL,
    outing INT NOT NULL,
    species INT NOT NULL,
    length NUMERIC(4,2),
    fly VARCHAR(64),
    PRIMARY KEY (id),
    CONSTRAINT fk_outing_id
        FOREIGN KEY (outing)
            REFERENCES outings(id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_species_id
        FOREIGN KEY (species)
            REFERENCES species(id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS brands (
    id SERIAL NOT NULL,
    brand VARCHAR(32) NOT NULL,
    description VARCHAR(512),
  PRIMARY KEY (id),
  CONSTRAINT uc_brand_name UNIQUE (brand)
);

CREATE TABLE IF NOT EXISTS colors (
    id SERIAL NOT NULL,
    color VARCHAR(32) NOT NULL,
    description VARCHAR(64),
  PRIMARY KEY (id),
  CONSTRAINT uc_color_name UNIQUE (color)
);

CREATE TABLE IF NOT EXISTS hook_lengths (
    id SERIAL NOT NULL,
    value VARCHAR(16) NOT NULL,
    description VARCHAR(64),
  PRIMARY KEY (id),
  CONSTRAINT uc_hook_length_name UNIQUE (value)
);

CREATE TABLE IF NOT EXISTS hook_weights (
    id SERIAL NOT NULL,
    value VARCHAR(16) NOT NULL,
    description VARCHAR(128),
  PRIMARY KEY (id),
  CONSTRAINT uc_hook_weight_name UNIQUE (value)
);

CREATE TABLE IF NOT EXISTS hook_eyes (
    id SERIAL NOT NULL,
    value VARCHAR(16) NOT NULL,
    description VARCHAR(128),
  PRIMARY KEY (id),
  CONSTRAINT uc_hook_eye_name UNIQUE (value) 
);

CREATE TABLE IF NOT EXISTS hook_types (
    id SERIAL NOT NULL,
    value VARCHAR(16) NOT NULL,
    description VARCHAR(128),
  PRIMARY KEY (id),
  CONSTRAINT uc_hook_type_name UNIQUE (value) 
);

CREATE TABLE IF NOT EXISTS hook_shapes (
    id SERIAL NOT NULL,
    value VARCHAR(16) NOT NULL,
    description VARCHAR(128),
  PRIMARY KEY (id),
  CONSTRAINT uc_hook_shape_name UNIQUE (value) 
);

CREATE TABLE IF NOT EXISTS hook_shanks (
    id SERIAL NOT NULL,
    value VARCHAR(16) NOT NULL,
    description VARCHAR(128),
  PRIMARY KEY (id),
  CONSTRAINT uc_hook_shank_name UNIQUE (value) 
);

CREATE TABLE IF NOT EXISTS hook_gapes (
    id SERIAL NOT NULL,
    value VARCHAR(16) NOT NULL,
    description VARCHAR(128),
  PRIMARY KEY (id),
  CONSTRAINT uc_hook_gape_name UNIQUE (value) 
);

CREATE TABLE IF NOT EXISTS hook_sizes (
    id SERIAL NOT NULL,
    value VARCHAR(16) NOT NULL,
    description VARCHAR(128),
  PRIMARY KEY (id),
  CONSTRAINT uc_hook_size_name UNIQUE (value) 
);

CREATE TABLE IF NOT EXISTS hooks (
    id SERIAL NOT NULL,
    brand INT NOT NULL,
    model VARCHAR(32) NOT NULL,
    size INT NOT NULL, 
    type INT NOT NULL,
    length INT NOT NULL,
    weight INT NOT NULL,
    eye INT NOT NULL,
    shank INT NOT NULL,
    shape INT NOT NULL,
    gape INT NOT NULL,
    barbless BOOLEAN DEFAULT 'f',
  PRIMARY KEY (id),
  CONSTRAINT uc_hook_name UNIQUE (brand, model, size),
  CONSTRAINT fk_hook_brand_id
    FOREIGN KEY (brand)
      REFERENCES brands(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  CONSTRAINT fk_hook_size_id
    FOREIGN KEY (size)
      REFERENCES hook_sizes(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE, 
  CONSTRAINT fk_hook_type_id
    FOREIGN KEY (type)
      REFERENCES hook_types(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE, 
  CONSTRAINT fk_hook_length_id
    FOREIGN KEY (length)
      REFERENCES hook_lengths(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  CONSTRAINT fk_hook_weight_id
    FOREIGN KEY (weight)
      REFERENCES hook_weights(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE, 
  CONSTRAINT fk_hook_eye_id
    FOREIGN KEY (eye)
      REFERENCES hook_eyes(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE, 
  CONSTRAINT fk_hook_shank_id
    FOREIGN KEY (shank)
      REFERENCES hook_shanks(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE, 
  CONSTRAINT fk_hook_shape_id
    FOREIGN KEY (shape)
      REFERENCES hook_shapes(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE, 
  CONSTRAINT fk_hook_gape_id
    FOREIGN KEY (gape)
      REFERENCES hook_gapes(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS bead_sizes (
  id SERIAL NOT NULL,
  value VARCHAR(32) NOT NULL,
  description VARCHAR (512),
  PRIMARY KEY (id),
  CONSTRAINT uc_bead_size_name UNIQUE (value)
);

CREATE TABLE IF NOT EXISTS bead_materials (
  id SERIAL NOT NULL,
  value VARCHAR(32),
  description VARCHAR (512),
  PRIMARY KEY (id),
  CONSTRAINT uc_bead_material_name UNIQUE (value)
);

CREATE TABLE IF NOT EXISTS bead_holes (
  id SERIAL NOT NULL,
  value VARCHAR(32),
  description VARCHAR (512),
  PRIMARY KEY (id),
  CONSTRAINT uc_bead_hole_name UNIQUE (value)
);

CREATE TABLE IF NOT EXISTS bead_shapes (
  id SERIAL NOT NULL,
  value VARCHAR(32),
  description VARCHAR (512),
  PRIMARY KEY (id),
  CONSTRAINT uc_bead_shape_name UNIQUE (value)
);

CREATE TABLE IF NOT EXISTS beads (
  id SERIAL NOT NULL,
  brand INT NOT NULL,
  model VARCHAR(32) NOT NULL,
  size INT NOT NULL,
  material INT NOT NULL,
  color INT NOT NULL,
  matte BOOLEAN NOT NULL DEFAULT 'f',
  faceted BOOLEAN NOT NULL DEFAULT 'f',
  hole INT NOT NULL,
  shape INT NOT NULL,
  CONSTRAINT uc_bead_name UNIQUE (brand, model, size, color),
  CONSTRAINT fk_bead_brand_id
    FOREIGN KEY (brand)
      REFERENCES brands(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,  
  CONSTRAINT fk_bead_size_id
    FOREIGN KEY (size)
      REFERENCES bead_sizes(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  CONSTRAINT fk_bead_material_id
    FOREIGN KEY (material)
      REFERENCES bead_materials(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  CONSTRAINT fk_bead_color_id
    FOREIGN KEY (color)
      REFERENCES colors(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  CONSTRAINT fk_bead_hole_id
    FOREIGN KEY (hole)
      REFERENCES bead_holes(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  CONSTRAINT fk_bead_shape_id
    FOREIGN KEY (shape)
      REFERENCES bead_shapes(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
  );

-- Populate
INSERT INTO species (species, description) VALUES 
  ('brown trout', 'Trout introduced in Minnesota by German immigrants in the 19th century'),
  ('brook trout', 'A Minnesota native trout that is a member of the char family'),
  ('rainbow trout', 'An introduced trout with no natural reproduction in Minnesota stream. Populatation maintained by stocking.'),
  ('tiger trout', 'Brown x brook trout hybrid. Extremely rare.');

INSERT INTO brands (brand, description) VALUES
  ('fire hole', 'Fire Hole'),
  ('hareline', 'Hareline Dubbin'),
  ('waspi', 'Waspi'),
  ('umpqua', 'Umpqua'),
  ('tiemco', 'Tiemco'),
  ('daiichi', 'Daiichi'),
  ('ahrex', 'Ahrex'),
  ('fulling mill', 'Fulling Mill'),
  ('kona', 'Kona'),
  ('hanak', 'Hanak'),
  ('mustad', 'Mustad'),
  ('cyclops', 'Cyclops');

INSERT INTO colors (color, description) VALUES
  ('gold', 'Metallic gold.'),
  ('silver', 'Metallic silver. Similiar, if not the same as, nickel.'),
  ('nickel', 'Metallic nickel. Similiar, if not the same as, silver.'),
  ('copper', 'Metallic copper.'),
  ('brass', 'Metallic brass. Similiar to gold.'),
  ('metallic black', 'Metallic black.'),
  ('black', 'Black -- gloss finish.'),
  ('matte black', 'Black -- matte finish.'),
  ('fl pink', 'Fluorescent pink -- gloss finish.');

INSERT INTO hook_lengths (value, description) VALUES
  ('2XS', '2x short'),
  ('1XS', '1x short'),
  ('0X', 'Standard'),
  ('1XL', '1x long'),
  ('2XL', '2x long'),
  ('3XL', '3x long'),
  ('4XL', '4x long'),
  ('6XL', '6x long');

INSERT INTO hook_weights (value, description) VALUES
  ('2XF', '2x fine'),
  ('1XF', '1x fine'),
  ('0X', 'Standard'),
  ('1XH', '1x heavy'),
  ('2XH', '2x heavy');

INSERT INTO hook_eyes (value, description) VALUES
  ('down', 'Down eye'),
  ('up', 'Up eye'),
  ('straight', 'Straight eye'),
  ('jig60', '60 degree jig'),
  ('jig90', '90 degree jig');


INSERT INTO hook_types (value, description) VALUES
  ('nymph','Commonly used for nymphs and wet flies, smaller sized suitable for some dry flies.'),
  ('dry fly', 'Thin wire hook appropriate for dry flies.'),
  ('scud', 'Curved shank imitates scud bodies and other nymphs/midges and dries.'),
  ('streamer', 'Longer shanked hooks perfect for streamers.');

INSERT INTO hook_shapes (value, description) VALUES
  ('round', 'Hood bend curves evenly from start of bend to the barb. Also known as the perfect or classic bend.'),
  ('sproat', 'Hook bend starts out gradaul with a sharper bend closer to the point.'),
  ('limeric', 'More agressive version of a sproat bend. Hook bend starts out gradaul with a sharper bend closer to the point.'); 

INSERT INTO hook_shanks (value, description) VALUES
  ('straight', 'Hook shank is straigh from eye to the start of the bend.'),
  ('curved', 'Hook bend curves from the eye to the start of bend.'),
  ('humped', 'Slightly curved shank from eye to the start of the bend.');

INSERT INTO hook_gapes (value, description) VALUES 
  ('0X', 'Standard'),
  ('1XG', '1x large gape'),
  ('2XG', '2x large gape'),
  ('stinger', 'Stinger gape');

INSERT INTO hook_sizes (value, description) VALUES
  ('28', 'Size 28'),
  ('26', 'Size 26'),
  ('24', 'Size 24'),
  ('22', 'Size 22'),
  ('20', 'Size 20'),
  ('18', 'Size 18'),
  ('16', 'Size 16'),
  ('14', 'Size 14'),
  ('12', 'Size 12'),
  ('10', 'Size 10'),
  ('8', 'Size 8'),
  ('6', 'Size 6'),
  ('4', 'Size 4'),
  ('2', 'Size 2'),
  ('1', 'Size 1');

INSERT INTO bead_sizes (value, description) VALUES
  ('1.5', 'Hook size 18-22'),
  ('1/16', 'Hook size 18-22'),
  ('2.0', 'Hook size 16-20'), 
  ('5/64', 'Hook size 16-20'),
  ('3/32', 'Hook size 14-18'),
  ('2.5', 'Hook size 14-18'),
  ('7/64', 'Hook size 12-16'),
  ('3.0', 'Hook size 10-14'),
  ('1/8', 'Hook size 10-14'),
  ('4.0', 'Hook size 8-12'),
  ('5/32', 'Hook size 8-12'),
  ('4.5', 'Hook size 6-10'),
  ('3/16', 'Hook size 6-10'),
  ('5.0', 'Hook size 4-8'),
  ('6.0', 'Hook size 4-8'),
  ('1/4', 'Hook size 4-8');

INSERT INTO bead_holes (value, description) VALUES
  ('counter sunk', 'Counter sunk hole.'),
  ('slotted', 'Slotted bead hole. Ideal for jig style hooks.');

INSERT INTO bead_materials (value, description) VALUES
  ('nickel', 'Standard bead material.'),
  ('brass', 'Brass bead material.'),
  ('tungsten', 'For heavier flies, particularly euro-style nymphs.'),
  ('glass', 'Glass bead. Adds the bead, but not the weight.');

INSERT INTO bead_shapes (value, description) VALUES
  ('round', 'Round bead.'),
  ('cone', 'Cone shaped bead.'),
  ('offset', 'Offset bead. Also known as bomb or insta-jig beads.'),
  ('barbell', 'Barbell bead for imitating eyes.'),
  ('sculpin', 'Scuplin imitation bead head'),
  ('bug', 'Generic insect imitation bead head');
