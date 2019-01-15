# samsClubAssn
Sams Club Assn

Walmart Mobile Engineering app assignment: 
- Create a new application with WalmartLabs Code Test API integrated. The application should have two screens.
- We’ll be looking at your coding style, use of data structures, collections, and overall Platform SDK knowledge.
- It’s up to you to impress us with this assignment. The list of a products can be a simple or as fancy as you’d like it to be. 
- Include product image for each product.
- Try to have some fun.
- Don’t use any 3rd party networking libraries like AFNetworking or AlamoFire.
Screen 1:
- First screen should contain a List of all the products returned by the Service call.
- The list should support Lazy Loading. When scrolled to the bottom of the list, start lazy loading next page of products and append it to the list.
Screen 2:
- Second screen should display details of the product.


Assignment complete with:

Helpers
   - Image cache
   - String extension: converts HTML formatted text to string

Network Manager
   - Facilitates the handling of web resources: uploading and downloading

Models
   - Product: contains information pertaining to specific product
   - Product Container: contains summary of products

ViewModels
   - Contains business logic that begins downloading products for displaying to user
      - Contains information about products downloaded

Views
   - Custom View: table view cell that contains brief product information
   - Controllers: contain logic for displaying list of products and for displaying detailed product information on a selected product
