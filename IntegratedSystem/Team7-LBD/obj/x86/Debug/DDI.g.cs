﻿#pragma checksum "..\..\..\DDI.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "DD99AD15EFFBA69CB7F8ABD6EAC5C2C3"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using Microsoft.Samples.Kinect.BodyBasics;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace Microsoft.Samples.Kinect.BodyBasics {
    
    
    /// <summary>
    /// DDI
    /// </summary>
    public partial class DDI : System.Windows.Window, System.Windows.Markup.IComponentConnector {
        
        
        #line 25 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Primitives.StatusBar statusBar;
        
        #line default
        #line hidden
        
        
        #line 28 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock patientIDTxt;
        
        #line default
        #line hidden
        
        
        #line 29 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock ageTxt;
        
        #line default
        #line hidden
        
        
        #line 30 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock genderTxt;
        
        #line default
        #line hidden
        
        
        #line 31 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock severityLBDTxt;
        
        #line default
        #line hidden
        
        
        #line 32 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock spROM15Txt;
        
        #line default
        #line hidden
        
        
        #line 33 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock spROM30Txt;
        
        #line default
        #line hidden
        
        
        #line 34 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock fpROMTxt;
        
        #line default
        #line hidden
        
        
        #line 35 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock peakVelTxt;
        
        #line default
        #line hidden
        
        
        #line 36 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock peakAccTxt;
        
        #line default
        #line hidden
        
        
        #line 37 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock peakJerkTxt;
        
        #line default
        #line hidden
        
        
        #line 38 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock twistingROMTxt;
        
        #line default
        #line hidden
        
        
        #line 39 "..\..\..\DDI.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ListBox anglesList;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/DiscreteGestureBasics-WPF;component/ddi.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\DDI.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.statusBar = ((System.Windows.Controls.Primitives.StatusBar)(target));
            return;
            case 2:
            this.patientIDTxt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 3:
            this.ageTxt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 4:
            this.genderTxt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 5:
            this.severityLBDTxt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 6:
            this.spROM15Txt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 7:
            this.spROM30Txt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 8:
            this.fpROMTxt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 9:
            this.peakVelTxt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 10:
            this.peakAccTxt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 11:
            this.peakJerkTxt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 12:
            this.twistingROMTxt = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 13:
            this.anglesList = ((System.Windows.Controls.ListBox)(target));
            return;
            }
            this._contentLoaded = true;
        }
    }
}

