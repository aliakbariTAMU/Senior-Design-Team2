﻿//---------------------------------------------------------------------------------------------------
// <copyright file="MainWindow.xaml.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//
// <Description>
// This program tracks up to 6 people simultaneously.
// If a person is tracked, the associated gesture detector will determine if that person is seated or not.
// If any of the 6 positions are not in use, the corresponding gesture detector(s) will be paused
// and the 'Not Tracked' image will be displayed in the UI.
// </Description>
//----------------------------------------------------------------------------------------------------

namespace Microsoft.Samples.Kinect.DiscreteGestureBasics
{
    using System;
    using System.Collections.Generic;
    using System.Collections.ObjectModel;
    using System.ComponentModel;
    using System.Windows;
    using System.Windows.Controls;
    using Microsoft.Kinect;
    using Microsoft.Kinect.VisualGestureBuilder;

    /// <summary>
    /// Interaction logic for the MainWindow
    /// </summary>
    public partial class FeedbackDisplay : Window, INotifyPropertyChanged
    {
        /// <summary> Active Kinect sensor </summary>
        private KinectSensor kinectSensor = null;

        /// <summary> Array for the bodies (Kinect will track up to 6 people simultaneously) </summary>
        private Body[] bodies = null;

        /// <summary>  Index of the active body (first tracked person in the body array) </summary>
        private int activeBodyIndex = 0;

        /// <summary> Reader for body frames </summary>
        private BodyFrameReader bodyFrameReader = null;

        /// <summary> Current status text to display </summary>
        private string statusText = null;

        /// <summary> KinectBodyView object which handles drawing the Kinect bodies to a View box in the UI </summary>
        private KinectBodyView kinectBodyView = null;

        /// <summary> List of gesture detectors, there will be one detector created for each potential body (max of 6) </summary>
        private List<GestureDetector> gestureDetectorList = null;

        // Creates Timer


        /// <summary>
        /// Initializes a new instance of the MainWindow class
        /// </summary>
        public FeedbackDisplay()
        {
            // only one sensor is currently supported
            this.kinectSensor = KinectSensor.GetDefault();

            // set IsAvailableChanged event notifier
            this.kinectSensor.IsAvailableChanged += this.Sensor_IsAvailableChanged;

            // open the sensor
            this.kinectSensor.Open();

            // set the status text
            //this.StatusText = this.kinectSensor.IsAvailable ? BodyBasics.Properties.Resources.RunningStatusText
            //                                                : BodyBasics.Properties.Resources.NoSensorStatusText;

            // open the reader for the body frames
            this.bodyFrameReader = this.kinectSensor.BodyFrameSource.OpenReader();

            // set the BodyFramedArrived event notifier
            this.bodyFrameReader.FrameArrived += this.Reader_BodyFrameArrived;

            // initialize the BodyViewer object for displaying tracked bodies in the UI
            this.kinectBodyView = new KinectBodyView(this.kinectSensor);

            // initialize the gesture detection objects for our gestures
            this.gestureDetectorList = new List<GestureDetector>();

            // initialize the MainWindow
            this.InitializeComponent();

            // set our data context objects for display in UI
            this.DataContext = this;
            this.kinectBodyViewbox.DataContext = this.kinectBodyView;

            // create a gesture detector for each body (6 bodies => 6 detectors) and create content controls to display results in the UI
            int col0Row = 0;
            int col1Row = 0;
            //int maxBodies = this.kinectSensor.BodyFrameSource.BodyCount;
            int maxBodies = 1;
            for (int i = 0; i < maxBodies; ++i)
            {
                StandingResultView standingResult = new StandingResultView(0, false, false, 0.0f);
                ArmsCrossedResultView armsCrossedResult = new ArmsCrossedResultView(0, false, false, 0.0f);
                GestureDetector detector = new GestureDetector(this.kinectSensor, standingResult, armsCrossedResult);
                this.gestureDetectorList.Add(detector);

                // split gesture results across the first two columns of the content grid
                ContentControl standingcontentControl = new ContentControl();
                ContentControl armscrossedcontentControl = new ContentControl();
                standingcontentControl.Content = this.gestureDetectorList[i].StandingResultView;
                armscrossedcontentControl.Content = this.gestureDetectorList[i].ArmsCrossedResultView;

                if (i % 2 == 0)
                {
                    // Gesture results for bodies: 0, 2, 4
                    Grid.SetColumn(standingcontentControl, 0);
                    Grid.SetColumn(armscrossedcontentControl, 0);
                    Grid.SetRow(standingcontentControl, col0Row);
                    Grid.SetRow(armscrossedcontentControl, col0Row + 1);
                    ++col0Row;
                }
                else
                {
                    // Gesture results for bodies: 1, 3, 5
                    Grid.SetColumn(standingcontentControl, 0);
                    Grid.SetColumn(armscrossedcontentControl, 0);
                    Grid.SetRow(standingcontentControl, col1Row);
                    Grid.SetRow(armscrossedcontentControl, col1Row + 1);
                    ++col1Row;
                }

                this.contentGrid.Children.Add(standingcontentControl);
                this.contentGrid.Children.Add(armscrossedcontentControl);
            }
        }

        /// <summary>
        /// INotifyPropertyChangedPropertyChanged event to allow window controls to bind to changeable data
        /// </summary>
        public event PropertyChangedEventHandler PropertyChanged;

        /// <summary>
        /// Gets or sets the current status text to display
        /// </summary>
        public string StatusText
        {
            get
            {
                return this.statusText;
            }

            set
            {
                if (this.statusText != value)
                {
                    this.statusText = value;

                    // notify any bound elements that the text has changed
                    if (this.PropertyChanged != null)
                    {
                        this.PropertyChanged(this, new PropertyChangedEventArgs("StatusText"));
                    }
                }
            }
        }

