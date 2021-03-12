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
    ##            46014.15143             9767.13805               60.43203 
    ##             livingArea               bedrooms             fireplaces 
    ##               91.78518           -15273.77998            -2666.06880 
    ##              bathrooms                  rooms heatinghot water/steam 
    ##            21529.36649             3541.69653            -8099.26582 
    ##        heatingelectric           fuelelectric                fueloil 
    ##           -10688.35594            -6732.27755           -12355.24496 
    ##           centralAirNo 
    ##           -19073.55099

Now we use the step regression based on the above medium linear model,
and thus obtain the following best linear model with following
coeffecients.

    ##                         (Intercept)                             lotSize 
    ##                        4.768670e+04                       -1.121908e+05 
    ##                                 age                          livingArea 
    ##                       -8.733498e+02                       -2.190279e+02 
    ##                            bedrooms                          fireplaces 
    ##                        1.405834e+03                        1.878130e+05 
    ##                           bathrooms                               rooms 
    ##                        1.103304e+05                        7.044231e+04 
    ##              heatinghot water/steam                     heatingelectric 
    ##                        2.839376e+05                        1.531749e+05 
    ##                        fuelelectric                             fueloil 
    ##                       -1.913340e+04                        1.407392e+05 
    ##                        centralAirNo                           landValue 
    ##                        3.390057e+04                       -1.016304e+00 
    ##                        waterfrontNo                   newConstructionNo 
    ##                       -5.174835e+04                       -9.528588e+03 
    ##         landValue:newConstructionNo             livingArea:fuelelectric 
    ##                        7.997041e-01                        3.306088e+00 
    ##                  livingArea:fueloil              landValue:waterfrontNo 
    ##                       -3.411370e+01                        1.123849e+00 
    ##                fireplaces:landValue             livingArea:centralAirNo 
    ##                       -5.649939e-01                       -1.550164e+01 
    ##                   lotSize:landValue           fuelelectric:centralAirNo 
    ##                       -2.852084e-01                        1.568513e+04 
    ##                fueloil:centralAirNo                       lotSize:rooms 
    ##                       -5.954592e+04                        2.190240e+03 
    ##                    age:centralAirNo        rooms:heatinghot water/steam 
    ##                        6.728969e+02                       -5.644829e+03 
    ##               rooms:heatingelectric             fireplaces:waterfrontNo 
    ##                       -1.087060e+03                       -1.072910e+05 
    ##                lotSize:waterfrontNo                 bathrooms:landValue 
    ##                        1.154138e+05                        2.399888e-01 
    ##                       age:landValue                 bedrooms:fireplaces 
    ##                        4.919513e-03                       -1.530855e+04 
    ##               livingArea:fireplaces        fireplaces:newConstructionNo 
    ##                        1.368720e+01                       -3.966422e+04 
    ##              bathrooms:fuelelectric                   bathrooms:fueloil 
    ##                       -1.750808e+04                       -2.106310e+04 
    ##              bathrooms:waterfrontNo             livingArea:waterfrontNo 
    ##                       -1.421985e+05                        3.280733e+02 
    ##                  rooms:waterfrontNo heatinghot water/steam:waterfrontNo 
    ##                       -6.697146e+04                       -2.465950e+05 
    ##        heatingelectric:waterfrontNo              fuelelectric:landValue 
    ##                       -1.269274e+05                        1.435707e+00 
    ##                   fueloil:landValue    heatinghot water/steam:landValue 
    ##                       -1.895791e-01                       -1.970392e-01 
    ##           heatingelectric:landValue         bathrooms:newConstructionNo 
    ##                       -1.205217e+00                        4.927943e+04 
    ##      centralAirNo:newConstructionNo        livingArea:newConstructionNo 
    ##                       -2.493956e+04                       -3.259320e+01

The out-of-sample RMSE for the best linear model is 6.455404110^{4},
which indicates it significantly outperforms the medium linear model
whose RMSE is 6.812090110^{4}.

### B) K-nearest-neighbor regression model

![](exercise2_files/figure-markdown_strict/unnamed-chunk-7-1.png)

Now we begin to build the K-nearest-neighbor regression model. From the
RMSE plot, we find the optimal K obtained from training set is 8 with
RMSE 6.059018410^{4}.

Next, we do prediction using the optimal K, with RMSE 6.682439910^{4}.
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

