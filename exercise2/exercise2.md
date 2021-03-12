1) Visualization
----------------

### A) One panel of line graphs that plots average boardings grouped by hour of the day, day of week, and month.

![](exercise2_files/figure-markdown_strict/unnamed-chunk-2-1.png)

The panel of line graphs show that the hour of peak boardings change
according to weekdays and weekends. Specifially, the boardings on
weekdays share the same pattern, which is unimodal at 17:00. By
contrast, the boradings on weekdends are much more flat.

We can also find some month-specific insights from the graphs. For
example, average boardings on Mondays in September look lower.
Similarly, average boardings on Weds/Thurs/Fri in November also look
lower. Those insights can be illustrated by holidays, i.e., Labor day in
September and Thanksgiving in November. On holidays, most people don’t
need to go to work, and it causes the reduction in the daily boarding.

### B) One panel of scatter plots showing boardings (y) vs. Nch 15-minute window, faceted by hour of the day, and with points colored in according to whether it is a weekday or weekend.

![](exercise2_files/figure-markdown_strict/unnamed-chunk-3-1.png)

The panel of scatter plots show the relationship between boardings and
temperature. Compared to the weekday boardings, boardings on weekends
seems less when the temperature is low, given the hour of day kept
constant. However, the effect is not significant, and we also need to
notice that the sample on weekends are not enough to support stong
argument that involves mutiple factors.

2) Saratoga house prices
------------------------

### A) Linear model

Recall the medium linear model in class, coefficients can be expressed
as follows.

    ##            (Intercept)                lotSize                    age 
    ##            39358.65735            10735.11845              100.08182 
    ##             livingArea               bedrooms             fireplaces 
    ##               95.02456           -16959.98157             3223.60053 
    ##              bathrooms                  rooms heatinghot water/steam 
    ##            19741.85680             4082.97581           -10999.28657 
    ##        heatingelectric           fuelelectric                fueloil 
    ##            -1276.15851           -14333.51916            -7247.44858 
    ##           centralAirNo 
    ##           -17555.49157

Now we use the step regression based on the above medium linear model,
and thus obtain the following best linear model with following
coeffecients.

    ##                    (Intercept)                        lotSize 
    ##                   2.371179e+05                   1.458142e+04 
    ##                            age                     livingArea 
    ##                  -2.711779e+03                  -2.043311e+02 
    ##                       bedrooms                     fireplaces 
    ##                   1.483077e+05                   1.842884e+05 
    ##                      bathrooms                          rooms 
    ##                   1.390831e+04                   3.255899e+03 
    ##         heatinghot water/steam                heatingelectric 
    ##                   1.188573e+04                   1.415302e+04 
    ##                   fuelelectric                        fueloil 
    ##                  -1.849719e+04                   1.020640e+03 
    ##                   centralAirNo                      landValue 
    ##                   1.000513e+04                   5.038943e-01 
    ##                   waterfrontNo              newConstructionNo 
    ##                  -2.443776e+05                   1.394588e+04 
    ##    landValue:newConstructionNo        livingArea:centralAirNo 
    ##                   4.721848e-01                  -1.465747e+01 
    ##           fireplaces:landValue          livingArea:fireplaces 
    ##                  -6.421607e-01                   2.333602e+01 
    ##        fireplaces:waterfrontNo        livingArea:waterfrontNo 
    ##                  -1.732453e+05                   2.739875e+02 
    ##          bedrooms:waterfrontNo         fuelelectric:landValue 
    ##                  -1.482659e+05                   3.211936e-01 
    ##              fueloil:landValue      fuelelectric:centralAirNo 
    ##                  -4.297839e-01                   1.630191e+04 
    ##           fueloil:centralAirNo               age:waterfrontNo 
    ##                  -4.050577e+04                   2.069557e+03 
    ##               age:centralAirNo        livingArea:fuelelectric 
    ##                   5.497039e+02                   3.513150e-01 
    ##             livingArea:fueloil      fuelelectric:waterfrontNo 
    ##                  -2.167577e+01                  -1.054239e+04 
    ##           fueloil:waterfrontNo            bedrooms:fireplaces 
    ##                   7.721434e+04                  -8.014384e+03 
    ##            bathrooms:landValue                  age:landValue 
    ##                   3.352806e-01                   4.628364e-03 
    ## lotSize:heatinghot water/steam        lotSize:heatingelectric 
    ##                   2.351513e+04                  -6.997711e+02 
    ##             lotSize:fireplaces             bedrooms:landValue 
    ##                  -7.778659e+03                  -1.170336e-01 
    ##                    lotSize:age                  lotSize:rooms 
    ##                  -2.123502e+02                   2.322407e+03 
    ##              lotSize:bathrooms   rooms:heatinghot water/steam 
    ##                  -9.205056e+03                  -4.843031e+03 
    ##          rooms:heatingelectric 
    ##                  -2.183342e+03