        private void button3_Click(object sender, RoutedEventArgs e)
        {
            kinectBodyView.kinectFeedback.initialPosRS.Clear();
            kinectBodyView.kinectFeedback.initialPosSS.Clear();
            //kinectBodyView.kinectFeedback.initialPosSM.Clear();
            kinectBodyView.kinectFeedback.initialPosSB.Clear();
            kinectBodyView.kinectFeedback.isInitial = true;

            ButtonCalibrate.IsEnabled = false;
            ButtonCalibrate.IsEnabled = true;
        }


        /// <summary>
        /// Execute shutdown tasks
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void MainWindow_Closing(object sender, CancelEventArgs e)
        {
            if (this.bodyFrameReader != null)
            {
                // BodyFrameReader is IDisposable
                this.bodyFrameReader.FrameArrived -= this.Reader_BodyFrameArrived;
                this.bodyFrameReader.Dispose();
                this.bodyFrameReader = null;
            }

            if (this.gestureDetectorList != null)
            {
                // The GestureDetector contains disposable members (VisualGestureBuilderFrameSource and VisualGestureBuilderFrameReader)
                foreach (GestureDetector detector in this.gestureDetectorList)
                {
                    detector.Dispose();
                }

                this.gestureDetectorList.Clear();
                this.gestureDetectorList = null;
            }

            if (this.kinectSensor != null)
            {
                this.kinectSensor.IsAvailableChanged -= this.Sensor_IsAvailableChanged;
                this.kinectSensor.Close();
                this.kinectSensor = null;
            }
        }

        /// <summary>
        /// Handles the event when the sensor becomes unavailable (e.g. paused, closed, unplugged).
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void Sensor_IsAvailableChanged(object sender, IsAvailableChangedEventArgs e)
        {
            // on failure, set the status text
            try
            {
                //this.StatusText = this.kinectSensor.IsAvailable ? BodyBasics.Properties.Resources.RunningStatusText
                //                                                : BodyBasics.Properties.Resources.SensorNotAvailableStatusText;
            }
            catch
            {

            }
        }

        /// <summary>
        /// Gets the first body in the bodies array that is currently tracked by the Kinect sensor
        /// </summary>
        /// <returns>Index of first tracked body, or -1 if no body is tracked</returns>
        private int GetActiveBodyIndex()
        {
            int activeBodyIndex = -1;
            int maxBodies = this.kinectSensor.BodyFrameSource.BodyCount;

            for (int i = 0; i < maxBodies; ++i)
            {
                // find the first tracked body and verify it has hands tracking enabled (by default, Kinect will only track handstate for 2 people)
                if (this.bodies[i].IsTracked && (this.bodies[i].HandRightState != HandState.NotTracked || this.bodies[i].HandLeftState != HandState.NotTracked))
                {
                    activeBodyIndex = i;
                    break;
                }
            }

            return activeBodyIndex;
        }

        /// <summary>
        /// Handles the body frame data arriving from the sensor and updates the associated gesture detector object for each body
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void Reader_BodyFrameArrived(object sender, BodyFrameArrivedEventArgs e)
        {
            bool dataReceived = false;

            using (BodyFrame bodyFrame = e.FrameReference.AcquireFrame())
            {
                if (bodyFrame != null)
                {
                    if (this.bodies == null)
                    {
                        // creates an array of 6 bodies, which is the max number of bodies that Kinect can track simultaneously
                        this.bodies = new Body[bodyFrame.BodyCount];
                    }

                    // The first time GetAndRefreshBodyData is called, Kinect will allocate each Body in the array.
                    // As long as those body objects are not disposed and not set to null in the array,
                    // those body objects will be re-used.
                    bodyFrame.GetAndRefreshBodyData(this.bodies);
                    if (!this.bodies[this.activeBodyIndex].IsTracked)
                    {
                        // we lost tracking of the active body, so update to the first tracked body in the array
                        int bodyIndex = this.GetActiveBodyIndex();

                        if (bodyIndex >= 0)
                        {
                            this.activeBodyIndex = bodyIndex;
                        }
                    }
                    dataReceived = true;
                }
            }

            if (dataReceived)
            {


                // visualize the new body data
                this.kinectBodyView.UpdateBodyFrame(this.bodies);
                sagittalAngle.Text = kinectBodyView.kinectFeedback.sagittalAngleTxt;
                flexAngle.Text = kinectBodyView.kinectFeedback.flexAngleTxt;
                zeroBool.Text = kinectBodyView.kinectFeedback.isZero;
                thirtyBool.Text = kinectBodyView.kinectFeedback.isThirty;
                isFullFlex.Text = kinectBodyView.kinectFeedback.isFlex;

                // we may have lost/acquired bodies, so update the corresponding gesture detectors
                if (this.bodies != null)
                {
                    // loop through all bodies to see if any of the gesture detectors need to be updated
                    //int maxBodies = this.kinectSensor.BodyFrameSource.BodyCount;
                    int maxBodies = 1;
                    for (int i = 0; i < maxBodies; ++i)
                    {
                        Body activeBody = this.bodies[this.activeBodyIndex];
                        ulong trackingId = activeBody.TrackingId;

                        // if the current body TrackingId changed, update the corresponding gesture detector with the new value
                        if (activeBody.TrackingId != this.gestureDetectorList[i].TrackingId)
                        {
                            this.gestureDetectorList[i].TrackingId = trackingId;

                            // if the current body is tracked, unpause its detector to get VisualGestureBuilderFrameArrived events
                            // if the current body is not tracked, pause its detector so we don't waste resources trying to get invalid gesture results
                            this.gestureDetectorList[i].IsPaused = trackingId == 0;
                        }
                    }
                }
            }
        }
    }
}