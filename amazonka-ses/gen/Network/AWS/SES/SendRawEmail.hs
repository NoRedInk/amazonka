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
-- Module      : Network.AWS.SES.SendRawEmail
-- Copyright   : (c) 2013-2018 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+amazonka@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Composes an email message and immediately queues it for sending.
--
--
-- This operation is more flexible than the @SendEmail@ API operation. When you use the @SendRawEmail@ operation, you can specify the headers of the message as well as its content. This flexibility is useful, for example, when you want to send a multipart MIME email (such a message that contains both a text and an HTML version). You can also use this operation to send messages that include attachments.
--
-- The @SendRawEmail@ operation has the following requirements:
--
--     * You can only send email from <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-addresses-and-domains.html verified email addresses or domains> . If you try to send email from an address that isn't verified, the operation results in an "Email address not verified" error.
--
--     * If your account is still in the <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/request-production-access.html Amazon SES sandbox> , you can only send email to other verified addresses in your account, or to addresses that are associated with the <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/mailbox-simulator.html Amazon SES mailbox simulator> .
--
--     * The maximum message size, including attachments, is 10 MB.
--
--     * Each message has to include at least one recipient address. A recipient address includes any address on the To:, CC:, or BCC: lines.
--
--     * If you send a single message to more than one recipient address, and one of the recipient addresses isn't in a valid format (that is, it's not in the format /UserName@[SubDomain.]Domain.TopLevelDomain/ ), Amazon SES rejects the entire message, even if the other addresses are valid.
--
--     * Each message can include up to 50 recipient addresses across the To:, CC:, or BCC: lines. If you need to send a single message to more than 50 recipients, you have to split the list of recipient addresses into groups of less than 50 recipients, and send separate messages to each group.
--
--     * Amazon SES allows you to specify 8-bit Content-Transfer-Encoding for MIME message parts. However, if Amazon SES has to modify the contents of your message (for example, if you use open and click tracking), 8-bit content isn't preserved. For this reason, we highly recommend that you encode all content that isn't 7-bit ASCII. For more information, see <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-raw.html#send-email-mime-encoding MIME Encoding> in the /Amazon SES Developer Guide/ .
--
--
--
-- Additionally, keep the following considerations in mind when using the @SendRawEmail@ operation:
--
--     * Although you can customize the message headers when using the @SendRawEmail@ operation, Amazon SES will automatically apply its own @Message-ID@ and @Date@ headers; if you passed these headers when creating the message, they will be overwritten by the values that Amazon SES provides.
--
--     * If you are using sending authorization to send on behalf of another user, @SendRawEmail@ enables you to specify the cross-account identity for the email's Source, From, and Return-Path parameters in one of two ways: you can pass optional parameters @SourceArn@ , @FromArn@ , and/or @ReturnPathArn@ to the API, or you can include the following X-headers in the header of your raw email:
--
--     * @X-SES-SOURCE-ARN@ 
--
--     * @X-SES-FROM-ARN@ 
--
--     * @X-SES-RETURN-PATH-ARN@ 
--
--
--
-- /Important:/ Don't include these X-headers in the DKIM signature. Amazon SES removes these before it sends the email.
--
-- If you only specify the @SourceIdentityArn@ parameter, Amazon SES sets the From and Return-Path addresses to the same identity that you specified.
--
-- For more information about sending authorization, see the <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html Using Sending Authorization with Amazon SES> in the /Amazon SES Developer Guide./ 
--
--     * For every message that you send, the total number of recipients (including each recipient in the To:, CC: and BCC: fields) is counted against the maximum number of emails you can send in a 24-hour period (your /sending quota/ ). For more information about sending quotas in Amazon SES, see <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/manage-sending-limits.html Managing Your Amazon SES Sending Limits> in the /Amazon SES Developer Guide./ 
--
--
--
module Network.AWS.SES.SendRawEmail
    (
    -- * Creating a Request
      sendRawEmail
    , SendRawEmail
    -- * Request Lenses
    , sreConfigurationSetName
    , sreSourceARN
    , sreDestinations
    , sreReturnPathARN
    , sreSource
    , sreFromARN
    , sreTags
    , sreRawMessage

    -- * Destructuring the Response
    , sendRawEmailResponse
    , SendRawEmailResponse
    -- * Response Lenses
    , srersResponseStatus
    , srersMessageId
    ) where

