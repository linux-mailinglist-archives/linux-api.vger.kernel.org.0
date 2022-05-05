Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FFF51BDEF
	for <lists+linux-api@lfdr.de>; Thu,  5 May 2022 13:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354787AbiEEL0C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 May 2022 07:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiEELZ6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 May 2022 07:25:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F4653B73
        for <linux-api@vger.kernel.org>; Thu,  5 May 2022 04:22:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C9D851F38A;
        Thu,  5 May 2022 11:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651749737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJDRSUTdb5ybeBA5bzxdSn8LTP1LamasunF0g7vONQw=;
        b=iFGCj0R5jzXo08g7+CMxRt4ILZZBUIVZWbjwvyOBP3keDZkwAGICf+D6y6+AtA2Hvc3d3B
        71ybcWAEykWC1miTGN6EFXGBD9n7OaukYQqM+qSpTOyuGgvc4qUiypwfNFU4k9BvrMghae
        FSNF+6Ws6d6bJfWl8KjvVwHBHvMijfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651749737;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJDRSUTdb5ybeBA5bzxdSn8LTP1LamasunF0g7vONQw=;
        b=ODRTVcyalF3P7nijm9ijYaPU0O5z4xT07MEND42CirAQ0E131OPDhg5A6eegeN6vB7R1M5
        slHE+0FzJ5vOjrCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B83EB2C141;
        Thu,  5 May 2022 11:22:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 58632A0627; Thu,  5 May 2022 13:22:17 +0200 (CEST)
Date:   Thu, 5 May 2022 13:22:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-api@vger.kernel.org
Subject: Re: Fanotify API - Tracking File Movement
Message-ID: <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
References: <YnOmG2DvSpvvOEOQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnOmG2DvSpvvOEOQ@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Matthew!

On Thu 05-05-22 20:25:31, Matthew Bobrowski wrote:
> I was having a brief chat with Amir the other day about an idea/use
> case that I have which at present don't believe is robustly supported
> by the fanotify API. I was wondering whether you could share some
> thoughts on supporting the following idea.
> 
> I have a need to track file movement across a filesystem without
> necessarily burdening the system by having to watch the entire
> filesystem for such movements. That is, knowing when file /dir1/a had
> been moved from /dir1/a to /dir2/a and then from /dir2/a to /dir3/a
> and so on. Or more simply, knowing the destination/new path of the
> file once it has moved.

OK, and the places the file moves to can be arbitrary? That seems like a
bit narrow usecase :)

> Initially, I was thinking of using FAN_MOVE_SELF, but it doesn't quite
> cut it. For such events, you only know the target location or path of
> a file had been modified once it has subsequently been moved
> elsewhere. Not to mention that path resolution using the file
> identifier from such an event may not always work. Then there's
> FAN_RENAME which could arguably work. This would include setting up a
> watch on the parent directory of the file of interest and then using
> the information record of type FAN_EVENT_INFO_TYPE_NEW_DFID_NAME to
> figure out the new target location of the file once it has been moved
> and then resetting the mark on the next parent directory once the new
> target location is known. But, as Amir rightfully mentioned, this
> rinse and repeat mark approach is suboptimal as it can lead to certain
> race conditions.

It seems to me you really want FAN_MOVE_SELF but you'd need more
information coming with it like the new parent dir, wouldn't you? It would
be relatively easy to add that info but it would kind of suck that it would
be difficult to discover in advance whether the directory info will arrive
with the event or not. But that actually would seem to be the case for
FAN_RENAME as well because we didn't seem to bother to refuse FAN_RENAME on
a file. Amir?

> Having briefly mentioned all this, what is your stance on maybe
> extending out FAN_RENAME to also cover files? Or, maybe you have
> another approach/idea in mind to cover such cases i.e. introducing a
> new flag FAN_{TRACK,TRACE}.

So extending FAN_MOVE_SELF or FAN_RENAME looks OK to me, not much thoughts
beyond that :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
