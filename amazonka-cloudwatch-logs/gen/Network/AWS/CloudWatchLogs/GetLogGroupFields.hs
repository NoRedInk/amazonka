{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.CloudWatchLogs.GetLogGroupFields
-- Copyright   : (c) 2013-2018 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+amazonka@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Returns a list of the fields that are included in log events in the specified log group, along with the percentage of log events that contain each field. The search is limited to a time period that you specify.
--
--
-- In the results, fields that start with @ are fields generated by CloudWatch Logs. For example, @@timestamp@ is the timestamp of each log event.
--
-- The response results are sorted by the frequency percentage, starting with the highest percentage.
--
module Network.AWS.CloudWatchLogs.GetLogGroupFields
    (
    -- * Creating a Request
      getLogGroupFields
    , GetLogGroupFields
    -- * Request Lenses
    , glgfTime
    , glgfLogGroupName

    -- * Destructuring the Response
    , getLogGroupFieldsResponse
    , GetLogGroupFieldsResponse
    -- * Response Lenses
    , glgfrsLogGroupFields
    , glgfrsResponseStatus
    ) where

import Network.AWS.CloudWatchLogs.Types
import Network.AWS.CloudWatchLogs.Types.Product
import Network.AWS.Lens
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | /See:/ 'getLogGroupFields' smart constructor.
data GetLogGroupFields = GetLogGroupFields'{_glgfTime
                                            :: !(Maybe Nat),
                                            _glgfLogGroupName :: !Text}
                           deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'GetLogGroupFields' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'glgfTime' - The time to set as the center of the query. If you specify @time@ , the 8 minutes before and 8 minutes after this time are searched. If you omit @time@ , the past 15 minutes are queried. The @time@ value is specified as epoch time, the number of seconds since January 1, 1970, 00:00:00 UTC.
--
-- * 'glgfLogGroupName' - The name of the log group to search.
getLogGroupFields
    :: Text -- ^ 'glgfLogGroupName'
    -> GetLogGroupFields
getLogGroupFields pLogGroupName_
  = GetLogGroupFields'{_glgfTime = Nothing,
                       _glgfLogGroupName = pLogGroupName_}

-- | The time to set as the center of the query. If you specify @time@ , the 8 minutes before and 8 minutes after this time are searched. If you omit @time@ , the past 15 minutes are queried. The @time@ value is specified as epoch time, the number of seconds since January 1, 1970, 00:00:00 UTC.
glgfTime :: Lens' GetLogGroupFields (Maybe Natural)
glgfTime = lens _glgfTime (\ s a -> s{_glgfTime = a}) . mapping _Nat

-- | The name of the log group to search.
glgfLogGroupName :: Lens' GetLogGroupFields Text
glgfLogGroupName = lens _glgfLogGroupName (\ s a -> s{_glgfLogGroupName = a})

instance AWSRequest GetLogGroupFields where
        type Rs GetLogGroupFields = GetLogGroupFieldsResponse
        request = postJSON cloudWatchLogs
        response
          = receiveJSON
              (\ s h x ->
                 GetLogGroupFieldsResponse' <$>
                   (x .?> "logGroupFields" .!@ mempty) <*>
                     (pure (fromEnum s)))

instance Hashable GetLogGroupFields where

instance NFData GetLogGroupFields where

instance ToHeaders GetLogGroupFields where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("Logs_20140328.GetLogGroupFields" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON GetLogGroupFields where
        toJSON GetLogGroupFields'{..}
          = object
              (catMaybes
                 [("time" .=) <$> _glgfTime,
                  Just ("logGroupName" .= _glgfLogGroupName)])

instance ToPath GetLogGroupFields where
        toPath = const "/"

instance ToQuery GetLogGroupFields where
        toQuery = const mempty

-- | /See:/ 'getLogGroupFieldsResponse' smart constructor.
data GetLogGroupFieldsResponse = GetLogGroupFieldsResponse'{_glgfrsLogGroupFields
                                                            ::
                                                            !(Maybe
                                                                [LogGroupField]),
                                                            _glgfrsResponseStatus
                                                            :: !Int}
                                   deriving (Eq, Read, Show, Data, Typeable,
                                             Generic)

-- | Creates a value of 'GetLogGroupFieldsResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'glgfrsLogGroupFields' - The array of fields found in the query. Each object in the array contains the name of the field, along with the percentage of time it appeared in the log events that were queried.
--
-- * 'glgfrsResponseStatus' - -- | The response status code.
getLogGroupFieldsResponse
    :: Int -- ^ 'glgfrsResponseStatus'
    -> GetLogGroupFieldsResponse
getLogGroupFieldsResponse pResponseStatus_
  = GetLogGroupFieldsResponse'{_glgfrsLogGroupFields =
                                 Nothing,
                               _glgfrsResponseStatus = pResponseStatus_}

-- | The array of fields found in the query. Each object in the array contains the name of the field, along with the percentage of time it appeared in the log events that were queried.
glgfrsLogGroupFields :: Lens' GetLogGroupFieldsResponse [LogGroupField]
glgfrsLogGroupFields = lens _glgfrsLogGroupFields (\ s a -> s{_glgfrsLogGroupFields = a}) . _Default . _Coerce

-- | -- | The response status code.
glgfrsResponseStatus :: Lens' GetLogGroupFieldsResponse Int
glgfrsResponseStatus = lens _glgfrsResponseStatus (\ s a -> s{_glgfrsResponseStatus = a})

instance NFData GetLogGroupFieldsResponse where
