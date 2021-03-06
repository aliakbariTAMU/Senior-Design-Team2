﻿using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestProgram
{
    class Program
    {
        static void Main(string[] args)
        {
            List<double> Timestamps1 = new List<double>();
            List<double> Timestamps2 = new List<double>();
            List<double> Input1 = new List<double>();
            List<double> Input2 = new List<double>();
            List<double> PeakValuesHolder = new List<double>();
            List<double> PeakTimeHolder = new List<double>();
            List<double> TruePeakHolder = new List<double>();
            List<double> TruePeakTimeHolder = new List<double>();
            string path1 = @"C:\Users\burns\Desktop\403\MATLAB Codes\test1_vel.txt";
            string path2 = @"C:\Users\burns\Desktop\403\MATLAB Codes\test2_vel.txt";
            int I1Eletracker = 0;
            int I2Eletracker = 0;
            double I1max = 0;
            double I1container = 0;
            int I1Ele = 0;                          // some variables unused
            double I2max = 0;
            double I2cont = 0;
            int I2Ele = 0;
            double TimeI1 = 0;
            double TimeI2 = 0;
            int I1CorEle = 0;
            int I2CorEle = 0;
            double CorrectionFactor;
            double ispeak;
            //Read in txt file into lists for manipulation

            /*TextReader rdr = File.OpenText(path);
            while ((line = rdr.ReadLine()) != null)
            {
                string text = rdr.ReadLine();
                /*string[] bits = text.Split(' ');   //Incorrect read-in
                double x = double.Parse(bits[0]);
                double y = double.Parse(bits[1]);
                Console.WriteLine(text);
            }
            rdr.Close();*/

            using (TextReader reader = File.OpenText(path1))
            {
                string readin1;
                while ((readin1 = reader.ReadLine()) != null)
                {
                    //string text = reader.ReadLine();
                    string[] bits = readin1.Split(new [] {' '}, StringSplitOptions.RemoveEmptyEntries);
                    double x = double.Parse(bits[0]);
                    double y = double.Parse(bits[1]);
                    Console.WriteLine(x);
                    Timestamps1.Add(x);
                    Console.WriteLine(y);
                    Input1.Add(y);
                }
                Console.WriteLine("To read in next file press any key");
                System.Console.ReadKey();
            }
            
            using (TextReader reader2 = File.OpenText(path2))
            {
                string readin2;
                while ((readin2 = reader2.ReadLine()) != null)
                {
                   // string text2 = reader2.ReadLine();
                    string[] bits = readin2.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                    double x2 = double.Parse(bits[0]);
                    double y2 = double.Parse(bits[1]);
                    Console.WriteLine(x2);
                    Timestamps2.Add(x2);
                    Console.WriteLine(y2);
                    Input2.Add(y2);
                }
                Console.WriteLine("Both Files read in, press any key");
                System.Console.ReadKey();
            }
            

            //dummy test


            for (int i1iter = 0; i1iter < Input1.Count; i1iter++)
            {
                if (Input1[i1iter] > Input1[i1iter - 1] && Input1[i1iter + 1] < Input1[i1iter])
                {
                    ispeak = Input1[i1iter];
                    PeakValuesHolder.Add(ispeak);
                    PeakTimeHolder.Add(Timestamps1[i1iter]);
                }



            }
            for (int peakiter = 0; peakiter < PeakValuesHolder.Count; peakiter++)
            {
                if (PeakTimeHolder[peakiter + 1] - PeakTimeHolder[peakiter] > 0.5)
                {
                    TruePeakHolder.Add(PeakValuesHolder[peakiter]);
                    TruePeakTimeHolder.Add(PeakTimeHolder[peakiter]);
                }
            }


        }
    }
}
