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
  ~name, ~discipline, ~high_score, ~min_score, ~a, ~max_score, ~curve,
  "USA Archery Outdoor 1440", "Compound", 1398, 1100, 0.009935, 1440, "exp", # Numbers not real
  "NFAA Indoor 360", "Compound", 360, 328, 0.00023, 360, "exp" # Numbers not real
)