import Network.AWS.Lens
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response
import Network.AWS.SES.Types
import Network.AWS.SES.Types.Product

-- | Represents a request to send a single raw email using Amazon SES. For more information, see the <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-raw.html Amazon SES Developer Guide> .
--
--
--
-- /See:/ 'sendRawEmail' smart constructor.
data SendRawEmail = SendRawEmail'{_sreConfigurationSetName
                                  :: !(Maybe Text),
                                  _sreSourceARN :: !(Maybe Text),
                                  _sreDestinations :: !(Maybe [Text]),
                                  _sreReturnPathARN :: !(Maybe Text),
                                  _sreSource :: !(Maybe Text),
                                  _sreFromARN :: !(Maybe Text),
                                  _sreTags :: !(Maybe [MessageTag]),
                                  _sreRawMessage :: !RawMessage}
                      deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'SendRawEmail' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'sreConfigurationSetName' - The name of the configuration set to use when you send an email using @SendRawEmail@ .
--
-- * 'sreSourceARN' - This parameter is used only for sending authorization. It is the ARN of the identity that is associated with the sending authorization policy that permits you to send for the email address specified in the @Source@ parameter. For example, if the owner of @example.com@ (which has ARN @arn:aws:ses:us-east-1:123456789012:identity/example.com@ ) attaches a policy to it that authorizes you to send from @user@example.com@ , then you would specify the @SourceArn@ to be @arn:aws:ses:us-east-1:123456789012:identity/example.com@ , and the @Source@ to be @user@example.com@ . Instead of using this parameter, you can use the X-header @X-SES-SOURCE-ARN@ in the raw message of the email. If you use both the @SourceArn@ parameter and the corresponding X-header, Amazon SES uses the value of the @SourceArn@ parameter.
--
-- * 'sreDestinations' - A list of destinations for the message, consisting of To:, CC:, and BCC: addresses.
--
-- * 'sreReturnPathARN' - This parameter is used only for sending authorization. It is the ARN of the identity that is associated with the sending authorization policy that permits you to use the email address specified in the @ReturnPath@ parameter. For example, if the owner of @example.com@ (which has ARN @arn:aws:ses:us-east-1:123456789012:identity/example.com@ ) attaches a policy to it that authorizes you to use @feedback@example.com@ , then you would specify the @ReturnPathArn@ to be @arn:aws:ses:us-east-1:123456789012:identity/example.com@ , and the @ReturnPath@ to be @feedback@example.com@ . Instead of using this parameter, you can use the X-header @X-SES-RETURN-PATH-ARN@ in the raw message of the email. If you use both the @ReturnPathArn@ parameter and the corresponding X-header, Amazon SES uses the value of the @ReturnPathArn@ parameter.
--
-- * 'sreSource' - The identity's email address. If you do not provide a value for this parameter, you must specify a "From" address in the raw text of the message. (You can also specify both.) If you specify the @Source@ parameter and have feedback forwarding enabled, then bounces and complaints will be sent to this email address. This takes precedence over any Return-Path header that you might include in the raw text of the message.
--
-- * 'sreFromARN' - This parameter is used only for sending authorization. It is the ARN of the identity that is associated with the sending authorization policy that permits you to specify a particular "From" address in the header of the raw email. Instead of using this parameter, you can use the X-header @X-SES-FROM-ARN@ in the raw message of the email. If you use both the @FromArn@ parameter and the corresponding X-header, Amazon SES uses the value of the @FromArn@ parameter.
--
-- * 'sreTags' - A list of tags, in the form of name/value pairs, to apply to an email that you send using @SendRawEmail@ . Tags correspond to characteristics of the email that you define, so that you can publish email sending events.
--
-- * 'sreRawMessage' - The raw email message itself. The message has to meet the following criteria:     * The message has to contain a header and a body, separated by a blank line.     * All of the required header fields must be present in the message.     * Each part of a multipart MIME message must be formatted properly.     * Attachments must be of a content type that Amazon SES supports. For a list on unsupported content types, see <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/mime-types.html Unsupported Attachment Types> in the /Amazon SES Developer Guide/ .     * The entire message must be base64-encoded.     * If any of the MIME parts in your message contain content that is outside of the 7-bit ASCII character range, we highly recommend that you encode that content. For more information, see <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-raw.html Sending Raw Email> in the /Amazon SES Developer Guide/ .     * Per <https://tools.ietf.org/html/rfc5321#section-4.5.3.1.6 RFC 5321> , the maximum length of each line of text, including the <CRLF>, must not exceed 1,000 characters.
sendRawEmail
    :: RawMessage -- ^ 'sreRawMessage'
    -> SendRawEmail
