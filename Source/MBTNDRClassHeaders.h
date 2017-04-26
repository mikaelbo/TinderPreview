@interface TNDRMatchesMessagesViewModel : NSObject

- (id)matchForIndexPath:(NSIndexPath *)indexPath;

@end


@interface TNDRNewMatchesViewController : UIViewController

@property (strong, nonatomic) UICollectionView *collectionView;

- (void)collectionView:(id)view didSelectItemAtIndexPath:(id)indexPath;

@end


@interface TNDRMatchesViewController : UIViewController

@property (strong, nonatomic) TNDRMatchesMessagesViewModel *matchesWithMessagesViewModel;
@property (strong, nonatomic) TNDRNewMatchesViewController *matchesCollectionViewController;
@property (strong, nonatomic) UITableView *tableView;

- (void)didRequestToUnmatch:(id)unmatch;
- (void)didRequestToReport:(id)report;
- (void)presentProfileForMatch:(id)match withAvatarImage:(id)avatarImage;
- (void)tableView:(id)tableView didSelectRowAtIndexPath:(id)indexPath;
- (void)didSelectNewMatchCell:(id)cell atIndexPath:(id)indexPath;

@end


@interface TNDRSlidingPagedViewController : UIViewController 

@property (strong, nonatomic) TNDRMatchesViewController *matchesViewController;

@end


@interface TNDRMatch : NSObject

@property (readonly, assign, nonatomic) id theirGroupOwner;
@property (readonly, assign, nonatomic) id myGroup;
@property (nonatomic, strong) id user;

@end


@interface TNDRMatchCell : UITableViewCell

@property(readonly, strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *nameLabel;

@end

@interface TNDRMatchCell(GestureRecognizer)

- (void)MBTNDR_setLongPressRecognizer:(UILongPressGestureRecognizer *)recognizer;
- (UILongPressGestureRecognizer *)MBTNDR_longPressRecognizer;

@end


@interface TNDRNewMatchCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) TNDRMatch* match;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *nameLabel;

@end


@interface TNDRCurrentUser : NSObject

+ (instancetype)sharedCurrentUser;

@end


@interface TNDRSlackChatViewController : UIViewController

@property (nonatomic, strong) id match;

- (instancetype)initWithMatch:(id)match cachedMatchImage:(id)image animationDelegate:(id)delegate currentUser:(id)user;
- (void)showMatchProfileWithUser:(id)user;

@end
