-- Handcrafted Haven (Supabase) seed data
--
-- Inserts the sample rows from `src/data/marketplace.ts`.
-- Safe to re-run: uses UPSERTs keyed by `id`.

begin;

-- Sellers
insert into public.sellers (id, name, location, specialty, bio, story, "avatarEmoji")
values
  ('s1', 'Lia Ceramics', 'Belo Horizonte, MG', 'Artistic ceramics',
    $seed$Functional and decorative pieces shaped and fired in small batches.$seed$,
    $seed$Lia turns local clay into collections inspired by organic forms. Every piece goes through hand shaping and glazes developed in her own studio.$seed$,
    '🏺'),
  ('s2', 'Trama Viva Studio', 'Florianopolis, SC', 'Weaving and macrame',
    $seed$Natural home textures made with responsibly sourced fibers.$seed$,
    $seed$At Trama Viva, Ana and Joana create textile pieces with recycled cotton and plant fibers. Their focus is to combine visual comfort with conscious production.$seed$,
    '🧶'),
  ('s3', 'Dourado Workshop', 'Salvador, BA', 'Metal and leather accessories',
    $seed$Durable accessories with hand-finished details and original design.$seed$,
    $seed$Dourado Workshop was born from the desire to craft everyday accessories with long-lasting materials and Brazilian identity.$seed$,
    '👜'),
  ('s4', 'Paper and Bloom', 'Curitiba, PR', 'Handmade stationery',
    $seed$Notebooks, cards, and gifts made with hand-binding techniques.$seed$,
    $seed$Using classic binding techniques, Paper and Bloom creates small collections for gifting and daily use, always with certified paper.$seed$,
    '📒')
on conflict (id) do update set
  name = excluded.name,
  location = excluded.location,
  specialty = excluded.specialty,
  bio = excluded.bio,
  story = excluded.story,
  "avatarEmoji" = excluded."avatarEmoji";

-- Products
insert into public.products (
  id,
  "sellerId",
  title,
  category,
  description,
  price,
  "imageEmoji",
  featured
)
values
  ('p1', 's1', 'Aurora Vase', 'Ceramics', $seed$Ceramic vase with matte glaze in earthy tones.$seed$, 189, '🏺', true),
  ('p2', 's2', 'Serra Macrame Wall Panel', 'Textile', $seed$Wall macrame panel made with natural fibers.$seed$, 229, '🧵', true),
  ('p3', 's3', 'Pathway Bag', 'Accessories', $seed$Plant-based leather bag with gold-tone hardware.$seed$, 319, '👜', true),
  ('p4', 's4', 'Botanical Notebook', 'Stationery', $seed$Hand-stitched notebook with textured paper cover.$seed$, 89, '📔', false),
  ('p5', 's1', 'Sun Plate', 'Ceramics', $seed$Hand-painted decorative plate, ideal for table centerpieces.$seed$, 142, '🍽️', false),
  ('p6', 's2', 'Valley Throw', 'Textile', $seed$Light throw made of recycled cotton for sofa or bed.$seed$, 259, '🧣', false),
  ('p7', 's3', 'Breeze Bracelet', 'Accessories', $seed$Handcrafted bracelet with leather and brushed metal clasp.$seed$, 74, '📿', false),
  ('p8', 's4', 'Earth Card Set', 'Stationery', $seed$Set of handmade cards for thoughtful messages.$seed$, 52, '💌', false),
  ('p9', 's2', 'Nest Cushion', 'Decor', $seed$Embroidered cushion with hypoallergenic filling.$seed$, 136, '🛋️', false)
on conflict (id) do update set
  "sellerId" = excluded."sellerId",
  title = excluded.title,
  category = excluded.category,
  description = excluded.description,
  price = excluded.price,
  "imageEmoji" = excluded."imageEmoji",
  featured = excluded.featured;

-- Reviews
insert into public.reviews (id, "productId", author, rating, comment)
values
  ('r1', 'p1', 'Carla M.', 5, $seed$Impeccable finish and very careful packaging.$seed$),
  ('r2', 'p1', 'Rafael N.', 4, $seed$Beautiful and exactly as shown in photos. Fast delivery.$seed$),
  ('r3', 'p2', 'Aline G.', 5, $seed$It made my living room so cozy. I loved it.$seed$),
  ('r4', 'p3', 'Patricia L.', 5, $seed$Excellent material, it feels like it will last for years.$seed$),
  ('r5', 'p6', 'Joao T.', 4, $seed$Very comfortable and a beautiful color combination.$seed$)
on conflict (id) do update set
  "productId" = excluded."productId",
  author = excluded.author,
  rating = excluded.rating,
  comment = excluded.comment;

commit;