The out-of-sample RMSE for the best linear model is 5.709928610^{4},
which indicates it significantly outperforms the medium linear model
whose RMSE is 6.69228910^{4}.

### B) K-nearest-neighbor regression model

![](exercise2_files/figure-markdown_strict/unnamed-chunk-7-1.png)

Now we begin to build the K-nearest-neighbor regression model. From the
RMSE plot, we find the optimal K obtained from training set is 8 with
RMSE 6.286918510^{4}.

Next, we do prediction using the optimal K, with RMSE 5.757266810^{4}.
The KNN model seems to have similar performance on
achievingout-of-sample mean-squared error compared to linear model. The
reason behind may be that the price doesn’t not have a clear linear
relationship with other factors, and thus linear model fails to
outperform than KNN model.

3) Classification and retrospective sampling
--------------------------------------------

![](exercise2_files/figure-markdown_strict/unnamed-chunk-9-1.png)

We first make a bar plot of default probability by credit history. As
depicited in the figure, borrowers with good history have a significant
higher default probability, while borrowers with terrible history have a
significant lower default probability.

    ##         (Intercept)            duration              amount         installment 
    ##       -7.075258e-01        2.525834e-02        9.596288e-05        2.216019e-01 
    ##                 age         historypoor     historyterrible          purposeedu 
    ##       -2.018401e-02       -1.107586e+00       -1.884675e+00        7.247898e-01 
    ## purposegoods/repair       purposenewcar      purposeusedcar       foreigngerman 
    ##        1.049037e-01        8.544560e-01       -7.959260e-01       -1.264676e+00

We then build a logistic regression model using the variables duration,
amount, installment, age, history, propose and foreign. We notice that
history and foreign are two deterministic factors in the logistric
regression model. However, we need to note that the dataset is highly
unbalanced. As a major factor, the data with good history only accounts
for 8% of the dataset. Therefore, the dataset is not appropriate for
building a predictive model of defaults. The bank need to resample to
create a dataset with credit history factor evenly-distributed in good,
poor and terrible.

4) Children and hotel reservations
----------------------------------

### A) Model building

We first build the baseline 1 model with RMSE 0.266625.

    ##                  (Intercept)  market_segmentComplementary 
    ##                 -0.020625518                  0.090271588 
    ##      market_segmentCorporate         market_segmentDirect 
    ##                  0.013441989                  0.115799024 
    ##         market_segmentGroups  market_segmentOffline_TA/TO 
    ##                  0.006471694                  0.022072111 
    ##      market_segmentOnline_TA                       adults 
    ##                  0.080835935                  0.016975340 
    ##           customer_typeGroup       customer_typeTransient 
    ##                 -0.017348344                  0.018129254 
    ## customer_typeTransient-Party            is_repeated_guest 
    ##                 -0.007817164                 -0.042165453