We first build the baseline 1 model with RMSE 0.2684381.

    ##                  (Intercept)  market_segmentComplementary 
    ##                  -0.02531083                   0.07436734 
    ##      market_segmentCorporate         market_segmentDirect 
    ##                   0.01499826                   0.11163456 
    ##         market_segmentGroups  market_segmentOffline_TA/TO 
    ##                   0.01027402                   0.02448492 
    ##      market_segmentOnline_TA                       adults 
    ##                   0.07994469                   0.01911658 
    ##           customer_typeGroup       customer_typeTransient 
    ##                  -0.01455807                   0.01941276 
    ## customer_typeTransient-Party            is_repeated_guest 
    ##                  -0.01032236                  -0.03927724

We then build the baseline 1 model with RMSE 0.2338721.

    ##                        (Intercept)                  hotelResort_Hotel 
    ##                      -5.711038e-02                      -3.470843e-02 
    ##                          lead_time            stays_in_weekend_nights 
    ##                       4.744390e-05                       3.056381e-03 
    ##               stays_in_week_nights                             adults 
    ##                      -8.978911e-04                      -3.749122e-02 
    ##                             mealFB                             mealHB 
    ##                       5.007105e-02                      -5.206145e-04 
    ##                             mealSC                      mealUndefined 
    ##                      -5.436529e-02                       3.172464e-02 
    ##        market_segmentComplementary            market_segmentCorporate 
    ##                       4.706004e-02                       4.667838e-02 
    ##               market_segmentDirect               market_segmentGroups 
    ##                       5.055139e-02                       6.096289e-02 
    ##        market_segmentOffline_TA/TO            market_segmentOnline_TA 
    ##                       7.286083e-02                       6.433929e-02 
    ##         distribution_channelDirect            distribution_channelGDS 
    ##                       1.640792e-02                      -7.187363e-02 
    ##          distribution_channelTA/TO                  is_repeated_guest 
    ##                       1.181646e-03                      -2.828175e-02 
    ##             previous_cancellations     previous_bookings_not_canceled 
    ##                       1.077941e-03                      -2.305524e-03 
    ##                reserved_room_typeB                reserved_room_typeC 
    ##                       1.946637e-01                       5.525840e-01 
    ##                reserved_room_typeD                reserved_room_typeE 
    ##                      -6.587815e-02                      -2.813011e-02 
    ##                reserved_room_typeF                reserved_room_typeG 
    ##                       3.054590e-01                       4.171038e-01 
    ##                reserved_room_typeH                reserved_room_typeL 
    ##                       6.101676e-01                      -8.463921e-02 
    ##                assigned_room_typeB                assigned_room_typeC 
    ##                       2.362836e-02                       8.829789e-02 
    ##                assigned_room_typeD                assigned_room_typeE 
    ##                       5.913836e-02                       5.392233e-02 
    ##                assigned_room_typeF                assigned_room_typeG 
    ##                       6.340718e-02                       1.013804e-01 
    ##                assigned_room_typeH                assigned_room_typeI 
    ##                       7.760483e-02                       9.724079e-02 
    ##                assigned_room_typeK                    booking_changes 
    ##                       1.410161e-02                       2.080158e-02 
    ##             deposit_typeNon_Refund             deposit_typeRefundable 
    ##                       3.351305e-02                       2.103113e-02 
    ##               days_in_waiting_list                 customer_typeGroup 
    ##                      -6.049736e-05                      -5.449922e-03 
    ##             customer_typeTransient       customer_typeTransient-Party 
    ##                       1.175013e-02                      -3.348658e-02 
    ##                 average_daily_rate required_car_parking_spacesparking 
    ##                       8.736150e-04                      -6.606695e-04 
    ##          total_of_special_requests 
    ##                       3.303487e-02

