
full_model_r <- "
  EmotionalLability =~ i122 + i138 + i165 + i181
  Anxiousness =~ i079 + i109 + i130 + i174
  SeparationInsecurity =~ i050 + i127 + i149 + i175
  Hostility =~ i038 + i092 + i158 + i170
  Perseveration =~ i060 + i080 + i100 + i128
  RestrictedAffectivity =~ i084 + i091 + i167 + i184
  Submissiveness =~ i009 + i015 + i063 + i202
  NegativeAffect =~ Emotional Lability + Anxiousness + SeparationInsecurity +
  Hostility + Perseveration + RestrictedAffectivity + Submissiveness
  
  Withdrawal =~  i082 + i136 + i146 + i186
  Anhedonia =~ i023+ i026+ i124+ i157
  Depressivity =~  i081 + i151 + i163 + i169
  IntimacyAvoidance =~ i089 + i120 + i145 + i203
  Suspiciousness =~ i002 + i117  + i133  + i190
  Detachment =~ Withdrawal + Anhedonia + IntimacyAvoidance + Depressivity +Suspiciousness
  
  AttentionSeeking =~ i074 + i173 + i191 + i211
  Callousness =~ i019 + i153 + i166 + i183
  Manipulativeness =~ i107 + i125 + i162 + i219
  Deceitfulness =~ i053 + i134 + i206 + i218
  Grandiosity =~ i040  + i114 + i187 + i197
  Antagonism =~ Manipulativeness + Deceitfulness + Grandiosity +AttentionSeeking +Callousness
  
  Irresponsibility =~ i129 + i156 + i160 + i171
  Impulsivity =~ i004 + i016 + i017 + i022
  Distractibility =~  i118 + i132 + i144 + i199
  RigidPerfectionism =~  i105 + i123 + i176 + i196
  RiskTaking =~ i039 + i048 + i067 + i159 
  Disinhibition =~ Irresponsibility + Impulsivity + Distractibility +RigidPerfectionism +
  RiskTaking
  
  UnusualBeliefs =~i106 + i139  + i150 +  i209
  Eccentricity =~  i025 + i070 + i152 + i205
  PerceptualDysregulation =~  i044 + i154 + i192 + i217
  Psychoticism =~ UnusualBeliefs + Eccentricity + PerceptualDysregulation
  
  NegativeAffect ~~ Detachment + Antagonism + Disinhibition + Psychoticism
  Detachment ~~ Antagonism + Disinhibition + Psychoticism
  Antagonism ~~ Disinhibition + Psychoticism
  Disinhibition ~~ Psychoticism
  
  "