We then build the baseline 1 model with RMSE 0.2317826.

    ##                        (Intercept)                  hotelResort_Hotel 
    ##                      -6.506453e-02                      -3.388670e-02 
    ##                          lead_time            stays_in_weekend_nights 
    ##                       3.082275e-05                       4.667454e-03 
    ##               stays_in_week_nights                             adults 
    ##                      -3.161816e-04                      -3.933953e-02 
    ##                             mealFB                             mealHB 
    ##                       1.865732e-02                       1.873441e-03 
    ##                             mealSC                      mealUndefined 
    ##                      -5.328223e-02                       2.103112e-02 
    ##        market_segmentComplementary            market_segmentCorporate 
    ##                       6.782503e-02                       4.999491e-02 
    ##               market_segmentDirect               market_segmentGroups 
    ##                       5.443911e-02                       6.268574e-02 
    ##        market_segmentOffline_TA/TO            market_segmentOnline_TA 
    ##                       7.407668e-02                       6.722149e-02 
    ##         distribution_channelDirect            distribution_channelGDS 
    ##                       1.814907e-02                      -7.238348e-02 
    ##          distribution_channelTA/TO                  is_repeated_guest 
    ##                       2.828434e-03                      -3.150484e-02 
    ##             previous_cancellations     previous_bookings_not_canceled 
    ##                       6.363709e-04                      -2.191993e-03 
    ##                reserved_room_typeB                reserved_room_typeC 
    ##                       2.358578e-01                       5.470497e-01 
    ##                reserved_room_typeD                reserved_room_typeE 
    ##                      -6.859883e-02                      -2.326734e-02 
    ##                reserved_room_typeF                reserved_room_typeG 
    ##                       3.000435e-01                       4.353515e-01 
    ##                reserved_room_typeH                reserved_room_typeL 
    ##                       5.473498e-01                      -2.215931e-02 
    ##                assigned_room_typeB                assigned_room_typeC 
    ##                       8.551638e-03                       9.039763e-02 
    ##                assigned_room_typeD                assigned_room_typeE 
    ##                       6.009274e-02                       4.639133e-02 
    ##                assigned_room_typeF                assigned_room_typeG 
    ##                       6.365142e-02                       9.240518e-02 
    ##                assigned_room_typeH                assigned_room_typeI 
    ##                       1.152784e-01                       9.392410e-02 
    ##                assigned_room_typeK                    booking_changes 
    ##                       3.280336e-02                       1.900105e-02 
    ##             deposit_typeNon_Refund             deposit_typeRefundable 
    ##                       3.241135e-02                       3.359746e-02 
    ##               days_in_waiting_list                 customer_typeGroup 
    ##                      -1.382975e-05                      -2.532230e-03 
    ##             customer_typeTransient       customer_typeTransient-Party 
    ##                       1.398069e-02                      -2.830991e-02 
    ##                 average_daily_rate required_car_parking_spacesparking 
    ##                       9.048462e-04                       1.860900e-03 
    ##          total_of_special_requests 
    ##                       3.335135e-02

We finally build the baseline 3 model with RMSE 0.23057, including
features extracted from arrival\_date.

    ##                    (Intercept)              hotelResort_Hotel 
    ##                  -2.287024e-02                  -3.531073e-02 
    ##                      lead_time           stays_in_week_nights 
    ##                   6.200331e-05                   1.164492e-03 
    ##                         adults                         mealFB 
    ##                  -4.368388e-02                   7.589183e-04 
    ##                         mealHB                         mealSC 
    ##                  -2.756539e-03                  -5.207352e-02 
    ##                  mealUndefined    market_segmentComplementary 
    ##                   3.703382e-03                   6.787128e-02 
    ##        market_segmentCorporate           market_segmentDirect 
    ##                   4.195643e-02                   4.654347e-02 
    ##           market_segmentGroups    market_segmentOffline_TA/TO 
    ##                   6.306948e-02                   7.196578e-02 
    ##        market_segmentOnline_TA     distribution_channelDirect 
    ##                   6.192101e-02                   1.335632e-02 
    ##        distribution_channelGDS      distribution_channelTA/TO 
    ##                  -7.326842e-02                  -3.869643e-03 
    ##              is_repeated_guest previous_bookings_not_canceled 
    ##                  -3.009035e-02                  -2.162334e-03 
    ##            reserved_room_typeB            reserved_room_typeC 
    ##                   2.177554e-01                   5.351308e-01 
    ##            reserved_room_typeD            reserved_room_typeE 
    ##                  -6.678254e-02                  -2.659489e-02 
    ##            reserved_room_typeF            reserved_room_typeG 
    ##                   2.924893e-01                   4.260768e-01 
    ##            reserved_room_typeH            reserved_room_typeL 
    ##                   5.333480e-01                  -4.621305e-02 
    ##            assigned_room_typeB            assigned_room_typeC 
    ##                   1.489594e-02                   9.657584e-02 
    ##            assigned_room_typeD            assigned_room_typeE 
    ##                   5.867880e-02                   4.995231e-02 
    ##            assigned_room_typeF            assigned_room_typeG 
    ##                   6.847635e-02                   9.943024e-02 
    ##            assigned_room_typeH            assigned_room_typeI 
    ##                   1.301597e-01                   9.669155e-02 
    ##            assigned_room_typeK                booking_changes 
    ##                   3.422219e-02                   1.886834e-02 
    ##             customer_typeGroup         customer_typeTransient 
    ##                  -9.229443e-03                   3.961882e-03 
    ##   customer_typeTransient-Party             average_daily_rate 
    ##                  -3.768601e-02                   9.534779e-04 
    ##      total_of_special_requests                  arrival_wday2 
    ##                   3.336430e-02                  -5.302359e-03 
    ##                  arrival_wday3                  arrival_wday4 
    ##                  -1.142600e-02                  -1.251360e-02 
    ##                  arrival_wday5                  arrival_wday6 
    ##                  -6.677058e-03                  -1.116392e-02 
    ##                  arrival_wday7                 arrival_month2 
    ##                   5.407345e-03                   2.210810e-02 
    ##                 arrival_month3                 arrival_month4 
    ##                  -4.465004e-03                  -3.919675e-03 
    ##                 arrival_month5                 arrival_month6 
    ##                  -4.070036e-02                  -3.669845e-02 
    ##                 arrival_month7                 arrival_month8 
    ##                   1.154361e-02                   7.216384e-03 
    ##                 arrival_month9                arrival_month10 
    ##                  -5.116316e-02                  -2.883306e-02 
    ##                arrival_month11                arrival_month12 
    ##                  -2.924985e-02                   6.025032e-03 
    ##               arrival_year2016               arrival_year2017 
    ##                   4.842297e-03                  -1.006436e-02

