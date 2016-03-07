
#import "AppConstant.h"
#import "BuyerRequestVC.h"
#import "BTDropInCustomVC.h"
#import "ProgressHUD.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface BuyerRequestVC () <UITextFieldDelegate, UITextViewDelegate, BTDropInCustomVCDelegate, UISearchControllerDelegate, UITableViewDataSource,UITableViewDelegate>

@end

//------------------------------------------------------------------------------------------
@implementation BuyerRequestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _sharedData = [KMSHelper sharedInstance];
    _btService  = [BraintreeMerchantAPI sharedService];
    [self adjustIphoneModelHeights];
    
    // custom gig is indicated by a nil segueSender
    if (_segueSender == nil) {
        _sharedData.placeName    = @"Task (custom gig)";
        _sharedData.placeAddress = @"click to add your address";
        _sharedData.orderType    = @"Task";
        _sharedData.placeId      = @"";
        [self initSearchController];

        _searchButton.enabled = YES;
        _readyToRequest = NO;
    } else {
        
        _searchButton.enabled = NO;
        _readyToRequest = YES;
    }
  
    // setup common text labels
    _placeAddress.text      = _sharedData.placeAddress;
    _placeName.text         = _sharedData.placeName;
    _labelBWC.text          = @"* extra charge may apply during bad weather";
    _labelOfRatio.textColor = [UIColor redColor];

    [self checkCustomerlizePage:_sharedData.orderType];
    [self updateDate:[NSDate date]];
    
    _latitudeVar = @"0.0";
    _longitudeVar = @"0.0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)checkCustomerlizePage:(id)sender {
    if ([sender isEqualToString:@"Cronuts"]) {
        _timeToWaitLabel.text  = @"One order per sitter";
        _customerOfferLabel.text = @"2 Cronuts: $60";
        [self hidePlusHoursButtons:YES];
        _labelOfRatio.text = nil;
        
    } else if([sender isEqualToString:@"Signup"]) {
        _timeToWaitLabel.text  = @"Please be there early";
        _customerOfferLabel.text = @"Flat rate: $32";
        [self hidePlusHoursButtons:YES];
        _labelOfRatio.text = nil;
        
    } else if([sender isEqualToString:@"Experience"]) {
        _timeToWaitLabel.text  = @"Price will change by specific time";
        [self hidePlusHoursButtons:NO];
        _labelOfRatio.text = @"1 sitter per 1 or 2 customers";
        
    } else if([sender isEqualToString:@"Task"]) {
        _timeToWaitLabel.text  = @"Estimated hours";
        [self hidePlusHoursButtons:NO];
        _labelOfRatio.text = nil;
        
    } else if([sender isEqualToString:@"LineSwap"]) {
        _timeToWaitLabel.text = @"Hours (min. 2) you want us to wait";
        [self hidePlusHoursButtons:NO];
        _labelOfRatio.text = @"1 sitter for 1 customer only";
    }
    
    _hours = 1;
    [self hoursChanged];
}

//-----------------------------------------------------------------------------------------
#pragma mark - Autocomplete search

// init search result table for address search
- (void)initSearchResultTable {
    _searchResultTable = [[UITableView alloc] initWithFrame:CGRectMake(_topView.frame.origin.x,
                                                                         _topView.frame.size.height+50,
                                                                         self.view.frame.size.width,
                                                                         self.view.frame.size.height-_topView.frame.size.height)
                                                        style:UITableViewStylePlain];
    _searchResultTable.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _searchResultTable.delegate         = self;
    _searchResultTable.dataSource       = self;
    _searchResultTable.alpha            = 0.9;
    _searchResultTable.scrollEnabled    = YES;
    _searchResultTable.hidden           = NO;
    [self.view addSubview:_searchResultTable];
    [_searchController setActive:YES];
}

