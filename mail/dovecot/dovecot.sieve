require "fileinto";

if exists "X-Spam-Flag" {
  if header :contains "X-Spam-Flag" "NO" {
  } else {
    fileinto "Junk";
    stop;
  }
}