sendRawEmail pRawMessage_
  = SendRawEmail'{_sreConfigurationSetName = Nothing,
                  _sreSourceARN = Nothing, _sreDestinations = Nothing,
                  _sreReturnPathARN = Nothing, _sreSource = Nothing,
                  _sreFromARN = Nothing, _sreTags = Nothing,
                  _sreRawMessage = pRawMessage_}

-- | The name of the configuration set to use when you send an email using @SendRawEmail@ .
sreConfigurationSetName :: Lens' SendRawEmail (Maybe Text)
sreConfigurationSetName = lens _sreConfigurationSetName (\ s a -> s{_sreConfigurationSetName = a})

-- | This parameter is used only for sending authorization. It is the ARN of the identity that is associated with the sending authorization policy that permits you to send for the email address specified in the @Source@ parameter. For example, if the owner of @example.com@ (which has ARN @arn:aws:ses:us-east-1:123456789012:identity/example.com@ ) attaches a policy to it that authorizes you to send from @user@example.com@ , then you would specify the @SourceArn@ to be @arn:aws:ses:us-east-1:123456789012:identity/example.com@ , and the @Source@ to be @user@example.com@ . Instead of using this parameter, you can use the X-header @X-SES-SOURCE-ARN@ in the raw message of the email. If you use both the @SourceArn@ parameter and the corresponding X-header, Amazon SES uses the value of the @SourceArn@ parameter.
sreSourceARN :: Lens' SendRawEmail (Maybe Text)
sreSourceARN = lens _sreSourceARN (\ s a -> s{_sreSourceARN = a})

-- | A list of destinations for the message, consisting of To:, CC:, and BCC: addresses.
sreDestinations :: Lens' SendRawEmail [Text]
sreDestinations = lens _sreDestinations (\ s a -> s{_sreDestinations = a}) . _Default . _Coerce

-- | This parameter is used only for sending authorization. It is the ARN of the identity that is associated with the sending authorization policy that permits you to use the email address specified in the @ReturnPath@ parameter. For example, if the owner of @example.com@ (which has ARN @arn:aws:ses:us-east-1:123456789012:identity/example.com@ ) attaches a policy to it that authorizes you to use @feedback@example.com@ , then you would specify the @ReturnPathArn@ to be @arn:aws:ses:us-east-1:123456789012:identity/example.com@ , and the @ReturnPath@ to be @feedback@example.com@ . Instead of using this parameter, you can use the X-header @X-SES-RETURN-PATH-ARN@ in the raw message of the email. If you use both the @ReturnPathArn@ parameter and the corresponding X-header, Amazon SES uses the value of the @ReturnPathArn@ parameter.
sreReturnPathARN :: Lens' SendRawEmail (Maybe Text)
sreReturnPathARN = lens _sreReturnPathARN (\ s a -> s{_sreReturnPathARN = a})

-- | The identity's email address. If you do not provide a value for this parameter, you must specify a "From" address in the raw text of the message. (You can also specify both.) If you specify the @Source@ parameter and have feedback forwarding enabled, then bounces and complaints will be sent to this email address. This takes precedence over any Return-Path header that you might include in the raw text of the message.
sreSource :: Lens' SendRawEmail (Maybe Text)
sreSource = lens _sreSource (\ s a -> s{_sreSource = a})

-- | This parameter is used only for sending authorization. It is the ARN of the identity that is associated with the sending authorization policy that permits you to specify a particular "From" address in the header of the raw email. Instead of using this parameter, you can use the X-header @X-SES-FROM-ARN@ in the raw message of the email. If you use both the @FromArn@ parameter and the corresponding X-header, Amazon SES uses the value of the @FromArn@ parameter.
sreFromARN :: Lens' SendRawEmail (Maybe Text)
sreFromARN = lens _sreFromARN (\ s a -> s{_sreFromARN = a})