- (IBAction)searchForAddress:(id)sender {
    _addressField = [[UITextView alloc] initWithFrame:_addressField.frame];
    _addressField.alpha           = 1;
    _addressField.backgroundColor = [UIColor grayColor];
    _addressField.textColor       = [UIColor whiteColor];
    [_addressField setFont:[UIFont systemFontOfSize:14]];
    [_topView addSubview:_addressField];
    _addressField.delegate = self;
    [_addressField becomeFirstResponder];

    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _addressField.frame = _placeAddress.frame;
        _addressField.layer.cornerRadius = 5;
        _addressField.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        [self initSearchResultTable];
    } completion:^(BOOL finished){}];
}

- (void)removeAddressField {
    _searchResultPlaces = nil;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _addressField.frame = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [_addressField removeFromSuperview];
        [_searchResultTable removeFromSuperview];
    }];
}

- (void)initSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = (id<UISearchResultsUpdating>)self;
    self.searchController.delegate = self;
    _searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] initWithApiKey:KEY_AUTOCOMPLETE];
}

- (void)geoCodeUsingAddress:(NSString *)address {
    NSString *theAdress =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", theAdress];
  
    //disabled send request action
    _readyToRequest = NO;

    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:req] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dict) {
                NSArray *array = dict[@"results"];
                if ([array count] > 0){
                    _latitudeVar = array[0][@"geometry"][@"location"][@"lat"];
                    _longitudeVar = array[0][@"geometry"][@"location"][@"lng"];
                    NSString *address = array[0][@"formatted_address"];
                    if ([address length] > 0) {
                        if ([address containsString:@", USA"]) {
                            address = [address substringToIndex:[address length] - [@", USA" length]];
                        } else if ([address containsString:@", United States"]) {
                            address = [address substringToIndex:[address length] - [@", United States" length]];
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _placeAddress.text = address;
                        _readyToRequest = YES;
                    });
                }
            }
        }
    }] resume];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (![_addressField.text length]) {
        self.searchResultTable.alpha = 0.0;
        return;
    }
  
    _searchQuery.input = _addressField.text;
    dispatch_async(dispatch_get_main_queue(),^{
        [_searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
            if (error) {
                [ProgressHUD showError:@"Could not fetch places"];
            } else {
                _searchResultPlaces = places;
                self.searchResultTable.alpha = 0.9;
                [self.searchResultTable reloadData];
            }
        }];
    });
}

- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [_searchResultPlaces objectAtIndex:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_searchResultPlaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SPGooglePlacesAutocompletePlace *place = [self placeAtIndexPath:indexPath];
    [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
        //_placeAddress.text = addressString;
        _sharedData.placeId = addressString;
        [self geoCodeUsingAddress:addressString];
        [self.searchController setActive:NO];
    }];
    [self removeAddressField];
}

//-----------------------------------------------------------------------------------------
#pragma mark - helper method

- (NSString *)assembleSecretCode {
    return [NSString stringWithFormat:@"%zd%zd%zd%zd",
            arc4random_uniform(10),
            arc4random_uniform(10),
            arc4random_uniform(10),
            arc4random_uniform(10)];
}

//iphone different size screen showing
- (void)adjustIphoneModelHeights {
    // iPhone 4 series
    if (480 == [[UIScreen mainScreen] bounds].size.height) {
        _msgWidth.constant  = 320;
        _amountTop.constant = 0;
        _plusTop.constant   = 0;
        [self.view layoutIfNeeded];
    }
    // iPhone 5 series
    if (568 == [[UIScreen mainScreen] bounds].size.height) {
        [self.view layoutIfNeeded];
    }
    //iphone 6 series
    if (667 == [[UIScreen mainScreen] bounds].size.height) {
      _msgWidth.constant  = 375;
      _amountTop.constant = 0;
      _plusTop.constant   = 0;
      [self.view layoutIfNeeded];
    }
    //iphone 6s series
    if (736 == [[UIScreen mainScreen] bounds].size.height) {
      _msgWidth.constant  = 414;
      _amountTop.constant = 0;
      _plusTop.constant   = 0;
      [self.view layoutIfNeeded];
    }
}

