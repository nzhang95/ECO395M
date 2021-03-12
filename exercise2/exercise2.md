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
    ##            41487.00608             5860.79797               99.99712 
    ##             livingArea               bedrooms             fireplaces 
    ##               99.52556           -17195.51279             2975.06058 
    ##              bathrooms                  rooms heatinghot water/steam 
    ##            18204.09504             3225.16157            -7811.22263 
    ##        heatingelectric           fuelelectric                fueloil 
    ##             -278.99129           -14783.46990            -5335.25803 
    ##           centralAirNo 
    ##           -16055.13601

Now we use the step regression based on the above medium linear model,
and thus obtain the following best linear model with following
coeffecients.

    ##                         (Intercept)                             lotSize 
    ##                       -3.079211e+05                        5.386084e+05 
    ##                                 age                          livingArea 
    ##                       -9.143016e+02                       -2.750292e+02 
    ##                            bedrooms                          fireplaces 
    ##                        4.217782e+05                        1.962195e+04 
    ##                           bathrooms                               rooms 
    ##                       -2.301624e+05                        4.202919e+03 
    ##              heatinghot water/steam                     heatingelectric 
    ##                        4.880972e+05                        1.200215e+05 
    ##                        fuelelectric                             fueloil 
    ##                       -2.004888e+04                        9.785917e+04 
    ##                        centralAirNo                           landValue 
    ##                        7.776847e+03                        1.781175e+00 
    ##                        waterfrontNo                   newConstructionNo 
    ##                        2.512080e+05                        1.970285e+04 
    ##             livingArea:centralAirNo         landValue:newConstructionNo 
    ##                       -1.517502e+01                        5.250262e-01 
    ##                   lotSize:landValue    bathrooms:heatinghot water/steam 
    ##                       -2.587301e-01                       -1.463021e+03 
    ##           bathrooms:heatingelectric              landValue:waterfrontNo 
    ##                       -2.138488e+04                       -1.478660e+00 
    ##                fireplaces:landValue               livingArea:fireplaces 
    ##                       -5.062654e-01                        2.217874e+01 
    ##                 bedrooms:fireplaces             livingArea:fuelelectric 
    ##                       -1.198174e+04                        5.732905e-01 
    ##                  livingArea:fueloil           fuelelectric:centralAirNo 
    ##                       -3.402536e+01                        8.964022e+03 
    ##                fueloil:centralAirNo                    age:centralAirNo 
    ##                       -4.768382e+04                        7.734837e+02 
    ##               bedrooms:waterfrontNo             livingArea:waterfrontNo 
    ##                       -4.112208e+05                        3.513827e+02 
    ## heatinghot water/steam:waterfrontNo        heatingelectric:waterfrontNo 
    ##                       -4.567062e+05                       -6.883470e+04 
    ##                lotSize:waterfrontNo              bathrooms:waterfrontNo 
    ##                       -5.250383e+05                        2.638686e+05 
    ##                 bathrooms:landValue                  bedrooms:bathrooms 
    ##                        2.373328e-01                       -6.628027e+03 
    ##        rooms:heatinghot water/steam               rooms:heatingelectric 
    ##                       -5.071151e+03                       -1.731381e+03 
    ##                       age:landValue 
    ##                        2.387119e-03

The out-of-sample RMSE for the best linear model is 7.488332810^{4},
which indicates it significantly outperforms the medium linear model
whose RMSE is 7.506859110^{4}.

### B) K-nearest-neighbor regression model

![](exercise2_files/figure-markdown_strict/unnamed-chunk-7-1.png)

Now we begin to build the K-nearest-neighbor regression model. From the
RMSE plot, we find the optimal K obtained from training set is 14 with
RMSE 6.002868210^{4}.

Next, we do prediction using the optimal K, with RMSE 7.037762510^{4}.
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

We first build the baseline 1 model with RMSE 0.2708666.

    ##                  (Intercept)  market_segmentComplementary 
    ##                 -0.018689564                  0.085229185 
    ##      market_segmentCorporate         market_segmentDirect 
    ##                  0.014445069                  0.113788229 
    ##         market_segmentGroups  market_segmentOffline_TA/TO 
    ##                  0.006760946                  0.021157497 
    ##      market_segmentOnline_TA                       adults 
    ##                  0.080385295                  0.017317831 
    ##           customer_typeGroup       customer_typeTransient 
    ##                 -0.021882814                  0.015812779 
    ## customer_typeTransient-Party            is_repeated_guest 
    ##                 -0.010349016                 -0.044777538