-- | A list of tags, in the form of name/value pairs, to apply to an email that you send using @SendRawEmail@ . Tags correspond to characteristics of the email that you define, so that you can publish email sending events.
sreTags :: Lens' SendRawEmail [MessageTag]
sreTags = lens _sreTags (\ s a -> s{_sreTags = a}) . _Default . _Coerce

-- | The raw email message itself. The message has to meet the following criteria:     * The message has to contain a header and a body, separated by a blank line.     * All of the required header fields must be present in the message.     * Each part of a multipart MIME message must be formatted properly.     * Attachments must be of a content type that Amazon SES supports. For a list on unsupported content types, see <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/mime-types.html Unsupported Attachment Types> in the /Amazon SES Developer Guide/ .     * The entire message must be base64-encoded.     * If any of the MIME parts in your message contain content that is outside of the 7-bit ASCII character range, we highly recommend that you encode that content. For more information, see <https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-raw.html Sending Raw Email> in the /Amazon SES Developer Guide/ .     * Per <https://tools.ietf.org/html/rfc5321#section-4.5.3.1.6 RFC 5321> , the maximum length of each line of text, including the <CRLF>, must not exceed 1,000 characters.
sreRawMessage :: Lens' SendRawEmail RawMessage
sreRawMessage = lens _sreRawMessage (\ s a -> s{_sreRawMessage = a})

instance AWSRequest SendRawEmail where
        type Rs SendRawEmail = SendRawEmailResponse
        request = postQuery ses
        response
          = receiveXMLWrapper "SendRawEmailResult"
              (\ s h x ->
                 SendRawEmailResponse' <$>
                   (pure (fromEnum s)) <*> (x .@ "MessageId"))

instance Hashable SendRawEmail where

instance NFData SendRawEmail where

instance ToHeaders SendRawEmail where
        toHeaders = const mempty

instance ToPath SendRawEmail where
        toPath = const "/"

instance ToQuery SendRawEmail where
        toQuery SendRawEmail'{..}
          = mconcat
              ["Action" =: ("SendRawEmail" :: ByteString),
               "Version" =: ("2010-12-01" :: ByteString),
               "ConfigurationSetName" =: _sreConfigurationSetName,
               "SourceArn" =: _sreSourceARN,
               "Destinations" =:
                 toQuery (toQueryList "member" <$> _sreDestinations),
               "ReturnPathArn" =: _sreReturnPathARN,
               "Source" =: _sreSource, "FromArn" =: _sreFromARN,
               "Tags" =:
                 toQuery (toQueryList "member" <$> _sreTags),
               "RawMessage" =: _sreRawMessage]

-- | Represents a unique message ID.
--
--
--
-- /See:/ 'sendRawEmailResponse' smart constructor.
data SendRawEmailResponse = SendRawEmailResponse'{_srersResponseStatus
                                                  :: !Int,
                                                  _srersMessageId :: !Text}
                              deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'SendRawEmailResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'srersResponseStatus' - -- | The response status code.
--
-- * 'srersMessageId' - The unique message identifier returned from the @SendRawEmail@ action. 
sendRawEmailResponse
    :: Int -- ^ 'srersResponseStatus'
    -> Text -- ^ 'srersMessageId'
    -> SendRawEmailResponse
sendRawEmailResponse pResponseStatus_ pMessageId_
  = SendRawEmailResponse'{_srersResponseStatus =
                            pResponseStatus_,
                          _srersMessageId = pMessageId_}

-- | -- | The response status code.
srersResponseStatus :: Lens' SendRawEmailResponse Int
srersResponseStatus = lens _srersResponseStatus (\ s a -> s{_srersResponseStatus = a})

-- | The unique message identifier returned from the @SendRawEmail@ action. 
srersMessageId :: Lens' SendRawEmailResponse Text
srersMessageId = lens _srersMessageId (\ s a -> s{_srersMessageId = a})

instance NFData SendRawEmailResponse where
