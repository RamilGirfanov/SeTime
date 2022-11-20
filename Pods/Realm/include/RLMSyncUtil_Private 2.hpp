////////////////////////////////////////////////////////////////////////////
//
// Copyright 2016 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import "RLMSyncUtil_Private.h"

#import "RLMSyncConfiguration_Private.h"

#import <realm/object-store/sync/sync_manager.hpp>
#import <realm/util/optional.hpp>

@class RLMSyncErrorResponseModel;
class CocoaSyncUserContext;

namespace realm {
enum class AccessLevel;
}

realm::SyncSessionStopPolicy translateStopPolicy(RLMSyncStopPolicy stopPolicy);
RLMSyncStopPolicy translateStopPolicy(realm::SyncSessionStopPolicy stop_policy);

typedef NS_ENUM(NSUInteger, RLMClientResetMode);
RLMClientResetMode translateClientResetMode(realm::ClientResyncMode mode);
realm::ClientResyncMode translateClientResetMode(RLMClientResetMode mode);

#pragma mark - Get user context

CocoaSyncUserContext& context_for(const std::shared_ptr<realm::SyncUser>& user);

#pragma mark - Error construction

NSError *make_auth_error_bad_response(NSDictionary *json=nil);
NSError *make_auth_error_http_status(NSInteger status);
NSError *make_auth_error_client_issue();
NSError *make_auth_error(RLMSyncErrorResponseModel *responseModel);

// Set 'code' to NSNotFound to not actually have an error code.
NSError *make_sync_error(RLMSyncSystemErrorKind kind, NSString *description, NSInteger code, NSDictionary *custom);
NSError *make_sync_error(NSError *wrapped_auth_error);
NSError *make_sync_error(std::error_code, RLMSyncSystemErrorKind kind=RLMSyncSystemErrorKindSession);
