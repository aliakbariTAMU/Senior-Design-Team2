   M S B A M L   `   `   `  ����T  PDiscreteGestureBasics-WPF, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullY1clr-namespace:Microsoft.Samples.Kinect.BodyBasics#Microsoft.Samples.Kinect.BodyBasics  5   	   -    'Microsoft.Samples.Kinect.BodyBasics.DDI   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   Clocal1clr-namespace:Microsoft.Samples.Kinect.BodyBasics     5   	     � Title$  Data Display��5   	   $
��1000��6   $	��800��6,    � 	Resources 5	         MediumGreyBrush �� Color  KinectPurpleBrush  KinectBlueBrush��%�   &	        &	 #     &	 F     �� 5
   
   $ 	#ff6e6e6e��62   �� 5   
   $ 	#ff52318f��64   �� 5   
   $ 	#ff00BCF2��62   5      .��5      � $��	10 0 10 0q�6    � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $��0 �6   �� 5      $
��Auto �6   .+�5   
   (� $��1��6   $��Center=�6   .��5      �� $��UniformToFill=�63   ��6   �� *ImageSource+63   5      �� 5   
   -   5        $��	statusBar��5   ?   $��2��6   $��Stretch=�6!   $��Bottom=�6P   
�������#��[  6~   .@�5      �� ��6   �� *
StatusText+5      �� 5   
   -   5         ��Name$ patientIDTxt��5      $
��Left=�6*   $��45��6E   $��27,3,0,0q�6Q   $��2��6c   $
��Wrap=�6p   $��Patient ID:��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5   
   -   5        $ ageTxt��5      $
��Left=�6$   $��45��6?   $��	27,32,0,0q�6K   $��2��6^   $
��Wrap=�6k   $
��Age:��6   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5   
   -   5        $ 	genderTxt��5      $
��Left=�6'   $��45��6B   $��	27,61,0,0q�6N   $��2��6a   $
��Wrap=�6n   $��Gender: ��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5   
   -   5        $ severityLBDTxt��5      $
��Left=�6,   $��45��6G   $��	27,90,0,0q�6S   $��2��6f   $
��Wrap=�6s   $��LBD Rating:��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5    
   -   5        $ 
spROM15Txt��5       $
��Left=�6(   $��31��6C   $��
27,119,0,0q�6O   $��2��6c   $
��Wrap=�6p   $��SPROM15:��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5!   
   -   5        $ 
spROM30Txt��5!      $
��Left=�6(   $��31��6C   $��
27,148,0,0q�6O   $��2��6c   $
��Wrap=�6p   $��SPROM30:��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5"   
   -   5        $ fpROMTxt��5"      $
��Left=�6&   $��31��6A   $��
27,177,0,0q�6M   $��2��6a   $
��Wrap=�6n   $��FPROM:��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5#   
   -	   5        $ 
peakVelTxt��5#      $
��Left=�6(   $��31��6C   $��
27,206,0,0q�6O   $��2��6c   $
��Wrap=�6p   $��Peak Angular Velocity:��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5$   
   -
   5        $ 
peakAccTxt��5$      $
��Left=�6(   $��31��6C   $��
27,235,0,0q�6O   $��2��6c   $
��Wrap=�6p   $ ��Peak Angular Acceleration:��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5%   
   -   5        $ peakJerkTxt��5%      $
��Left=�6)   $��31��6D   $��
27,264,0,0q�6P   $��2��6d   $
��Wrap=�6q   $��Peak Angular Jerk:��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5&   
   -   5        $ twistingROMTxt��5&      $
��Left=�6,   $��31��6G   $��
27,293,0,0q�6S   $��2��6g   $
��Wrap=�6t   $��Twisting ROM:��6�   $	��Top=�6�   $	��500��6�   $��18.667(�6�   �� 5'   
   -   5         ��Name$ 
anglesList��5'      $
��Left=�6&   $��31��6A   $��
27,322,0,0q�6M   $��2��6a   $	��Top=�6n   $	��500��6�   $��18.667(�6�   �� 5(   
   -   5        $��GraphDisplayButton��5(   i   $��Graph��6   $��2��6!   $��31��6.   $
��Left=�6:   $��
616,31,0,0q�6U   $	��Top=�6�   $��70��6�    J� RenderTransformOrigin$ 1.158,25.263&�6�   5)      5*      