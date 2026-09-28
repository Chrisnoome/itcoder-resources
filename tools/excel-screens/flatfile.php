<?php
/**
 * Writes work/flatfile.json: the tuck shop's first nine sales and sale 18 as
 * one flat sheet (Sale, Date, Product, Category, Price, Qty), straight from
 * the platform's tuck shop (content/sql/db/tuckshop.php), for flatfile.ps1.
 *
 * Two slips are made on purpose, for SQL lesson A2's "Why not a
 * spreadsheet?" activity (Chris, 28 September 2026): sale 9's price was
 * changed to 30 and the other mince pie rows were missed, and sale 18 says
 * "Mince Pei".
 */

$site  = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse';
$db    = require $site . '/content/sql/db/tuckshop.php';
$items = [];

foreach ($db['tables']['tblProducts']['rows'] as $product)
    $items[$product[0]] = $product;

$rows = [];

foreach ($db['tables']['tblSales']['rows'] as [$saleId, $productId, $quantity, $date])
{
    if ($saleId > 9 && $saleId !== 18)
        continue;

    [, $name, $category, $price] = $items[$productId];

    if ($saleId === 9)  $price = 30.00;         // the price change that missed two rows
    if ($saleId === 18) $name  = 'Mince Pei';   // the spelling slip

    $rows[] = [$saleId, str_replace ('-', '/', $date), $name, $category, $price, $quantity];
} // foreach sale

$json = json_encode (['header' => ['Sale', 'Date', 'Product', 'Category', 'Price', 'Qty'], 'rows' => $rows], JSON_PRETTY_PRINT);

@mkdir (__DIR__ . '/work');
file_put_contents (__DIR__ . '/work/flatfile.json', $json);
echo count ($rows) . " rows -> work/flatfile.json\n";
