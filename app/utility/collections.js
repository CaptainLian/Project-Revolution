
const collections = Object.create(null);
const utilities = Object.create(null);


/**
 * Conducts binary search to an array
 * @method
 * @param   {Array} array               The array to be searched
 * @param   {Any} value                 The value to be searched
 * @param   {Function(a, b)} comparison A function that dicates how 2 values within the array are compared,
 *                                       - function must return a value less than 0 to indicate a < b
 *                                       - function must return 0 if a = b
 *                                       - function must return a value greater than 0 to indicate a > b 
 * @returns {Integer}                   The index of the value within the array
 */
utilities.binarySearch = (array, value, comparator) => {
	let lowestIndex = 0;
	let highestIndex = array.length;
	comparator = comparator || ((a, b) => {
		if(a > b) return 1;
		if(a < b) return -1;
		return 0;
	});

	while(lowestIndex <= highestIndex){
		//Get to the middle of high and low using fast division by 2
		const middle = (lowestIndex + highestIndex) >> 1;
		const comparison = comparator(value, array[middle]);
		if(comparison > 0){
			lowestIndex = middle + 1;
		}else if(comparison < 0){
			highestIndex = middle + 1;
		}else{
			return middle;
		}
	}

	return -lowestIndex - 1;
};

/**
 * Conducts binary search to an array to confirm the existence of the value within the array
 * @method
 * @param   {Array} array               The array to be searched
 * @param   {Any} value                 The value to be searched
 * @param   {Function(a, b)} comparison A function that dicates how 2 values within the array are compared,
 *                                       - function must return a value less than 0 to indicate a < b
 *                                       - function must return 0 if a = b
 *                                       - function must return a value greater than 0 to indicate a > b 
 * @returns {Boolean}                   True if the value exists in the array, false otherwise
 */
utilities.binarySearchContains = (array, value, comparator) => {
	return utilities.binarySearch(array, value, comparator) >= 0;
};



collections.utilities = utilities;
module.exports = collections;