We finally build the baseline 3 model with RMSE 0.2326119, including
features extracted from arrival\_date.

    ##                    (Intercept)              hotelResort_Hotel 
    ##                  -1.416226e-02                  -3.622535e-02 
    ##                      lead_time                         adults 
    ##                   8.148413e-05                  -4.177432e-02 
    ##                         mealFB                         mealHB 
    ##                   3.193765e-02                  -5.242662e-03 
    ##                         mealSC                  mealUndefined 
    ##                  -5.252094e-02                   1.533136e-02 
    ##    market_segmentComplementary        market_segmentCorporate 
    ##                   4.472275e-02                   3.422156e-02 
    ##           market_segmentDirect           market_segmentGroups 
    ##                   3.903954e-02                   5.607222e-02 
    ##    market_segmentOffline_TA/TO        market_segmentOnline_TA 
    ##                   6.642447e-02                   5.459787e-02 
    ##     distribution_channelDirect        distribution_channelGDS 
    ##                   1.199651e-02                  -7.386659e-02 
    ##      distribution_channelTA/TO              is_repeated_guest 
    ##                  -4.682281e-03                  -2.707214e-02 
    ## previous_bookings_not_canceled            reserved_room_typeB 
    ##                  -2.277526e-03                   1.760779e-01 
    ##            reserved_room_typeC            reserved_room_typeD 
    ##                   5.417301e-01                  -6.349571e-02 
    ##            reserved_room_typeE            reserved_room_typeF 
    ##                  -3.073202e-02                   2.986088e-01 
    ##            reserved_room_typeG            reserved_room_typeH 
    ##                   4.083797e-01                   5.968138e-01 
    ##            reserved_room_typeL            assigned_room_typeB 
    ##                  -1.079101e-01                   3.051058e-02 
    ##            assigned_room_typeC            assigned_room_typeD 
    ##                   9.475916e-02                   5.758875e-02 
    ##            assigned_room_typeE            assigned_room_typeF 
    ##                   5.695984e-02                   6.769224e-02 
    ##            assigned_room_typeG            assigned_room_typeH 
    ##                   1.080104e-01                   8.937750e-02 
    ##            assigned_room_typeI            assigned_room_typeK 
    ##                   9.935084e-02                   1.622069e-02 
    ##                booking_changes             customer_typeGroup 
    ##                   2.059284e-02                  -9.021990e-03 
    ##         customer_typeTransient   customer_typeTransient-Party 
    ##                   2.510168e-03                  -4.164707e-02 
    ##             average_daily_rate      total_of_special_requests 
    ##                   9.289572e-04                   3.326949e-02 
    ##                  arrival_wday2                  arrival_wday3 
    ##                  -1.246005e-03                  -8.382961e-03 
    ##                  arrival_wday4                  arrival_wday5 
    ##                  -7.564224e-03                  -6.505527e-03 
    ##                  arrival_wday6                  arrival_wday7 
    ##                  -1.156484e-02                   5.324085e-03 
    ##                 arrival_month2                 arrival_month3 
    ##                   2.312525e-02                  -2.614291e-03 
    ##                 arrival_month4                 arrival_month5 
    ##                  -5.207957e-03                  -3.796171e-02 
    ##                 arrival_month6                 arrival_month7 
    ##                  -3.307440e-02                   1.313906e-02 
    ##                 arrival_month8                 arrival_month9 
    ##                   6.098448e-03                  -5.350068e-02 
    ##                arrival_month10                arrival_month11 
    ##                  -2.879893e-02                  -2.407951e-02 
    ##                arrival_month12               arrival_year2016 
    ##                   5.181346e-03                   3.259832e-03 
    ##               arrival_year2017 
    ##                  -1.434771e-02

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
<td style="text-align: right;">0.0682731</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0481928</td>
<td style="text-align: right;">0.0441767</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0720000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0400000</td>
<td style="text-align: right;">0.0360000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0680000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0480000</td>
<td style="text-align: right;">0.0480000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0840000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0640000</td>
<td style="text-align: right;">0.0560000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0760000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0760000</td>
<td style="text-align: right;">0.0720000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0800000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0680000</td>
<td style="text-align: right;">0.0680000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0800000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0600000</td>
<td style="text-align: right;">0.0600000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0920000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0640000</td>
<td style="text-align: right;">0.0640000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0840000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0560000</td>
<td style="text-align: right;">0.0560000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0760000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0520000</td>
<td style="text-align: right;">0.0520000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.1000000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0440000</td>
<td style="text-align: right;">0.0440000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0800000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0320000</td>
<td style="text-align: right;">0.0320000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0760000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0600000</td>
<td style="text-align: right;">0.0560000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.1000000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0520000</td>
<td style="text-align: right;">0.0520000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.1040000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0440000</td>
<td style="text-align: right;">0.0440000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0720000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0480000</td>
<td style="text-align: right;">0.0440000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0840000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0440000</td>
<td style="text-align: right;">0.0400000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0720000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0480000</td>
<td style="text-align: right;">0.0440000</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.0640000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0720000</td>
<td style="text-align: right;">0.0720000</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.0760000</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0.0640000</td>
<td style="text-align: right;">0.0640000</td>
</tr>
</tbody>
</table>