- (void)adjustHeightConstraints {
    [self.view layoutIfNeeded];
    CGFloat configHeight = _configView.frame.size.height-64;
  // get rid of nav height
    _box1HeightConstraint.constant = configHeight / 3;
    _box2HeightConstraint.constant = configHeight / 3;
}

- (void)hidePlusHoursButtons:(BOOL)hide{
    _plusButton.hidden       = hide;
    _subtractButton.hidden   = hide;
}

//-----------------------------------------------------------------------------------------
#pragma mark - change hours of wait in line

- (void)hoursChanged {
    int min = 1;
    if ([_sharedData.orderType isEqualToString:@"LineSwap"]) min = 2;
    if (_hours > 24) _hours = 24;
    if (_hours < min) _hours = min;
    
    if ([_sharedData.orderType isEqualToString:@"LineSwap"]) {
        _price = 5+20*_hours;
        [_customerOfferLabel setText:[NSString stringWithFormat:@"%zd hr = $%zd", _hours, (int)_price]];
    } else if ([_sharedData.orderType isEqualToString:@"Experience"]){
        _price = 10+20*_hours;
        [_customerOfferLabel setText:[NSString stringWithFormat:@"%zd hr = $%zd", _hours, (int)_price]];
    } else if ([_sharedData.orderType isEqualToString:@"Task"]){
        _price = 22+10*_hours;
        [_customerOfferLabel setText:[NSString stringWithFormat:@"%zd hr = $%zd", _hours, (int)_price]];
    } else if ([_sharedData.orderType isEqualToString:@"Cronuts"]){
        _price = 60;
    } else if ([_sharedData.orderType isEqualToString:@"Signup"]) {
        _price = 32;
    }
}

- (IBAction)plusTimer:(id)sender{
    ++_hours;
    [self hoursChanged];
}

- (IBAction)subtractTimer:(id)sender{
    --_hours;
    [self hoursChanged];
}

//------------------------------------------------------------------------------------------
#pragma mark - request action

- (IBAction)requestOrder:(id)sender {
    
    // 1 check if user exist
    if (_sharedData.myParseObj == nil) {
        [self loadLoginStatus];
        return;

    // 2. check if request is valid
    } else if (!_readyToRequest) {
        UIAlertView *warning = [[UIAlertView alloc] initWithTitle:@"Need More Info" message:@"Please let us know your task destination address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [warning show];
    
    } else {
        // debug begin
        AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [del visualizeLocatingDudes];
        [self backendBuyerRequest];
        [self dismissVC];
        return;
        // debug end, remove this later
        
        // the following code should be the good one, but not reachable here
        
    // 3. check if braintree vault is ready
        [[BraintreeMerchantAPI sharedService] getVaultStatus:_sharedData.myParseObj.objectId completion:^(NSString *vaultStatus, NSError *error) {
            if (error) {
                [KMSHelper displayError:error forTask:@"Error Creating Transation"];
            } else {
                if (![vaultStatus isEqualToString:@"YES"]) {
                    [self presentDropInView];
                } else {
                    // finally here's the real deal
                    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [del visualizeLocatingDudes];
                    [self backendBuyerRequest];
                    [self dismissVC];
                }
            }
        }];
    }
}

//------------------------------------------------------------------------------------------
# pragma mark - set arrival time

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame    = CGRectMake(0,
                                            self.view.bounds.size.height,
                                            self.view.frame.size.width,
                                            40);
    CGRect datePickerTargetFrame = CGRectMake(20,
                                            self.view.bounds.size.height/2+40,
                                            self.view.frame.size.width-40,
                                            self.view.frame.size.height - (self.view.bounds.size.height/2+40));
    CGRect textOptionFrame       = CGRectMake(0,
                                            0,
                                            self.view.frame.size.width,
                                            50);
  
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view viewWithTag:9].alpha  = 0;
        [self.view viewWithTag:10].frame = datePickerTargetFrame;
        [self.view viewWithTag:11].frame = toolbarTargetFrame;
        [self.view viewWithTag:12].frame = textOptionFrame;
    } completion:^(BOOL finished) {
        [self removePickerViews];
    }];
}