full_model_r_cl <- '
  EmotionalLability =~ i122 + prior("normal(1,3)")*i138 + prior("normal(1,3)")*i165 + prior("normal(1,3)")*i181
  Anxiousness =~ i079 + prior("normal(1,3)")*i109 + prior("normal(1,3)")*i130 + prior("normal(1,3)")*i174
  SeparationInsecurity =~ i050 + prior("normal(1,3)")*i127 + prior("normal(1,3)")*i149 + prior("normal(1,3)")*i175
  Hostility =~ i038 + prior("normal(1,3)")*i092 + prior("normal(1,3)")*i158 + prior("normal(1,3)")*i170
  Perseveration =~ i060 + prior("normal(1,3)")*i080 + prior("normal(1,3)")*i100 + prior("normal(1,3)")*i128
  RestrictedAffectivity =~ i084 + prior("normal(1,3)")*i091 + prior("normal(1,3)")*i167 + prior("normal(1,3)")*i184
  Submissiveness =~ i009 + prior("normal(1,3)")*i015 + prior("normal(1,3)")*i063 + prior("normal(1,3)")*i202
  NegativeAffect =~ Emotional Lability + prior("normal(1,3)")*Anxiousness + prior("normal(1,3)")*SeparationInsecurity + prior("normal(1,3)")*Hostility + prior("normal(1,3)")*Perseveration + prior("normal(1,3)")*RestrictedAffectivity + prior("normal(1,3)")*Submissiveness +
  Withdrawal + Anhedonia + IntimacyAvoidance + Depressivity +Suspiciousness + Manipulativeness + 
  Deceitfulness + Grandiosity +AttentionSeeking +Callousness + Irresponsibility + Impulsivity + Distractibility +RigidPerfectionism +
  RiskTaking + UnusualBeliefs + Eccentricity + PerceptualDysregulation
  
  
  Withdrawal =~  i082 + prior("normal(1,3)")*i136 + prior("normal(1,3)")*i146 + prior("normal(1,3)")*i186
  Anhedonia =~ i023+ prior("normal(1,3)")*i026+ prior("normal(1,3)")*i124+ prior("normal(1,3)")*i157
  Depressivity =~  i081 + prior("normal(1,3)")*i151 + prior("normal(1,3)")*i163 + prior("normal(1,3)")*i169
  IntimacyAvoidance =~ i089 + prior("normal(1,3)")*i120 + prior("normal(1,3)")*i145 + prior("normal(1,3)")*i203
  Suspiciousness =~ i002 + prior("normal(1,3)")*i117  + prior("normal(1,3)")*i133  + prior("normal(1,3)")*i190
  Detachment =~ Withdrawal + prior("normal(1,3)")*Anhedonia + prior("normal(1,3)")*IntimacyAvoidance + prior("normal(1,3)")*Depressivity +prior("normal(1,3)")*Suspiciousness +
  Emotional Lability + Anxiousness + SeparationInsecurity + Hostility + Perseveration + 
  RestrictedAffectivity + Submissiveness + Manipulativeness + Deceitfulness + Grandiosity +AttentionSeeking +Callousness+
  Irresponsibility + Impulsivity + Distractibility +RigidPerfectionism +
  RiskTaking+ UnusualBeliefs + Eccentricity + PerceptualDysregulation

  
  AttentionSeeking =~ i074 + prior("normal(1,3)")*i173 + prior("normal(1,3)")*i191 + prior("normal(1,3)")*i211
  Callousness =~ i019 + prior("normal(1,3)")*i153 + prior("normal(1,3)")*i166 + prior("normal(1,3)")*i183
  Manipulativeness =~ i107 + prior("normal(1,3)")*i125 + prior("normal(1,3)")*i162 + prior("normal(1,3)")*i219
  Deceitfulness =~ i053 + prior("normal(1,3)")*i134 + prior("normal(1,3)")*i206 + prior("normal(1,3)")*i218
  Grandiosity =~ i040  + prior("normal(1,3)")*i114 + prior("normal(1,3)")*i187 + prior("normal(1,3)")*i197
  Antagonism =~ Manipulativeness + prior("normal(1,3)")*Deceitfulness + prior("normal(1,3)")*Grandiosity +prior("normal(1,3)")*AttentionSeeking +prior("normal(1,3)")*Callousness +
  Emotional Lability + Anxiousness + SeparationInsecurity + Hostility + Perseveration + RestrictedAffectivity + Submissiveness +
  Irresponsibility + Impulsivity + Distractibility +RigidPerfectionism +
  RiskTaking + UnusualBeliefs + Eccentricity + PerceptualDysregulation
  
  Irresponsibility =~ i129 + prior("normal(1,3)")*i156 + prior("normal(1,3)")*i160 + prior("normal(1,3)")*i171
  Impulsivity =~ i004 + prior("normal(1,3)")*i016 + prior("normal(1,3)")*i017 + prior("normal(1,3)")*i022
  Distractibility =~  i118 + prior("normal(1,3)")*i132 + prior("normal(1,3)")*i144 + prior("normal(1,3)")*i199
  RigidPerfectionism =~  i105 + prior("normal(1,3)")*i123 + prior("normal(1,3)")*i176 + prior("normal(1,3)")*i196
  RiskTaking =~ i039 + prior("normal(1,3)")*i048 + prior("normal(1,3)")*i067 + prior("normal(1,3)")*i159 
  Disinhibition =~ Irresponsibility + prior("normal(1,3)")*Impulsivity + prior("normal(1,3)")*Distractibility +prior("normal(1,3)")*RigidPerfectionism + prior("normal(1,3)")*RiskTaking +
  Manipulativeness + Deceitfulness + Grandiosity +AttentionSeeking +Callousness +
  Emotional Lability + Anxiousness + SeparationInsecurity + Hostility + Perseveration + RestrictedAffectivity + Submissiveness +
  UnusualBeliefs + Eccentricity + PerceptualDysregulation
  
  
  UnusualBeliefs =~i106 + prior("normal(1,3)")*i139  + prior("normal(1,3)")*i150 +  prior("normal(1,3)")*i209
  Eccentricity =~  i025 + prior("normal(1,3)")*i070 + prior("normal(1,3)")*i152 + prior("normal(1,3)")*i205
  PerceptualDysregulation =~  i044 + prior("normal(1,3)")*i154 + prior("normal(1,3)")*i192 + prior("normal(1,3)")*i217
  Psychoticism =~ UnusualBeliefs + prior("normal(1,3)")*Eccentricity + prior("normal(1,3)")*PerceptualDysregulation +
  Irresponsibility + Impulsivity + Distractibility +RigidPerfectionism + RiskTaking +
  Manipulativeness + Deceitfulness + Grandiosity +AttentionSeeking +Callousness +
  Emotional Lability + Anxiousness + SeparationInsecurity + Hostility + Perseveration + RestrictedAffectivity + Submissiveness 
  
  NegativeAffect ~~ Detachment + Antagonism + Disinhibition + Psychoticism
  Detachment ~~ Antagonism + Disinhibition + Psychoticism
  Antagonism ~~ Disinhibition + Psychoticism
  Disinhibition ~~ Psychoticism
  
  '