We then build the baseline 1 model with RMSE 0.2348758.

    ##                        (Intercept)                  hotelResort_Hotel 
    ##                      -5.321609e-02                      -3.275777e-02 
    ##                          lead_time            stays_in_weekend_nights 
    ##                       4.028740e-05                       4.091913e-03 
    ##               stays_in_week_nights                             adults 
    ##                      -8.112112e-04                      -3.848536e-02 
    ##                             mealFB                             mealHB 
    ##                       3.833994e-02                       3.421470e-03 
    ##                             mealSC                      mealUndefined 
    ##                      -5.284811e-02                       1.731572e-02 
    ##        market_segmentComplementary            market_segmentCorporate 
    ##                       5.327489e-02                       4.573661e-02 
    ##               market_segmentDirect               market_segmentGroups 
    ##                       4.968880e-02                       5.932967e-02 
    ##        market_segmentOffline_TA/TO            market_segmentOnline_TA 
    ##                       7.126137e-02                       6.629527e-02 
    ##         distribution_channelDirect            distribution_channelGDS 
    ##                       1.670730e-02                      -7.560776e-02 
    ##          distribution_channelTA/TO                  is_repeated_guest 
    ##                      -5.486575e-04                      -3.258560e-02 
    ##             previous_cancellations     previous_bookings_not_canceled 
    ##                       1.062283e-03                      -2.122318e-03 
    ##                reserved_room_typeB                reserved_room_typeC 
    ##                       2.036527e-01                       5.241857e-01 
    ##                reserved_room_typeD                reserved_room_typeE 
    ##                      -6.411836e-02                      -2.700074e-02 
    ##                reserved_room_typeF                reserved_room_typeG 
    ##                       2.978912e-01                       4.241075e-01 
    ##                reserved_room_typeH                reserved_room_typeL 
    ##                       6.351878e-01                      -1.583972e-01 
    ##                assigned_room_typeB                assigned_room_typeC 
    ##                       1.401534e-02                       1.014176e-01 
    ##                assigned_room_typeD                assigned_room_typeE 
    ##                       5.543141e-02                       5.068273e-02 
    ##                assigned_room_typeF                assigned_room_typeG 
    ##                       7.362057e-02                       1.004805e-01 
    ##                assigned_room_typeH                assigned_room_typeI 
    ##                       4.783557e-02                       7.683199e-02 
    ##                assigned_room_typeK                    booking_changes 
    ##                       2.575514e-02                       2.102034e-02 
    ##             deposit_typeNon_Refund             deposit_typeRefundable 
    ##                       3.064488e-02                       9.155786e-03 
    ##               days_in_waiting_list                 customer_typeGroup 
    ##                      -1.032501e-06                      -8.487175e-03 
    ##             customer_typeTransient       customer_typeTransient-Party 
    ##                       9.794048e-03                      -3.229576e-02 
    ##                 average_daily_rate required_car_parking_spacesparking 
    ##                       8.617116e-04                       6.458049e-04 
    ##          total_of_special_requests 
    ##                       3.280280e-02