- (void)removePickerViews {
    [[self.view viewWithTag:9]  removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
    [[self.view viewWithTag:12] removeFromSuperview];
    [[self.view viewWithTag:30] removeFromSuperview];
    [[self.view viewWithTag:31] removeFromSuperview];
}

- (void)doneButton:(id)sender {
//    NSDate *pickerTake = datePicker.date;
//    NSTimeInterval hoursChanged = _hours * 60 * 60;
//    // change it to with two component
//    NSDate *newDate = [pickerTake dateByAddingTimeInterval:hoursChanged];

    // check for ascending order
    if ([_datePicker.date compare:[NSDate date]] == NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"Task time earlier than current time!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // TODO: come back to check if hours are counted as well
    
    [self dismissDatePicker:self];
}

- (IBAction)pickArrivalTime:(id)sender {
    //toolbar frame and picker frame
    CGRect toolbarTargetFrame   = CGRectMake(20,
                                             self.view.bounds.size.height/2,
                                             self.view.frame.size.width-40,
                                             40);
    
    CGRect datePickerTargetFrame = CGRectMake(20,
                                              self.view.bounds.size.height/2+40,
                                              self.view.frame.size.width-40,
                                              self.view.frame.size.height - (self.view.bounds.size.height/2+40));
    
    CGRect textOptionFrame = CGRectMake((self.view.frame.size.width/2)-
                                        (self.view.frame.size.width-100)/2,
                                         80,
                                         self.view.frame.size.width-100,
                                         250);
    
    // dark view with tapGesture
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag   = 9;
    darkView.alpha = 0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 300)];
    [label setFont:[UIFont fontWithName:@"Arial" size:30]];
    label.textColor     = [UIColor whiteColor];
    label.tag           = 12;
    label.numberOfLines = 4;
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
    
    NSString *orderType = _sharedData.orderType;
      
    if ([orderType isEqualToString:@"LineSwap"]) {
        label.text = @"Please arrive 40 minutes before the sale starts. One sitter, one customer!";
    } else if([orderType containsString:@"Signup"]) {
        label.text = @"Please be on time, otherwise you could miss your call.";
    }
    
    //add instruction on the layer page
    //date and time are setting up with picker
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(20,
                                                                self.view.bounds.size.height+40,
                                                                self.view.frame.size.width-40,
                                                                216)];
    _datePicker.tag = 10;
    _datePicker.backgroundColor = [UIColor grayColor];
    [_datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    [_datePicker addTarget:_datePicker.date action:@selector(datepickerDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    
    //toorBar with done button and space
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                                     self.view.bounds.size.height,
                                                                     self.view.frame.size.width,
                                                                     40)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        toolBar.frame     = toolbarTargetFrame;
        _datePicker.frame = datePickerTargetFrame;
        label.frame       = textOptionFrame;
        darkView.alpha    = 0.85;
    } completion:^(BOOL finished) {
    }];
}

- (void)datepickerDidChange:(UIDatePicker *) picker {
    [self updateDate:picker.date];
}

