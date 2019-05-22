# Set up a tibble containing some important data about the various archery rounds
#
# The equation to calculate performance points is
#          pts = 100 x exp(a*(Score - b))
# where a comes from the model and b is the highest score in the dataset (i.e. "high_score" in tibble
# below).

library(tidyverse)

rounds <- tribble(
  # round name, equipment class, high score in data set, minimum score to earn points,
  # "a" value from model, max possible score for round, curve type (e.g., "exp" or "linear")
  ~name, ~discipline, ~max_score, ~low_score, ~high_score, ~a, ~slope, ~intercept, ~model,
  "USA 25-Meter 1200", "Compound", 1200, 1080, 1154, 0.026899, 1.550, -1692.014, "exp",
  "USA 25-Meter 1200", "Recurve", 1200, 955, 1094, 0.012048, 0.702, -670.346, "linear",
  "USA 25-Meter 600", "Compound", 600, 540, 577, 0.053798, 3.101, -1692.014, "exp",
  "USA 25-Meter 600", "Recurve", 600, 478, 547, 0.024097, 1.404, -670.346, "linear",
  "NFAA 600", "Compound", 600, 432, 583, 0.018552, 0.682, -313.586, "exp",
  "NFAA 600", "Recurve", 600, 391, 524, 0.010131, 0.760, -290.794, "linear",
  "NFAA 900", "Compound", 900, 811, 887, 0.035309, 1.454, -1203.247, "exp",
  "NFAA 900", "Recurve", 900, 664, 810, 0.013973, 0.607, -403.064, "exp",
  "NFAA Animal 294", "Compound", 294, 282, 290, 0.189326, 11.730, -3302.119, "linear",
  "NFAA Animal 294", "Recurve", 294, 262, 289, 0.194967, 3.314, -882.674, "exp",
  "NFAA Animal 588", "Compound", 588, 564, 580, 0.094663, 5.865, -3302.119, "linear",
  "NFAA Animal 588", "Recurve", 588, 523, 578, 0.097484, 1.657, -882.674, "exp",
  "NFAA Field 280", "Compound", 280, 256, 277, 0.110354, 4.986, -1291.699, "exp",
  "NFAA Field 280", "Recurve", 280, 206, 244, 0.051311, 2.565, -532.669, "exp",
  "NFAA Field 560", "Compound", 560, 511, 554, 0.055177, 2.493, -1291.699, "exp",
  "NFAA Field 560", "Recurve", 560, 412, 487, 0.025655, 1.282, -532.669, "exp",
  "NFAA Hunter 280", "Compound", 280, 256, 278, 0.110390, 5.076, -1321.150, "exp",
  "NFAA Hunter 280", "Recurve", 280, 197, 246, 0.041967, 2.003, -401.170, "exp",
  "NFAA Hunter 560", "Compound", 560, 513, 556, 0.055195, 2.538, -1321.150, "exp",
  "NFAA Hunter 560", "Recurve", 560, 394, 491, 0.020984, 1.001, -401.170, "exp",
  "NFAA Indoor 360", "Compound", 360, 328, 358, 0.100895, 3.673, -1232.857, "exp",
  "NFAA Indoor 360", "Recurve", 360, 239, 312, 0.021531, 1.355, -322.489, "linear",
  "NFAA Indoor 720", "Compound", 720, 657, 717, 0.050447, 1.837, -1232.857, "exp",
  "NFAA Indoor 720", "Recurve", 720, 476, 625, 0.010765, 0.678, -322.489, "linear",
  "USA Indoor 1200", "Compound", 1200, 1027, 1165, 0.015055, 0.874, -920.378, "exp",
  "USA Indoor 1200", "Recurve", 1200, 707, 1104, 0.005261, 0.279, -213.835, "exp",
  "USA Indoor 600", "Compound", 600, 514, 582, 0.030111, 1.747, -920.378, "exp",
  "USA Indoor 600", "Recurve", 600, 354, 552, 0.010522, 0.558, -213.835, "exp",
  "USA Outdoor 1440", "Compound", 1440, 1149, 1397, 0.009922, 0.420, -499.809, "exp",
  "USA Outdoor 1440", "Recurve", 1440, 894, 1252, 0.004729, 0.270, -241.103, "linear",
  "USA Outdoor 720", "Compound", 720, 574, 698, 0.019843, 0.841, -499.809, "exp",
  "USA Outdoor 720", "Recurve", 720, 447, 626, 0.009458, 0.540, -241.103, "linear",
  "Vegas 330", "Compound", 330, 277, 320, 0.048037, 2.556, -722.812, "exp",
  "Vegas 330", "Recurve", 330, 202, 296, 0.021600, 1.163, -249.022, "exp"
)

