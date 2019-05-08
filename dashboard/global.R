# Set up a tibble containing some important data about the various archery rounds
#
# The equation to calculate performance points is
#          pts = 100 x exp(a*(Score - b))
# where a comes from the model and b is the highest score in the dataset (i.e. "high_score" in tibble
# below).

rounds <- tribble(
  # round name, equipment class, high score in data set, "a" value from model, max possible score for round
  ~name, ~discipline, ~high_score, ~a, ~max_score,
  "USA Archery Outdoor 1440", "Compound", 1398, 0.009935, 1440,
  "NFAA Indoor 360", "Compound", 360, 0.00023, 360
)

