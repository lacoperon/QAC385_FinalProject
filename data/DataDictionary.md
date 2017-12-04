# Data Dictionary

## train.tsv, test.tsv

The files consist of a list of product listings. These files are tab-delimited.

- `train_id` or `test_id` - the id of the listing
- `name` - the title of the listing. Note that we have cleaned the data to remove text that look like prices (e.g. $20) to avoid leakage. These removed prices are represented as `[rm]`
- `item_condition_id` - the condition of the items provided by the seller
- `category_name` - category of the listing
- `brand_name`
- `price` - the price that the item was sold for. This is the target variable that you will predict. The unit is USD. This column doesn't exist in `test.tsv` since that is what you will predict.
- `shipping` - 1 if shipping fee is paid by seller and 0 by buyer
- `item_description` - the full description of the item. Note that we have cleaned the data to remove text that look like prices (e.g. $20) to avoid leakage. These removed prices are represented as `[rm]`

Please note that in stage 1, all the test data will be calculated on the public leaderboard. In stage 2, we will swap the `test.tsv` file to the complete test dataset that includes the private leaderboard data.