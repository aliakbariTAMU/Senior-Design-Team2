   M S B A M L   `   `   `  ����  DiscreteGestureBasics-WPF6    0Microsoft.Samples.Kinect.BodyBasics.DisplayGraph   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      -   5          � Title$  Graph��5      $	��310��5      $	��480��6   .��5      � 
������� � RowDefinitions 5   
   �� 5      $��30 �6   �� 5	      $��* �6    � ColumnDefinitions 5   
   �� 5      $��50 �6   �� 5      $��* �6   .+�5   
   �� $��0��6   $��0��6!   $��Center=�5      $��Center=�5      ��5      ��  �� ElementName$ sliZoom�� �� Path$ Value� �� StringFormat$ {0:P0}��5      �� 5   
   -   5        $��sliZoom��5       �� Orientation$ Vertical=�6    $��Center=�5      $��0,0,0,5q�5      $��1��5      $��0��6    � Minimum$
 0.25Q�5       � Maximum$
 3.00Q�6   	 � Value$
	 1.00Q�6+   
 � SmallChange$

 0.25Q�5       � LargeChange$
 0.25Q�6     �� TickFrequency$
 0.25Q�5       �� TickPlacement$ BottomRight=�6"    �� IsSnapToTickEnabled . 5      �� 5   
   -   5        $��scvGraph��5      $��0��5      $��1��6   $��2��6*   $
��Auto=�5       $
��Auto=�5!      .��5"      �� -   5        $��canGraph��5"      
�������$	��400��5#      $	��250��6   $	��TOP=�5$      $��Center=�5%       � LayoutTransform 5&      �� 5'       �� ScaleX 5(      �� $ sliZoom��$ Value� �� ScaleY 5)      �� $ sliZoom��$ Value�5+      5,      �� 5-   
   -   5         ��Name$ trialTxt��5-      $
��Left=�6&   $��25��6A   $��26.4,221.6,0,0q�6M   $��1��6e   $
��Wrap=�6r   $��Trial��6�   $	��Top=�6�   $��44��6�   $��18.667(�6�   $��1��6�   �� 5.   
   -   5        $��trialBox��5.   U   $��1��6   $
��Left=�6    $��70.4,221.6,0,9.8q�6;   $��78��6e    �� 
IsEditable . $��1��6�   �� 5/   
   -   5        $ parameterTxt��5/      $
��Left=�6*   $��30��6E   $��156.4,220.6,0,-0.2q�6Q   $��1��6m   $
��Wrap=�6z   $��	Parameter��6�   $	��Top=�6�   $��92��6�   $��18.667(�6�   $��1��6�    J� RenderTransformOrigin$ 0.502,-0.902&�6�   �� 50   
   -   5        $��parameterBox��50   V   $��1��6   $
��Left=�6    $��248.4,221.6,0,9.8q�6;   $��78��6j    . $��1��6�   51      52      