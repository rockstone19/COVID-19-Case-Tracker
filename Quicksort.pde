// quicksort: Wen Geng Lin
// sort casesLowHigh from lowest number of cases to highest using quicksort

void swap(ArrayList<DailyCase> arr, int i, int j)
{
  DailyCase tempCase = arr.get(i);
  arr.set(i, arr.get(j));
  arr.set(j, tempCase);
}

int partition(ArrayList<DailyCase> arr, int low, int high)
{
  int pivot = arr.get(high).cases;

  int i = (low-1);

  for (int j = low; j <= high - 1; j++)
  {
    if (arr.get(j).cases < pivot)
    {
      i++;
      swap(arr, i, j);
    }
  }
  swap(arr, i + 1, high);
  return (i + 1);
}

void quickSort(ArrayList<DailyCase> arr, int low, int high)
{
  if (low < high)
  {
    int pi = partition(arr, low, high);

    quickSort(arr, low, pi - 1);
    quickSort(arr, pi + 1, high);
  }
}