full_model_r_maples <- '
  EmotionalLability =~ i122 + prior("normal(1,.5)")*i138 + prior("normal(1,.5)")*i165 + prior("normal(1,.5)")*i181
  Anxiousness =~ i079 + prior("normal(1,.5)")*i109 + prior("normal(1,.5)")*i130 + prior("normal(1,.5)")*i174
  SeparationInsecurity =~ i050 + prior("normal(1,.5)")*i127 + prior("normal(1,.5)")*i149 + prior("normal(1,.5)")*i175
  Hostility =~ i038 + prior("normal(1,.5)")*i092 + prior("normal(1,.5)")*i158 + prior("normal(1,.5)")*i170
  Perseveration =~ i060 + prior("normal(1,.5)")*i080 + prior("normal(1,.5)")*i100 + prior("normal(1,.5)")*i128
  RestrictedAffectivity =~ i084 + prior("normal(1,.5)")*i091 + prior("normal(1,.5)")*i167 + prior("normal(1,.5)")*i184
  Submissiveness =~ i009 + prior("normal(1,.5)")*i015 + prior("normal(1,.5)")*i063 + prior("normal(1,.5)")*i202
  
  NegativeAffect =~ prior("normal(.74,.1)")*Anxiousness + prior("normal(.65,.1)")*Emotional Lability +  prior("normal(.66,.1)")*SeparationInsecurity +  prior("normal(.39,.1)")*Hostility +  prior("normal(.53,.1)")*Perseveration +  prior("normal(-.13,.1)")*RestrictedAffectivity +  prior("normal(.43,.1)")*Submissiveness +
   prior("normal(.17,.1)")*Withdrawal +  prior("normal(.46,.1)")*Anhedonia +  prior("normal(.06,.1)")*IntimacyAvoidance + 
    prior("normal(.56,.1)")*Depressivity + prior("normal(.38,.1)")*Suspiciousness +  prior("normal(.07,.1)")*Manipulativeness + 
   prior("normal(.19,.1)")*Deceitfulness +  prior("normal(.09,.1)")*Grandiosity + prior("normal(.25,.1)")*AttentionSeeking +
    prior("normal(.03,.1)")*Callousness +  prior("normal(.24,.1)")*Irresponsibility +  prior("normal(.15,.1)")*Impulsivity + 
     prior("normal(.47,.1)")*Distractibility + prior("normal(.37,.1)")*RigidPerfectionism +
   prior("normal(.01,.1)")*RiskTaking +  prior("normal(.14,.1)")*UnusualBeliefs +  prior("normal(.22,.1)")*Eccentricity + 
    prior("normal(.13,.1)")*PerceptualDysregulation
  
  NegativeAffect ~ 0*1
  NegativeAffect ~~ 1*NegativeAffect
              
  Withdrawal =~  i082 + prior("normal(1,.5)")*i136 + prior("normal(1,.5)")*i146 + prior("normal(1,.5)")*i186
  Anhedonia =~ i023+ prior("normal(1,.5)")*i026+ prior("normal(1,.5)")*i124+ prior("normal(1,.5)")*i157
  Depressivity =~  i081 + prior("normal(1,.5)")*i151 + prior("normal(1,.5)")*i163 + prior("normal(1,.5)")*i169
  IntimacyAvoidance =~ i089 + prior("normal(1,.5)")*i120 + prior("normal(1,.5)")*i145 + prior("normal(1,.5)")*i203
  Suspiciousness =~ i002 + prior("normal(1,.5)")*i117  + prior("normal(1,.5)")*i133  + prior("normal(1,.5)")*i190
  
  Detachment =~  prior("normal(.78,.1)")*Withdrawal +  prior("normal(.60,.1)")*Anhedonia +  prior("normal(.54,.1)")*IntimacyAvoidance +  prior("normal(.56,.1)")*Depressivity + prior("normal(.39,.1)")*Suspiciousness +
   prior("normal(.11,.1)")*Emotional Lability +  prior("normal(.23,.1)")*Anxiousness +  prior("normal(.-0.6,.1)")*SeparationInsecurity + 
    prior("normal(.33,.1)")*Hostility +  prior("normal(.26,.1)")*Perseveration + 
   prior("normal(.54,.1)")*RestrictedAffectivity +  prior("normal(.08,.1)")*Submissiveness +  prior("normal(.16,.1)")*Manipulativeness + 
    prior("normal(.30,.1)")*Deceitfulness +  prior("normal(.24,.1)")*Grandiosity + prior("normal(-.22,.1)")*AttentionSeeking +
     prior("normal(.48,.1)")*Callousness+
   prior("normal(.37,.1)")*Irresponsibility +  prior("normal(.07,.1)")*Impulsivity +  prior("normal(.20,.1)")*Distractibility +
    prior("normal(.16,.1)")*RigidPerfectionism +
   prior("normal(.07,.1)")*RiskTaking+  prior("normal(.16,.1)")*UnusualBeliefs +  prior("normal(.27,.1)")*Eccentricity + 
    prior("normal(.26,.1)")*PerceptualDysregulation
    
Detachment ~ 0*1
  Detachment ~~ 1*Detachment
  
  AttentionSeeking =~ i074 + prior("normal(1,.5)")*i173 + prior("normal(1,.5)")*i191 + prior("normal(1,.5)")*i211
  Callousness =~ i019 + prior("normal(1,.5)")*i153 + prior("normal(1,.5)")*i166 + prior("normal(1,.5)")*i183
  Manipulativeness =~ i107 + prior("normal(1,.5)")*i125 + prior("normal(1,.5)")*i162 + prior("normal(1,.5)")*i219
  Deceitfulness =~ i053 + prior("normal(1,.5)")*i134 + prior("normal(1,.5)")*i206 + prior("normal(1,.5)")*i218
  Grandiosity =~ i040  + prior("normal(1,.5)")*i114 + prior("normal(1,.5)")*i187 + prior("normal(1,.5)")*i197
  
  Antagonism =~  prior("normal(.66,.1)")*Manipulativeness +  prior("normal(.60,.1)")*Deceitfulness +  prior("normal(.70,.1)")*Grandiosity + prior("normal(.56,.1)")*AttentionSeeking + prior("normal(.53,.1)")*Callousness +
   prior("normal(.07,.1)")*Emotional Lability +  prior("normal(.01,.1)")*Anxiousness +  prior("normal(.18,.1)")*SeparationInsecurity + 
    prior("normal(.29,.1)")*Hostility +  prior("normal(.17,.1)")*Perseveration +  prior("normal(.33,.1)")*RestrictedAffectivity +  prior("normal(.15,.1)")*Submissiveness +
   prior("normal(.37,.1)")*Irresponsibility +  prior("normal(.23,.1)")*Impulsivity +  prior("normal(.04,.1)")*Distractibility +
    prior("normal(.31,.1)")*RigidPerfectionism +
   prior("normal(.39,.1)")*RiskTaking +  prior("normal(.24,.1)")*UnusualBeliefs +  prior("normal(.14,.1)")*Eccentricity + 
    prior("normal(.35,.1)")*PerceptualDysregulation

  Antagonism ~ 0*1
  Antagonism ~~ 1*Antagonism
  
  
  Irresponsibility =~ i129 + prior("normal(1,.5)")*i156 + prior("normal(1,.5)")*i160 + prior("normal(1,.5)")*i171
  Impulsivity =~ i004 + prior("normal(1,.5)")*i016 + prior("normal(1,.5)")*i017 + prior("normal(1,.5)")*i022
  Distractibility =~  i118 + prior("normal(1,.5)")*i132 + prior("normal(1,.5)")*i144 + prior("normal(1,.5)")*i199
  RigidPerfectionism =~  i105 + prior("normal(1,.5)")*i123 + prior("normal(1,.5)")*i176 + prior("normal(1,.5)")*i196
  RiskTaking =~ i039 + prior("normal(1,.5)")*i048 + prior("normal(1,.5)")*i067 + prior("normal(1,.5)")*i159 
  
  Disinhibition =~  prior("normal(.48,.1)")*Irresponsibility +  prior("normal(.74,.1)")*Impulsivity +  prior("normal(.52,.1)")*Distractibility + prior("normal(-.02,.1)")*RigidPerfectionism +  prior("normal(.59,.1)")*RiskTaking +
   prior("normal(.32,.1)")*Manipulativeness +  prior("normal(.39,.1)")*Deceitfulness +  prior("normal(.15,.1)")*Grandiosity + prior("normal(.29,.1)")*AttentionSeeking + prior("normal(.28,.1)")*Callousness +
   prior("normal(.29,.1)")*Emotional Lability +  prior("normal(.11,.1)")*Anxiousness +  prior("normal(.19,.1)")*SeparationInsecurity +  prior("normal(.29,.1)")*Hostility +  prior("normal(.33,.1)")*Perseveration +  prior("normal(.13,.1)")*RestrictedAffectivity +  prior("normal(.14,.1)")*Submissiveness +
   prior("normal(.28,.1)")*UnusualBeliefs +  prior("normal(.37,.1)")*Eccentricity +  prior("normal(.31,.1)")*PerceptualDysregulation
  
  Disinhibition ~ 0*1
  Disinhibition ~~ 1*Disinhibition  
  
  UnusualBeliefs =~i106 + prior("normal(1,.5)")*i139  + prior("normal(1,.5)")*i150 +  prior("normal(1,.5)")*i209
  Eccentricity =~  i025 + prior("normal(1,.5)")*i070 + prior("normal(1,.5)")*i152 + prior("normal(1,.5)")*i205
  PerceptualDysregulation =~  i044 + prior("normal(1,.5)")*i154 + prior("normal(1,.5)")*i192 + prior("normal(1,.5)")*i217
  
  Psychoticism =~  prior("normal(.77,.1)")*UnusualBeliefs +  prior("normal(.38,.1)")*Eccentricity +  prior("normal(.67,.1)")*PerceptualDysregulation +
   prior("normal(.34,.1)")*Irresponsibility +  prior("normal(.18,.1)")*Impulsivity +  prior("normal(.17,.1)")*Distractibility + prior("normal(.29,.1)")*RigidPerfectionism +  prior("normal(.22,.1)")*RiskTaking +
   prior("normal(.21,.1)")*Manipulativeness +  prior("normal(.26,.1)")*Deceitfulness +  prior("normal(.29,.1)")*Grandiosity + prior("normal(.10,.1)")*AttentionSeeking + prior("normal(.25,.1)")*Callousness +
   prior("normal(.40,.1)")*Emotional Lability +  prior("normal(.23,.1)")*Anxiousness +  prior("normal(.16,.1)")*SeparationInsecurity +  prior("normal(.23,.1)")*Hostility +  prior("normal(.29,.1)")*Perseveration +  prior("normal(.04,.1)")*RestrictedAffectivity +  prior("normal(.05,.1)")*Submissiveness 
  
    Psychoticism ~ 0*1
  Psychoticism ~~ 1*Psychoticism  
  
  NegativeAffect ~~ Detachment + Antagonism + Disinhibition + Psychoticism
  Detachment ~~ Antagonism + Disinhibition + Psychoticism
  Antagonism ~~ Disinhibition + Psychoticism
  Disinhibition ~~ Psychoticism
  
  '