- (void)updateDate:(NSDate *)date {
    // server time will be sent to BE
    NSDateFormatter *serverFormatter = [[NSDateFormatter alloc] init];
    [serverFormatter setDateFormat:@"HH:mma MM/dd/yyyy"];
    [serverFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    _serverTime = [serverFormatter stringFromDate:date];
  
    // local time should be used for UI
    NSDateFormatter *userFormatter = [[NSDateFormatter alloc] init];
    [userFormatter setDateFormat:@"HH:mma MM/dd/yyyy"];
    [userFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *localTime = [userFormatter stringFromDate:date];
    _arrivalTime.text = localTime; // display with local time
}

//------------------------------------------------------------------------------------------
# pragma mark - Customer Instructions (box3)

- (IBAction)writeCustomInstructions:(id)sender {
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 20;
    darkView.alpha = 0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCustomInstructionViews)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];

    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self initCustomInstructionField];
        darkView.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
}

- (void)initCustomInstructionField {
    _customInstructionField = [[UITextView alloc] initWithFrame: CGRectMake(0,
                      self.view.frame.size.height/2,
                      self.view.frame.size.width,
                      self.view.frame.size.height-(self.view.bounds.size.height/2))];
  
    _customInstructionField.tag             = 21;
    _customInstructionField.alpha           = 0.85;
    _customInstructionField.textColor       = [UIColor colorWithRed:256.0 green:256.0 blue:256.0 alpha:1];
    _customInstructionField.backgroundColor = [UIColor grayColor];
    [_customInstructionField setFont:[UIFont systemFontOfSize:25]];
    [self.view addSubview:_customInstructionField];
    _customInstructionField.delegate = self;
    [_customInstructionField becomeFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textField {
    if (![textField.text  isEqual: @""]){
        textField.text = @"";
    }
    int i = self.view.frame.size.height-(self.view.bounds.size.height/2);
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect newRect = CGRectMake(0,
                                    i-250,
                                    self.view.frame.size.width,
                                    self.view.frame.size.height-(self.view.bounds.size.height/2));
        textField.frame = newRect;
    } completion:^(BOOL finished) {
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
  if (_customInstructionField) {
      if ([textView.text isEqual:@"(customer instructions)"]){
        _customInstructions.text = @"";
      } else {
        _customInstructions.text = textView.text;
      }
  } else if (_addressField) {
      [self updateSearchResultsForSearchController:self.searchController];
  }
}

- (void)removeCustomInstructionViews {
    CGRect testField = CGRectMake(0,
                                self.view.frame.size.height/2,
                                self.view.frame.size.width,
                                self.view.frame.size.height-(self.view.bounds.size.height/2));
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view viewWithTag:20].alpha = 0;
        [self.view viewWithTag:21].frame = testField;
    } completion:^(BOOL finished) {
        [[self.view viewWithTag:20] removeFromSuperview];
        [[self.view viewWithTag:21] removeFromSuperview];
    }];
}

//------------------------------------------------------------------------------------------
#pragma mark - Backend

-(void)add_favorite {
  NSString *postDatas = [NSString stringWithFormat:@"buyer_id=%@", _sharedData.myParseObj.objectId];
//NSData *postData = [postDatas dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
  //NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  
  [request setURL:[NSURL URLWithString:@"https://keepmyseat.com:8443/mmkms-v1/linedude/buyer/add_favorite"]];
//  request = [NSMutableURLRequest requestWithURL:url
//                                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
  [request setHTTPMethod:@"POST"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPBody:[postDatas dataUsingEncoding:NSUTF8StringEncoding]];
  [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (!error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
        NSLog(@"buyer request return: %@", dict);
        //[self parsePushBuyerRequest];
    }
  }] resume];
}

