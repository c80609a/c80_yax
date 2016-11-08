# rake db:seed:c80_yax_01_fill_props

C80Yax::Prop.delete_all
C80Yax::Prop.create!({
                               thumb_sm_width:  80,
                               thumb_sm_height: 50,
                               thumb_md_width:  250,
                               thumb_md_height: 160,
                               thumb_lg_width:  1000,
                               thumb_lg_height: 550
                           })