#Only include those cl which > .30 in maples
full_model_r_maplesLoose <- ' 
  EmotionalLability =~ i122 + prior("normal(1,.5)")*i138 + prior("normal(1,.5)")*i165 + prior("normal(1,.5)")*i181
  Anxiousness =~ i079 + prior("normal(1,.5)")*i109 + prior("normal(1,.5)")*i130 + prior("normal(1,.5)")*i174
  SeparationInsecurity =~ i050 + prior("normal(1,.5)")*i127 + prior("normal(1,.5)")*i149 + prior("normal(1,.5)")*i175
  Hostility =~ i038 + prior("normal(1,.5)")*i092 + prior("normal(1,.5)")*i158 + prior("normal(1,.5)")*i170
  Perseveration =~ i060 + prior("normal(1,.5)")*i080 + prior("normal(1,.5)")*i100 + prior("normal(1,.5)")*i128
  RestrictedAffectivity =~ i084 + prior("normal(1,.5)")*i091 + prior("normal(1,.5)")*i167 + prior("normal(1,.5)")*i184
  Submissiveness =~ i009 + prior("normal(1,.5)")*i015 + prior("normal(1,.5)")*i063 + prior("normal(1,.5)")*i202
  
  NegativeAffect =~ Anxiousness + prior("normal(1,.1)")*Emotional Lability +  prior("normal(1,.1)")*SeparationInsecurity +  prior("normal(.7,.1)")*Hostility +  prior("normal(1,.1)")*Perseveration +  prior("normal(1,1)")*RestrictedAffectivity +  prior("normal(1,.1)")*Submissiveness +
   prior("normal(1,1)")*Anhedonia  +
    prior("normal(1,1)")*Depressivity + prior("normal(6,1)")*Suspiciousness +
     prior("normal(1,1)")*Distractibility + prior("normal(1,1)")*RigidPerfectionism 

              
  Withdrawal =~  i082 + prior("normal(1,.5)")*i136 + prior("normal(1,.5)")*i146 + prior("normal(1,.5)")*i186
  Anhedonia =~ i023+ prior("normal(1,.5)")*i026+ prior("normal(1,.5)")*i124+ prior("normal(1,.5)")*i157
  Depressivity =~  i081 + prior("normal(1,.5)")*i151 + prior("normal(1,.5)")*i163 + prior("normal(1,.5)")*i169
  IntimacyAvoidance =~ i089 + prior("normal(1,.5)")*i120 + prior("normal(1,.5)")*i145 + prior("normal(1,.5)")*i203
  Suspiciousness =~ i002 + prior("normal(1,.5)")*i117  + prior("normal(1,.5)")*i133  + prior("normal(1,.5)")*i190
  
  Detachment =~  Withdrawal +   prior("normal(1,.1)")*Anhedonia +   prior("normal(1,.1)")*IntimacyAvoidance +   prior("normal(1,.1)")*Depressivity +  prior("normal(1,1)")*Suspiciousness +
    prior("normal(1,1)")*Hostility +
   prior("normal(1,1)")*RestrictedAffectivity +
    prior("normal(1,1)")*Deceitfulness +
     prior("normal(1,1)")*Callousness+
   prior("normal(1,1)")*Irresponsibility
    
  
  AttentionSeeking =~ i074 + prior("normal(1,.5)")*i173 + prior("normal(1,.5)")*i191 + prior("normal(1,.5)")*i211
  Callousness =~ i019 + prior("normal(1,.5)")*i153 + prior("normal(1,.5)")*i166 + prior("normal(1,.5)")*i183
  Manipulativeness =~ i107 + prior("normal(1,.5)")*i125 + prior("normal(1,.5)")*i162 + prior("normal(1,.5)")*i219
  Deceitfulness =~ i053 + prior("normal(1,.5)")*i134 + prior("normal(1,.5)")*i206 + prior("normal(1,.5)")*i218
  Grandiosity =~ i040  + prior("normal(1,.5)")*i114 + prior("normal(1,.5)")*i187 + prior("normal(1,.5)")*i197
  
  Antagonism =~  Manipulativeness +  prior("normal(1,.1)")*Deceitfulness +  prior("normal(1,.1)")*Grandiosity + prior("normal(1,.1)")*AttentionSeeking + prior("normal(1,.1)")*Callousness +
   prior("normal(1,1)")*RestrictedAffectivity +  
   prior("normal(1,1)")*Irresponsibility +
    prior("normal(1,1)")*RigidPerfectionism +
   prior("normal(1,1)")*RiskTaking +  
    prior("normal(1,1)")*PerceptualDysregulation
  
  
  Irresponsibility =~ i129 + prior("normal(1,.5)")*i156 + prior("normal(1,.5)")*i160 + prior("normal(1,.5)")*i171
  Impulsivity =~ i004 + prior("normal(1,.5)")*i016 + prior("normal(1,.5)")*i017 + prior("normal(1,.5)")*i022
  Distractibility =~  i118 + prior("normal(1,.5)")*i132 + prior("normal(1,.5)")*i144 + prior("normal(1,.5)")*i199
  RigidPerfectionism =~  i105 + prior("normal(1,.5)")*i123 + prior("normal(1,.5)")*i176 + prior("normal(1,.5)")*i196
  RiskTaking =~ i039 + prior("normal(1,.5)")*i048 + prior("normal(1,.5)")*i067 + prior("normal(1,.5)")*i159 
  
  Disinhibition =~  Irresponsibility +  prior("normal(1,.1)")*Impulsivity +  prior("normal(1,.1)")*Distractibility + prior("normal(1,1)")*RigidPerfectionism + prior("normal(1,.1)")*RiskTaking +
   prior("normal(1,1)")*Manipulativeness +  prior("normal(1,1)")*Deceitfulness +  prior("normal(1,1)")*Perseveration +  
   prior("normal(1,1)")*Eccentricity +  prior("normal(1,1)")*PerceptualDysregulation
  
  
  UnusualBeliefs =~i106 + prior("normal(1,.5)")*i139  + prior("normal(1,.5)")*i150 +  prior("normal(1,.5)")*i209
  Eccentricity =~  i025 + prior("normal(1,.5)")*i070 + prior("normal(1,.5)")*i152 + prior("normal(1,.5)")*i205
  PerceptualDysregulation =~  i044 + prior("normal(1,.5)")*i154 + prior("normal(1,.5)")*i192 + prior("normal(1,.5)")*i217
  
  Psychoticism =~  UnusualBeliefs + prior("normal(1,.1)")*Eccentricity +  prior("normal(1,.1)")*PerceptualDysregulation +
   prior("normal(1,1)")*Irresponsibility + 
   prior("normal(1,1)")*Emotional Lability

  NegativeAffect ~~ Detachment + Antagonism + Disinhibition + Psychoticism
  Detachment ~~ Antagonism + Disinhibition + Psychoticism
  Antagonism ~~ Disinhibition + Psychoticism
  Disinhibition ~~ Psychoticism
  
  '