We finally build the baseline 3 model with RMSE 0.2340863, including
features extracted from arrival\_date.

    ##                    (Intercept)              hotelResort_Hotel 
    ##                  -6.180911e-03                  -3.404555e-02 
    ##                      lead_time                         adults 
    ##                   7.526306e-05                  -4.290827e-02 
    ##                         mealFB                         mealHB 
    ##                   2.085967e-02                  -1.221841e-03 
    ##                         mealSC                  mealUndefined 
    ##                  -5.143128e-02                   1.351790e-03 
    ##    market_segmentComplementary        market_segmentCorporate 
    ##                   4.898301e-02                   3.287887e-02 
    ##           market_segmentDirect           market_segmentGroups 
    ##                   3.842810e-02                   5.430037e-02 
    ##    market_segmentOffline_TA/TO        market_segmentOnline_TA 
    ##                   6.482037e-02                   5.588677e-02 
    ##     distribution_channelDirect        distribution_channelGDS 
    ##                   1.084925e-02                  -7.517264e-02 
    ##      distribution_channelTA/TO              is_repeated_guest 
    ##                  -7.035219e-03                  -3.122302e-02 
    ## previous_bookings_not_canceled            reserved_room_typeB 
    ##                  -2.070935e-03                   1.857482e-01 
    ##            reserved_room_typeC            reserved_room_typeD 
    ##                   5.148590e-01                  -6.192290e-02 
    ##            reserved_room_typeE            reserved_room_typeF 
    ##                  -2.943065e-02                   2.901312e-01 
    ##            reserved_room_typeG            reserved_room_typeH 
    ##                   4.142466e-01                   6.189065e-01 
    ##            reserved_room_typeL            assigned_room_typeB 
    ##                  -1.782445e-01                   2.017050e-02 
    ##            assigned_room_typeC            assigned_room_typeD 
    ##                   1.072600e-01                   5.373428e-02 
    ##            assigned_room_typeE            assigned_room_typeF 
    ##                   5.317294e-02                   7.884377e-02 
    ##            assigned_room_typeG            assigned_room_typeH 
    ##                   1.079820e-01                   6.281782e-02 
    ##            assigned_room_typeI            assigned_room_typeK 
    ##                   7.780975e-02                   2.803573e-02 
    ##                booking_changes             customer_typeGroup 
    ##                   2.096284e-02                  -1.551738e-02 
    ##         customer_typeTransient   customer_typeTransient-Party 
    ##                  -1.157098e-03                  -4.264810e-02 
    ##             average_daily_rate      total_of_special_requests 
    ##                   9.148119e-04                   3.299239e-02 
    ##                  arrival_wday2                  arrival_wday3 
    ##                  -6.847348e-03                  -1.128396e-02 
    ##                  arrival_wday4                  arrival_wday5 
    ##                  -1.334251e-02                  -7.448108e-03 
    ##                  arrival_wday6                  arrival_wday7 
    ##                  -1.450986e-02                   4.999042e-03 
    ##                 arrival_month2                 arrival_month3 
    ##                   2.224462e-02                  -9.995199e-04 
    ##                 arrival_month4                 arrival_month5 
    ##                   4.483304e-04                  -3.951307e-02 
    ##                 arrival_month6                 arrival_month7 
    ##                  -3.852576e-02                   1.562686e-02 
    ##                 arrival_month8                 arrival_month9 
    ##                   7.703626e-03                  -4.876552e-02 
    ##                arrival_month10                arrival_month11 
    ##                  -2.806660e-02                  -2.696330e-02 
    ##                arrival_month12               arrival_year2016 
    ##                   6.493715e-03                   6.495256e-03 
    ##               arrival_year2017 
    ##                  -1.161750e-02

### B) Model validation: step 1

In step 1, we plot ROC curves for the three model using dataset
hotels\_dev, with threshold varys from 0 to 1. Those curves indicate
that linear model and baseline 2 are significantly better than baseline
1.

![](exercise2_files/figure-markdown_strict/unnamed-chunk-15-1.png)

### C) Model validation: step 2

In step 2, we create 20 folds of hotels\_Val, predict whether each
booking will have children on it using above 3 model, and compare
predictions. The threshold is set as 0.41, which is determinted by
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
<td style="text-align: right;">0.064257</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0441767</td>
<td style="text-align: right;">0.0361446</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.116000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0440000</td>
<td style="text-align: right;">0.0520000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.096000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0840000</td>
<td style="text-align: right;">0.0880000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.096000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0400000</td>
<td style="text-align: right;">0.0400000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.044000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0480000</td>
<td style="text-align: right;">0.0440000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.100000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0680000</td>
<td style="text-align: right;">0.0640000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.080000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0440000</td>
<td style="text-align: right;">0.0440000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.072000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0640000</td>
<td style="text-align: right;">0.0640000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.076000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0680000</td>
<td style="text-align: right;">0.0680000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.060000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0440000</td>
<td style="text-align: right;">0.0440000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.096000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0560000</td>
<td style="text-align: right;">0.0480000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.072000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0680000</td>
<td style="text-align: right;">0.0640000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.080000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0400000</td>
<td style="text-align: right;">0.0440000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.088000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0560000</td>
<td style="text-align: right;">0.0560000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.072000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0560000</td>
<td style="text-align: right;">0.0480000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.096000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0560000</td>
<td style="text-align: right;">0.0560000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.056000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0280000</td>
<td style="text-align: right;">0.0240000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.060000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0800000</td>
<td style="text-align: right;">0.0800000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.104000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0560000</td>
<td style="text-align: right;">0.0520000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.080000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0400000</td>
<td style="text-align: right;">0.0400000</td>
</tr>
</tbody>
</table>