- (void)backendBuyerRequest {
    
    // generate secret code for this transaction
    _secrectDigits = [self assembleSecretCode];
    
    //=============== BACKEND ==================
//    NSLog(@"BACKEND: /buyer/place_order_on_seller_items (POST)");
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/buyer/request_service", API_HTTPS_ENDPOINT]];
    NSString *postString = [NSString stringWithFormat:@"buyer_id=%@&buyer_name=%@&price=%zd&time_of_arrival=%@&custom_message=%@&location_hashId=%@&latitude=%@&longitude=%@&order_type=%@&secret_code=%@",
                        _sharedData.myParseObj.objectId,
                        _sharedData.myParseObj.username,
                        (int)_price,
                        _serverTime,
                        _customInstructions.text,
                        _sharedData.placeId,
                        _latitudeVar,
                        _longitudeVar,
                        _sharedData.orderType,
                        _secrectDigits
    ];
    
    NSLog(@"post string = %@", postString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:CONST_REQ_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
            NSLog(@"buyer request return: %@", dict);
            [self parsePushBuyerRequest];
        }
    }] resume];
}

- (void)parsePushBuyerRequest {
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"LineDudeSitters"];
    NSString *message = [NSString stringWithFormat:@"New buyer request from %@!", _sharedData.myParseObj[@"fullname"]];
    NSDictionary *pushData = @{ @"aps" : @{
                                        @"alert" : message,
                                        @"badge" : @1,
                                        @"sound" : @"cashier_sound.caf"},
                                        @"pushKey" : @"BUYER_REQUEST"};
    [push setData:pushData];
    [push sendPushInBackground];
}

//------------------------------------------------------------------------------------------
#pragma mark - Braintree Dropin

- (void)presentDropInView {
    UIViewController *dropInViewController;
    dropInViewController = [self configuredDropInViewController];
    if (dropInViewController) {
        dropInViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dropInCustomVCDidCancel:)];
        UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:dropInViewController];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (BTDropInCustomVC *)configuredDropInViewController {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [_btService.braintree.client postAnalyticsEvent:@"custom.ios.dropin.init" success:nil failure:nil];
    BTDropInCustomVC *dropInViewController = [[BTDropInCustomVC alloc] initWithClient:_btService.braintree.client];
    dropInViewController.delegate = self;
    [dropInViewController fetchPaymentMethods];
    
    dropInViewController.title = @"Payment Card (Buyer)";
    dropInViewController.summaryTitle = @"Register a card to request your seat";
    dropInViewController.summaryDescription = @"(Charged only when enter escrow with seller)";
    //    dropInViewController.displayAmount = @"$5.00";
    dropInViewController.callToActionText = @"Register Card";
    dropInViewController.shouldHideCallToAction = NO;
    dropInViewController.view.backgroundColor = [UIColor blackColor];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buyer_bg.png"]];
    bg.frame = dropInViewController.view.frame;
    [dropInViewController.view insertSubview:bg atIndex:0];
    
    return dropInViewController;
}

- (void)dropInCustomVC:(__unused BTDropInCustomVC *)viewController didSucceedWithPaymentMethod:(BTPaymentMethod *)paymentMethod {
    // update card form
    BTUICardFormView *cardForm = viewController.dropInContentView.cardForm;
    NSString *expirationDate = [NSString stringWithFormat:@"%@/%@", cardForm.expirationMonth, cardForm.expirationYear];
    [ProgressHUD show:@"Updating buyer card info ... "];
    [_btService updateCustomerInfo:[KMSHelper sharedInstance].myParseObj.objectId number:cardForm.number expirationDate:expirationDate cvv:cardForm.cvv completion:^(NSString *success,NSString *status, NSError *error){
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error) {
            [KMSHelper displayError:error forTask:@"updateCustomerInfo"];
        } else {
//            NSString *message = [NSString stringWithFormat:@"%@%@;\n%@%@;", @"success=", success,@"status=", status];
            if([success isEqualToString:@"success"]) {
                [ProgressHUD showSuccess:@"Success!"];
            } else {
                [ProgressHUD showError:@"Something went wrong ..."];
            }
        }
    }];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropInCustomVCDidCancel:(__unused BTDropInCustomVC *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//------------------------------------------------------------------------------------------
#pragma mark - Segue

- (IBAction)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadLoginStatus{
    [self performSegueWithIdentifier:@"SegLogin" sender:self];
}

@end