#####facets#####
facet_models<- list(
Anhedonia = "Anhedonia =~ i001+ i023+ i026+ i030+ i124+ i155+ i157+ i189",

Anxiousness = "Anxiousness =~ i079 + i093 + i095 +i096 +i109 + i110 + i130 +i141 + i174
",
AttentionSeeking = "AttentionSeeking =~ i014 + i043 + i074 + i111 + i113 + i173 + i191 +i211
",

Callousness = "Callousness =~ i011 + i013 + i019 + i054 + i072 + i073 + i090 + i153 + i166 + i183 + i198 + i200 + i207 + i208
",
Deceitfulness = "Deceitfulness =~ i041 + i053 + i056 + i076 + i126 + i134 + i142 + i206 + i214 + i218
",
Depressivity = "Depressivity =~ i027 + i061 + i066 + i081 + i086 + i104 + i119 + i148 + i151 + i163 + i168 + i169 + i178 + i212
",
Distractibility = "Distractibility =~ i006 + i029 + i047 + i068 + i088 + i118 + i132 + i144 + i199
",
Eccentricity = "Eccentricity =~ i005 + i021 + i024 + i025 + i033 + i052 + i055 + i070 + i071 + i152 + i172 + i185 + i205
",
EmotionalLability = "EmotionalLability =~ i018 + i062 + i102 + i122 + i138 + i165 + i181
",
Grandiosity = "Grandiosity =~ i040 + i065 + i114 + i179 + i187 + i197
",
Hostility = "Hostility =~ i028 + i032 + i038 + i085 + i092 + i116 + i158 + i170 + i188 + i216
",
Impulsivity = "Impulsivity =~ i004 + i016 + i017 + i022 + i058 + i204
",
IntimacyAvoidance = "IntimacyAvoidance =~ i089 + i097 + i108 + i120 + i145 + i203
",
Irresponsibility = "Irresponsibility =~ i031 + i129 + i156 + i160 + i171 + i201 + i210
",
Manipulativeness = "Manipulativeness =~ i107 + i125 + i162 + i180 + i219
",
PerceptualDysregulation = "PerceptualDysregulation =~ i036 + i037 + i042 + i044 + i059 + i077 + i083 + i154 + i192 + i193 + i213 + i217
",
Perseveration = "Perseveration =~ i046 + i051 + i060 + i078 + i080 + i100 + i121 + i128 + i137
",
RestrictedAffectivity = "RestrictedAffectivity =~ i008 + i045 + i084 + i091 + i101 + i167 + i184
",
RigidPerfectionism = "RigidPerfectionism =~ i034 + i049 + i105 + i115 + i123 + i135 + i140 + i176 + i196 + i220
",
RiskTaking = "RiskTaking =~ i003 + i007 + i035 + i039 + i048 + i067 + i069 + i087 + i098 + i112 + i159 + i164 + i195 + i215
",
SeparationInsecurity = "SeparationInsecurity =~ i012 + i050 + i057 + i064 + i127 + i149 + i175
",
Submissiveness = "Submissiveness =~ i009 + i015 + i063 + i202
",
Suspiciousness = "Suspiciousness =~ i002 + i103 + i117 + i131 + i133 + i177 + i190
",
UnusualBeliefs = "UnusualBeliefs =~ i094 + i099 + i106 + i139 + i143 + i150 + i194 + i209
",
Withdrawal = "Withdrawal =~ i010 + i020 + i075 + i082 + i136 + i146 + i147 + i161 + i182 + i186
")

facet_models_r<- list(
  Anhedonia = "Anhedonia =~ i023+ i026+ i124+ i157",
  
  Anxiousness = "Anxiousness =~ i079 + i109 + i130 + i174",
  
  AttentionSeeking = "AttentionSeeking =~ i074 + i173 + i191 + i211
",
  
  Callousness = "Callousness =~ i019 + i153 + i166 + i183
",
  Deceitfulness = "Deceitfulness =~ i053 + i134 + i206 + i218
",
  Depressivity = "Depressivity =~  i081 + i151 + i163 + i169
",
  Distractibility = "Distractibility =~  i118 + i132 + i144 + i199
",
  Eccentricity = "Eccentricity =~  i025 + i070 + i152 + i205
",
  EmotionalLability = "EmotionalLability =~ i122 + i138 + i165 + i181
",
  Grandiosity = "Grandiosity =~ i040  + i114 + i187 + i197
",
  Hostility = "Hostility =~ i038 + i092 + i158 + i170
",
  Impulsivity = "Impulsivity =~ i004 + i016 + i017 + i022
",
  IntimacyAvoidance = "IntimacyAvoidance =~ i089 + i120 + i145 + i203
",
  Irresponsibility = "Irresponsibility =~ i129 + i156 + i160 + i171
",
  Manipulativeness = "Manipulativeness =~ i107 + i125 + i162 + i219
",
  PerceptualDysregulation = "PerceptualDysregulation =~  i044 + i154 + i192 + i217
",
  Perseveration = "Perseveration =~ i060 + i080 + i100 + i128
",
  RestrictedAffectivity = "RestrictedAffectivity =~ i084 + i091 + i167 + i184
",
  RigidPerfectionism = "RigidPerfectionism =~  i105 + i123 + i176 + i196
",
  RiskTaking = "RiskTaking =~ i039 + i048 + i067 + i159 
",
  SeparationInsecurity = "SeparationInsecurity =~ i050 + i127 + i149 + i175
",
  Submissiveness = "Submissiveness =~ i009 + i015 + i063 + i202
",
  Suspiciousness = "Suspiciousness =~ i002 + i117  + i133  + i190
",
  UnusualBeliefs = "UnusualBeliefs =~i106 + i139  + i150 +  i209
",
  Withdrawal = "Withdrawal =~  i082 + i136 + i146 + i186
")
###### dimensions ######


dimension_models_r <- list(
  N = "EmotionalLability =~ i122 + i138 + i165 + i181
  Anxiousness =~ i079 + i109 + i130 + i174
  SeparationInsecurity =~ i050 + i127 + i149 + i175
  NegativeAffect =~ Emotional Lability + Anxiousness + SeparationInsecurity",
  
  C = "Withdrawal =~  i082 + i136 + i146 + i186
  Anhedonia =~ i023+ i026+ i124+ i157
  IntimacyAvoidance =~ i089 + i120 + i145 + i203
  Detachment =~ Withdrawal + Anhedonia + IntimacyAvoidance",
  
  A = "Manipulativeness =~ i107 + i125 + i162 + i219
  Deceitfulness =~ i053 + i134 + i206 + i218
  Grandiosity =~ i040  + i114 + i187 + i197
  Antagonism =~ Manipulativeness + Deceitfulness + Grandiosity",
  
  E = "Irresponsibility =~ i129 + i156 + i160 + i171
  Impulsivity =~ i004 + i016 + i017 + i022
  Distractibility =~  i118 + i132 + i144 + i199
  Disinhibition =~ Irresponsibility + Impulsivity + Distractibility",
  
  O = "UnusualBeliefs =~i106 + i139  + i150 +  i209
  Eccentricity =~  i025 + i070 + i152 + i205
  PerceptualDysregulation =~  i044 + i154 + i192 + i217
  Psychoticism =~ UnusualBeliefs + Eccentricity + PerceptualDysregulation")
  

dimension_models <- list(
N = "EmotionalLability =~ i018 + i062 + i102 + i122 + i138 + i165 + i181
Anxiousness =~ i079 + i093 + i095 +i096 +i109 + i110 + i130 +i141 + i174
SeparationInsecurity =~ i012 + i050 + i057 + i064 + i127 + i149 + i175

NegativeAffect =~ Emotional Lability + Anxiousness + SeparationInsecurity",

C = "Withdrawal =~ i010 + i020 + i075 + i082 + i136 + i146 + i147 + i161 + i182 + i186
Anhedonia =~ i001+ i023+ i026+ i030+ i124+ i155+ i157+ i189
IntimacyAvoidance =~ i089 + i097 + i108 + i120 + i145 + i203

Detachment =~ Withdrawal + Anhedonia + IntimacyAvoidance",

A = "
Manipulativeness =~ i107 + i125 + i162 + i180 + i219
Deceitfulness =~ i041 + i053 + i056 + i076 + i126 + i134 + i142 + i206 + i214 + i218
Grandiosity =~ i040 + i065 + i114 + i179 + i187 + i197

Antagonism =~ Manipulativeness + Deceitfulness + Grandiosity",

E = "Irresponsibility =~ i031 + i129 + i156 + i160 + i171 + i201 + i210
Impulsivity =~ i004 + i016 + i017 + i022 + i058 + i204
Distractibility =~ i006 + i029 + i047 + i068 + i088 + i118 + i132 + i144 + i199

Disinhibition =~ Irresponsibility + Impulsivity + Distractibility",

O = "UnusualBeliefs =~ i094 + 1*i099 + i106 + i139 + i143 + i150 + i194 + i209
Eccentricity =~ i005 + i021 + i024 + i025 + i033 + i052 + i055 + i070 + i071 + i152 + i172 + i185 + i205
PerceptualDysregulation =~ i036 + i037 + i042 + i044 + i059 + i077 + i083 + i154 + i192 + i193 + i213 + i217
Psychoticism =~ UnusualBeliefs + Eccentricity + PerceptualDysregulation")


full_model_r <- "
  EmotionalLability =~ i122 + i138 + i165 + i181
  Anxiousness =~ i079 + i109 + i130 + i174
  SeparationInsecurity =~ i050 + i127 + i149 + i175
  NegativeAffect =~ Emotional Lability + Anxiousness + SeparationInsecurity
  
  Withdrawal =~  i082 + i136 + i146 + i186
  Anhedonia =~ i023+ i026+ i124+ i157
  IntimacyAvoidance =~ i089 + i120 + i145 + i203
  Detachment =~ Withdrawal + Anhedonia + IntimacyAvoidance
  
  Manipulativeness =~ i107 + i125 + i162 + i219
  Deceitfulness =~ i053 + i134 + i206 + i218
  Grandiosity =~ i040  + i114 + i187 + i197
  Antagonism =~ Manipulativeness + Deceitfulness + Grandiosity
  
  Irresponsibility =~ i129 + i156 + i160 + i171
  Impulsivity =~ i004 + i016 + i017 + i022
  Distractibility =~  i118 + i132 + i144 + i199
  Disinhibition =~ Irresponsibility + Impulsivity + Distractibility
  
  UnusualBeliefs =~i106 + i139  + i150 +  i209
  Eccentricity =~  i025 + i070 + i152 + i205
  PerceptualDysregulation =~  i044 + i154 + i192 + i217
  Psychoticism =~ UnusualBeliefs + Eccentricity + PerceptualDysregulation
  
  NegativeAffect ~~ Detachment + Antagonism + Disinhibition + Psychoticism
  Detachment ~~ Antagonism + Disinhibition + Psychoticism
  Antagonism ~~ Disinhibition + Psychoticism
  Disinhibition ~~ Psychoticism
  
  "







#####facets#####
facet_models_tau<- list(
  Anhedonia_tau = "Anhedonia =~ 1*i001+ 1*i023+ 1*i026+ (-1)*i030+ 1*i124+ (-1)*i155+ 1*i157+ 1*i189",
  
  Anxiousness_tau = "Anxiousness =~ 1*i079 + 1*i093 + 1*i095 +(-1)*i096 +1*i109 + 1*i110 + 1*i130 +1*i141 + 1*i174
",
  AttentionSeeking_tau = "AttentionSeeking =~ 1*i014 + 1*i043 + 1*i074 + 1*i111 + 1*i113 + 1*i173 + 1*i191 +1*i211
",
  
  Callousness_tau = "Callousness =~ 1*i011 + 1*i013 + 1*i019 + 1*i054 + 1*i072 + 1*i073 +(-1)*i090 + 1*i153 + 1*i166 + 1*i183 + 1*i198 + 1*i200 + 1*i207 + 1*i208
",
  Deceitfulness_tau = "Deceitfulness =~ 1*i041 + 1*i053 + 1*i056 + 1*i076 + 1*i126 + 1*i134 + (-1)*i142 + 1*i206 + 1*i214 + 1*i218
",
  Depressivity_tau = "Depressivity =~ 1*i027 + 1*i061 + 1*i066 + 1*i081 + 1*i086 + 1*i104 + 1*i119 + 1*i148 + 1*i151 + 1*i163 + 1*i168 + 1*i169 + 1*i178 + 1*i212
",
  Distractibility_tau = "Distractibility =~ 1*i006 + 1*i029 + 1*i047 + 1*i068 + 1*i088 + 1*i118 + 1*i132 + 1*i144 + 1*i199
",
  Eccentricity_tau = "Eccentricity =~ 1*i005 + 1*i021 + 1*i024 + 1*i025 + 1*i033 + 1*i052 + 1*i055 + 1*i070 + 1*i071 + 1*i152 + 1*i172 + 1*i185 + 1*i205
",
  EmotionalLability_tau = "EmotionalLability =~ 1*i018 + 1*i062 + 1*i102 + 1*i122 + 1*i138 + 1*i165 + 1*i181
",
  Grandiosity_tau = "Grandiosity =~ 1*i040 + 1*i065 + 1*i114 + 1*i179 + 1*i187 + 1*i197
",
  Hostility_tau = "Hostility =~ 1*i028 + 1*i032 + 1*i038 + 1*i085 + 1*i092 + 1*i116 + 1*i158 + 1*i170 + 1*i188 + 1*i216
",
  Impulsivity_tau = "Impulsivity =~ 1*i004 + 1*i016 + 1*i017 + 1*i022 + (-1)*i058 + 1*i204
",
  IntimacyAvoidance_tau = "IntimacyAvoidance =~ 1*i089 + (-1)*i097 + 1*i108 + 1*i120 + 1*i145 + 1*i203
",
  Irresponsibility_tau = "Irresponsibility =~ 1*i031 + 1*i129 + 1*i156 + 1*i160 + 1*i171 + 1*i201 + (-1)*i210
",
  Manipulativeness_tau = "Manipulativeness =~ 1*i107 + 1*i125 + 1*i162 + 1*i180 + 1*i219
",
  PerceptualDysregulation_tau = "PerceptualDysregulation =~ 1*i036 + 1*i037 + 1*i042 + 1*i044 + 1*i059 + 1*i077 + 1*i083 + 1*i154 + 1*i192 + 1*i193 + 1*i213 + 1*i217
",
  Perseveration_tau = "Perseveration =~ 1*i046 + 1*i051 + 1*i060 + 1*i078 + 1*i080 + 1*i100 + 1*i121 + 1*i128 + 1*i137
",
  RestrictedAffectivity_tau = "RestrictedAffectivity =~ 1*i008 + 1*i045 + 1*i084 + 1*i091 + 1*i101 + 1*i167 + 1*i184
",
  RigidPerfectionism_tau = "RigidPerfectionism =~ 1*i034 + 1*i049 + 1*i105 + 1*i115 + 1*i123 + 1*i135 + 1*i140 + 1*i176 + 1*i196 + 1*i220
",
  RiskTaking_tau = "RiskTaking =~ 1*i003 + (-1)*i007 + (-1)*i035 + 1*i039 + 1*i048 + 1*i067 + 1*i069 + (-1)*i087 + (-1)*i098 + 1*i112 + 1*i159 + (-1)*i164 + 1*i195 + (-1)*i215
",
  SeparationInsecurity_tau = "SeparationInsecurity =~ 1*i012 + 1*i050 + 1*i057 + 1*i064 + 1*i127 + 1*i149 + 1*i175
",
  Submissiveness_tau = "Submissiveness =~ 1*i009 + 1*i015 + 1*i063 + 1*i202
",
  Suspiciousness_tau = "Suspiciousness =~ 1*i002 + 1*i103 + 1*i117 + (-1)*i131 + 1*i133 + (-1)*i177 + 1*i190
",
  UnusualBeliefs_tau = "UnusualBeliefs =~ 1*i094 + 1*i099 + 1*i106 + 1*i139 + 1*i143 + 1*i150 + 1*i194 + 1*i209
",
  Withdrawal_tau = "Withdrawal =~ 1*i010 + 1*i020 + 1*i075 + 1*i082 + 1*i136 + 1*i146 + 1*i147 + 1*i161 + 1*i182 + 1*i186
")


dimension_models_tau <- list(
  N_tau = "EmotionalLability_tau =~ 1*i018 + 1*i062 + 1*i102 + 1*i122 + 1*i138 + 1*i165 + 1*i181
Anxiousness_tau =~ 1*i079 + 1*i093 + 1*i095 +(-1)*i096 +1*i109 + 1*i110 + 1*i130 +1*i141 + 1*i174
SeparationInsecurity_tau =~ 1*i012 + 1*i050 + 1*i057 + 1*i064 + 1*i127 + 1*i149 + 1*i175

NegativeAffect_tau =~ Emotional Lability_tau + Anxiousness_tau + SeparationInsecurity_tau",
  
  C_tau = "Withdrawal_tau =~ 1*i010 + 1*i020 + 1*i075 + 1*i082 + 1*i136 + 1*i146 + 1*i147 + 1*i161 + 1*i182 + 1*i186
Anhedonia_tau =~ 1*i001+ 1*i023+ 1*i026+ (-1)*i030+ 1*i124+ (-1)*i155+ 1*i157+ 1*i189
IntimacyAvoidance_tau =~ 1*i089 + (-1)*i097 + 1*i108 + 1*i120 + 1*i145 + 1*i203

Detachment_tau =~ Withdrawal_tau + Anhedonia_tau + IntimacyAvoidance_tau",
  
  A_tau = "
Manipulativeness_tau =~ 1*i107 + 1*i125 + 1*i162 + 1*i180 + 1*i219
Deceitfulness_tau =~ 1*i041 + 1*i053 + 1*i056 + 1*i076 + 1*i126 + 1*i134 + (-1)*i142 + 1*i206 + 1*i214 + 1*i218
Grandiosity_tau =~ 1*i040 + 1*i065 + 1*i114 + 1*i179 + 1*i187 + 1*i197

Antagonism_tau =~ Manipulativeness_tau + Deceitfulness_tau + Grandiosity_tau",
  
  E_tau = "Irresponsibility_tau =~ 1*i031 + 1*i129 + 1*i156 + 1*i160 + 1*i171 + 1*i201 + (-1)*i210
Impulsivity_tau =~ 1*i004 + 1*i016 + 1*i017 + 1*i022 + (-1)*i058 + 1*i204
Distractibility_tau =~ 1*i006 + 1*i029 + 1*i047 + 1*i068 + 1*i088 + 1*i118 + 1*i132 + 1*i144 + 1*i199

Disinhibition_tau =~ Irresponsibility_tau + Impulsivity_tau + Distractibility_tau",
  
  O_tau = "UnusualBeliefs_tau =~ 1*i094 + 1*1*i099 + 1*i106 + 1*i139 + 1*i143 + 1*i150 + 1*i194 + 1*i209
Eccentricity_tau =~ 1*i005 + 1*i021 + 1*i024 + 1*i025 + 1*i033 + 1*i052 + 1*i055 + 1*i070 + 1*i071 + 1*i152 + 1*i172 + 1*i185 + 1*i205
PerceptualDysregulation_tau =~ 1*i036 + 1*i037 + 1*i042 + 1*i044 + 1*i059 + 1*i077 + 1*i083 + 1*i154 + 1*i192 + 1*i193 + 1*i213 + 1*i217
Psychoticism_tau =~ UnusualBeliefs_tau + Eccentricity_tau + PerceptualDysregulation_tau")

