﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Microsoft.Samples.Kinect.BodyBasics
{
    /// <summary>
    /// Interaction logic for DDI.xaml
    /// </summary>
    public partial class DDI : Window
    {
        public DDI()
        {
            InitializeComponent();
            patientIDTxt.Text = "PatientID: " + ApplicationState.dataAnalysis.patientID.ToString();
            ageTxt.Text = "Age: " + ApplicationState.dataAnalysis.age.ToString();
            if (ApplicationState.dataAnalysis.gender == true)
            {
                genderTxt.Text = "Gender: " + "Male";
            }
            else
            {
                genderTxt.Text = "Gender: " + "Female";
            }

            severityLBDTxt.Text = "LBD Severity: " + ApplicationState.dataAnalysis.severityLBD.ToString();
            spROM15Txt.Text = "SP ROM15: " + ApplicationState.dataAnalysis.spROM15.ToString();
            spROM30Txt.Text = "SP ROM30: " + ApplicationState.dataAnalysis.spROM30.ToString();
            fpROMTxt.Text = "FP ROM: " + ApplicationState.dataAnalysis.fpROM.ToString();
            peakVelTxt.Text = "Peak Angular Velocity: " + ApplicationState.dataAnalysis.peakSPAngVelocityAt0.ToString();
            peakAccTxt.Text = "Peak Angular Acceleration: " + ApplicationState.dataAnalysis.peakSPAngAccelerationAt0.ToString();
            peakJerkTxt.Text = "Peak Angular Jerk: " + ApplicationState.dataAnalysis.peakSPAngJerkAt0.ToString();
            twistingROMTxt.Text = "Twisting ROM: " + ApplicationState.dataAnalysis.twistingROM.ToString();

            //List<string> stringList = new List<string>();
            //for(int i = 0; i < ApplicationState.dataAnalysis.kinectSPAngleAt0.Count; i ++)
            //{
            //    stringList.Add(ApplicationState.dataAnalysis.kinectSPAngleAt0[i].ToString());
            //}
            //anglesList.DataContext = stringList;
        }
    }
}