### B) Model validation: step 1

In step 1, we plot ROC curves for the three model using dataset
hotels\_dev, with threshold varys from 0 to 1. Those curves indicate
that linear model and baseline 2 are significantly better than baseline
1.

![](exercise2_files/figure-markdown_strict/unnamed-chunk-15-1.png)

### C) Model validation: step 2

In step 2, we create 20 folds of hotels\_Val, predict whether each
booking will have children on it using above 3 model, and compare
predictions. The threshold is set as 1, which is determinted by
maximizing the F1 score. We can find that baseline 2 and linear model
behave similarly, but there are still gaps between predictions and true
value.

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 26%" />
<col style="width: 26%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">True Probability</th>
<th style="text-align: right;">Predicted Probability 1</th>
<th style="text-align: right;">Predicted Probability 2</th>
<th style="text-align: right;">Predicted Probability 3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">0.0682731</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0441767</td>
<td style="text-align: right;">0.0441767</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0800000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0520000</td>
<td style="text-align: right;">0.0520000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0800000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0600000</td>
<td style="text-align: right;">0.0560000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.1080000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0680000</td>
<td style="text-align: right;">0.0640000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0480000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0520000</td>
<td style="text-align: right;">0.0480000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0840000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0640000</td>
<td style="text-align: right;">0.0640000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0640000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0640000</td>
<td style="text-align: right;">0.0600000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0840000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0680000</td>
<td style="text-align: right;">0.0640000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0520000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0280000</td>
<td style="text-align: right;">0.0200000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0960000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0760000</td>
<td style="text-align: right;">0.0760000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0840000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0480000</td>
<td style="text-align: right;">0.0480000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.1080000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0720000</td>
<td style="text-align: right;">0.0720000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.1000000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0400000</td>
<td style="text-align: right;">0.0400000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0880000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0720000</td>
<td style="text-align: right;">0.0720000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0840000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0640000</td>
<td style="text-align: right;">0.0640000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0440000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0360000</td>
<td style="text-align: right;">0.0360000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0840000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0480000</td>
<td style="text-align: right;">0.0480000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0880000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0400000</td>
<td style="text-align: right;">0.0320000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0920000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0480000</td>
<td style="text-align: right;">0.0520000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0720000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0400000</td>
<td style="text-align: right;">0.0400000</td>
</tr>
</tbody>
</table>
