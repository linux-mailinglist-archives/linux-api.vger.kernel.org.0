Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7139151BD1D
	for <lists+linux-api@lfdr.de>; Thu,  5 May 2022 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346217AbiEEK3e (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 May 2022 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351636AbiEEK3d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 May 2022 06:29:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B0517F3
        for <linux-api@vger.kernel.org>; Thu,  5 May 2022 03:25:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x18so3973886plg.6
        for <linux-api@vger.kernel.org>; Thu, 05 May 2022 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CkK0DqAW8f2rdMRPzYi3UVnBEn9CvaB7ptkhpv8zcpA=;
        b=DTvHjpYN18+RoiyLCqhZ8K/03zRTkwWflaS1bMwfxlcf7ZK1NSAfdGIYk14RCgAdro
         YcBidS4NaSKLxFyIJ7z9SeZZsytgkHty7YJtykbEBAhKscbQ3o+lrOZNTNES5GD5RLt9
         KTX1qeNIcXsf1kO9/Ajn8JxNilMaMnc6eRnZMBX4R3iUogC9G60umiLjgojTtbPuNNbk
         QMcW8HEP/rhLsav5fbWB2LR5YGSJ2aOJ4djmqGGNEg+3Y6Eh2o/23Lxm/WQwm+iuBh61
         x/n7mXG2XvVoJ5blg3G40IeFsxpt9ygNqoMepr3DLoSuhjje0WseEUZg5QnueEmJCcem
         O+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CkK0DqAW8f2rdMRPzYi3UVnBEn9CvaB7ptkhpv8zcpA=;
        b=TmkT4/YebeCfM8e8HzQq01QuuV8wxarCt7uHyGAvMWKahe1JQzoQs/5IQFLSGDvclR
         q1ptf3Ahhl8+gmw78R+vJU2ex5iLhYmXrDFmH1AO40N5kJ2t8lsyJGZfiu9c9Xitb5V4
         IBQhEP20CvmQS3Q1/Goc40y0S0+/ZJVKnkNBPjYdYaJhvlSpVdNEeTEsKlDJkxPpaPAd
         LltUMYrlFhH6LFZvH+myTq6AYZz13yU/qlKQeORGJ4rxa/exSAKfSH1MYLOM36mkO4+m
         V45n8VqHQpMGWRmLAxWFRwzET2PIJm4VD/5WCM3y1kZjuOO5p++LOdyUYqLLeJ0WlTiZ
         YS/Q==
X-Gm-Message-State: AOAM532XYG5jUKM3zIXtzfVsXZRe+s24ILhtRiL4Bra4uCbBsqTlAzS1
        F+1tJh402e0ruQr7XUXcj9TC0Q==
X-Google-Smtp-Source: ABdhPJz932/wKoWpIfLko18xWP/eql2qn2+YG6svYWsT54uEzVarutUBRvn5djgqKlsLtJ/kjBRGtA==
X-Received: by 2002:a17:902:9309:b0:156:983d:2193 with SMTP id bc9-20020a170902930900b00156983d2193mr25876887plb.158.1651746353400;
        Thu, 05 May 2022 03:25:53 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:7c5b:6465:b196:d835])
        by smtp.gmail.com with ESMTPSA id b14-20020aa78ece000000b0050dc76281fasm1022220pfr.212.2022.05.05.03.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 03:25:52 -0700 (PDT)
Date:   Thu, 5 May 2022 20:25:31 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-api@vger.kernel.org
Subject: Fanotify API - Tracking File Movement
Message-ID: <YnOmG2DvSpvvOEOQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Jan,

I was having a brief chat with Amir the other day about an idea/use
case that I have which at present don't believe is robustly supported
by the fanotify API. I was wondering whether you could share some
thoughts on supporting the following idea.

I have a need to track file movement across a filesystem without
necessarily burdening the system by having to watch the entire
filesystem for such movements. That is, knowing when file /dir1/a had
been moved from /dir1/a to /dir2/a and then from /dir2/a to /dir3/a
and so on. Or more simply, knowing the destination/new path of the
file once it has moved.

Initially, I was thinking of using FAN_MOVE_SELF, but it doesn't quite
cut it. For such events, you only know the target location or path of
a file had been modified once it has subsequently been moved
elsewhere. Not to mention that path resolution using the file
identifier from such an event may not always work. Then there's
FAN_RENAME which could arguably work. This would include setting up a
watch on the parent directory of the file of interest and then using
the information record of type FAN_EVENT_INFO_TYPE_NEW_DFID_NAME to
figure out the new target location of the file once it has been moved
and then resetting the mark on the next parent directory once the new
target location is known. But, as Amir rightfully mentioned, this
rinse and repeat mark approach is suboptimal as it can lead to certain
race conditions.

Having briefly mentioned all this, what is your stance on maybe
extending out FAN_RENAME to also cover files? Or, maybe you have
another approach/idea in mind to cover such cases i.e. introducing a
new flag FAN_{TRACK,TRACE}.

Eager to hear your thoughts on this.

/M
