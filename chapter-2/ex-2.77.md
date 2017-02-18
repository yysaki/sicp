> (put 'real-part '(complex) real-part)
> (put 'imag-part '(complex) imag-part)
> (put 'magnitude '(complex) magnitude)
> (put 'angle '(complex) angle)
> どうしてこれが働くか詳しく述べよ. 例えばzが図2.24に示すオブジェクトとして, 式(magnitude z)を評価する時, 呼び出されるすべての手続きをトレースせよ. 特にapply-genericは何回呼び出されるか. それぞれの場合どの手続きが振り分けられるか. 


`(magnitude z)` でapply-generic は2回呼び出される。
complexがrectangular形式で作成されていた場合, 1回目はcomplexとしてmagnitudeの演算を探し出し、 2回目はrectangularとしてmagnitudeの演算を探し出す。
